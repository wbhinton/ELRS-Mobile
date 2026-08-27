// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Bindingsfrase';

  @override
  String get networkSsidLabel => 'WiFi SSID';

  @override
  String get flashingButtonLabel => 'Flash';

  @override
  String get packetRateLabel => 'Pakkehastighet';

  @override
  String get baudRateLabel => 'Baudrate';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Oppdaterer $expressLRS-fastvare på $radioMaster- eller $betaFPV-maskinvare...';
  }

  @override
  String get flashDeviceLabel => 'Flash enhet';

  @override
  String get deviceConfigLabel => 'Enhetskonfigurasjon';

  @override
  String get firmwareManagerLabel => 'Fastvarebehandler';

  @override
  String get settingsLabel => 'Innstillinger';

  @override
  String get helpSupportLabel => 'Hjelp og støtte';

  @override
  String get noDeviceFoundLabel => 'Ingen enhet funnet';

  @override
  String get retryLabel => 'Prøv igjen';

  @override
  String get manualConnectionLabel => 'Manuell tilkobling';

  @override
  String get manualIpOverrideLabel => 'Manuell IP-overstyring';

  @override
  String get connectLabel => 'Koble til';

  @override
  String get cancelLabel => 'Avbryt';

  @override
  String get matchedLabel => 'Matchet';

  @override
  String get mismatchLabel => 'Avvik';

  @override
  String connectedLabel(String ip) {
    return 'Tilkoblet: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Flashing og WiFi';

  @override
  String get aboutSupportCategoryLabel => 'Om og støtte';

  @override
  String get advancedCategoryLabel => 'Avansert';

  @override
  String get flashingDefaultsSectionLabel =>
      'Standardinnstillinger for flashing';

  @override
  String get default24GHzDomainLabel => 'Standard 2,4 GHz-domene';

  @override
  String get defaultSubGHzDomainLabel => 'Standard Sub-GHz-domene';

  @override
  String get globalBindingPhraseLabel => 'Global bindingsfrase';

  @override
  String get homeWifiSsidLabel => 'Hjemme-WiFi SSID';

  @override
  String get homeWifiPasswordLabel => 'Hjemme-WiFi passord';

  @override
  String get manageCachedFirmwareLabel => 'Administrer bufret fastvare';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Last ned eller slett frakoblet fastvare';

  @override
  String get maxCachedVersionsLabel => 'Maks antall bufrede versjoner';

  @override
  String get clearFirmwareCacheLabel => 'Tøm fastvarebuffer';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Slett alle nedlastede fastvarefiler';

  @override
  String get clearLabel => 'TØM';

  @override
  String get aboutSectionLabel => 'Om';

  @override
  String get appVersionLabel => 'Appversjon';

  @override
  String get legalLicenseLabel => 'Juridisk og lisens';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standard ansvarsfraskrivelse og GPLv3-lisens';

  @override
  String get supportDevelopmentLabel => 'Støtt utviklingen';

  @override
  String get supportDevelopmentSubtitle => 'Støtt utvikleren via Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Del analysedata';

  @override
  String get shareAnalyticsSubtitle =>
      'Hjelp til med å forbedre appen ved å dele anonyme bruksdata';

  @override
  String get expertModeLabel => 'Ekspertmodus';

  @override
  String get expertModeSubtitle =>
      'Aktiver avansert fastvarehåndtering og nedlastinger';

  @override
  String get exportElrsLuaScriptLabel => 'Eksporter ELRS Lua-skript';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Lagre elrs.lua for EdgeTX/OpenTX-radioer';

  @override
  String get submitDebugReportLabel => 'Send feilrapport til Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Hjelp oss å fikse feil ved å dele anonyme systemlogger';

  @override
  String get clearFirmwareCacheTitle => 'Tømme fastvarebuffer?';

  @override
  String get clearFirmwareCacheMessage =>
      'Dette vil slette alle nedlastede zip-filer med fastvare. Du må laste dem ned på nytt hvis du vil flashe frakoblet.';

  @override
  String get clearAllLabel => 'TØM ALT';

  @override
  String get submitDebugReportTitle => 'Send feilrapport';

  @override
  String get submitDebugReportMessage =>
      'Dette vil sende enhetsinformasjon og applogger til Sentry for feilsøking. Ingen personlig informasjon som bindingsfraser eller WiFi-passord vil bli inkludert.';

  @override
  String get describeIssueHint => 'Beskriv problemet du opplever...';

  @override
  String get proceedLabel => 'Fortsett';

  @override
  String get submittingReportProgress => 'Sender rapport…';

  @override
  String get saveLabel => 'Lagre';

  @override
  String get notSetLabel => 'Ikke angitt';

  @override
  String get languageOverrideLabel => 'Språk';

  @override
  String get languageOverrideSystemDefault => 'Systemstandard';

  @override
  String get legalNoticeSectionTitle => 'Juridisk merknad';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile er et gratis og åpen kildekode-prosjekt (FOSS) utviklet uavhengig av Weston Hinton. Dette prosjektet er ikke et offisielt produkt fra ExpressLRS LLC og støttes, godkjennes eller sertifiseres ikke offisielt av ExpressLRS-utviklingsteamet.';

  @override
  String get trademarkNoticeSectionTitle => 'Varemerkeerklæring';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS og ExpressLRS-logoen er varemerker for ExpressLRS LLC. Bruk av disse merkene er kun for beskrivende formål og kompatibilitet. For den offisielle ExpressLRS-konfiguratoren og dokumentasjon, vennligst besøk expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Offisiell støtte';

  @override
  String get officialSupportSectionText =>
      'Støtt det offisielle ExpressLRS-prosjektet: ';

  @override
  String get donateOpenCollectiveLabel => 'Doner via Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Programvarelisens';

  @override
  String get gplv3NoticeText =>
      'Dette prosjektet er lisensiert under GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Veiledning for flashing';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Ressurser';

  @override
  String get resourceCommunitySupport => 'Fellesskap og støtte';

  @override
  String get resourceDiscordCommunity => 'Discord-fellesskap';

  @override
  String get resourceJoinDiscord => 'Bli med i ELRS Discord';

  @override
  String get resourceGithubRepo => 'GitHub-depot';

  @override
  String get resourceFlashRecovery => 'Gjenoppretting etter flashing';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Hvis enheten virker uresponsiv etter en mislykket flashing:';

  @override
  String get resourceRecoveryStep1 =>
      'Hold inne BOOT-knappen mens du kobler til via USB for å gå inn i bootloader-modus.';

  @override
  String get resourceRecoveryStep2 =>
      'Bruk ELRS Web Flasher på expresslrs.org/flasher for å flashe på nytt over USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'For WiFi-kompatible enheter, hold BOOT inne i 60 sekunder for å starte WiFi Hotspot-gjenopprettingsmodus.';

  @override
  String get resourceRecoveryStep4 =>
      'Bli med i #help på ELRS Discord — fellesskapet kan vanligvis gjenopprette enhver enhet.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Joshua Bardwells gjenopprettingsguide anbefales på det sterkeste:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'Gjenopprettingsvideo';

  @override
  String get resourceLegalLiability => 'Juridisk og ansvar';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile leveres som den er, uten noen form for garanti. Utviklerne er ikke ansvarlige for eventuelle skader, tap av data eller maskinvarefeil som følge av bruk av denne applikasjonen, inkludert, men ikke begrenset til, ubrukelige («bricked») mottakere, sendere eller flykontrollere.\n\nVed å bruke denne appen påtar du deg fullt ansvar for maskinvaren din.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Vis fullstendig ansvarsfraskrivelse';

  @override
  String get disclaimerTitle => 'Bruk på eget ansvar';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile leveres som den er, uten noen form for garanti.';

  @override
  String get disclaimerLiability =>
      'Utviklerne er ikke ansvarlige for eventuelle skader, tap av data eller maskinvarefeil som følge av bruk av denne applikasjonen, inkludert, men ikke begrenset til, ubrukelige («bricked») mottakere, sendere eller flykontrollere.';

  @override
  String get disclaimerAgreement =>
      'Ved å bruke denne appen bekrefter du at du forstår risikoen ved å flashe tilpasset fastvare og påtar deg fullt ansvar for maskinvaren din.';

  @override
  String get disclaimerVerification =>
      'Bekreft alltid mål- og fastvareversjon før flashing. Behold en sikkerhetskopi av den opprinnelige fastvaren hvis mulig.';

  @override
  String get disclaimerUnderstand => 'Jeg forstår';

  @override
  String get optionsTitle => 'Fastvarealternativer';

  @override
  String get optionsSubtitle => 'Konfigurer binding og nettverksopplysninger.';

  @override
  String get wifiPasswordLabel => 'WiFi-passord';

  @override
  String get wifiOnIntervalLabel => 'Intervall for automatisk WiFi';

  @override
  String get regulatoryDomainLabel => 'Regulatorisk domene';

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
