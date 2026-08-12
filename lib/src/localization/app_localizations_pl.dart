// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Fraza wiążąca';

  @override
  String get networkSsidLabel => 'SSID sieci WiFi';

  @override
  String get flashingButtonLabel => 'Flashuj';

  @override
  String get packetRateLabel => 'Częstotliwość pakietów';

  @override
  String get baudRateLabel => 'Szybkość transmisji';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Aktualizowanie oprogramowania $expressLRS na sprzęcie $radioMaster lub $betaFPV...';
  }

  @override
  String get flashDeviceLabel => 'Flashuj urządzenie';

  @override
  String get deviceConfigLabel => 'Konfiguracja urządzenia';

  @override
  String get firmwareManagerLabel => 'Menedżer oprogramowania';

  @override
  String get settingsLabel => 'Ustawienia';

  @override
  String get helpSupportLabel => 'Pomoc i wsparcie';

  @override
  String get noDeviceFoundLabel => 'Nie znaleziono urządzenia';

  @override
  String get retryLabel => 'Ponów';

  @override
  String get manualConnectionLabel => 'Połączenie ręczne';

  @override
  String get manualIpOverrideLabel => 'Ręczne nadpisywanie IP';

  @override
  String get connectLabel => 'Połącz';

  @override
  String get cancelLabel => 'Anuluj';

  @override
  String get matchedLabel => 'Dopasowano';

  @override
  String get mismatchLabel => 'Niezgodność';

  @override
  String connectedLabel(String ip) {
    return 'Połączono: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Flashowanie i Wi-Fi';

  @override
  String get aboutSupportCategoryLabel => 'Informacje i wsparcie';

  @override
  String get advancedCategoryLabel => 'Zaawansowane';

  @override
  String get flashingDefaultsSectionLabel => 'Domyślne ustawienia flashowania';

  @override
  String get default24GHzDomainLabel => 'Domyślna domena 2.4GHz';

  @override
  String get defaultSubGHzDomainLabel => 'Domyślna domena Sub-GHz';

  @override
  String get globalBindingPhraseLabel => 'Globalna fraza wiążąca';

  @override
  String get homeWifiSsidLabel => 'SSID domowej sieci Wi-Fi';

  @override
  String get homeWifiPasswordLabel => 'Hasło domowej sieci Wi-Fi';

  @override
  String get manageCachedFirmwareLabel =>
      'Zarządzaj buforowanym oprogramowaniem';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Pobierz lub usuń oprogramowanie offline';

  @override
  String get maxCachedVersionsLabel => 'Maks. liczba buforowanych wersji';

  @override
  String get clearFirmwareCacheLabel =>
      'Wyczyść pamięć podręczną oprogramowania';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Usuń wszystkie pobrane pliki oprogramowania';

  @override
  String get clearLabel => 'WYCZYŚĆ';

  @override
  String get aboutSectionLabel => 'Informacje';

  @override
  String get appVersionLabel => 'Wersja aplikacji';

  @override
  String get legalLicenseLabel => 'Informacje prawne i licencja';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standardowe wyłączenie odpowiedzialności i licencja GPLv3';

  @override
  String get supportDevelopmentLabel => 'Wsparcie rozwoju';

  @override
  String get supportDevelopmentSubtitle => 'Wesprzyj dewelopera przez Ko-fi';

  @override
  String get developerSectionLabel => 'Deweloper';

  @override
  String get developerModeEnabledLabel => 'Tryb dewelopera włączony';

  @override
  String get testSentryErrorCaptureLabel =>
      'Testuj przechwytywanie błędów Sentry';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Wysyła wyjątek testowy do Sentry — sprawdź panel sterowania';

  @override
  String get shareAnalyticsLabel => 'Udostępnij dane analityczne';

  @override
  String get shareAnalyticsSubtitle =>
      'Pomóż ulepszyć aplikację, udostępniając anonimowe dane użytkowania';

  @override
  String get expertModeLabel => 'Tryb eksperta';

  @override
  String get expertModeSubtitle =>
      'Włącz zaawansowaną obsługę oprogramowania i pobierania';

  @override
  String get exportElrsLuaScriptLabel => 'Eksportuj skrypt Lua ELRS';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Zapisz elrs.lua dla radiotelefonów EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel => 'Wyślij raport debugowania do Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Pomóż nam naprawić błędy, udostępniając anonimowe logi systemowe';

  @override
  String get clearFirmwareCacheTitle =>
      'Wyczyścić pamięć podręczną oprogramowania?';

  @override
  String get clearFirmwareCacheMessage =>
      'Spowoduje to usunięcie wszystkich pobranych plików ZIP z oprogramowaniem. Będziesz musiał pobrać je ponownie, jeśli zechcesz flashować offline.';

  @override
  String get clearAllLabel => 'WYCZYŚĆ WSZYSTKO';

  @override
  String get submitDebugReportTitle => 'Wyślij raport debugowania';

  @override
  String get submitDebugReportMessage =>
      'Spowoduje to wysłanie informacji o Twoim urządzeniu i logów aplikacji do Sentry w celu debugowania. Nie zostaną uwzględnione żadne dane osobowe, takie jak frazy wiążące lub hasła Wi-Fi.';

  @override
  String get describeIssueHint =>
      'Proszę opisać problem, którego doświadczasz...';

  @override
  String get proceedLabel => 'Kontynuuj';

  @override
  String get submittingReportProgress => 'Wysyłanie raportu…';

  @override
  String get saveLabel => 'Zapisz';

  @override
  String get notSetLabel => 'Nie ustawiono';

  @override
  String get languageOverrideLabel => 'Język';

  @override
  String get languageOverrideSystemDefault => 'Domyślne systemowe';

  @override
  String get legalNoticeSectionTitle => 'Nota prawna';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile to darmowy projekt open-source (FOSS) opracowany niezależnie przez Westona Hintona. Ten projekt nie jest oficjalnym produktem ExpressLRS LLC i nie jest oficjalnie wspierany, promowany ani certyfikowany przez zespół deweloperski ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Informacja o znaku towarowym';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS i logo ExpressLRS są znakami towarowymi ExpressLRS LLC. Użycie tych znaków służy wyłącznie celom opisowym i zapewnieniu kompatybilności. Aby uzyskać dostęp do oficjalnego konfiguratora i dokumentacji ExpressLRS, odwiedź stronę expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Oficjalne wsparcie';

  @override
  String get officialSupportSectionText =>
      'Wspieraj oficjalny projekt ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel =>
      'Przekaż darowiznę przez Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Licencja oprogramowania';

  @override
  String get gplv3NoticeText =>
      'Ten projekt jest licencjonowany na podstawie GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Instrukcja flashowania';

  @override
  String get tabFaq => 'Często zadawane pytania';

  @override
  String get tabResources => 'Zasoby';

  @override
  String get resourceCommunitySupport => 'Społeczność i wsparcie';

  @override
  String get resourceDiscordCommunity => 'Społeczność Discord';

  @override
  String get resourceJoinDiscord => 'Dołącz do Discorda ELRS';

  @override
  String get resourceGithubRepo => 'Repozytorium GitHub';

  @override
  String get resourceFlashRecovery => 'Odzyskiwanie po flashowaniu';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Jeśli Twoje urządzenie nie reaguje po nieudanym flashowaniu:';

  @override
  String get resourceRecoveryStep1 =>
      'Przytrzymaj przycisk BOOT podczas podłączania przez USB, aby wejść w tryb bootloadera.';

  @override
  String get resourceRecoveryStep2 =>
      'Użyj ELRS Web Flasher na expresslrs.org/flasher, aby ponownie wgrać oprogramowanie przez USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'W przypadku urządzeń z obsługą WiFi, przytrzymaj BOOT przez 60 sekund, aby uruchomić tryb odzyskiwania Hotspotu WiFi.';

  @override
  String get resourceRecoveryStep4 =>
      'Dołącz do kanału #help na Discordzie ELRS — społeczność zazwyczaj jest w stanie odzyskać każde urządzenie.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Przewodnik odceglania autorstwa Joshuy Bardwella jest wysoce zalecany:';

  @override
  String get resourceWebFlasherButton => 'Flasher internetowy';

  @override
  String get resourceRecoveryVideoButton => 'Film o odzyskiwaniu';

  @override
  String get resourceLegalLiability => 'Aspekty prawne i odpowiedzialność';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile jest dostarczane w stanie, w jakim się znajduje, bez jakiejkolwiek gwarancji. Twórcy nie ponoszą odpowiedzialności za jakiekolwiek szkody, utratę danych ani nieprawidłowo działający sprzęt wynikające z użycia tej aplikacji, w tym między innymi za „uceglone” odbiorniki, nadajniki lub kontrolery lotu.\n\nKorzystając z tej aplikacji, akceptujesz pełną odpowiedzialność za swój sprzęt.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Zobacz pełne wyłączenie odpowiedzialności';

  @override
  String get disclaimerTitle => 'Używasz na własne ryzyko';

  @override
  String get disclaimerHeader =>
      'Aplikacja ELRS Mobile jest dostarczana w stanie, w jakim jest, bez jakiejkolwiek gwarancji.';

  @override
  String get disclaimerLiability =>
      'Deweloperzy nie ponoszą odpowiedzialności za żadne uszkodzenia, utratę danych ani niesprawne działanie sprzętu wynikające z użycia tej aplikacji, w tym między innymi za uszkodzone (zbrickowane) odbiorniki, nadajniki lub kontrolery lotu.';

  @override
  String get disclaimerAgreement =>
      'Korzystając z tej aplikacji, potwierdzasz, że rozumiesz ryzyko flashowania niestandardowego oprogramowania układowego i akceptujesz pełną odpowiedzialność za swój sprzęt.';

  @override
  String get disclaimerVerification =>
      'Zawsze weryfikuj cel i wersję oprogramowania układowego przed flashowaniem. Jeśli to możliwe, zachowaj kopię oryginalnego oprogramowania.';

  @override
  String get disclaimerUnderstand => 'Rozumiem';

  @override
  String get optionsTitle => 'Opcje oprogramowania układowego';

  @override
  String get optionsSubtitle =>
      'Skonfiguruj parowanie i dane uwierzytelniające sieci.';

  @override
  String get wifiPasswordLabel => 'Hasło WiFi';

  @override
  String get wifiOnIntervalLabel => 'Interwał automatycznego włączania Wi-Fi';

  @override
  String get regulatoryDomainLabel => 'Domena regulacyjna';

  @override
  String get regDomainIsm => 'ISM (2.4GHz)';

  @override
  String get regDomainEuLbt => 'UE CE (2.4GHz LBT)';

  @override
  String get regDomainAu915 => 'AU (915MHz)';

  @override
  String get regDomainFcc915 => 'FCC (915MHz)';

  @override
  String get regDomainEu868 => 'UE (868MHz)';

  @override
  String get regDomainIn866 => 'IN (866MHz)';

  @override
  String get regDomainAu433 => 'AU (433MHz)';

  @override
  String get regDomainEu433 => 'UE (433MHz)';

  @override
  String get regDomainUs433 => 'US (433MHz)';
}
