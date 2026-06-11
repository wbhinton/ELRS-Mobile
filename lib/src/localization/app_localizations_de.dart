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
  String get packetRateLabel => 'Paketrate';

  @override
  String get baudRateLabel => 'Baudrate';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Aktualisiere $expressLRS-Firmware auf $radioMaster- oder $betaFPV-Hardware...';
  }

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
  String get flashingWifiCategoryLabel => 'Flashen & WLAN';

  @override
  String get aboutSupportCategoryLabel => 'Über & Support';

  @override
  String get advancedCategoryLabel => 'Erweitert';

  @override
  String get flashingDefaultsSectionLabel =>
      'Standardeinstellungen für das Flashen';

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
  String get aboutSectionLabel => 'Über';

  @override
  String get appVersionLabel => 'App-Version';

  @override
  String get legalLicenseLabel => 'Rechtliches & Lizenz';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Standard-Haftungsausschluss und GPLv3-Lizenz';

  @override
  String get developerSectionLabel => 'Entwickler';

  @override
  String get developerModeEnabledLabel => 'Entwicklermodus aktiviert';

  @override
  String get testSentryErrorCaptureLabel => 'Sentry-Fehlererfassung testen';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Sendet eine Testausnahme an Sentry – prüfen Sie das Dashboard';

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
}
