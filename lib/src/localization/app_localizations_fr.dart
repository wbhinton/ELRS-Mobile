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
  String get flashingStatusLocating => 'Localisation du firmware';

  @override
  String get flashingStatusUnpacking => 'Décompression du firmware';

  @override
  String get flashingStatusDownloading => 'Téléchargement du firmware';

  @override
  String get flashingStatusBuilding => 'Construction du firmware';

  @override
  String get flashingStatusUploading => 'Transfert vers l\'appareil';

  @override
  String get flashingStatusFinalizing =>
      'Écriture sur l\'appareil — Veuillez patienter';

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

  @override
  String get flashingStatusSaved => 'Firmware enregistré';

  @override
  String get flashErrorNoTarget => 'Veuillez sélectionner un appareil cible.';

  @override
  String get flashErrorNoVersion =>
      'Veuillez sélectionner une version de firmware.';

  @override
  String get flashErrorNoDevice =>
      'Impossible de flasher : aucun appareil ELRS n\'est connecté.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Puce incompatible : ce firmware est conçu pour $targetChip, mais l\'appareil connecté est $deviceChip. Sélectionnez une cible pour la même puce.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Pas d\'accès internet pour récupérer les fichiers manquants. Veuillez vous déconnecter de l\'appareil ELRS, télécharger ce firmware via le Gestionnaire de micrologiciels pour compléter votre cache, puis réessayez.';

  @override
  String get flashErrorOfflineDownload =>
      'Pas d\'accès internet. Vous ne pouvez pas télécharger de firmware lorsque vous êtes connecté au point d\'accès de l\'appareil ELRS. Veuillez vous déconnecter, télécharger cette version via le Gestionnaire de micrologiciels, puis réessayez.';

  @override
  String get flashErrorFlashFailed => 'Échec du flash.';

  @override
  String get flashErrorUnconfirmed =>
      'L\'appareil s\'est déconnecté avant de confirmer le flash, il est donc possible qu\'il n\'ait pas été terminé. Cela se produit s\'il perd de l\'énergie ou redémarre pendant le flash, et occasionnellement sur une liaison Wi-Fi faible après un flash réussi. Vérifiez la version du micrologiciel dans la configuration de l\'appareil (Device Config) et flashez à nouveau si elle n\'a pas changé.';

  @override
  String get flashErrorDownloadFailed =>
      'Échec du téléchargement du micrologiciel.';

  @override
  String get validationSsidTooLong =>
      'Le SSID doit contenir 32 caractères ou moins.';

  @override
  String get validationPasswordTooShort =>
      'Le mot de passe doit contenir au moins 8 caractères.';

  @override
  String get validationPasswordTooLong =>
      'Le mot de passe doit contenir 63 caractères ou moins.';

  @override
  String get targetMismatchTitle => 'Cible Incompatible';

  @override
  String get targetMismatchMessage =>
      'La cible du micrologiciel sélectionnée ne correspond pas au matériel actuellement en cours d\'exécution sur l\'appareil. Êtes-vous sûr de vouloir forcer le flash ?';

  @override
  String get forceFlashLabel => 'FORCER LE FLASH';

  @override
  String get noBindPhraseTitle => 'Aucune Phrase de Liaison';

  @override
  String get noBindPhraseMessage =>
      'Aucune phrase de liaison définie. Voulez-vous continuer avec la valeur par défaut (vide) ?';

  @override
  String get flashSuccessSnackbar => 'Flash terminé avec succès !';

  @override
  String get firmwareSavedSnackbar => 'Micrologiciel enregistré avec succès !';

  @override
  String get flashSuccessMessage => 'Flash réussi ! L\'appareil redémarre.';

  @override
  String get stm32OtaWarning =>
      'Cible STM32 sélectionnée : Le flash OTA n\'est pas pris en charge pour ce matériel. Vous pouvez construire et enregistrer ce micrologiciel localement pour le flasher manuellement via STLink ou Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'TÉLÉCHARGER LE BINAIRE';

  @override
  String get waitingForDeviceLabel => 'ATTENTE DE L\'APPAREIL...';

  @override
  String get otaUnavailableLabel => 'OTA Indisponible';

  @override
  String get doneLabel => 'TERMINÉ';

  @override
  String get targetSelectionTitle => 'Sélection de la cible';

  @override
  String get deviceTypeLabel => 'Type d\'appareil';

  @override
  String get deviceVendorLabel => 'Fabricant de l\'appareil';

  @override
  String get regulatoryFrequencyLabel => 'Réglementation et Fréquence';

  @override
  String get deviceTargetLabel => 'Cible de l\'appareil';

  @override
  String get noFirmwareDownloadedButton =>
      'Aucun firmware téléchargé. Aller au gestionnaire de firmware';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Le matériel nécessite la v$version ou une version plus récente.';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'Télécharger le firmware compatible';

  @override
  String get firmwareVersionLabel => 'Version du firmware';

  @override
  String get firmwareVersionHelper => 'Sélectionnez la version ELRS à flasher';

  @override
  String get cachedBadge => '(Mis en cache)';

  @override
  String errorLoadingVersions(String error) {
    return 'Erreur lors du chargement des versions : $error';
  }

  @override
  String get flashingProfileLabel => 'Profil de flashage';

  @override
  String get addProfileTooltip => 'Ajouter un profil';

  @override
  String get deleteProfileTooltip => 'Supprimer le profil';

  @override
  String get bindingPhraseHelper => 'Votre phrase de liaison unique';

  @override
  String get addProfileTitle => 'Ajouter un profil de flashage';

  @override
  String get profileNameHint => 'Nom du profil (ex: Mes Quads)';

  @override
  String get addLabel => 'Ajouter';

  @override
  String get deleteProfileTitle => 'Supprimer le profil';

  @override
  String deleteProfileMessage(String name) {
    return 'Êtes-vous sûr de vouloir supprimer le profil \"$name\" ?';
  }

  @override
  String get deleteLabel => 'Supprimer';

  @override
  String get settingsCategoryProfilesNetwork => 'Profils et réseau';

  @override
  String get settingsCategoryAppStorage => 'Application et stockage';

  @override
  String get settingsCategoryAdvancedDebug => 'Avancé et débogage';

  @override
  String get settingsCategoryAboutLegal => 'À propos et mentions légales';

  @override
  String get settingsSectionRegulatoryDefaults =>
      'Paramètres réglementaires par défaut';

  @override
  String get settingsSectionPreferences => 'Préférences';

  @override
  String get settingsSectionPowerTools => 'Outils avancés';

  @override
  String get settingsSectionDiagnostics => 'Diagnostics';

  @override
  String get regDomainUnknown => 'Inconnu';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versions',
      one: '1 version',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Modifier $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Saisir $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua enregistré sur l\'appareil !';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Échec de l\'enregistrement du script : $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Soumis ! ID d\'événement : $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Rapport soumis avec succès !';

  @override
  String debugReportFailed(String error) {
    return 'Échec de la soumission : $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Erreur lors du chargement de la licence : $error';
  }

  @override
  String get firmwareErrorLoadFailed =>
      'Impossible de charger les versions du firmware.';

  @override
  String get firmwareErrorOnHotspot =>
      'Impossible de télécharger le firmware lorsque vous êtes directement connecté au point d\'accès Wi-Fi du récepteur. Veuillez vous déconnecter ou utiliser un réseau domestique.';

  @override
  String get firmwareErrorCacheFull =>
      'Limite du cache atteinte. Veuillez supprimer une ancienne version.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Impossible d\'atteindre le serveur de firmware. Veuillez vérifier votre connexion internet.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Téléchargement interrompu : la connexion réseau a été perdue. Veuillez vérifier votre connexion et réessayer.';

  @override
  String get firmwareErrorDownloadFailed =>
      'Échec du téléchargement du firmware.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Impossible de supprimer cette version du firmware.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Version $version';
  }

  @override
  String get readyForOfflineUse => 'Prêt pour une utilisation hors ligne';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Stockage utilisé : $sizeString Mo';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit versions';
  }

  @override
  String get splashTagline => 'OUTIL DE CONFIGURATION INDÉPENDANT';

  @override
  String get splashDisclaimer =>
      'Ceci n\'est pas un produit officiel ExpressLRS.\nCompatible avec les firmwares 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Appareil ELRS';

  @override
  String get unknownIpLabel => 'IP Inconnue';

  @override
  String get firmwareBinariesFileType => 'Binaires de Firmware';

  @override
  String helpContentLoadFailed(String error) {
    return 'Erreur lors du chargement du contenu d\'aide : $error';
  }
}
