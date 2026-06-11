// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Bindungsphrase';

  @override
  String get networkSsidLabel => 'WLAN-SSID';

  @override
  String get flashingButtonLabel => 'Flashen';

  @override
  String get packetRateLabel => 'Paketrate';

  @override
  String get baudRateLabel => 'Baudrate';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Aktualisiere $expressLRS-Firmware auf $radioMaster- oder $betaFPV-Hardware...';
  }

  @override
  String get flashDeviceLabel => 'Gerät flashen';

  @override
  String get deviceConfigLabel => 'Gerätekonfiguration';

  @override
  String get firmwareManagerLabel => 'Firmware-Verwaltung';

  @override
  String get settingsLabel => 'Einstellungen';

  @override
  String get helpSupportLabel => 'Hilfe & Support';

  @override
  String get noDeviceFoundLabel => 'Kein Gerät gefunden';

  @override
  String get retryLabel => 'Wiederholen';

  @override
  String get manualConnectionLabel => 'Manuelle Verbindung';

  @override
  String get manualIpOverrideLabel => 'Manuelle IP-Überschreibung';

  @override
  String get connectLabel => 'Verbinden';

  @override
  String get cancelLabel => 'Abbrechen';

  @override
  String get matchedLabel => 'Übereinstimmend';

  @override
  String get mismatchLabel => 'Nicht übereinstimmend';

  @override
  String connectedLabel(String ip) {
    return 'Verbunden: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Flashen & WLAN';

  @override
  String get aboutSupportCategoryLabel => 'Über & Support';

  @override
  String get advancedCategoryLabel => 'Erweitert';

  @override
  String get flashingDefaultsSectionLabel =>
      'Standardeinstellungen für das Flashen';

  @override
  String get default24GHzDomainLabel => 'Standard 2,4-GHz-Domain';

  @override
  String get defaultSubGHzDomainLabel => 'Standard Sub-GHz-Domain';

  @override
  String get globalBindingPhraseLabel => 'Globale Bindungsphrase';

  @override
  String get homeWifiSsidLabel => 'Heim-WLAN-SSID';

  @override
  String get homeWifiPasswordLabel => 'Heim-WLAN-Passwort';

  @override
  String get manageCachedFirmwareLabel =>
      'Zwischengespeicherte Firmware verwalten';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Offline-Firmware herunterladen oder löschen';

  @override
  String get maxCachedVersionsLabel => 'Max. zwischengespeicherte Versionen';

  @override
  String get clearFirmwareCacheLabel => 'Firmware-Cache leeren';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Alle heruntergeladenen Firmware-Dateien löschen';

  @override
  String get clearLabel => 'LEEREN';

  @override
  String get aboutSectionLabel => 'Über';

  @override
  String get appVersionLabel => 'App-Version';

  @override
  String get legalLicenseLabel => 'Rechtliches & Lizenz';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standard-Haftungsausschluss und GPLv3-Lizenz';

  @override
  String get developerSectionLabel => 'Entwickler';

  @override
  String get developerModeEnabledLabel => 'Entwicklermodus aktiviert';

  @override
  String get testSentryErrorCaptureLabel => 'Sentry-Fehlererfassung testen';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Sendet eine Testausnahme an Sentry – prüfen Sie das Dashboard';

  @override
  String get shareAnalyticsLabel => 'Analysedaten teilen';

  @override
  String get shareAnalyticsSubtitle =>
      'Helfen Sie, die App zu verbessern, indem Sie anonyme Nutzungsdaten teilen';

  @override
  String get expertModeLabel => 'Expertenmodus';

  @override
  String get expertModeSubtitle =>
      'Aktiviert erweiterte Firmware-Handhabung und Downloads';

  @override
  String get exportElrsLuaScriptLabel => 'ELRS Lua-Skript exportieren';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'elrs.lua für EdgeTX-/OpenTX-Fernsteuerungen speichern';

  @override
  String get submitDebugReportLabel => 'Debug-Bericht an Sentry senden';

  @override
  String get submitDebugReportSubtitle =>
      'Helfen Sie uns, Fehler zu beheben, indem Sie anonyme Systemprotokolle teilen';

  @override
  String get clearFirmwareCacheTitle => 'Firmware-Cache leeren?';

  @override
  String get clearFirmwareCacheMessage =>
      'Dadurch werden alle heruntergeladenen Firmware-ZIP-Dateien gelöscht. Sie müssen diese erneut herunterladen, wenn Sie offline flashen möchten.';

  @override
  String get clearAllLabel => 'ALLE LÖSCHEN';

  @override
  String get submitDebugReportTitle => 'Debug-Bericht senden';

  @override
  String get submitDebugReportMessage =>
      'Dies sendet Ihre Geräteinformationen und App-Protokolle zur Fehlerbehebung an Sentry. Keine persönlichen Daten wie Bindungsphrasen oder WLAN-Passwörter werden enthalten sein.';

  @override
  String get describeIssueHint =>
      'Bitte beschreiben Sie das aufgetretene Problem...';

  @override
  String get proceedLabel => 'Fortfahren';

  @override
  String get submittingReportProgress => 'Bericht wird gesendet…';

  @override
  String get saveLabel => 'Speichern';

  @override
  String get notSetLabel => 'Nicht festgelegt';
}
