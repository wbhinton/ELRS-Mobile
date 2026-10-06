import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/app_release.dart';

part 'app_update_repository.g.dart';

/// Served from Cloudflare R2 so it is reachable where Google Play and
/// GitHub are blocked.
const latestReleaseUrl = 'https://cdn.elrsmobile.com/latest.json';

class AppUpdateRepository {
  final Dio _dio;
  static final _log = Logger('AppUpdateRepository');

  AppUpdateRepository(this._dio);

  /// Fetches the latest release. Returns null on any failure: the app is
  /// offline-first, so no connection is normal and never an error.
  Future<AppRelease?> fetchLatestRelease() async {
    try {
      final response = await _dio.get<String>(
        latestReleaseUrl,
        options: Options(responseType: ResponseType.plain),
      );
      final release = AppRelease.tryParse(jsonDecode(response.data ?? ''));
      if (release == null) _log.warning('Ignoring malformed latest.json');
      return release;
    } on DioException catch (e) {
      _log.fine('Update check skipped: ${e.type}');
      return null;
    } on FormatException catch (e) {
      _log.warning('Ignoring malformed latest.json: $e');
      return null;
    }
  }
}

@riverpod
AppUpdateRepository appUpdateRepository(Ref ref) {
  final dio = Dio(
    BaseOptions(
      // Short timeouts: this runs in the background and must never hold
      // anything up on poor field connections.
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'User-Agent': 'ELRSMobile/1.0',
      },
    ),
  );
  return AppUpdateRepository(dio);
}
