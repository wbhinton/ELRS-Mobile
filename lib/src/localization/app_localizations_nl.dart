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
  String get packetRateLabel => 'Pakketfrequentie';

  @override
  String get baudRateLabel => 'Baudsnelheid';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Firmware van $expressLRS bijwerken op $radioMaster of $betaFPV hardware...';
  }

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
  String get flashingWifiCategoryLabel => 'Flashen en wifi';

  @override
  String get aboutSupportCategoryLabel => 'Over en ondersteuning';

  @override
  String get advancedCategoryLabel => 'Geavanceerd';

  @override
  String get flashingDefaultsSectionLabel =>
      'Standaardinstellingen voor flashen';

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
  String get aboutSectionLabel => 'Over';

  @override
  String get appVersionLabel => 'Appversie';

  @override
  String get legalLicenseLabel => 'Juridisch en licentie';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standaard disclaimer en GPLv3-licentie';

  @override
  String get developerSectionLabel => 'Ontwikkelaar';

  @override
  String get developerModeEnabledLabel => 'Ontwikkelaarsmodus ingeschakeld';

  @override
  String get testSentryErrorCaptureLabel => 'Test Sentry foutregistratie';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Verstuurt een testfout naar Sentry — controleer het dashboard';

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
}
