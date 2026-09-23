// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Frase di Associazione';

  @override
  String get networkSsidLabel => 'SSID WiFi';

  @override
  String get flashingButtonLabel => 'Flascia';

  @override
  String get flashingStatusLocating => 'Locating Firmware';

  @override
  String get flashingStatusUnpacking => 'Unpacking Firmware';

  @override
  String get flashingStatusDownloading => 'Downloading Firmware';

  @override
  String get flashingStatusBuilding => 'Building Firmware';

  @override
  String get flashingStatusUploading => 'Uploading to Device';

  @override
  String get flashingStatusFinalizing => 'Writing to Device — Please Wait';

  @override
  String get packetRateLabel => 'Frequenza dei Pacchetti';

  @override
  String get baudRateLabel => 'Velocità Baud';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Aggiornamento firmware $expressLRS su hardware $radioMaster o $betaFPV...';
  }

  @override
  String get flashDeviceLabel => 'Flascia Dispositivo';

  @override
  String get deviceConfigLabel => 'Configurazione Dispositivo';

  @override
  String get firmwareManagerLabel => 'Gestore Firmware';

  @override
  String get settingsLabel => 'Impostazioni';

  @override
  String get helpSupportLabel => 'Aiuto e Supporto';

  @override
  String get noDeviceFoundLabel => 'Nessun Dispositivo Trovato';

  @override
  String get retryLabel => 'Riprova';

  @override
  String get manualConnectionLabel => 'Connessione Manuale';

  @override
  String get manualIpOverrideLabel => 'Sovrascrittura IP Manuale';

  @override
  String get connectLabel => 'Connetti';

  @override
  String get cancelLabel => 'Annulla';

  @override
  String get matchedLabel => 'Corrispondente';

  @override
  String get mismatchLabel => 'Non Corrispondente';

  @override
  String connectedLabel(String ip) {
    return 'Connesso: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Flasciatura e WiFi';

  @override
  String get aboutSupportCategoryLabel => 'Informazioni e Supporto';

  @override
  String get advancedCategoryLabel => 'Avanzate';

  @override
  String get flashingDefaultsSectionLabel =>
      'Impostazioni Predefinite di Flasciatura';

  @override
  String get default24GHzDomainLabel => 'Dominio 2.4GHz Predefinito';

  @override
  String get defaultSubGHzDomainLabel => 'Dominio Sub-GHz Predefinito';

  @override
  String get globalBindingPhraseLabel => 'Frase di Associazione Globale';

  @override
  String get homeWifiSsidLabel => 'SSID WiFi di Casa';

  @override
  String get homeWifiPasswordLabel => 'Password WiFi di Casa';

  @override
  String get manageCachedFirmwareLabel =>
      'Gestisci Firmware Memorizzato nella Cache';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Scarica o elimina firmware offline';

  @override
  String get maxCachedVersionsLabel => 'Versioni Max nella Cache';

  @override
  String get clearFirmwareCacheLabel => 'Svuota Cache Firmware';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Elimina tutti i file firmware scaricati';

  @override
  String get clearLabel => 'SVUOTA';

  @override
  String get aboutSectionLabel => 'Informazioni';

  @override
  String get appVersionLabel => 'Versione App';

  @override
  String get legalLicenseLabel => 'Legale e Licenza';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Dichiarazione di non responsabilità standard e Licenza GPLv3';

  @override
  String get supportDevelopmentLabel => 'Sostieni lo Sviluppo';

  @override
  String get supportDevelopmentSubtitle =>
      'Sostieni lo sviluppatore tramite Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Condividi Analisi';

  @override
  String get shareAnalyticsSubtitle =>
      'Aiuta a migliorare l\'app condividendo dati di utilizzo anonimi';

  @override
  String get expertModeLabel => 'Modalità Esperto';

  @override
  String get expertModeSubtitle =>
      'Abilita la gestione avanzata del firmware e i download';

  @override
  String get exportElrsLuaScriptLabel => 'Esporta Script Lua ELRS';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Salva elrs.lua per radio EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel => 'Invia Rapporto di Debug a Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Aiutaci a risolvere i bug condividendo i log di sistema anonimi';

  @override
  String get clearFirmwareCacheTitle => 'Svuotare la Cache del Firmware?';

  @override
  String get clearFirmwareCacheMessage =>
      'Questo eliminerà tutti i file zip del firmware scaricati. Dovrai scaricarli nuovamente se desideri flasciare offline.';

  @override
  String get clearAllLabel => 'SVUOTA TUTTO';

  @override
  String get submitDebugReportTitle => 'Invia Rapporto di Debug';

  @override
  String get submitDebugReportMessage =>
      'Questo invierà le informazioni del tuo dispositivo e i log dell\'app a Sentry per il debug. Nessuna informazione personale come Frasi di Associazione o password WiFi sarà inclusa.';

  @override
  String get describeIssueHint =>
      'Descrivi il problema che stai riscontrando...';

  @override
  String get proceedLabel => 'Procedi';

  @override
  String get submittingReportProgress => 'Invio rapporto in corso…';

  @override
  String get saveLabel => 'Salva';

  @override
  String get notSetLabel => 'Non impostato';

  @override
  String get languageOverrideLabel => 'Lingua';

  @override
  String get languageOverrideSystemDefault => 'Predefinito di Sistema';

  @override
  String get legalNoticeSectionTitle => 'Avviso Legale';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile è un progetto gratuito e open-source (FOSS) sviluppato indipendentemente da Weston Hinton. Questo progetto non è un prodotto ufficiale di ExpressLRS LLC e non è ufficialmente supportato, approvato o certificato dal team di sviluppo di ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Avviso sui Marchi Registrati';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS e il logo ExpressLRS sono marchi registrati di ExpressLRS LLC. L\'uso di questi marchi è a solo scopo descrittivo e di compatibilità. Per il configuratore e la documentazione ufficiali di ExpressLRS, si prega di visitare expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Supporto Ufficiale';

  @override
  String get officialSupportSectionText =>
      'Supporta il progetto ufficiale ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel => 'Dona tramite Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Licenza Software';

  @override
  String get gplv3NoticeText =>
      'Questo progetto è concesso in licenza sotto la GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Guida al Flashing';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Risorse';

  @override
  String get resourceCommunitySupport => 'Community e Supporto';

  @override
  String get resourceDiscordCommunity => 'Community Discord';

  @override
  String get resourceJoinDiscord => 'Unisciti al Discord di ELRS';

  @override
  String get resourceGithubRepo => 'Repository GitHub';

  @override
  String get resourceFlashRecovery => 'Ripristino Firmware';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Se il tuo dispositivo sembra non rispondere dopo un flash fallito:';

  @override
  String get resourceRecoveryStep1 =>
      'Tieni premuto il pulsante BOOT mentre colleghi tramite USB per entrare in modalità bootloader.';

  @override
  String get resourceRecoveryStep2 =>
      'Usa l\'ELRS Web Flasher su expresslrs.org/flasher per riflashare tramite USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Per i dispositivi con capacità WiFi, tieni premuto BOOT per 60 secondi per attivare la modalità di recupero Hotspot WiFi.';

  @override
  String get resourceRecoveryStep4 =>
      'Unisciti a #help sul Discord di ELRS — la community di solito può recuperare qualsiasi dispositivo.';

  @override
  String get resourceBardwellGuideRecommended =>
      'La guida di Joshua Bardwell per il \'de-bricking\' è altamente raccomandata:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'Video di Recupero';

  @override
  String get resourceLegalLiability => 'Legale e Responsabilità';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile è fornito \'così com\'è\', senza alcuna garanzia. Gli sviluppatori non sono responsabili per eventuali danni, perdita di dati o hardware non funzionante derivanti dall\'uso di questa applicazione, inclusi ma non limitati a ricevitori, trasmettitori o controllori di volo \'brickati\'.\n\nUtilizzando questa app, accetti la piena responsabilità per il tuo hardware.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Visualizza Dichiarazione di Non Responsabilità Completa';

  @override
  String get disclaimerTitle => 'Uso a Proprio Rischio';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile è fornito così com\'è, senza alcuna garanzia.';

  @override
  String get disclaimerLiability =>
      'Gli sviluppatori non sono responsabili per eventuali danni, perdita di dati o hardware non funzionante derivanti dall\'uso di questa applicazione, inclusi ma non limitati a ricevitori, trasmettitori o controllori di volo danneggiati in modo irreparabile.';

  @override
  String get disclaimerAgreement =>
      'Utilizzando questa app, confermi di aver compreso i rischi del flashing di firmware personalizzati e accetti la piena responsabilità per il tuo hardware.';

  @override
  String get disclaimerVerification =>
      'Verifica sempre il dispositivo di destinazione e la versione del firmware prima del flashing. Se possibile, conserva una copia del firmware originale.';

  @override
  String get disclaimerUnderstand => 'Ho Capito';

  @override
  String get optionsTitle => 'Opzioni Firmware';

  @override
  String get optionsSubtitle =>
      'Configura l\'associazione e le credenziali di rete.';

  @override
  String get wifiPasswordLabel => 'Password WiFi';

  @override
  String get wifiOnIntervalLabel => 'Intervallo di accensione automatica WiFi';

  @override
  String get regulatoryDomainLabel => 'Dominio Normativo';

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
  String get regDomainUs433 => 'USA (433MHz)';

  @override
  String get flashingStatusSaved => 'Firmware Saved';

  @override
  String get flashErrorNoTarget => 'Please select a target device.';

  @override
  String get flashErrorNoVersion => 'Please select a firmware version.';

  @override
  String get flashErrorNoDevice => 'Cannot flash: no ELRS device connected.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Incompatible chip: this firmware is built for $targetChip, but the connected device is $deviceChip. Select a target for the same chip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'No internet access to fetch missing files. Please disconnect from the ELRS device, download this firmware via the Firmware Manager to complete your cache, and try again.';

  @override
  String get flashErrorOfflineDownload =>
      'No internet access. You cannot download firmware while connected to the ELRS device hotspot. Please disconnect, download this version via the Firmware Manager, and try again.';

  @override
  String get flashErrorFlashFailed => 'Flashing failed.';

  @override
  String get flashErrorUnconfirmed =>
      'The device disconnected before confirming the flash, so it may not have completed. This happens if it loses power or restarts mid-flash, and occasionally on a weak WiFi link after a successful flash. Check the firmware version in Device Config, and flash again if it hasn\'t changed.';

  @override
  String get flashErrorDownloadFailed => 'Failed to download firmware.';

  @override
  String get validationSsidTooLong => 'SSID must be 32 characters or less';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get validationPasswordTooLong =>
      'Password must be 63 characters or less';

  @override
  String get targetMismatchTitle => 'Target Mismatch';

  @override
  String get targetMismatchMessage =>
      'The selected firmware target does not match the hardware currently running on the device. Are you sure you want to force flash?';

  @override
  String get forceFlashLabel => 'Force Flash';

  @override
  String get noBindPhraseTitle => 'No Binding Phrase';

  @override
  String get noBindPhraseMessage =>
      'No binding phrase set. Proceed with the default (empty)?';

  @override
  String get flashSuccessSnackbar => 'Flashing completed successfully!';

  @override
  String get firmwareSavedSnackbar => 'Firmware saved successfully!';

  @override
  String get flashSuccessMessage => 'Flashing Successful! Device is rebooting.';

  @override
  String get stm32OtaWarning =>
      'STM32 Target Selected: OTA flashing is not supported for this hardware. You can build and save this firmware locally to flash manually via STLink or Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'Download Binary';

  @override
  String get waitingForDeviceLabel => 'Waiting for Device...';

  @override
  String get otaUnavailableLabel => 'OTA Unavailable';

  @override
  String get doneLabel => 'Done';

  @override
  String get targetSelectionTitle => 'Target Selection';

  @override
  String get deviceTypeLabel => 'Device Type';

  @override
  String get deviceVendorLabel => 'Device Vendor';

  @override
  String get regulatoryFrequencyLabel => 'Regulatory & Frequency';

  @override
  String get deviceTargetLabel => 'Device Target';

  @override
  String get noFirmwareDownloadedButton =>
      'No firmware downloaded. Go to Firmware Manager';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Hardware requires v$version or newer.';
  }

  @override
  String get downloadCompatibleFirmwareButton => 'Download Compatible Firmware';

  @override
  String get firmwareVersionLabel => 'Firmware Version';

  @override
  String get firmwareVersionHelper => 'Select the ELRS version to flash';

  @override
  String get cachedBadge => '(Cached)';

  @override
  String errorLoadingVersions(String error) {
    return 'Error loading versions: $error';
  }

  @override
  String get flashingProfileLabel => 'Flashing Profile';

  @override
  String get addProfileTooltip => 'Add Profile';

  @override
  String get deleteProfileTooltip => 'Delete Profile';

  @override
  String get bindingPhraseHelper => 'Your unique binding phrase';

  @override
  String get addProfileTitle => 'Add Flashing Profile';

  @override
  String get profileNameHint => 'Profile Name (e.g., My Quads)';

  @override
  String get addLabel => 'Add';

  @override
  String get deleteProfileTitle => 'Delete Profile';

  @override
  String deleteProfileMessage(String name) {
    return 'Are you sure you want to delete the profile \"$name\"?';
  }

  @override
  String get deleteLabel => 'Delete';

  @override
  String get settingsCategoryProfilesNetwork => 'Profiles & Network';

  @override
  String get settingsCategoryAppStorage => 'App & Storage';

  @override
  String get settingsCategoryAdvancedDebug => 'Advanced & Debug';

  @override
  String get settingsCategoryAboutLegal => 'About & Legal';

  @override
  String get settingsSectionRegulatoryDefaults => 'Regulatory Defaults';

  @override
  String get settingsSectionPreferences => 'Preferences';

  @override
  String get settingsSectionPowerTools => 'Power Tools';

  @override
  String get settingsSectionDiagnostics => 'Diagnostics';

  @override
  String get regDomainUnknown => 'Unknown';

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
    return 'Edit $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Enter $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua saved to device!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Failed to save script: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Submitted! Event ID: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Report submitted successfully!';

  @override
  String debugReportFailed(String error) {
    return 'Failed to submit: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Error loading license: $error';
  }
}
