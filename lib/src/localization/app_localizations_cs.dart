// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Vazebná fráze';

  @override
  String get networkSsidLabel => 'SSID Wi-Fi';

  @override
  String get flashingButtonLabel => 'Nahrát';

  @override
  String get packetRateLabel => 'Rychlost paketů';

  @override
  String get baudRateLabel => 'Baudová rychlost';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Aktualizuji firmware $expressLRS na hardwaru $radioMaster nebo $betaFPV...';
  }

  @override
  String get flashDeviceLabel => 'Nahrát zařízení';

  @override
  String get deviceConfigLabel => 'Konfigurace zařízení';

  @override
  String get firmwareManagerLabel => 'Správce firmwaru';

  @override
  String get settingsLabel => 'Nastavení';

  @override
  String get helpSupportLabel => 'Nápověda a podpora';

  @override
  String get noDeviceFoundLabel => 'Žádné zařízení nebylo nalezeno';

  @override
  String get retryLabel => 'Opakovat';

  @override
  String get manualConnectionLabel => 'Ruční připojení';

  @override
  String get manualIpOverrideLabel => 'Ruční přepsání IP adresy';

  @override
  String get connectLabel => 'Připojit';

  @override
  String get cancelLabel => 'Zrušit';

  @override
  String get matchedLabel => 'Shoduje se';

  @override
  String get mismatchLabel => 'Neshoda';

  @override
  String connectedLabel(String ip) {
    return 'Připojeno: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Nahrávání firmwaru a Wi-Fi';

  @override
  String get aboutSupportCategoryLabel => 'O aplikaci a podpora';

  @override
  String get advancedCategoryLabel => 'Pokročilé';

  @override
  String get flashingDefaultsSectionLabel =>
      'Výchozí nastavení nahrávání firmwaru';

  @override
  String get default24GHzDomainLabel => 'Výchozí doména 2.4GHz';

  @override
  String get defaultSubGHzDomainLabel => 'Výchozí doména Sub-GHz';

  @override
  String get globalBindingPhraseLabel => 'Globální vazebná fráze';

  @override
  String get homeWifiSsidLabel => 'SSID domácí Wi-Fi';

  @override
  String get homeWifiPasswordLabel => 'Heslo domácí Wi-Fi';

  @override
  String get manageCachedFirmwareLabel => 'Spravovat firmware v mezipaměti';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Stáhnout nebo smazat offline firmware';

  @override
  String get maxCachedVersionsLabel => 'Max. počet verzí v mezipaměti';

  @override
  String get clearFirmwareCacheLabel => 'Vyčistit mezipaměť firmwaru';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Smazat všechny stažené soubory firmwaru';

  @override
  String get clearLabel => 'VYČISTIT';

  @override
  String get aboutSectionLabel => 'O aplikaci';

  @override
  String get appVersionLabel => 'Verze aplikace';

  @override
  String get legalLicenseLabel => 'Právní informace a licence';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standardní prohlášení a licence GPLv3';

  @override
  String get developerSectionLabel => 'Vývojář';

  @override
  String get developerModeEnabledLabel => 'Režim vývojáře povolen';

  @override
  String get testSentryErrorCaptureLabel => 'Test zachycení chyb Sentry';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Odešle testovací výjimku do Sentry — zkontrolujte řídicí panel';

  @override
  String get shareAnalyticsLabel => 'Sdílet analýzy';

  @override
  String get shareAnalyticsSubtitle =>
      'Pomozte vylepšit aplikaci sdílením anonymních dat o používání';

  @override
  String get expertModeLabel => 'Expertní režim';

  @override
  String get expertModeSubtitle =>
      'Povolit pokročilé zpracování a stahování firmwaru';

  @override
  String get exportElrsLuaScriptLabel => 'Exportovat ELRS Lua Script';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Uložit soubor elrs.lua pro rádia EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel => 'Odeslat zprávu o ladění do Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Pomozte nám opravit chyby sdílením anonymních systémových protokolů';

  @override
  String get clearFirmwareCacheTitle => 'Vyčistit mezipaměť firmwaru?';

  @override
  String get clearFirmwareCacheMessage =>
      'Tímto odstraníte všechny stažené soubory firmwaru (ZIP). Budete je muset znovu stáhnout, pokud chcete nahrávat firmware offline.';

  @override
  String get clearAllLabel => 'VYČISTIT VŠE';

  @override
  String get submitDebugReportTitle => 'Odeslat zprávu o ladění';

  @override
  String get submitDebugReportMessage =>
      'Tímto odešlete informace o vašem zařízení a protokoly aplikace do Sentry pro účely ladění. Nebudou zahrnuty žádné osobní údaje, jako jsou vazebné fráze nebo hesla Wi-Fi.';

  @override
  String get describeIssueHint =>
      'Popište prosím problém, který se vyskytuje...';

  @override
  String get proceedLabel => 'Pokračovat';

  @override
  String get submittingReportProgress => 'Odesílám zprávu…';

  @override
  String get saveLabel => 'Uložit';

  @override
  String get notSetLabel => 'Nenastaveno';

  @override
  String get languageOverrideLabel => 'Jazyk';

  @override
  String get languageOverrideSystemDefault => 'Výchozí systémový';

  @override
  String get legalNoticeSectionTitle => 'Právní upozornění';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile je bezplatný a open-source (FOSS) projekt vyvinutý nezávisle Westonem Hintonem. Tento projekt není oficiálním produktem ExpressLRS LLC a není oficiálně podporován, schválen ani certifikován vývojovým týmem ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Upozornění na ochrannou známku';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS a logo ExpressLRS jsou ochranné známky společnosti ExpressLRS LLC. Použití těchto značek je pouze pro popisné a kompatibilní účely. Pro oficiální konfigurátor a dokumentaci ExpressLRS navštivte expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Oficiální podpora';

  @override
  String get officialSupportSectionText =>
      'Podpořte oficiální projekt ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel => 'Darovat přes Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Softwarová licence';

  @override
  String get gplv3NoticeText =>
      'Tento projekt je licencován pod GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Průvodce flashováním';

  @override
  String get tabFaq => 'Často kladené dotazy';

  @override
  String get tabResources => 'Zdroje';

  @override
  String get resourceCommunitySupport => 'Komunita a podpora';

  @override
  String get resourceDiscordCommunity => 'Komunita na Discordu';

  @override
  String get resourceJoinDiscord => 'Připojte se k ELRS Discordu';

  @override
  String get resourceGithubRepo => 'Úložiště na GitHubu';

  @override
  String get resourceFlashRecovery => 'Obnova po flashování';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Pokud vaše zařízení nereaguje po neúspěšném flashování:';

  @override
  String get resourceRecoveryStep1 =>
      'Podržte tlačítko BOOT a připojte zařízení přes USB pro vstup do režimu bootloaderu.';

  @override
  String get resourceRecoveryStep2 =>
      'Použijte ELRS Web Flasher na expresslrs.org/flasher pro opětovné flashování přes USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'U zařízení s podporou WiFi podržte BOOT po dobu 60 sekund pro spuštění režimu obnovy WiFi hotspotu.';

  @override
  String get resourceRecoveryStep4 =>
      'Připojte se k #help na ELRS Discordu — komunita obvykle dokáže obnovit jakékoli zařízení.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Důrazně doporučujeme průvodce od Joshua Bardwella pro obnovení zařízení:';

  @override
  String get resourceWebFlasherButton => 'Webový flasher';

  @override
  String get resourceRecoveryVideoButton => 'Video k obnově';

  @override
  String get resourceLegalLiability => 'Právní a odpovědnostní';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile je poskytován „tak jak je“, bez jakékoli záruky. Vývojáři nenesou odpovědnost za jakékoli škody, ztrátu dat nebo nefunkční hardware vyplývající z používání této aplikace, včetně, ale nikoli výhradně, „zazděných“ přijímačů, vysílačů nebo letových ovladačů.\n\nPoužíváním této aplikace přebíráte plnou odpovědnost za váš hardware.';

  @override
  String get resourceViewFullDisclaimerButton => 'Zobrazit celé prohlášení';

  @override
  String get disclaimerTitle => 'Používáte na vlastní riziko';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile je poskytován „tak jak je“, bez jakékoli záruky.';

  @override
  String get disclaimerLiability =>
      'Vývojáři nenesou odpovědnost za jakékoli škody, ztrátu dat nebo nefunkční hardware vyplývající z používání této aplikace, včetně, ale nikoli výhradně, „zazděných“ přijímačů, vysílačů nebo letových ovladačů.';

  @override
  String get disclaimerAgreement =>
      'Používáním této aplikace potvrzujete, že rozumíte rizikům flashování vlastního firmwaru a přebíráte plnou odpovědnost za svůj hardware.';

  @override
  String get disclaimerVerification =>
      'Před flashováním vždy ověřte cíl a verzi firmwaru. Pokud je to možné, uchovejte si záznam o původním firmwaru.';

  @override
  String get disclaimerUnderstand => 'Rozumím';

  @override
  String get optionsTitle => 'Možnosti firmwaru';

  @override
  String get optionsSubtitle =>
      'Konfigurujte vazbu a síťové přihlašovací údaje.';

  @override
  String get wifiPasswordLabel => 'Heslo k WiFi';

  @override
  String get wifiOnIntervalLabel => 'Interval automatického zapnutí Wi-Fi';

  @override
  String get regulatoryDomainLabel => 'Regulační doména';

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
