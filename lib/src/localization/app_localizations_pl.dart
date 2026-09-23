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
  String get flashingStatusLocating =>
      'Lokalizowanie oprogramowania układowego';

  @override
  String get flashingStatusUnpacking =>
      'Rozpakowywanie oprogramowania układowego';

  @override
  String get flashingStatusDownloading =>
      'Pobieranie oprogramowania układowego';

  @override
  String get flashingStatusBuilding => 'Tworzenie oprogramowania układowego';

  @override
  String get flashingStatusUploading => 'Wysyłanie na urządzenie';

  @override
  String get flashingStatusFinalizing =>
      'Zapisywanie na urządzeniu — proszę czekać';

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

  @override
  String get flashingStatusSaved => 'Oprogramowanie układowe zapisane';

  @override
  String get flashErrorNoTarget => 'Proszę wybrać urządzenie docelowe.';

  @override
  String get flashErrorNoVersion =>
      'Proszę wybrać wersję oprogramowania układowego.';

  @override
  String get flashErrorNoDevice =>
      'Nie można wgrać: brak podłączonego urządzenia ELRS.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Niezgodny układ: to oprogramowanie układowe jest zbudowane dla $targetChip, ale podłączone urządzenie to $deviceChip. Wybierz cel dla tego samego układu.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Brak dostępu do internetu, aby pobrać brakujące pliki. Odłącz się od urządzenia ELRS, pobierz to oprogramowanie układowe za pomocą Menedżera oprogramowania, aby uzupełnić pamięć podręczną, i spróbuj ponownie.';

  @override
  String get flashErrorOfflineDownload =>
      'Brak dostępu do internetu. Nie możesz pobierać oprogramowania układowego, gdy jesteś połączony z hotspotem urządzenia ELRS. Odłącz się, pobierz tę wersję za pomocą Menedżera oprogramowania i spróbuj ponownie.';

  @override
  String get flashErrorFlashFailed => 'Flashowanie nie powiodło się.';

  @override
  String get flashErrorUnconfirmed =>
      'Urządzenie rozłączyło się przed potwierdzeniem flashowania, więc mogło się ono nie zakończyć. Dzieje się tak, gdy urządzenie traci zasilanie lub restartuje się w trakcie flashowania, a sporadycznie także przy słabym połączeniu Wi-Fi po udanym flashowaniu. Sprawdź wersję oprogramowania w \'Konfiguracji urządzenia\' i ponownie flashuj, jeśli nie uległa zmianie.';

  @override
  String get flashErrorDownloadFailed =>
      'Nie udało się pobrać oprogramowania układowego.';

  @override
  String get validationSsidTooLong => 'SSID musi mieć 32 znaki lub mniej.';

  @override
  String get validationPasswordTooShort =>
      'Hasło musi mieć co najmniej 8 znaków.';

  @override
  String get validationPasswordTooLong => 'Hasło musi mieć 63 znaki lub mniej.';

  @override
  String get targetMismatchTitle => 'Niezgodność celu';

  @override
  String get targetMismatchMessage =>
      'Wybrany cel oprogramowania układowego nie pasuje do sprzętu aktualnie działającego na urządzeniu. Czy na pewno chcesz wymusić flashowanie?';

  @override
  String get forceFlashLabel => 'WYMUŚ FLASHOWANIE';

  @override
  String get noBindPhraseTitle => 'Brak frazy wiążącej';

  @override
  String get noBindPhraseMessage =>
      'Brak ustawionej frazy wiążącej. Kontynuować z domyślną (pustą)?';

  @override
  String get flashSuccessSnackbar => 'Flashowanie zakończono pomyślnie!';

  @override
  String get firmwareSavedSnackbar =>
      'Oprogramowanie układowe zapisano pomyślnie!';

  @override
  String get flashSuccessMessage =>
      'Flashowanie zakończone sukcesem! Urządzenie uruchamia się ponownie.';

  @override
  String get stm32OtaWarning =>
      'Wybrano cel STM32: Flashowanie OTA nie jest obsługiwane dla tego sprzętu. Możesz zbudować i zapisać to oprogramowanie układowe lokalnie, aby flashować ręcznie za pomocą STLink lub Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'POBIERZ PLIK BINARNY';

  @override
  String get waitingForDeviceLabel => 'OCZEKIWANIE NA URZĄDZENIE...';

  @override
  String get otaUnavailableLabel => 'OTA niedostępne';

  @override
  String get doneLabel => 'Gotowe';

  @override
  String get targetSelectionTitle => 'Wybór urządzenia docelowego';

  @override
  String get deviceTypeLabel => 'Typ urządzenia';

  @override
  String get deviceVendorLabel => 'Producent urządzenia';

  @override
  String get regulatoryFrequencyLabel => 'Regulacje i częstotliwość';

  @override
  String get deviceTargetLabel => 'Urządzenie docelowe';

  @override
  String get noFirmwareDownloadedButton =>
      'Brak pobranego oprogramowania układowego. Przejdź do Menedżera oprogramowania układowego';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Sprzęt wymaga wersji v$version lub nowszej.';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'Pobierz kompatybilne oprogramowanie układowe';

  @override
  String get firmwareVersionLabel => 'Wersja oprogramowania układowego';

  @override
  String get firmwareVersionHelper => 'Wybierz wersję ELRS do wgrania';

  @override
  String get cachedBadge => '(Zapisane w pamięci podręcznej)';

  @override
  String errorLoadingVersions(String error) {
    return 'Błąd ładowania wersji: $error';
  }

  @override
  String get flashingProfileLabel => 'Profil flashowania';

  @override
  String get addProfileTooltip => 'Dodaj profil';

  @override
  String get deleteProfileTooltip => 'Usuń profil';

  @override
  String get bindingPhraseHelper => 'Twoja unikalna fraza wiążąca';

  @override
  String get addProfileTitle => 'Dodaj profil flashowania';

  @override
  String get profileNameHint => 'Nazwa profilu (np. Moje Drony)';

  @override
  String get addLabel => 'Dodaj';

  @override
  String get deleteProfileTitle => 'Usuń profil';

  @override
  String deleteProfileMessage(String name) {
    return 'Czy na pewno chcesz usunąć profil „$name”?';
  }

  @override
  String get deleteLabel => 'Usuń';

  @override
  String get settingsCategoryProfilesNetwork => 'Profile i sieć';

  @override
  String get settingsCategoryAppStorage => 'Aplikacja i pamięć';

  @override
  String get settingsCategoryAdvancedDebug => 'Zaawansowane i debugowanie';

  @override
  String get settingsCategoryAboutLegal => 'Informacje i prawne';

  @override
  String get settingsSectionRegulatoryDefaults =>
      'Domyślne ustawienia regulacyjne';

  @override
  String get settingsSectionPreferences => 'Preferencje';

  @override
  String get settingsSectionPowerTools => 'Narzędzia zaawansowane';

  @override
  String get settingsSectionDiagnostics => 'Diagnostyka';

  @override
  String get regDomainUnknown => 'Nieznany';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wersji',
      many: '$count wersji',
      few: '$count wersje',
      one: '1 wersja',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Edytuj $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Wprowadź $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua zapisano na urządzeniu!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Nie udało się zapisać skryptu: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Wysłano! ID zdarzenia: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Raport wysłano pomyślnie!';

  @override
  String debugReportFailed(String error) {
    return 'Nie udało się wysłać: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Błąd ładowania licencji: $error';
  }

  @override
  String get firmwareErrorLoadFailed =>
      'Nie można załadować wersji oprogramowania układowego.';

  @override
  String get firmwareErrorOnHotspot =>
      'Nie można pobrać oprogramowania układowego, gdy jest się bezpośrednio połączonym z hotspotem Wi-Fi odbiornika. Proszę się rozłączyć lub użyć sieci domowej.';

  @override
  String get firmwareErrorCacheFull =>
      'Osiągnięto limit pamięci podręcznej. Proszę usunąć starszą wersję.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Nie można połączyć się z serwerem oprogramowania układowego. Proszę sprawdzić połączenie internetowe.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Pobieranie przerwane: utracono połączenie sieciowe. Proszę sprawdzić połączenie i spróbować ponownie.';

  @override
  String get firmwareErrorDownloadFailed =>
      'Nie udało się pobrać oprogramowania układowego.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Nie można usunąć tej wersji oprogramowania układowego.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Wersja $version';
  }

  @override
  String get readyForOfflineUse => 'Gotowe do użytku offline';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Użyte miejsce: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count / $limit Wersji',
      many: '$count / $limit Wersji',
      few: '$count / $limit Wersje',
      one: '$count / $limit Wersja',
    );
    return '$_temp0';
  }

  @override
  String get splashTagline => 'Niezależne Narzędzie Konfiguracyjne';

  @override
  String get splashDisclaimer =>
      'Nie jest to oficjalny produkt ExpressLRS.\nKompatybilne z oprogramowaniem układowym 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Urządzenie ELRS';

  @override
  String get unknownIpLabel => 'Nieznany adres IP';

  @override
  String get firmwareBinariesFileType =>
      'Pliki binarne oprogramowania układowego';

  @override
  String helpContentLoadFailed(String error) {
    return 'Błąd ładowania treści pomocy: $error';
  }
}
