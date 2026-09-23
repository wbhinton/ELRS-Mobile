import 'package:elrs_mobile/src/localization/app_localizations.dart';
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
}
