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
  String get flashingStatusLocating => 'Ricerca Firmware';

  @override
  String get flashingStatusUnpacking => 'Decompressione Firmware';

  @override
  String get flashingStatusDownloading => 'Download Firmware';

  @override
  String get flashingStatusBuilding => 'Creazione Firmware';

  @override
  String get flashingStatusUploading => 'Caricamento sul dispositivo';

  @override
  String get flashingStatusFinalizing =>
      'Scrittura sul dispositivo — Attendere';

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
  String get flashingStatusSaved => 'Firmware Salvato';

  @override
  String get flashErrorNoTarget =>
      'Selezionare un dispositivo di destinazione.';

  @override
  String get flashErrorNoVersion => 'Selezionare una versione firmware.';

  @override
  String get flashErrorNoDevice =>
      'Impossibile flashare: nessun dispositivo ELRS connesso.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Chip incompatibile: questo firmware è stato creato per $targetChip, ma il dispositivo connesso è $deviceChip. Selezionare una destinazione per lo stesso chip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Nessun accesso a internet per recuperare i file mancanti. Disconnettersi dal dispositivo ELRS, scaricare questo firmware tramite il Gestore Firmware per completare la cache e riprovare.';

  @override
  String get flashErrorOfflineDownload =>
      'Nessun accesso a internet. Impossibile scaricare il firmware mentre si è connessi all\'hotspot del dispositivo ELRS. Disconnettersi, scaricare questa versione tramite il Gestore Firmware e riprovare.';

  @override
  String get flashErrorFlashFailed => 'Flash fallito.';

  @override
  String get flashErrorUnconfirmed =>
      'Il dispositivo si è disconnesso prima di confermare il flash, quindi potrebbe non essersi completato. Ciò accade se perde alimentazione o si riavvia a metà del flash, e occasionalmente su un collegamento Wi-Fi debole dopo un flash riuscito. Controlla la versione del firmware in Configurazione Dispositivo e riflasha se non è cambiata.';

  @override
  String get flashErrorDownloadFailed => 'Download firmware fallito.';

  @override
  String get validationSsidTooLong =>
      'L\'SSID deve essere di 32 caratteri o meno';

  @override
  String get validationPasswordTooShort =>
      'La password deve essere di almeno 8 caratteri';

  @override
  String get validationPasswordTooLong =>
      'La password deve essere di 63 caratteri o meno';

  @override
  String get targetMismatchTitle => 'Target non corrispondente';

  @override
  String get targetMismatchMessage =>
      'Il target del firmware selezionato non corrisponde all\'hardware attualmente in esecuzione sul dispositivo. Sei sicuro di voler forzare il flash?';

  @override
  String get forceFlashLabel => 'FORZA FLASH';

  @override
  String get noBindPhraseTitle => 'Nessuna frase di binding';

  @override
  String get noBindPhraseMessage =>
      'Nessuna frase di binding impostata. Procedere con quella predefinita (vuota)?';

  @override
  String get flashSuccessSnackbar => 'Flash completato con successo!';

  @override
  String get firmwareSavedSnackbar => 'Firmware salvato con successo!';

  @override
  String get flashSuccessMessage =>
      'Flash riuscito! Il dispositivo si sta riavviando.';

  @override
  String get stm32OtaWarning =>
      'Target STM32 selezionato: il flash OTA non è supportato per questo hardware. Puoi compilare e salvare questo firmware in locale per flasharlo manualmente tramite STLink o Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'SCARICA BINARIO';

  @override
  String get waitingForDeviceLabel => 'IN ATTESA DEL DISPOSITIVO...';

  @override
  String get otaUnavailableLabel => 'OTA Non Disponibile';

  @override
  String get doneLabel => 'FATTO';

  @override
  String get targetSelectionTitle => 'Selezione Target';

  @override
  String get deviceTypeLabel => 'Tipo di Dispositivo';

  @override
  String get deviceVendorLabel => 'Produttore Dispositivo';

  @override
  String get regulatoryFrequencyLabel => 'Regolamentazione e Frequenza';

  @override
  String get deviceTargetLabel => 'Target Dispositivo';

  @override
  String get noFirmwareDownloadedButton =>
      'Nessun firmware scaricato. Vai a Gestore Firmware';

  @override
  String hardwareRequiresVersion(String version) {
    return 'L\'hardware richiede la v$version o successiva.';
  }

  @override
  String get downloadCompatibleFirmwareButton => 'Scarica Firmware Compatibile';

  @override
  String get firmwareVersionLabel => 'Versione Firmware';

  @override
  String get firmwareVersionHelper => 'Seleziona la versione ELRS da flashare';

  @override
  String get cachedBadge => '(In Cache)';

  @override
  String errorLoadingVersions(String error) {
    return 'Errore caricamento versioni: $error';
  }

  @override
  String get flashingProfileLabel => 'Profilo di Flashing';

  @override
  String get addProfileTooltip => 'Aggiungi Profilo';

  @override
  String get deleteProfileTooltip => 'Elimina Profilo';

  @override
  String get bindingPhraseHelper => 'La tua binding phrase unica';

  @override
  String get addProfileTitle => 'Aggiungi Profilo di Flashing';

  @override
  String get profileNameHint => 'Nome Profilo (es. I miei Quad)';

  @override
  String get addLabel => 'Aggiungi';

  @override
  String get deleteProfileTitle => 'Elimina Profilo';

  @override
  String deleteProfileMessage(String name) {
    return 'Sei sicuro di voler eliminare il profilo \"$name\"?';
  }

  @override
  String get deleteLabel => 'Elimina';

  @override
  String get settingsCategoryProfilesNetwork => 'Profili e Rete';

  @override
  String get settingsCategoryAppStorage => 'App e Archiviazione';

  @override
  String get settingsCategoryAdvancedDebug => 'Avanzate e Debug';

  @override
  String get settingsCategoryAboutLegal => 'Informazioni e Legali';

  @override
  String get settingsSectionRegulatoryDefaults =>
      'Impostazioni Predefinite Regolamentari';

  @override
  String get settingsSectionPreferences => 'Preferenze';

  @override
  String get settingsSectionPowerTools => 'Strumenti Avanzati';

  @override
  String get settingsSectionDiagnostics => 'Diagnostica';

  @override
  String get regDomainUnknown => 'Sconosciuto';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versioni',
      one: '1 versione',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Modifica $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Inserisci $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua salvato sul dispositivo!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Impossibile salvare lo script: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Inviato! ID evento: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Report inviato con successo!';

  @override
  String debugReportFailed(String error) {
    return 'Invio fallito: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Errore durante il caricamento della licenza: $error';
  }

  @override
  String get firmwareErrorLoadFailed =>
      'Impossibile caricare le versioni del firmware.';

  @override
  String get firmwareErrorOnHotspot =>
      'Impossibile scaricare il firmware mentre si è connessi direttamente all\'hotspot WiFi del ricevitore. Disconnettersi o usare una rete domestica.';

  @override
  String get firmwareErrorCacheFull =>
      'Limite della cache raggiunto. Eliminare una versione precedente.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Impossibile raggiungere il server del firmware. Verificare la connessione a Internet.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Download interrotto: la connessione di rete è stata persa. Verificare la connessione e riprovare.';

  @override
  String get firmwareErrorDownloadFailed =>
      'Download del firmware non riuscito.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Impossibile eliminare questa versione del firmware.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Versione $version';
  }

  @override
  String get readyForOfflineUse => 'Pronto per l\'uso offline';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Spazio utilizzato: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Versioni';
  }

  @override
  String get splashTagline => 'STRUMENTO DI CONFIGURAZIONE INDIPENDENTE';

  @override
  String get splashDisclaimer =>
      'Non è un prodotto ufficiale ExpressLRS.\nCompatibile con firmware 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Dispositivo ELRS';

  @override
  String get unknownIpLabel => 'IP sconosciuto';

  @override
  String get firmwareBinariesFileType => 'Binari Firmware';

  @override
  String helpContentLoadFailed(String error) {
    return 'Errore durante il caricamento dei contenuti della guida: $error';
  }
}
