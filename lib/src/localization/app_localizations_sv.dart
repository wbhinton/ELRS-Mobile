// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Bindningsfras';

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
  String get flashDeviceLabel => 'Flashenhet';

  @override
  String get deviceConfigLabel => 'Enhetskonfiguration';

  @override
  String get firmwareManagerLabel => 'Firmwarehanterare';

  @override
  String get settingsLabel => 'Inställningar';

  @override
  String get helpSupportLabel => 'Hjälp & support';

  @override
  String get noDeviceFoundLabel => 'Ingen enhet hittades';

  @override
  String get retryLabel => 'Försök igen';

  @override
  String get manualConnectionLabel => 'Manuell anslutning';

  @override
  String get manualIpOverrideLabel => 'Manuell IP-åsidosättning';

  @override
  String get connectLabel => 'Anslut';

  @override
  String get cancelLabel => 'Avbryt';

  @override
  String get matchedLabel => 'Matchad';

  @override
  String get mismatchLabel => 'Ej matchad';

  @override
  String connectedLabel(String ip) {
    return 'Ansluten: $ip';
  }

  @override
  String get default24GHzDomainLabel => 'Standard 2,4 GHz-domän';

  @override
  String get defaultSubGHzDomainLabel => 'Standard Sub-GHz-domän';

  @override
  String get globalBindingPhraseLabel => 'Global bindningsfras';

  @override
  String get homeWifiSsidLabel => 'Hem-WiFi-SSID';

  @override
  String get homeWifiPasswordLabel => 'Hem-WiFi-lösenord';

  @override
  String get manageCachedFirmwareLabel => 'Hantera cachad firmware';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Ladda ner eller ta bort offline firmware';

  @override
  String get maxCachedVersionsLabel => 'Maximalt antal cachade versioner';

  @override
  String get clearFirmwareCacheLabel => 'Rensa firmware-cache';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Ta bort alla nedladdade firmware-filer';

  @override
  String get clearLabel => 'RENSA';

  @override
  String get appVersionLabel => 'Appversion';

  @override
  String get legalLicenseLabel => 'Juridiskt & licens';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standardfriskrivning och GPLv3-licens';

  @override
  String get supportDevelopmentLabel => 'Stöd utvecklingen';

  @override
  String get supportDevelopmentSubtitle => 'Stöd utvecklaren via Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Dela analysdata';

  @override
  String get shareAnalyticsSubtitle =>
      'Hjälp till att förbättra appen genom att dela anonym användningsdata';

  @override
  String get expertModeLabel => 'Expertläge';

  @override
  String get expertModeSubtitle =>
      'Aktivera avancerad firmware-hantering och nedladdning';

  @override
  String get exportElrsLuaScriptLabel => 'Exportera ELRS Lua-skript';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Spara elrs.lua för EdgeTX/OpenTX-radioenheter';

  @override
  String get submitDebugReportLabel => 'Skicka debug-rapport till Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Hjälp oss att åtgärda buggar genom att dela anonyma systemloggar';

  @override
  String get clearFirmwareCacheTitle => 'Rensa firmware-cache?';

  @override
  String get clearFirmwareCacheMessage =>
      'Detta kommer att ta bort alla nedladdade firmware-zip-filer. Du måste ladda ner dem igen om du vill flasha offline.';

  @override
  String get clearAllLabel => 'RENSA ALLT';

  @override
  String get submitDebugReportTitle => 'Skicka debug-rapport';

  @override
  String get submitDebugReportMessage =>
      'Detta kommer att skicka din enhetsinformation och apploggar till Sentry för felsökning. Ingen personlig information som bindningsfraser eller WiFi-lösenord kommer att inkluderas.';

  @override
  String get describeIssueHint => 'Beskriv problemet du upplever...';

  @override
  String get proceedLabel => 'Fortsätt';

  @override
  String get submittingReportProgress => 'Skickar rapport…';

  @override
  String get saveLabel => 'Spara';

  @override
  String get notSetLabel => 'Ej inställt';

  @override
  String get languageOverrideLabel => 'Språk';

  @override
  String get languageOverrideSystemDefault => 'Systemstandard';

  @override
  String get legalNoticeSectionTitle => 'Juridisk information';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile är ett gratis och öppen källkods (FOSS) projekt utvecklat oberoende av Weston Hinton. Detta projekt är inte en officiell produkt från ExpressLRS LLC och stöds, godkänns eller certifieras inte officiellt av ExpressLRS utvecklingsteam.';

  @override
  String get trademarkNoticeSectionTitle => 'Information om varumärken';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS och ExpressLRS-logotypen är varumärken som tillhör ExpressLRS LLC. Användning av dessa märken sker endast i beskrivande syfte och för kompatibilitet. För den officiella ExpressLRS-konfiguratorn och dokumentationen, besök expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Officiellt stöd';

  @override
  String get officialSupportSectionText =>
      'Stöd det officiella ExpressLRS-projektet: ';

  @override
  String get donateOpenCollectiveLabel => 'Donera via Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Programvarulicens';

  @override
  String get gplv3NoticeText =>
      'Detta projekt är licensierat under GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Guide för flashning';

  @override
  String get tabFaq => 'Vanliga frågor';

  @override
  String get tabResources => 'Resurser';

  @override
  String get resourceCommunitySupport => 'Gemenskap & Support';

  @override
  String get resourceDiscordCommunity => 'Discord-gemenskap';

  @override
  String get resourceJoinDiscord => 'Gå med i ELRS Discord';

  @override
  String get resourceGithubRepo => 'GitHub-arkiv';

  @override
  String get resourceFlashRecovery => 'Återställning efter flashning';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Om din enhet verkar inte svara efter en misslyckad flashning:';

  @override
  String get resourceRecoveryStep1 =>
      'Håll in BOOT-knappen medan du ansluter via USB för att gå in i bootloader-läge.';

  @override
  String get resourceRecoveryStep2 =>
      'Använd ELRS Web Flasher på expresslrs.org/flasher för att flasha om via USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'För WiFi-kompatibla enheter, håll in BOOT i 60 sekunder för att aktivera WiFi Hotspot-återställningsläge.';

  @override
  String get resourceRecoveryStep4 =>
      'Gå med i #help på ELRS Discord — gemenskapen kan oftast återställa vilken enhet som helst.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Joshua Bardwells \'unbricking\'-guide rekommenderas starkt:';

  @override
  String get resourceWebFlasherButton => 'Webb-flasher';

  @override
  String get resourceRecoveryVideoButton => 'Återställningsvideo';

  @override
  String get resourceLegalLiability => 'Juridik & Ansvar';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile tillhandahålls i befintligt skick, utan någon form av garanti. Utvecklarna är inte ansvariga för någon skada, dataförlust eller icke-fungerande hårdvara som uppstår till följd av användningen av denna applikation, inklusive men inte begränsat till \"bricked\" mottagare, sändare eller flygkontroller.\n\nGenom att använda denna app accepterar du fullt ansvar för din hårdvara.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Visa fullständig friskrivning';

  @override
  String get disclaimerTitle => 'Använd på egen risk';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile tillhandahålls i befintligt skick, utan någon form av garanti.';

  @override
  String get disclaimerLiability =>
      'Utvecklarna är inte ansvariga för någon skada, dataförlust eller icke-fungerande hårdvara som uppstår till följd av användningen av denna applikation, inklusive men inte begränsat till \"bricked\" mottagare, sändare eller flygkontroller.';

  @override
  String get disclaimerAgreement =>
      'Genom att använda denna app bekräftar du att du förstår riskerna med att flasha anpassad firmware och accepterar fullt ansvar för din hårdvara.';

  @override
  String get disclaimerVerification =>
      'Verifiera alltid mål- och firmware-versionen innan du flashar. Spara en kopia av din ursprungliga firmware om möjligt.';

  @override
  String get disclaimerUnderstand => 'Jag förstår';

  @override
  String get optionsTitle => 'Firmware-alternativ';

  @override
  String get optionsSubtitle => 'Konfigurera bindning och nätverksuppgifter.';

  @override
  String get wifiPasswordLabel => 'WiFi-lösenord';

  @override
  String get wifiOnIntervalLabel => 'Wi-Fi Automatisk på-intervall';

  @override
  String get regulatoryDomainLabel => 'Regulatoriskt område';

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

  @override
  String get firmwareErrorLoadFailed => 'Could not load firmware versions.';

  @override
  String get firmwareErrorOnHotspot =>
      'Cannot download firmware while connected directly to the receiver\'s WiFi hotspot. Please disconnect or use a home network.';

  @override
  String get firmwareErrorCacheFull =>
      'Cache limit reached. Please delete an old version.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Unable to reach the firmware server. Please check your internet connection.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Download interrupted: the network connection was lost. Please check your connection and try again.';

  @override
  String get firmwareErrorDownloadFailed => 'Failed to download firmware.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Could not delete this firmware version.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Version $version';
  }

  @override
  String get readyForOfflineUse => 'Ready for offline use';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Storage Used: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Versions';
  }

  @override
  String get splashTagline => 'Independent Configuration Tool';

  @override
  String get splashDisclaimer =>
      'Not an official ExpressLRS product.\nCompatible with 3.3.x/4.x firmware.';

  @override
  String get unknownDeviceName => 'ELRS Device';

  @override
  String get unknownIpLabel => 'Unknown IP';

  @override
  String get firmwareBinariesFileType => 'Firmware Binaries';

  @override
  String helpContentLoadFailed(String error) {
    return 'Error loading help content: $error';
  }
}
