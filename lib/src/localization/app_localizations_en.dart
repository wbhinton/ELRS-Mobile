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

  @override
  String get languageOverrideLabel => 'Language';

  @override
  String get languageOverrideSystemDefault => 'System Default';

  @override
  String get legalNoticeSectionTitle => 'Legal Notice';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile is a free and open-source (FOSS) project developed independently by Weston Hinton. This project is not an official product of ExpressLRS LLC and is not officially supported, endorsed, or certified by the ExpressLRS development team.';

  @override
  String get trademarkNoticeSectionTitle => 'Trademark Notice';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS and the ExpressLRS logo are trademarks of ExpressLRS LLC. Use of these marks is for descriptive and compatibility purposes only. For the official ExpressLRS configurator and documentation, please visit expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Official Support';

  @override
  String get officialSupportSectionText =>
      'Support the official ExpressLRS project: ';

  @override
  String get donateOpenCollectiveLabel => 'Donate via Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Software License';

  @override
  String get gplv3NoticeText =>
      'This project is licensed under the GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Flashing Guide';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Resources';

  @override
  String get resourceCommunitySupport => 'Community & Support';

  @override
  String get resourceDiscordCommunity => 'Discord Community';

  @override
  String get resourceJoinDiscord => 'Join the ELRS Discord';

  @override
  String get resourceGithubRepo => 'GitHub Repository';

  @override
  String get resourceFlashRecovery => 'Flash Recovery';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'If your device appears unresponsive after a failed flash:';

  @override
  String get resourceRecoveryStep1 =>
      'Hold the BOOT button while plugging in via USB to enter bootloader mode.';

  @override
  String get resourceRecoveryStep2 =>
      'Use the ELRS Web Flasher at expresslrs.org/flasher to re-flash over USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'For WiFi-capable devices, hold BOOT for 60 seconds to trigger WiFi Hotspot recovery mode.';

  @override
  String get resourceRecoveryStep4 =>
      'Join #help on the ELRS Discord — the community can usually recover any device.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Joshua Bardwell\'s unbricking guide is highly recommended:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'Recovery Video';

  @override
  String get resourceLegalLiability => 'Legal & Liability';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile is provided as-is, without warranty of any kind. The developers are not responsible for any damage, data loss, or non-functional hardware resulting from the use of this application, including but not limited to bricked receivers, transmitters, or flight controllers.\n\nBy using this app you accept full responsibility for your hardware.';

  @override
  String get resourceViewFullDisclaimerButton => 'View Full Disclaimer';

  @override
  String get disclaimerTitle => 'Use at Your Own Risk';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile is provided as-is, without warranty of any kind.';

  @override
  String get disclaimerLiability =>
      'The developers are not responsible for any damage, data loss, or non-functional hardware resulting from the use of this application, including but not limited to bricked receivers, transmitters, or flight controllers.';

  @override
  String get disclaimerAgreement =>
      'By using this app you confirm that you understand the risks of flashing custom firmware and accept full responsibility for your hardware.';

  @override
  String get disclaimerVerification =>
      'Always verify the target and firmware version before flashing. Keep a record of your original firmware if possible.';

  @override
  String get disclaimerUnderstand => 'I Understand';

  @override
  String get optionsTitle => 'Firmware Options';

  @override
  String get optionsSubtitle => 'Configure binding and network credentials.';

  @override
  String get wifiPasswordLabel => 'WiFi Password';

  @override
  String get wifiOnIntervalLabel => 'WiFi Auto-On Interval';

  @override
  String get regulatoryDomainLabel => 'Regulatory Domain';

  @override
  String get regDomainIsm => 'ISM (2.4GHz)';

  @override
  String get regDomainEuLbt => 'EU CE (2.4GHz LBT)';

  @override
  String get regDomainAu915 => 'AU (915MHz)';

  @override
  String get regDomainFcc915 => 'FCC (915MHz)';

  @override
  String get regDomainEu868 => 'EU (868MHz)';

  @override
  String get regDomainIn866 => 'IN (866MHz)';

  @override
  String get regDomainAu433 => 'AU (433MHz)';

  @override
  String get regDomainEu433 => 'EU (433MHz)';

  @override
  String get regDomainUs433 => 'US (433MHz)';
}
