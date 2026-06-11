// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Phrase d\'appairage';

  @override
  String get networkSsidLabel => 'SSID Wi-Fi';

  @override
  String get flashingButtonLabel => 'Flasher';

  @override
  String get packetRateLabel => 'Taux de paquets';

  @override
  String get baudRateLabel => 'Débit Baud';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Mise à jour du firmware $expressLRS sur le matériel $radioMaster ou $betaFPV...';
  }

  @override
  String get flashDeviceLabel => 'Flasher le dispositif';

  @override
  String get deviceConfigLabel => 'Configuration de l\'appareil';

  @override
  String get firmwareManagerLabel => 'Gestionnaire de micrologiciels';

  @override
  String get settingsLabel => 'Paramètres';

  @override
  String get helpSupportLabel => 'Aide et support';

  @override
  String get noDeviceFoundLabel => 'Aucun appareil trouvé';

  @override
  String get retryLabel => 'Réessayer';

  @override
  String get manualConnectionLabel => 'Connexion manuelle';

  @override
  String get manualIpOverrideLabel => 'Remplacement manuel de l\'IP';

  @override
  String get connectLabel => 'Connecter';

  @override
  String get cancelLabel => 'Annuler';

  @override
  String get matchedLabel => 'Correspondant';

  @override
  String get mismatchLabel => 'Non-concordance';

  @override
  String connectedLabel(String ip) {
    return 'Connecté : $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Flashage et Wi-Fi';

  @override
  String get aboutSupportCategoryLabel => 'À propos et support';

  @override
  String get advancedCategoryLabel => 'Avancé';

  @override
  String get flashingDefaultsSectionLabel =>
      'Paramètres par défaut du flashage';

  @override
  String get default24GHzDomainLabel => 'Domaine 2.4 GHz par défaut';

  @override
  String get defaultSubGHzDomainLabel => 'Domaine Sub-GHz par défaut';

  @override
  String get globalBindingPhraseLabel => 'Phrase de liaison globale';

  @override
  String get homeWifiSsidLabel => 'SSID Wi-Fi domestique';

  @override
  String get homeWifiPasswordLabel => 'Mot de passe Wi-Fi domestique';

  @override
  String get manageCachedFirmwareLabel =>
      'Gérer les micrologiciels mis en cache';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Télécharger ou supprimer les micrologiciels hors ligne';

  @override
  String get maxCachedVersionsLabel => 'Versions max. en cache';

  @override
  String get clearFirmwareCacheLabel => 'Vider le cache des micrologiciels';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Supprimer tous les fichiers de micrologiciels téléchargés';

  @override
  String get clearLabel => 'EFFACER';

  @override
  String get aboutSectionLabel => 'À propos';

  @override
  String get appVersionLabel => 'Version de l\'application';

  @override
  String get legalLicenseLabel => 'Mentions légales et licence';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Exclusion de responsabilité standard et licence GPLv3';

  @override
  String get developerSectionLabel => 'Développeur';

  @override
  String get developerModeEnabledLabel => 'Mode développeur activé';

  @override
  String get testSentryErrorCaptureLabel =>
      'Tester la capture d\'erreur Sentry';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Envoie une exception de test à Sentry — vérifiez le tableau de bord';

  @override
  String get shareAnalyticsLabel => 'Partager les analyses';

  @override
  String get shareAnalyticsSubtitle =>
      'Aidez à améliorer l\'application en partageant des données d\'utilisation anonymes';

  @override
  String get expertModeLabel => 'Mode expert';

  @override
  String get expertModeSubtitle =>
      'Activer la gestion et les téléchargements avancés de micrologiciels';

  @override
  String get exportElrsLuaScriptLabel => 'Exporter le script Lua ELRS';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Enregistrer elrs.lua pour les radios EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel =>
      'Envoyer un rapport de débogage à Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Aidez-nous à corriger les bugs en partageant des journaux système anonymes';

  @override
  String get clearFirmwareCacheTitle => 'Vider le cache des micrologiciels ?';

  @override
  String get clearFirmwareCacheMessage =>
      'Cela supprimera tous les fichiers zip de micrologiciels téléchargés. Vous devrez les retélécharger si vous souhaitez flasher hors ligne.';

  @override
  String get clearAllLabel => 'TOUT EFFACER';

  @override
  String get submitDebugReportTitle => 'Envoyer un rapport de débogage';

  @override
  String get submitDebugReportMessage =>
      'Cela enverra les informations de votre appareil et les journaux de l\'application à Sentry pour le débogage. Aucune information personnelle comme les phrases de liaison ou les mots de passe Wi-Fi ne sera incluse.';

  @override
  String get describeIssueHint =>
      'Veuillez décrire le problème que vous rencontrez...';

  @override
  String get proceedLabel => 'Continuer';

  @override
  String get submittingReportProgress => 'Envoi du rapport…';

  @override
  String get saveLabel => 'Enregistrer';

  @override
  String get notSetLabel => 'Non défini';
}
