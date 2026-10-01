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
  String get flashingStatusLocating => 'Vyhledávání firmwaru';

  @override
  String get flashingStatusUnpacking => 'Rozbalování firmwaru';

  @override
  String get flashingStatusDownloading => 'Stahování firmwaru';

  @override
  String get flashingStatusBuilding => 'Sestavování firmwaru';

  @override
  String get flashingStatusUploading => 'Nahrávání do zařízení';

  @override
  String get flashingStatusFinalizing => 'Zápis do zařízení – prosím, počkejte';

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
  String get appVersionLabel => 'Verze aplikace';

  @override
  String get legalLicenseLabel => 'Právní informace a licence';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standardní prohlášení a licence GPLv3';

  @override
  String get supportDevelopmentLabel => 'Podpora vývoje';

  @override
  String get supportDevelopmentSubtitle => 'Podpořte vývojáře přes Ko-fi';

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

  @override
  String get flashingStatusSaved => 'Firmware uložen';

  @override
  String get flashErrorNoTarget => 'Prosím, vyberte cílové zařízení.';

  @override
  String get flashErrorNoVersion => 'Prosím, vyberte verzi firmwaru.';

  @override
  String get flashErrorNoDevice =>
      'Nelze nahrát firmware: není připojeno žádné zařízení ELRS.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Nekompatibilní čip: tento firmware je sestaven pro $targetChip, ale připojené zařízení je $deviceChip. Vyberte cíl pro stejný čip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Žádný přístup k internetu pro stažení chybějících souborů. Odpojte se od zařízení ELRS, stáhněte tento firmware pomocí Správce firmwaru pro doplnění mezipaměti a zkuste to znovu.';

  @override
  String get flashErrorOfflineDownload =>
      'Žádný přístup k internetu. Nemůžete stahovat firmware, když jste připojeni k hotspotu zařízení ELRS. Odpojte se, stáhněte tuto verzi pomocí Správce firmwaru a zkuste to znovu.';

  @override
  String get flashErrorFlashFailed => 'Nahrávání firmware selhalo.';

  @override
  String get flashErrorUnconfirmed =>
      'Zařízení se odpojilo před potvrzením nahrání firmware, takže nahrání nemuselo být dokončeno. K tomu dochází, pokud zařízení ztratí napájení nebo se restartuje uprostřed nahrávání, a občas na slabém WiFi spojení po úspěšném nahrání. Zkontrolujte verzi firmware v Konfiguraci zařízení a pokud se nezměnila, nahrajte firmware znovu.';

  @override
  String get flashErrorDownloadFailed => 'Stažení firmware selhalo.';

  @override
  String get validationSsidTooLong => 'SSID musí mít 32 znaků nebo méně';

  @override
  String get validationPasswordTooShort => 'Heslo musí mít alespoň 8 znaků';

  @override
  String get validationPasswordTooLong => 'Heslo musí mít 63 znaků nebo méně';

  @override
  String get targetMismatchTitle => 'Neshoda cílového zařízení';

  @override
  String get targetMismatchMessage =>
      'Vybraný cílový firmware neodpovídá hardwaru, který je aktuálně na zařízení. Opravdu chcete vynutit nahrání?';

  @override
  String get forceFlashLabel => 'VYNUTIT NAHRÁNÍ';

  @override
  String get noBindPhraseTitle => 'Bez bindovací fráze';

  @override
  String get noBindPhraseMessage =>
      'Není nastavena bindovací fráze. Pokračovat s výchozí (prázdnou)?';

  @override
  String get flashSuccessSnackbar => 'Nahrávání firmware úspěšně dokončeno!';

  @override
  String get firmwareSavedSnackbar => 'Firmware úspěšně uložen!';

  @override
  String get flashSuccessMessage =>
      'Nahrávání firmware úspěšné! Zařízení se restartuje.';

  @override
  String get stm32OtaWarning =>
      'Vybráno cílové zařízení STM32: OTA nahrávání není pro tento hardware podporováno. Firmware můžete sestavit a uložit lokálně a nahrát jej ručně přes STLink nebo Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'STÁHNOUT BINÁRNÍ SOUBOR';

  @override
  String get waitingForDeviceLabel => 'ČEKÁNÍ NA ZAŘÍZENÍ...';

  @override
  String get otaUnavailableLabel => 'OTA NEDOSTUPNÉ';

  @override
  String get doneLabel => 'HOTOVO';

  @override
  String get targetSelectionTitle => 'Výběr cílového zařízení';

  @override
  String get deviceTypeLabel => 'Typ zařízení';

  @override
  String get deviceVendorLabel => 'Výrobce zařízení';

  @override
  String get regulatoryFrequencyLabel => 'Regulační oblast a frekvence';

  @override
  String get deviceTargetLabel => 'Cílové zařízení';

  @override
  String get noFirmwareDownloadedButton =>
      'Není stažen žádný firmware. Přejít na Správce firmware';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Hardware vyžaduje verzi v$version nebo novější.';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'Stáhnout kompatibilní firmware';

  @override
  String get firmwareVersionLabel => 'Verze firmware';

  @override
  String get firmwareVersionHelper => 'Vyberte verzi ELRS k nahrání';

  @override
  String get cachedBadge => '(Uloženo)';

  @override
  String errorLoadingVersions(String error) {
    return 'Chyba při načítání verzí: $error';
  }

  @override
  String get flashingProfileLabel => 'Profil nahrávání';

  @override
  String get addProfileTooltip => 'Přidat profil';

  @override
  String get deleteProfileTooltip => 'Smazat profil';

  @override
  String get bindingPhraseHelper => 'Vaše jedinečná bindovací fráze';

  @override
  String get addProfileTitle => 'Přidat profil nahrávání';

  @override
  String get profileNameHint => 'Název profilu (např. Moje drony)';

  @override
  String get addLabel => 'Přidat';

  @override
  String get deleteProfileTitle => 'Smazat profil';

  @override
  String deleteProfileMessage(String name) {
    return 'Opravdu chcete smazat profil „$name“?';
  }

  @override
  String get deleteLabel => 'Smazat';

  @override
  String get settingsCategoryProfilesNetwork => 'Profily a síť';

  @override
  String get settingsCategoryAppStorage => 'Aplikace a úložiště';

  @override
  String get settingsCategoryAdvancedDebug => 'Pokročilé a ladění';

  @override
  String get settingsCategoryAboutLegal => 'O aplikaci a právní informace';

  @override
  String get settingsSectionRegulatoryDefaults => 'Výchozí regulační nastavení';

  @override
  String get settingsSectionPreferences => 'Předvolby';

  @override
  String get settingsSectionPowerTools => 'Nástroje pro pokročilé';

  @override
  String get settingsSectionDiagnostics => 'Diagnostika';

  @override
  String get regDomainUnknown => 'Neznámý';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count verzí',
      few: '$count verze',
      one: '1 verze',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Upravit $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Zadejte $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua uloženo do zařízení!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Nepodařilo se uložit skript: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Odesláno! ID události: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Zpráva byla úspěšně odeslána!';

  @override
  String debugReportFailed(String error) {
    return 'Nepodařilo se odeslat: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Chyba při načítání licence: $error';
  }

  @override
  String get firmwareErrorLoadFailed => 'Nepodařilo se načíst verze firmwaru.';

  @override
  String get firmwareErrorOnHotspot =>
      'Nelze stáhnout firmware, když jste připojeni přímo k Wi-Fi hotspotu přijímače. Prosím, odpojte se nebo použijte domácí síť.';

  @override
  String get firmwareErrorCacheFull =>
      'Dosažen limit mezipaměti. Prosím, smažte starou verzi.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Nelze se připojit k serveru firmwaru. Zkontrolujte prosím své připojení k internetu.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Stahování přerušeno: připojení k síti bylo ztraceno. Zkontrolujte prosím své připojení a zkuste to znovu.';

  @override
  String get firmwareErrorDownloadFailed => 'Stažení firmwaru se nezdařilo.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Tuto verzi firmwaru se nepodařilo smazat.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Verze $version';
  }

  @override
  String get readyForOfflineUse => 'Připraveno pro offline použití';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Využité úložiště: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Verzí';
  }

  @override
  String get splashTagline => 'Nezávislý konfigurační nástroj';

  @override
  String get splashDisclaimer =>
      'Není oficiální produkt ExpressLRS.\nKompatibilní s firmwarem 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Zařízení ELRS';

  @override
  String get unknownIpLabel => 'Neznámá IP';

  @override
  String get firmwareBinariesFileType => 'Binární soubory firmwaru';

  @override
  String helpContentLoadFailed(String error) {
    return 'Chyba při načítání obsahu nápovědy: $error';
  }
}
