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
  String get supportDevelopmentLabel => 'Soutenir le développement';

  @override
  String get supportDevelopmentSubtitle => 'Soutenez le développeur via Ko-fi';

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

  @override
  String get languageOverrideLabel => 'Langue';

  @override
  String get languageOverrideSystemDefault => 'Par défaut du système';

  @override
  String get legalNoticeSectionTitle => 'Mentions Légales';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile est un projet libre et open-source (FOSS) développé indépendamment par Weston Hinton. Ce projet n\'est pas un produit officiel d\'ExpressLRS LLC et n\'est pas officiellement pris en charge, approuvé ou certifié par l\'équipe de développement ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Avis de Marque Déposée';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS et le logo ExpressLRS sont des marques déposées d\'ExpressLRS LLC. L\'utilisation de ces marques est uniquement à des fins descriptives et de compatibilité. Pour le configurateur et la documentation officiels d\'ExpressLRS, veuillez visiter expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Support Officiel';

  @override
  String get officialSupportSectionText =>
      'Soutenez le projet officiel ExpressLRS :';

  @override
  String get donateOpenCollectiveLabel => 'Faire un don via Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Licence Logicielle';

  @override
  String get gplv3NoticeText =>
      'Ce projet est sous licence GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Guide de Flashage';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Ressources';

  @override
  String get resourceCommunitySupport => 'Communauté et Support';

  @override
  String get resourceDiscordCommunity => 'Communauté Discord';

  @override
  String get resourceJoinDiscord => 'Rejoindre le Discord ELRS';

  @override
  String get resourceGithubRepo => 'Dépôt GitHub';

  @override
  String get resourceFlashRecovery => 'Récupération après Flashage';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Si votre appareil ne répond plus après un flashage échoué :';

  @override
  String get resourceRecoveryStep1 =>
      'Maintenez le bouton BOOT enfoncé tout en branchant l\'appareil via USB pour entrer en mode bootloader.';

  @override
  String get resourceRecoveryStep2 =>
      'Utilisez le Flasheur Web ELRS sur expresslrs.org/flasher pour re-flasher via USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Pour les appareils compatibles Wi-Fi, maintenez le bouton BOOT enfoncé pendant 60 secondes pour déclencher le mode de récupération Hotspot Wi-Fi.';

  @override
  String get resourceRecoveryStep4 =>
      'Rejoignez #help sur le Discord ELRS — la communauté peut généralement récupérer n\'importe quel appareil.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Le guide de déblocage de Joshua Bardwell est vivement recommandé :';

  @override
  String get resourceWebFlasherButton => 'Flasheur Web';

  @override
  String get resourceRecoveryVideoButton => 'Vidéo de Récupération';

  @override
  String get resourceLegalLiability => 'Aspects Légaux et Responsabilité';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile est fourni tel quel, sans aucune garantie. Les développeurs ne sont pas responsables de tout dommage, perte de données ou matériel non fonctionnel résultant de l\'utilisation de cette application, y compris, mais sans s\'y limiter, les récepteurs, émetteurs ou contrôleurs de vol rendus inutilisables.\n\nEn utilisant cette application, vous acceptez l\'entière responsabilité de votre matériel.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Voir la Décharge de Responsabilité Complète';

  @override
  String get disclaimerTitle => 'À utiliser à vos risques et périls';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile est fourni tel quel, sans garantie d\'aucune sorte.';

  @override
  String get disclaimerLiability =>
      'Les développeurs ne sont pas responsables des dommages, pertes de données ou de tout matériel non fonctionnel résultant de l\'utilisation de cette application, y compris, mais sans s\'y limiter, les récepteurs, émetteurs ou contrôleurs de vol bloqués.';

  @override
  String get disclaimerAgreement =>
      'En utilisant cette application, vous confirmez que vous comprenez les risques liés au flashage de firmware personnalisé et acceptez l\'entière responsabilité de votre matériel.';

  @override
  String get disclaimerVerification =>
      'Vérifiez toujours la cible et la version du firmware avant de flasher. Conservez une copie de votre firmware original si possible.';

  @override
  String get disclaimerUnderstand => 'Je comprends';

  @override
  String get optionsTitle => 'Options du micrologiciel';

  @override
  String get optionsSubtitle =>
      'Configurez la liaison et les identifiants réseau.';

  @override
  String get wifiPasswordLabel => 'Mot de passe Wi-Fi';

  @override
  String get wifiOnIntervalLabel =>
      'Intervalle d\'activation automatique du Wi-Fi';

  @override
  String get regulatoryDomainLabel => 'Domaine réglementaire';

  @override
  String get regDomainIsm => 'ISM (2,4 GHz)';

  @override
  String get regDomainEuLbt => 'UE CE (2,4 GHz LBT)';

  @override
  String get regDomainAu915 => 'AU (915 MHz)';

  @override
  String get regDomainFcc915 => 'FCC (915 MHz)';

  @override
  String get regDomainEu868 => 'UE (868 MHz)';

  @override
  String get regDomainIn866 => 'IN (866 MHz)';

  @override
  String get regDomainAu433 => 'AU (433 MHz)';

  @override
  String get regDomainEu433 => 'UE (433 MHz)';

  @override
  String get regDomainUs433 => 'US (433 MHz)';
}
