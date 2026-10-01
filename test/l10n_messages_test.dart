import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'package:elrs_mobile/src/features/firmware_manager/presentation/firmware_manager_error.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  test('cached version count uses singular and plural forms', () {
    expect(l10n.maxCachedVersionsCount(1), '1 version');
    expect(l10n.maxCachedVersionsCount(3), '3 versions');
  });

  test('field dialogs embed the setting name', () {
    expect(l10n.editFieldTitle('Home WiFi SSID'), 'Edit Home WiFi SSID');
    expect(l10n.enterFieldHint('Home WiFi SSID'), 'Enter Home WiFi SSID');
  });

  test('storage size uses locale decimal formatting', () {
    expect(l10n.storageUsedMb(12.46), 'Storage Used: 12.5 MB');
    final de = lookupAppLocalizations(const Locale('de'));
    // Untranslated so far, but the number still follows German formatting.
    expect(de.storageUsedMb(12.46), contains('12,5'));
  });

  test('firmware manager errors map to their messages', () {
    const error = FirmwareManagerError(
      FirmwareManagerErrorKind.deleteFailed,
      'PathNotFoundException',
    );
    expect(error.message(l10n), l10n.firmwareErrorDeleteFailed);
    expect(error.detail, 'PathNotFoundException');
  });
}
