import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elrs_mobile/src/core/storage/persistence_service.dart';
import 'package:elrs_mobile/src/features/app_update/application/app_update_service.dart';
import 'package:elrs_mobile/src/features/app_update/data/app_update_repository.dart';
import 'package:elrs_mobile/src/features/app_update/domain/app_release.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockSecureStorage extends Mock implements FlutterSecureStorage {}

class _FakeRepository extends AppUpdateRepository {
  _FakeRepository() : super(Dio());

  AppRelease? release;
  int fetches = 0;

  @override
  Future<AppRelease?> fetchLatestRelease() async {
    fetches++;
    return release;
  }
}

AppRelease _release(int code) => AppRelease(
      version: '1.0.$code',
      versionCode: code,
      downloadUrl: Uri.parse('https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk'),
    );

const _validJson = '''
{"version": "1.0.45", "version_code": 111, "sha256": "abc", "size": 1,
 "url": "https://cdn.elrsmobile.com/releases/v1.0.45/ELRS-Mobile-v1.0.45.apk",
 "latest_url": "https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk",
 "published_at": "2026-10-06T00:00:00Z"}
''';

void main() {
  group('AppRelease.tryParse', () {
    test('reads the fields published by the release workflow', () {
      final release = AppRelease.tryParse({
        'version': '1.0.45',
        'version_code': 111,
        'latest_url': 'https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk',
      });
      expect(release?.version, '1.0.45');
      expect(release?.versionCode, 111);
      expect(release?.downloadUrl.host, 'cdn.elrsmobile.com');
    });

    test('rejects missing fields, wrong types and non-https links', () {
      expect(AppRelease.tryParse({'version': '1.0.45'}), isNull);
      expect(
        AppRelease.tryParse({
          'version': '1.0.45',
          'version_code': '111',
          'latest_url': 'https://cdn.elrsmobile.com/a.apk',
        }),
        isNull,
      );
      expect(
        AppRelease.tryParse({
          'version': '1.0.45',
          'version_code': 111,
          'latest_url': 'http://cdn.elrsmobile.com/a.apk',
        }),
        isNull,
      );
      expect(AppRelease.tryParse(['not', 'a', 'map']), isNull);
    });
  });

  group('AppUpdateRepository', () {
    late Dio dio;
    late DioAdapter adapter;

    setUp(() {
      dio = Dio();
      adapter = DioAdapter(dio: dio);
    });

    test('parses latest.json', () async {
      adapter.onGet(latestReleaseUrl, (server) => server.reply(200, jsonDecode(_validJson)));
      final release = await AppUpdateRepository(dio).fetchLatestRelease();
      expect(release?.versionCode, 111);
    });

    test('returns null when offline', () async {
      adapter.onGet(
        latestReleaseUrl,
        (server) => server.throws(
          0,
          DioException.connectionError(
            requestOptions: RequestOptions(path: latestReleaseUrl),
            reason: 'offline',
          ),
        ),
      );
      expect(await AppUpdateRepository(dio).fetchLatestRelease(), isNull);
    });

    test('returns null on a server error or malformed body', () async {
      adapter.onGet(latestReleaseUrl, (server) => server.reply(404, 'Not found'));
      expect(await AppUpdateRepository(dio).fetchLatestRelease(), isNull);

      adapter.onGet(
        latestReleaseUrl,
        (server) => server.reply(200, {'version': 1, 'latest_url': null}),
      );
      expect(await AppUpdateRepository(dio).fetchLatestRelease(), isNull);
    });
  });

  group('AppUpdateService', () {
    late _FakeRepository repository;
    late PersistenceService persistence;
    late DateTime now;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      persistence = PersistenceService(
        await SharedPreferences.getInstance(),
        _MockSecureStorage(),
      );
      repository = _FakeRepository();
      now = DateTime(2026, 10, 6, 12);
    });

    AppUpdateService service({bool enabled = true, String build = '110'}) =>
        AppUpdateService(
          repository: repository,
          persistence: persistence,
          packageInfo: () async => PackageInfo(
            appName: 'ELRS Mobile',
            packageName: 'io.datarx.elrsmobile',
            version: '1.0.44',
            buildNumber: build,
          ),
          enabled: enabled,
          now: () => now,
        );

    test('offers a newer version code', () async {
      repository.release = _release(111);
      final result = await service().checkForUpdate();
      expect(result, isA<UpdateAvailable>());
      result as UpdateAvailable;
      expect(result.release.versionCode, 111);
      expect(result.currentVersion, '1.0.44');
    });

    test('does not offer the same or an older version code', () async {
      repository.release = _release(110);
      expect(await service().checkForUpdate(), isA<NoUpdate>());

      repository.release = _release(109);
      expect(await service().checkForUpdate(manual: true), isA<NoUpdate>());
    });

    test('is a no-op outside direct-download builds', () async {
      repository.release = _release(111);
      expect(await service(enabled: false).checkForUpdate(), isA<NoUpdate>());
      expect(repository.fetches, 0);
    });

    test('checks automatically at most once a day', () async {
      repository.release = _release(110);
      await service().checkForUpdate();
      expect(repository.fetches, 1);

      now = now.add(const Duration(hours: 23));
      repository.release = _release(111);
      expect(await service().checkForUpdate(), isA<NoUpdate>());
      expect(repository.fetches, 1);

      now = now.add(const Duration(hours: 2));
      expect(await service().checkForUpdate(), isA<UpdateAvailable>());
      expect(repository.fetches, 2);
    });

    test('a manual check ignores the daily limit', () async {
      repository.release = _release(111);
      await service().checkForUpdate();
      expect(
        await service().checkForUpdate(manual: true),
        isA<UpdateAvailable>(),
      );
      expect(repository.fetches, 2);
    });

    test('a failed check does not use up the daily slot', () async {
      repository.release = null;
      expect(await service().checkForUpdate(), isA<UpdateCheckFailed>());

      repository.release = _release(111);
      expect(await service().checkForUpdate(), isA<UpdateAvailable>());
    });

    test('a skipped version is not offered again, but a later one is',
        () async {
      repository.release = _release(111);
      await service().skipVersion(_release(111));
      expect(await service().checkForUpdate(), isA<NoUpdate>());

      // A manual check still shows it.
      expect(
        await service().checkForUpdate(manual: true),
        isA<UpdateAvailable>(),
      );

      now = now.add(const Duration(days: 1));
      repository.release = _release(112);
      expect(await service().checkForUpdate(), isA<UpdateAvailable>());
    });

    test('an unparseable local build number never prompts', () async {
      repository.release = _release(111);
      expect(await service(build: '').checkForUpdate(), isA<NoUpdate>());
    });
  });
}
