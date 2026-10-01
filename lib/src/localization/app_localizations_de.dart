// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Bindungsphrase';

  @override
  String get networkSsidLabel => 'WLAN-SSID';

  @override
  String get flashingButtonLabel => 'Flashen';

  @override
  String get flashingStatusLocating => 'Firmware lokalisieren';

  @override
  String get flashingStatusUnpacking => 'Firmware entpacken';

  @override
  String get flashingStatusDownloading => 'Firmware herunterladen';

  @override
  String get flashingStatusBuilding => 'Firmware erstellen';

  @override
  String get flashingStatusUploading => 'Auf Gerät hochladen';

  @override
  String get flashingStatusFinalizing => 'Auf Gerät schreiben — Bitte warten';

  @override
  String get flashDeviceLabel => 'Gerät flashen';

  @override
  String get deviceConfigLabel => 'Gerätekonfiguration';

  @override
  String get firmwareManagerLabel => 'Firmware-Verwaltung';

  @override
  String get settingsLabel => 'Einstellungen';

  @override
  String get helpSupportLabel => 'Hilfe & Support';

  @override
  String get noDeviceFoundLabel => 'Kein Gerät gefunden';

  @override
  String get retryLabel => 'Wiederholen';

  @override
  String get manualConnectionLabel => 'Manuelle Verbindung';

  @override
  String get manualIpOverrideLabel => 'Manuelle IP-Überschreibung';

  @override
  String get connectLabel => 'Verbinden';

  @override
  String get cancelLabel => 'Abbrechen';

  @override
  String get matchedLabel => 'Übereinstimmend';

  @override
  String get mismatchLabel => 'Nicht übereinstimmend';

  @override
  String connectedLabel(String ip) {
    return 'Verbunden: $ip';
  }

  @override
  String get default24GHzDomainLabel => 'Standard 2,4-GHz-Domain';

  @override
  String get defaultSubGHzDomainLabel => 'Standard Sub-GHz-Domain';

  @override
  String get globalBindingPhraseLabel => 'Globale Bindungsphrase';

  @override
  String get homeWifiSsidLabel => 'Heim-WLAN-SSID';

  @override
  String get homeWifiPasswordLabel => 'Heim-WLAN-Passwort';

  @override
  String get manageCachedFirmwareLabel =>
      'Zwischengespeicherte Firmware verwalten';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Offline-Firmware herunterladen oder löschen';

  @override
  String get maxCachedVersionsLabel => 'Max. zwischengespeicherte Versionen';

  @override
  String get clearFirmwareCacheLabel => 'Firmware-Cache leeren';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Alle heruntergeladenen Firmware-Dateien löschen';

  @override
  String get clearLabel => 'LEEREN';

  @override
  String get appVersionLabel => 'App-Version';

  @override
  String get legalLicenseLabel => 'Rechtliches & Lizenz';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standard-Haftungsausschluss und GPLv3-Lizenz';

  @override
  String get supportDevelopmentLabel => 'Entwicklung unterstützen';

  @override
  String get supportDevelopmentSubtitle =>
      'Unterstütze den Entwickler über Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Analysedaten teilen';

  @override
  String get shareAnalyticsSubtitle =>
      'Helfen Sie, die App zu verbessern, indem Sie anonyme Nutzungsdaten teilen';

  @override
  String get expertModeLabel => 'Expertenmodus';

  @override
  String get expertModeSubtitle =>
      'Aktiviert erweiterte Firmware-Handhabung und Downloads';

  @override
  String get exportElrsLuaScriptLabel => 'ELRS Lua-Skript exportieren';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'elrs.lua für EdgeTX-/OpenTX-Fernsteuerungen speichern';

  @override
  String get submitDebugReportLabel => 'Debug-Bericht an Sentry senden';

  @override
  String get submitDebugReportSubtitle =>
      'Helfen Sie uns, Fehler zu beheben, indem Sie anonyme Systemprotokolle teilen';

  @override
  String get clearFirmwareCacheTitle => 'Firmware-Cache leeren?';

  @override
  String get clearFirmwareCacheMessage =>
      'Dadurch werden alle heruntergeladenen Firmware-ZIP-Dateien gelöscht. Sie müssen diese erneut herunterladen, wenn Sie offline flashen möchten.';

  @override
  String get clearAllLabel => 'ALLE LÖSCHEN';

  @override
  String get submitDebugReportTitle => 'Debug-Bericht senden';

  @override
  String get submitDebugReportMessage =>
      'Dies sendet Ihre Geräteinformationen und App-Protokolle zur Fehlerbehebung an Sentry. Keine persönlichen Daten wie Bindungsphrasen oder WLAN-Passwörter werden enthalten sein.';

  @override
  String get describeIssueHint =>
      'Bitte beschreiben Sie das aufgetretene Problem...';

  @override
  String get proceedLabel => 'Fortfahren';

  @override
  String get submittingReportProgress => 'Bericht wird gesendet…';

  @override
  String get saveLabel => 'Speichern';

  @override
  String get notSetLabel => 'Nicht festgelegt';

  @override
  String get languageOverrideLabel => 'Sprache';

  @override
  String get languageOverrideSystemDefault => 'Systemstandard';

  @override
  String get legalNoticeSectionTitle => 'Rechtliche Hinweise';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile ist ein kostenloses und quelloffenes (FOSS) Projekt, das unabhängig von Weston Hinton entwickelt wurde. Dieses Projekt ist kein offizielles Produkt von ExpressLRS LLC und wird nicht offiziell vom ExpressLRS-Entwicklungsteam unterstützt, befürwortet oder zertifiziert.';

  @override
  String get trademarkNoticeSectionTitle => 'Markenhinweis';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS und das ExpressLRS-Logo sind Marken von ExpressLRS LLC. Die Verwendung dieser Marken dient ausschließlich beschreibenden und Kompatibilitätszwecken. Für den offiziellen ExpressLRS Konfigurator und die Dokumentation besuchen Sie bitte expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Offizieller Support';

  @override
  String get officialSupportSectionText =>
      'Unterstützen Sie das offizielle ExpressLRS-Projekt: ';

  @override
  String get donateOpenCollectiveLabel => 'Über Open Collective spenden';

  @override
  String get softwareLicenseSectionTitle => 'Softwarelizenz';

  @override
  String get gplv3NoticeText =>
      'Dieses Projekt ist unter der GNU General Public License v3.0 lizenziert.';

  @override
  String get tabFlashingGuide => 'Flash-Anleitung';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Ressourcen';

  @override
  String get resourceCommunitySupport => 'Community & Support';

  @override
  String get resourceDiscordCommunity => 'Discord-Community';

  @override
  String get resourceJoinDiscord => 'Dem ELRS Discord beitreten';

  @override
  String get resourceGithubRepo => 'GitHub-Repository';

  @override
  String get resourceFlashRecovery => 'Flash-Wiederherstellung';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Wenn Ihr Gerät nach einem fehlgeschlagenen Flash-Vorgang nicht mehr reagiert:';

  @override
  String get resourceRecoveryStep1 =>
      'Halten Sie die BOOT-Taste gedrückt, während Sie das Gerät über USB anschließen, um in den Bootloader-Modus zu gelangen.';

  @override
  String get resourceRecoveryStep2 =>
      'Verwenden Sie den ELRS Web Flasher unter expresslrs.org/flasher, um über USB/UART neu zu flashen.';

  @override
  String get resourceRecoveryStep3 =>
      'Halten Sie bei WLAN-fähigen Geräten die BOOT-Taste 60 Sekunden lang gedrückt, um den WLAN-Hotspot-Wiederherstellungsmodus auszulösen.';

  @override
  String get resourceRecoveryStep4 =>
      'Treten Sie #help im ELRS Discord bei — die Community kann in der Regel jedes Gerät wiederherstellen.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Joshua Bardwells \'Unbricking\'-Anleitung ist sehr empfehlenswert:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'Wiederherstellungsvideo';

  @override
  String get resourceLegalLiability => 'Recht & Haftung';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile wird \'wie besehen\' und ohne jegliche Gewährleistung bereitgestellt. Die Entwickler sind nicht verantwortlich für Schäden, Datenverlust oder nicht funktionierende Hardware, die aus der Nutzung dieser Anwendung resultieren, einschließlich, aber nicht beschränkt auf \'gebrickte\' Empfänger, Sender oder Flugsteuerungen.\n\nDurch die Nutzung dieser App übernehmen Sie die volle Verantwortung für Ihre Hardware.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Vollständigen Haftungsausschluss anzeigen';

  @override
  String get disclaimerTitle => 'Nutzung auf eigene Gefahr';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile wird wie besehen und ohne jegliche Gewährleistung zur Verfügung gestellt.';

  @override
  String get disclaimerLiability =>
      'Die Entwickler sind nicht verantwortlich für Schäden, Datenverlust oder nicht funktionsfähige Hardware, die aus der Nutzung dieser Anwendung resultieren, einschließlich, aber nicht beschränkt auf „gebrickte“ Empfänger, Sender oder Flugsteuerungen.';

  @override
  String get disclaimerAgreement =>
      'Durch die Nutzung dieser App bestätigen Sie, dass Sie die Risiken des Flashens von benutzerdefinierter Firmware verstehen und die volle Verantwortung für Ihre Hardware übernehmen.';

  @override
  String get disclaimerVerification =>
      'Verifizieren Sie immer das Ziel und die Firmware-Version vor dem Flashen. Bewahren Sie, wenn möglich, eine Kopie Ihrer Original-Firmware auf.';

  @override
  String get disclaimerUnderstand => 'Ich verstehe';

  @override
  String get optionsTitle => 'Firmware-Optionen';

  @override
  String get optionsSubtitle =>
      'Bindung und Netzwerkanmeldeinformationen konfigurieren.';

  @override
  String get wifiPasswordLabel => 'WLAN-Passwort';

  @override
  String get wifiOnIntervalLabel => 'WLAN Auto-Ein-Intervall';

  @override
  String get regulatoryDomainLabel => 'Regulierungsbereich';

  @override
  String get regDomainIsm => 'ISM (2,4 GHz)';

  @override
  String get regDomainEuLbt => 'EU CE (2,4 GHz LBT)';

  @override
  String get regDomainAu915 => 'AU (915 MHz)';

  @override
  String get regDomainFcc915 => 'FCC (915 MHz)';

  @override
  String get regDomainEu868 => 'EU (868 MHz)';

  @override
  String get regDomainIn866 => 'IN (866 MHz)';

  @override
  String get regDomainAu433 => 'AU (433 MHz)';

  @override
  String get regDomainEu433 => 'EU (433 MHz)';

  @override
  String get regDomainUs433 => 'US (433 MHz)';

  @override
  String get flashingStatusSaved => 'Firmware gespeichert';

  @override
  String get flashErrorNoTarget => 'Bitte wählen Sie ein Zielgerät aus.';

  @override
  String get flashErrorNoVersion =>
      'Bitte wählen Sie eine Firmware-Version aus.';

  @override
  String get flashErrorNoDevice =>
      'Flashvorgang nicht möglich: Es ist kein ELRS-Gerät verbunden.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Inkompatibler Chip: Diese Firmware wurde für $targetChip erstellt, das verbundene Gerät ist jedoch $deviceChip. Wählen Sie ein Ziel für denselben Chip aus.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Kein Internetzugang zum Abrufen fehlender Dateien. Bitte trennen Sie die Verbindung zum ELRS-Gerät, laden Sie diese Firmware über die Firmware-Verwaltung herunter, um Ihren Cache zu vervollständigen, und versuchen Sie es erneut.';

  @override
  String get flashErrorOfflineDownload =>
      'Kein Internetzugang. Sie können keine Firmware herunterladen, während Sie mit dem ELRS-Geräte-Hotspot verbunden sind. Bitte trennen Sie die Verbindung, laden Sie diese Version über die Firmware-Verwaltung herunter und versuchen Sie es erneut.';

  @override
  String get flashErrorFlashFailed => 'Flashen fehlgeschlagen.';

  @override
  String get flashErrorUnconfirmed =>
      'Das Gerät hat die Verbindung getrennt, bevor der Flashvorgang bestätigt wurde, daher ist er möglicherweise nicht abgeschlossen. Dies geschieht, wenn das Gerät während des Flashvorgangs die Stromversorgung verliert oder neu startet, und gelegentlich bei einer schwachen WLAN-Verbindung nach einem erfolgreichen Flashvorgang. Überprüfen Sie die Firmware-Version in \'Gerätekonfiguration\' und flashen Sie erneut, falls sie sich nicht geändert hat.';

  @override
  String get flashErrorDownloadFailed =>
      'Herunterladen der Firmware fehlgeschlagen.';

  @override
  String get validationSsidTooLong =>
      'SSID muss 32 Zeichen oder weniger lang sein';

  @override
  String get validationPasswordTooShort =>
      'Passwort muss mindestens 8 Zeichen lang sein';

  @override
  String get validationPasswordTooLong =>
      'Passwort muss 63 Zeichen oder weniger lang sein';

  @override
  String get targetMismatchTitle => 'Zielhardware-Konflikt';

  @override
  String get targetMismatchMessage =>
      'Die ausgewählte Firmware ist nicht mit der aktuellen Hardware auf dem Gerät kompatibel. Möchten Sie den Flashvorgang wirklich erzwingen?';

  @override
  String get forceFlashLabel => 'FLASH ERZWINGEN';

  @override
  String get noBindPhraseTitle => 'Keine Bindungsphrase';

  @override
  String get noBindPhraseMessage =>
      'Keine Bindungsphrase festgelegt. Mit der Standardeinstellung (leer) fortfahren?';

  @override
  String get flashSuccessSnackbar => 'Flashvorgang erfolgreich abgeschlossen!';

  @override
  String get firmwareSavedSnackbar => 'Firmware erfolgreich gespeichert!';

  @override
  String get flashSuccessMessage =>
      'Flashen erfolgreich! Gerät wird neu gestartet.';

  @override
  String get stm32OtaWarning =>
      'STM32-Ziel ausgewählt: OTA-Flashen wird für diese Hardware nicht unterstützt. Sie können diese Firmware lokal erstellen und speichern, um sie manuell über STLink oder Betaflight Passthrough zu flashen.';

  @override
  String get downloadBinaryLabel => 'BINÄRDATEI HERUNTERLADEN';

  @override
  String get waitingForDeviceLabel => 'WARTE AUF GERÄT...';

  @override
  String get otaUnavailableLabel => 'OTA NICHT VERFÜGBAR';

  @override
  String get doneLabel => 'FERTIG';

  @override
  String get targetSelectionTitle => 'Zielauswahl';

  @override
  String get deviceTypeLabel => 'Gerätetyp';

  @override
  String get deviceVendorLabel => 'Gerätehersteller';

  @override
  String get regulatoryFrequencyLabel => 'Regulierung & Frequenz';

  @override
  String get deviceTargetLabel => 'Geräte-Ziel';

  @override
  String get noFirmwareDownloadedButton =>
      'Keine Firmware heruntergeladen. Zum Firmware-Manager gehen';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Hardware benötigt v$version oder neuer.';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'Kompatible Firmware herunterladen';

  @override
  String get firmwareVersionLabel => 'Firmware-Version';

  @override
  String get firmwareVersionHelper =>
      'Wählen Sie die zu flashende ELRS-Version aus';

  @override
  String get cachedBadge => '(Im Cache)';

  @override
  String errorLoadingVersions(String error) {
    return 'Fehler beim Laden der Versionen: $error';
  }

  @override
  String get flashingProfileLabel => 'Flash-Profil';

  @override
  String get addProfileTooltip => 'Profil hinzufügen';

  @override
  String get deleteProfileTooltip => 'Profil löschen';

  @override
  String get bindingPhraseHelper => 'Ihre einzigartige Bindungsphrase';

  @override
  String get addProfileTitle => 'Flash-Profil hinzufügen';

  @override
  String get profileNameHint => 'Profilname (z.B. Meine Quads)';

  @override
  String get addLabel => 'Hinzufügen';

  @override
  String get deleteProfileTitle => 'Profil löschen';

  @override
  String deleteProfileMessage(String name) {
    return 'Möchten Sie das Profil „$name“ wirklich löschen?';
  }

  @override
  String get deleteLabel => 'Löschen';

  @override
  String get settingsCategoryProfilesNetwork => 'Profile & Netzwerk';

  @override
  String get settingsCategoryAppStorage => 'App & Speicher';

  @override
  String get settingsCategoryAdvancedDebug => 'Erweitert & Debug';

  @override
  String get settingsCategoryAboutLegal => 'Über & Rechtliches';

  @override
  String get settingsSectionRegulatoryDefaults =>
      'Regulatorische Standardeinstellungen';

  @override
  String get settingsSectionPreferences => 'Einstellungen';

  @override
  String get settingsSectionPowerTools => 'Experten-Tools';

  @override
  String get settingsSectionDiagnostics => 'Diagnose';

  @override
  String get regDomainUnknown => 'Unbekannt';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Versionen',
      one: '1 Version',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return '$field bearbeiten';
  }

  @override
  String enterFieldHint(String field) {
    return '$field eingeben';
  }

  @override
  String get luaScriptSavedSnackbar =>
      'elrs.lua wurde auf dem Gerät gespeichert!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Speichern des Skripts fehlgeschlagen: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Gesendet! Ereignis-ID: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Bericht erfolgreich gesendet!';

  @override
  String debugReportFailed(String error) {
    return 'Senden fehlgeschlagen: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Fehler beim Laden der Lizenz: $error';
  }

  @override
  String get firmwareErrorLoadFailed =>
      'Firmware-Versionen konnten nicht geladen werden.';

  @override
  String get firmwareErrorOnHotspot =>
      'Firmware kann nicht heruntergeladen werden, während Sie direkt mit dem WLAN-Hotspot des Empfängers verbunden sind. Bitte trennen Sie die Verbindung oder verwenden Sie ein Heimnetzwerk.';

  @override
  String get firmwareErrorCacheFull =>
      'Cache-Limit erreicht. Bitte löschen Sie eine alte Version.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Firmware-Server nicht erreichbar. Bitte überprüfen Sie Ihre Internetverbindung.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Download unterbrochen: Die Netzwerkverbindung wurde getrennt. Bitte überprüfen Sie Ihre Verbindung und versuchen Sie es erneut.';

  @override
  String get firmwareErrorDownloadFailed =>
      'Fehler beim Herunterladen der Firmware.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Diese Firmware-Version konnte nicht gelöscht werden.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Version $version';
  }

  @override
  String get readyForOfflineUse => 'Bereit für die Offline-Nutzung';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Speicherbelegung: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Versionen';
  }

  @override
  String get splashTagline => 'Unabhängiges Konfigurationstool';

  @override
  String get splashDisclaimer =>
      'Kein offizielles ExpressLRS-Produkt.\nKompatibel mit 3.3.x/4.x Firmware.';

  @override
  String get unknownDeviceName => 'ELRS-Gerät';

  @override
  String get unknownIpLabel => 'Unbekannte IP';

  @override
  String get firmwareBinariesFileType => 'Firmware-Binärdateien';

  @override
  String helpContentLoadFailed(String error) {
    return 'Fehler beim Laden der Hilfeinhalte: $error';
  }
}
