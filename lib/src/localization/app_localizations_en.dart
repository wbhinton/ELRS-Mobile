// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Binding Phrase';

  @override
  String get networkSsidLabel => 'WiFi SSID';

  @override
  String get flashingButtonLabel => 'Flash';

  @override
  String get packetRateLabel => 'Packet Rate';

  @override
  String get baudRateLabel => 'Baud Rate';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Updating $expressLRS firmware on $radioMaster or $betaFPV hardware...';
  }

  @override
  String get flashDeviceLabel => 'Flash Device';

  @override
  String get deviceConfigLabel => 'Device Config';

  @override
  String get firmwareManagerLabel => 'Firmware Manager';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get helpSupportLabel => 'Help & Support';

  @override
  String get noDeviceFoundLabel => 'No Device Found';

  @override
  String get retryLabel => 'Retry';

  @override
  String get manualConnectionLabel => 'Manual Connection';

  @override
  String get manualIpOverrideLabel => 'Manual IP Override';

  @override
  String get connectLabel => 'Connect';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get matchedLabel => 'Matched';

  @override
  String get mismatchLabel => 'Mismatch';

  @override
  String connectedLabel(String ip) {
    return 'Connected: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Flashing & WiFi';

  @override
  String get aboutSupportCategoryLabel => 'About & Support';

  @override
  String get advancedCategoryLabel => 'Advanced';

  @override
  String get flashingDefaultsSectionLabel => 'Flashing Defaults';

  @override
  String get default24GHzDomainLabel => 'Default 2.4GHz Domain';

  @override
  String get defaultSubGHzDomainLabel => 'Default Sub-GHz Domain';

  @override
  String get globalBindingPhraseLabel => 'Global Binding Phrase';

  @override
  String get homeWifiSsidLabel => 'Home WiFi SSID';

  @override
  String get homeWifiPasswordLabel => 'Home WiFi Password';

  @override
  String get manageCachedFirmwareLabel => 'Manage Cached Firmware';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Download or delete offline firmware';

  @override
  String get maxCachedVersionsLabel => 'Max Cached Versions';

  @override
  String get clearFirmwareCacheLabel => 'Clear Firmware Cache';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Delete all downloaded firmware files';

  @override
  String get clearLabel => 'CLEAR';

  @override
  String get aboutSectionLabel => 'About';

  @override
  String get appVersionLabel => 'App Version';

  @override
  String get legalLicenseLabel => 'Legal & License';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standard disclaimer and GPLv3 License';

  @override
  String get developerSectionLabel => 'Developer';

  @override
  String get developerModeEnabledLabel => 'Developer Mode Enabled';

  @override
  String get testSentryErrorCaptureLabel => 'Test Sentry Error Capture';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Sends a test exception to Sentry — check the dashboard';

  @override
  String get shareAnalyticsLabel => 'Share Analytics';

  @override
  String get shareAnalyticsSubtitle =>
      'Help improve the app by sharing anonymous usage data';

  @override
  String get expertModeLabel => 'Expert Mode';

  @override
  String get expertModeSubtitle =>
      'Enable advanced firmware handling and downloads';

  @override
  String get exportElrsLuaScriptLabel => 'Export ELRS Lua Script';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Save elrs.lua for EdgeTX/OpenTX radios';

  @override
  String get submitDebugReportLabel => 'Submit Debug Report to Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Help us fix bugs by sharing anonymous system logs';

  @override
  String get clearFirmwareCacheTitle => 'Clear Firmware Cache?';

  @override
  String get clearFirmwareCacheMessage =>
      'This will delete all downloaded firmware zip files. You will need to re-download them if you want to flash offline.';

  @override
  String get clearAllLabel => 'CLEAR ALL';

  @override
  String get submitDebugReportTitle => 'Submit Debug Report';

  @override
  String get submitDebugReportMessage =>
      'This will send your device info and app logs to Sentry for debugging. No personal info like Binding Phrases or WiFi passwords will be included.';

  @override
  String get describeIssueHint =>
      'Please describe the issue you are experiencing...';

  @override
  String get proceedLabel => 'Proceed';

  @override
  String get submittingReportProgress => 'Submitting report…';

  @override
  String get saveLabel => 'Save';

  @override
  String get notSetLabel => 'Not set';
}
