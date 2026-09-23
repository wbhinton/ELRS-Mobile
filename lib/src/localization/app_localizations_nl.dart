// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Bindingszin';

  @override
  String get networkSsidLabel => 'Wifi-SSID';

  @override
  String get flashingButtonLabel => 'Flashen';

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
  String get flashDeviceLabel => 'Apparaat flashen';

  @override
  String get deviceConfigLabel => 'Apparaatconfiguratie';

  @override
  String get firmwareManagerLabel => 'Firmwarebeheer';

  @override
  String get settingsLabel => 'Instellingen';

  @override
  String get helpSupportLabel => 'Help en ondersteuning';

  @override
  String get noDeviceFoundLabel => 'Geen apparaat gevonden';

  @override
  String get retryLabel => 'Opnieuw proberen';

  @override
  String get manualConnectionLabel => 'Handmatige verbinding';

  @override
  String get manualIpOverrideLabel => 'Handmatige IP-overschrijving';

  @override
  String get connectLabel => 'Verbinden';

  @override
  String get cancelLabel => 'Annuleren';

  @override
  String get matchedLabel => 'Overeenkomst';

  @override
  String get mismatchLabel => 'Geen overeenkomst';

  @override
  String connectedLabel(String ip) {
    return 'Verbonden: $ip';
  }

  @override
  String get default24GHzDomainLabel => 'Standaard 2.4GHz-domein';

  @override
  String get defaultSubGHzDomainLabel => 'Standaard Sub-GHz-domein';

  @override
  String get globalBindingPhraseLabel => 'Globale bindingszin';

  @override
  String get homeWifiSsidLabel => 'Thuis-wifi-SSID';

  @override
  String get homeWifiPasswordLabel => 'Thuis-wifi-wachtwoord';

  @override
  String get manageCachedFirmwareLabel => 'Gecachete firmware beheren';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Offline firmware downloaden of verwijderen';

  @override
  String get maxCachedVersionsLabel => 'Max. gecachete versies';

  @override
  String get clearFirmwareCacheLabel => 'Firmwarecache wissen';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Alle gedownloade firmwarebestanden verwijderen';

  @override
  String get clearLabel => 'WISSEN';

  @override
  String get appVersionLabel => 'Appversie';

  @override
  String get legalLicenseLabel => 'Juridisch en licentie';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standaard disclaimer en GPLv3-licentie';

  @override
  String get supportDevelopmentLabel => 'Ondersteun de ontwikkeling';

  @override
  String get supportDevelopmentSubtitle =>
      'Ondersteun de ontwikkelaar via Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Analytics delen';

  @override
  String get shareAnalyticsSubtitle =>
      'Help de app te verbeteren door anonieme gebruiksgegevens te delen';

  @override
  String get expertModeLabel => 'Expertmodus';

  @override
  String get expertModeSubtitle =>
      'Schakel geavanceerde firmwareverwerking en downloads in';

  @override
  String get exportElrsLuaScriptLabel => 'ELRS Lua-script exporteren';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Sla elrs.lua op voor EdgeTX/OpenTX-radio\'s';

  @override
  String get submitDebugReportLabel => 'Debugrapport indienen bij Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Help ons bugs op te lossen door anonieme systeemlogs te delen';

  @override
  String get clearFirmwareCacheTitle => 'Firmwarecache wissen?';

  @override
  String get clearFirmwareCacheMessage =>
      'Hiermee worden alle gedownloade firmware-zipbestanden verwijderd. U moet ze opnieuw downloaden als u offline wilt flashen.';

  @override
  String get clearAllLabel => 'ALLES WISSEN';

  @override
  String get submitDebugReportTitle => 'Debugrapport indienen';

  @override
  String get submitDebugReportMessage =>
      'Hiermee worden uw apparaatinformatie en app-logs naar Sentry verzonden voor debugging. Geen persoonlijke informatie zoals bindingszinnen of wifi-wachtwoorden wordt opgenomen.';

  @override
  String get describeIssueHint =>
      'Beschrijf alstublieft het probleem dat u ervaart...';

  @override
  String get proceedLabel => 'Doorgaan';

  @override
  String get submittingReportProgress => 'Rapport indienen…';

  @override
  String get saveLabel => 'Opslaan';

  @override
  String get notSetLabel => 'Niet ingesteld';

  @override
  String get languageOverrideLabel => 'Taal';

  @override
  String get languageOverrideSystemDefault => 'Systeemstandaard';

  @override
  String get legalNoticeSectionTitle => 'Juridische kennisgeving';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile is een gratis en open-source (FOSS) project, onafhankelijk ontwikkeld door Weston Hinton. Dit project is geen officieel product van ExpressLRS LLC en wordt niet officieel ondersteund, goedgekeurd of gecertificeerd door het ExpressLRS ontwikkelteam.';

  @override
  String get trademarkNoticeSectionTitle => 'Handelsmerkverklaring';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS en het ExpressLRS logo zijn handelsmerken van ExpressLRS LLC. Het gebruik van deze merken is uitsluitend voor beschrijvende en compatibiliteitsdoeleinden. Voor de officiële ExpressLRS configurator en documentatie, bezoek expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Officiële ondersteuning';

  @override
  String get officialSupportSectionText =>
      'Ondersteun het officiële ExpressLRS project: ';

  @override
  String get donateOpenCollectiveLabel => 'Doneer via Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Softwarelicentie';

  @override
  String get gplv3NoticeText =>
      'Dit project is gelicentieerd onder de GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Flashgids';

  @override
  String get tabFaq => 'Veelgestelde vragen';

  @override
  String get tabResources => 'Bronnen';

  @override
  String get resourceCommunitySupport => 'Community & ondersteuning';

  @override
  String get resourceDiscordCommunity => 'Discord community';

  @override
  String get resourceJoinDiscord => 'Word lid van de ELRS Discord';

  @override
  String get resourceGithubRepo => 'GitHub repository';

  @override
  String get resourceFlashRecovery => 'Flashherstel';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Als uw apparaat niet reageert na een mislukte flash:';

  @override
  String get resourceRecoveryStep1 =>
      'Houd de BOOT-knop ingedrukt terwijl u het apparaat via USB aansluit om de bootloader-modus te openen.';

  @override
  String get resourceRecoveryStep2 =>
      'Gebruik de ELRS Web Flasher op expresslrs.org/flasher om opnieuw te flashen via USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Voor apparaten met wifi-functionaliteit, houd BOOT 60 seconden ingedrukt om de wifi-hotspot herstelmodus te activeren.';

  @override
  String get resourceRecoveryStep4 =>
      'Word lid van #help op de ELRS Discord — de community kan meestal elk apparaat herstellen.';

  @override
  String get resourceBardwellGuideRecommended =>
      'De \'unbricking\'-handleiding van Joshua Bardwell wordt ten zeerste aanbevolen:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'Herstelvideo';

  @override
  String get resourceLegalLiability => 'Juridisch & aansprakelijkheid';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile wordt \'as-is\' geleverd, zonder enige vorm van garantie. De ontwikkelaars zijn niet verantwoordelijk voor enige schade, gegevensverlies of niet-functionerende hardware die voortvloeit uit het gebruik van deze applicatie, inclusief maar niet beperkt tot \'gebrickte\' ontvangers, zenders of vluchtcontrollers.\n\nDoor deze app te gebruiken, aanvaardt u de volledige verantwoordelijkheid voor uw hardware.';

  @override
  String get resourceViewFullDisclaimerButton => 'Bekijk volledige disclaimer';

  @override
  String get disclaimerTitle => 'Gebruik op eigen risico';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile wordt \'as-is\' geleverd, zonder enige vorm van garantie.';

  @override
  String get disclaimerLiability =>
      'De ontwikkelaars zijn niet verantwoordelijk voor enige schade, gegevensverlies of niet-functionerende hardware die voortvloeit uit het gebruik van deze applicatie, inclusief maar niet beperkt tot \'gebrickte\' ontvangers, zenders of vluchtcontrollers.';

  @override
  String get disclaimerAgreement =>
      'Door deze app te gebruiken, bevestigt u dat u de risico\'s van het flashen van aangepaste firmware begrijpt en de volledige verantwoordelijkheid voor uw hardware aanvaardt.';

  @override
  String get disclaimerVerification =>
      'Verifieer altijd het doelapparaat en de firmwareversie voordat u flasht. Bewaar indien mogelijk een kopie van uw originele firmware.';

  @override
  String get disclaimerUnderstand => 'Ik begrijp het';

  @override
  String get optionsTitle => 'Firmware-opties';

  @override
  String get optionsSubtitle => 'Configureer binding en netwerkgegevens.';

  @override
  String get wifiPasswordLabel => 'Wifi-wachtwoord';

  @override
  String get wifiOnIntervalLabel => 'WiFi automatische inschakelinterval';

  @override
  String get regulatoryDomainLabel => 'Regelgevingsdomein';

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
