import 'dart:async';

import 'package:elrs_mobile/src/features/app_update/application/app_update_service.dart';
import 'package:elrs_mobile/src/features/app_update/domain/app_release.dart';
import 'package:elrs_mobile/src/features/settings/presentation/settings_screen.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'package:elrs_mobile/src/localization/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FakeService implements AppUpdateService {
  _FakeService(this.onCheck);

  final Future<UpdateCheckResult> Function() onCheck;
  final manualFlags = <bool>[];

  @override
  Future<UpdateCheckResult> checkForUpdate({bool manual = false}) {
    manualFlags.add(manual);
    return onCheck();
  }

  @override
  Future<void> skipVersion(AppRelease release) async {}
}

final _l10n = AppLocalizationsEn();

final _update = UpdateAvailable(
  AppRelease(
    version: '1.0.45',
    versionCode: 111,
    downloadUrl: Uri.parse('https://cdn.elrsmobile.com/a.apk'),
  ),
  '1.0.44',
);

Future<void> _pumpTile(WidgetTester tester, AppUpdateService service) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        appUpdateServiceProvider.overrideWith((ref) async => service),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: CheckForUpdatesTile()),
      ),
    ),
  );
}

void main() {
  testWidgets('runs a manual check and offers an available update',
      (tester) async {
    final service = _FakeService(() async => _update);
    await _pumpTile(tester, service);

    await tester.tap(find.text(_l10n.checkForUpdatesLabel));
    await tester.pumpAndSettle();

    expect(service.manualFlags, [true]);
    expect(find.text(_l10n.updateAvailableTitle), findsOneWidget);
    expect(find.text(_l10n.updateDownloadButton), findsOneWidget);
  });

  testWidgets('says when the app is up to date', (tester) async {
    await _pumpTile(tester, _FakeService(() async => const NoUpdate()));

    await tester.tap(find.text(_l10n.checkForUpdatesLabel));
    await tester.pumpAndSettle();

    expect(find.text(_l10n.updateUpToDateMessage), findsOneWidget);
  });

  testWidgets('reports a failed check', (tester) async {
    await _pumpTile(
      tester,
      _FakeService(() async => const UpdateCheckFailed()),
    );

    await tester.tap(find.text(_l10n.checkForUpdatesLabel));
    await tester.pumpAndSettle();

    expect(find.text(_l10n.updateCheckFailedMessage), findsOneWidget);
  });

  testWidgets('an unexpected error shows the failure message', (tester) async {
    await _pumpTile(
      tester,
      _FakeService(() async => throw StateError('boom')),
    );

    await tester.tap(find.text(_l10n.checkForUpdatesLabel));
    await tester.pumpAndSettle();

    expect(find.text(_l10n.updateCheckFailedMessage), findsOneWidget);
  });

  testWidgets('shows progress and ignores taps while checking',
      (tester) async {
    final pending = Completer<UpdateCheckResult>();
    final service = _FakeService(() => pending.future);
    await _pumpTile(tester, service);

    await tester.tap(find.text(_l10n.checkForUpdatesLabel));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.text(_l10n.checkForUpdatesLabel));
    await tester.pump();
    expect(service.manualFlags, [true]);

    pending.complete(const NoUpdate());
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(_l10n.updateUpToDateMessage), findsOneWidget);
  });
}
