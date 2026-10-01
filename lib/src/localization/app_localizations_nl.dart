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
  String get flashingStatusLocating => 'Firmware zoeken';

  @override
  String get flashingStatusUnpacking => 'Firmware uitpakken';

  @override
  String get flashingStatusDownloading => 'Firmware downloaden';

  @override
  String get flashingStatusBuilding => 'Firmware samenstellen';

  @override
  String get flashingStatusUploading => 'Uploaden naar apparaat';

  @override
  String get flashingStatusFinalizing =>
      'Wegschrijven naar apparaat — Even geduld';

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
  String get flashingStatusSaved => 'Firmware opgeslagen';

  @override
  String get flashErrorNoTarget => 'Selecteer een doelapparaat.';

  @override
  String get flashErrorNoVersion => 'Selecteer een firmwareversie.';

  @override
  String get flashErrorNoDevice =>
      'Flashen onmogelijk: geen ELRS-apparaat verbonden.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Incompatibele chip: deze firmware is gebouwd voor $targetChip, maar het verbonden apparaat is $deviceChip. Selecteer een doel voor dezelfde chip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Geen internettoegang om ontbrekende bestanden op te halen. Koppel los van het ELRS-apparaat, download deze firmware via de Firmwarebeheerder om uw cache te voltooien en probeer het opnieuw.';

  @override
  String get flashErrorOfflineDownload =>
      'Geen internettoegang. U kunt geen firmware downloaden terwijl u verbonden bent met de hotspot van het ELRS-apparaat. Koppel los, download deze versie via de Firmwarebeheerder en probeer het opnieuw.';

  @override
  String get flashErrorFlashFailed => 'Flashen mislukt.';

  @override
  String get flashErrorUnconfirmed =>
      'Het apparaat heeft de verbinding verbroken voordat de flash bevestigd kon worden, dus het is mogelijk niet voltooid. Dit gebeurt als het de stroom verliest of opnieuw opstart tijdens het flashen, en soms bij een zwakke wifi-verbinding na een succesvolle flash. Controleer de firmwareversie in Apparaatconfiguratie en flash opnieuw als deze niet is gewijzigd.';

  @override
  String get flashErrorDownloadFailed => 'Firmware downloaden mislukt.';

  @override
  String get validationSsidTooLong => 'SSID mag maximaal 32 tekens bevatten.';

  @override
  String get validationPasswordTooShort =>
      'Wachtwoord moet minimaal 8 tekens bevatten.';

  @override
  String get validationPasswordTooLong =>
      'Wachtwoord mag maximaal 63 tekens bevatten.';

  @override
  String get targetMismatchTitle => 'Doel komt niet overeen';

  @override
  String get targetMismatchMessage =>
      'De geselecteerde firmware komt niet overeen met de hardware die momenteel op het apparaat draait. Weet u zeker dat u geforceerd wilt flashen?';

  @override
  String get forceFlashLabel => 'GEFORCEERD FLASHE N';

  @override
  String get noBindPhraseTitle => 'Geen Bindingsfrase';

  @override
  String get noBindPhraseMessage =>
      'Er is geen bindingsfrase ingesteld. Doorgaan met de standaard (leeg)?';

  @override
  String get flashSuccessSnackbar => 'Flashen succesvol voltooid!';

  @override
  String get firmwareSavedSnackbar => 'Firmware succesvol opgeslagen!';

  @override
  String get flashSuccessMessage =>
      'Flashen succesvol! Apparaat wordt opnieuw opgestart.';

  @override
  String get stm32OtaWarning =>
      'STM32-doel geselecteerd: OTA-flashen wordt niet ondersteund voor deze hardware. U kunt deze firmware lokaal bouwen en opslaan om handmatig te flashen via STLink of Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'BINAIR BESTAND DOWNLOADEN';

  @override
  String get waitingForDeviceLabel => 'WACHTEN OP APPARAAT...';

  @override
  String get otaUnavailableLabel => 'OTA niet beschikbaar';

  @override
  String get doneLabel => 'Klaar';

  @override
  String get targetSelectionTitle => 'Doelselectie';

  @override
  String get deviceTypeLabel => 'Apparaattype';

  @override
  String get deviceVendorLabel => 'Apparaatfabrikant';

  @override
  String get regulatoryFrequencyLabel => 'Regulering & Frequentie';

  @override
  String get deviceTargetLabel => 'Doelapparaat';

  @override
  String get noFirmwareDownloadedButton =>
      'Geen firmware gedownload. Ga naar Firmwarebeheer';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Hardware vereist v$version of nieuwer.';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'Compatibele firmware downloaden';

  @override
  String get firmwareVersionLabel => 'Firmwareversie';

  @override
  String get firmwareVersionHelper => 'Selecteer de ELRS-versie om te flashen';

  @override
  String get cachedBadge => '(In cache)';

  @override
  String errorLoadingVersions(String error) {
    return 'Fout bij laden versies: $error';
  }

  @override
  String get flashingProfileLabel => 'Flashprofiel';

  @override
  String get addProfileTooltip => 'Profiel toevoegen';

  @override
  String get deleteProfileTooltip => 'Profiel verwijderen';

  @override
  String get bindingPhraseHelper => 'Je unieke bindingsfrase';

  @override
  String get addProfileTitle => 'Flashprofiel toevoegen';

  @override
  String get profileNameHint => 'Profielnaam (bijv. Mijn Quads)';

  @override
  String get addLabel => 'Toevoegen';

  @override
  String get deleteProfileTitle => 'Profiel verwijderen';

  @override
  String deleteProfileMessage(String name) {
    return 'Weet je zeker dat je profiel \"$name\" wilt verwijderen?';
  }

  @override
  String get deleteLabel => 'Verwijderen';

  @override
  String get settingsCategoryProfilesNetwork => 'Profielen & Netwerk';

  @override
  String get settingsCategoryAppStorage => 'App & Opslag';

  @override
  String get settingsCategoryAdvancedDebug => 'Geavanceerd & Foutopsporing';

  @override
  String get settingsCategoryAboutLegal => 'Over & Juridisch';

  @override
  String get settingsSectionRegulatoryDefaults => 'Standaard Regelgeving';

  @override
  String get settingsSectionPreferences => 'Voorkeuren';

  @override
  String get settingsSectionPowerTools => 'Geavanceerde Hulpmiddelen';

  @override
  String get settingsSectionDiagnostics => 'Diagnostiek';

  @override
  String get regDomainUnknown => 'Onbekend';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versies',
      one: '1 versie',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return '$field bewerken';
  }

  @override
  String enterFieldHint(String field) {
    return 'Voer $field in';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua opgeslagen op apparaat!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Opslaan van script mislukt: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Verzonden! Gebeurtenis-ID: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Rapport succesvol verzonden!';

  @override
  String debugReportFailed(String error) {
    return 'Verzenden mislukt: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Fout bij laden licentie: $error';
  }

  @override
  String get firmwareErrorLoadFailed => 'Kon firmwareversies niet laden.';

  @override
  String get firmwareErrorOnHotspot =>
      'Kan firmware niet downloaden terwijl u direct verbonden bent met de wifi-hotspot van de ontvanger. Verbreek de verbinding of gebruik een thuisnetwerk.';

  @override
  String get firmwareErrorCacheFull =>
      'Cachelimiet bereikt. Verwijder een oudere versie.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Kan de firmwareserver niet bereiken. Controleer uw internetverbinding.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Download onderbroken: de netwerkverbinding is verloren gegaan. Controleer uw verbinding en probeer het opnieuw.';

  @override
  String get firmwareErrorDownloadFailed => 'Firmware downloaden mislukt.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Kon deze firmwareversie niet verwijderen.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Versie $version';
  }

  @override
  String get readyForOfflineUse => 'Klaar voor offline gebruik';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Gebruikte opslag: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Versies';
  }

  @override
  String get splashTagline => 'Onafhankelijke configuratietool';

  @override
  String get splashDisclaimer =>
      'Geen officieel ExpressLRS-product.\nCompatibel met 3.3.x/4.x firmware.';

  @override
  String get unknownDeviceName => 'ELRS-apparaat';

  @override
  String get unknownIpLabel => 'Onbekend IP-adres';

  @override
  String get firmwareBinariesFileType => 'Firmware binaire bestanden';

  @override
  String helpContentLoadFailed(String error) {
    return 'Fout bij laden van helpinhoud: $error';
  }
}
