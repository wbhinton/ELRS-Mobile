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
  String get flashingStatusLocating => 'Locating Firmware';

  @override
  String get flashingStatusUnpacking => 'Unpacking Firmware';

  @override
  String get flashingStatusDownloading => 'Downloading Firmware';

  @override
  String get flashingStatusBuilding => 'Building Firmware';

  @override
  String get flashingStatusUploading => 'Uploading to Device';

  @override
  String get flashingStatusFinalizing => 'Writing to Device — Please Wait';

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
  String get supportDevelopmentLabel => 'Support Development';

  @override
  String get supportDevelopmentSubtitle => 'Support the developer via Ko-fi';

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

  @override
  String get flashingStatusSaved => 'Firmware Saved';

  @override
  String get flashErrorNoTarget => 'Please select a target device.';

  @override
  String get flashErrorNoVersion => 'Please select a firmware version.';

  @override
  String get flashErrorNoDevice => 'Cannot flash: no ELRS device connected.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Incompatible chip: this firmware is built for $targetChip, but the connected device is $deviceChip. Select a target for the same chip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'No internet access to fetch missing files. Please disconnect from the ELRS device, download this firmware via the Firmware Manager to complete your cache, and try again.';

  @override
  String get flashErrorOfflineDownload =>
      'No internet access. You cannot download firmware while connected to the ELRS device hotspot. Please disconnect, download this version via the Firmware Manager, and try again.';

  @override
  String get flashErrorFlashFailed => 'Flashing failed.';

  @override
  String get flashErrorUnconfirmed =>
      'The device disconnected before confirming the flash, so it may not have completed. This happens if it loses power or restarts mid-flash, and occasionally on a weak WiFi link after a successful flash. Check the firmware version in Device Config, and flash again if it hasn\'t changed.';

  @override
  String get flashErrorDownloadFailed => 'Failed to download firmware.';

  @override
  String get validationSsidTooLong => 'SSID must be 32 characters or less';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get validationPasswordTooLong =>
      'Password must be 63 characters or less';

  @override
  String get targetMismatchTitle => 'Target Mismatch';

  @override
  String get targetMismatchMessage =>
      'The selected firmware target does not match the hardware currently running on the device. Are you sure you want to force flash?';

  @override
  String get forceFlashLabel => 'Force Flash';

  @override
  String get noBindPhraseTitle => 'No Binding Phrase';

  @override
  String get noBindPhraseMessage =>
      'No binding phrase set. Proceed with the default (empty)?';

  @override
  String get flashSuccessSnackbar => 'Flashing completed successfully!';

  @override
  String get firmwareSavedSnackbar => 'Firmware saved successfully!';

  @override
  String get flashSuccessMessage => 'Flashing Successful! Device is rebooting.';

  @override
  String get stm32OtaWarning =>
      'STM32 Target Selected: OTA flashing is not supported for this hardware. You can build and save this firmware locally to flash manually via STLink or Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'Download Binary';

  @override
  String get waitingForDeviceLabel => 'Waiting for Device...';

  @override
  String get otaUnavailableLabel => 'OTA Unavailable';

  @override
  String get doneLabel => 'Done';

  @override
  String get targetSelectionTitle => 'Target Selection';

  @override
  String get deviceTypeLabel => 'Device Type';

  @override
  String get deviceVendorLabel => 'Device Vendor';

  @override
  String get regulatoryFrequencyLabel => 'Regulatory & Frequency';

  @override
  String get deviceTargetLabel => 'Device Target';

  @override
  String get noFirmwareDownloadedButton =>
      'No firmware downloaded. Go to Firmware Manager';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Hardware requires v$version or newer.';
  }

  @override
  String get downloadCompatibleFirmwareButton => 'Download Compatible Firmware';

  @override
  String get firmwareVersionLabel => 'Firmware Version';

  @override
  String get firmwareVersionHelper => 'Select the ELRS version to flash';

  @override
  String get cachedBadge => '(Cached)';

  @override
  String errorLoadingVersions(String error) {
    return 'Error loading versions: $error';
  }

  @override
  String get flashingProfileLabel => 'Flashing Profile';

  @override
  String get addProfileTooltip => 'Add Profile';

  @override
  String get deleteProfileTooltip => 'Delete Profile';

  @override
  String get bindingPhraseHelper => 'Your unique binding phrase';

  @override
  String get addProfileTitle => 'Add Flashing Profile';

  @override
  String get profileNameHint => 'Profile Name (e.g., My Quads)';

  @override
  String get addLabel => 'Add';

  @override
  String get deleteProfileTitle => 'Delete Profile';

  @override
  String deleteProfileMessage(String name) {
    return 'Are you sure you want to delete the profile \"$name\"?';
  }

  @override
  String get deleteLabel => 'Delete';

  @override
  String get settingsCategoryProfilesNetwork => 'Profiles & Network';

  @override
  String get settingsCategoryAppStorage => 'App & Storage';

  @override
  String get settingsCategoryAdvancedDebug => 'Advanced & Debug';

  @override
  String get settingsCategoryAboutLegal => 'About & Legal';

  @override
  String get settingsSectionRegulatoryDefaults => 'Regulatory Defaults';

  @override
  String get settingsSectionPreferences => 'Preferences';

  @override
  String get settingsSectionPowerTools => 'Power Tools';

  @override
  String get settingsSectionDiagnostics => 'Diagnostics';

  @override
  String get regDomainUnknown => 'Unknown';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versions',
      one: '1 version',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Edit $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Enter $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua saved to device!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Failed to save script: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Submitted! Event ID: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Report submitted successfully!';

  @override
  String debugReportFailed(String error) {
    return 'Failed to submit: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Error loading license: $error';
  }
}
