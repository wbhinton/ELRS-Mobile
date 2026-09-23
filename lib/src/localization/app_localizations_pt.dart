// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Frase de Ligação';

  @override
  String get networkSsidLabel => 'SSID do WiFi';

  @override
  String get flashingButtonLabel => 'Gravar Firmware';

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
  String get flashDeviceLabel => 'Gravar Dispositivo';

  @override
  String get deviceConfigLabel => 'Configuração do Dispositivo';

  @override
  String get firmwareManagerLabel => 'Gestor de Firmware';

  @override
  String get settingsLabel => 'Definições';

  @override
  String get helpSupportLabel => 'Ajuda e Suporte';

  @override
  String get noDeviceFoundLabel => 'Nenhum Dispositivo Encontrado';

  @override
  String get retryLabel => 'Tentar Novamente';

  @override
  String get manualConnectionLabel => 'Conexão Manual';

  @override
  String get manualIpOverrideLabel => 'Sobrescrita Manual de IP';

  @override
  String get connectLabel => 'Conectar';

  @override
  String get cancelLabel => 'Cancelar';

  @override
  String get matchedLabel => 'Coincidente';

  @override
  String get mismatchLabel => 'Incompatibilidade';

  @override
  String connectedLabel(String ip) {
    return 'Conectado: $ip';
  }

  @override
  String get default24GHzDomainLabel => 'Domínio Padrão 2.4GHz';

  @override
  String get defaultSubGHzDomainLabel => 'Domínio Padrão Sub-GHz';

  @override
  String get globalBindingPhraseLabel => 'Frase de Ligação Global';

  @override
  String get homeWifiSsidLabel => 'SSID do WiFi Doméstico';

  @override
  String get homeWifiPasswordLabel => 'Palavra-passe do WiFi Doméstico';

  @override
  String get manageCachedFirmwareLabel => 'Gerir Firmware em Cache';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Descarregar ou apagar firmware offline';

  @override
  String get maxCachedVersionsLabel => 'Máximo de Versões em Cache';

  @override
  String get clearFirmwareCacheLabel => 'Limpar Cache de Firmware';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Apagar todos os ficheiros de firmware descarregados';

  @override
  String get clearLabel => 'LIMPAR';

  @override
  String get appVersionLabel => 'Versão da Aplicação';

  @override
  String get legalLicenseLabel => 'Informação Legal e Licença';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Aviso legal padrão e Licença GPLv3';

  @override
  String get supportDevelopmentLabel => 'Apoiar o Desenvolvimento';

  @override
  String get supportDevelopmentSubtitle => 'Apoie o desenvolvedor via Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Partilhar Análises';

  @override
  String get shareAnalyticsSubtitle =>
      'Ajude a melhorar a aplicação ao partilhar dados de utilização anónimos';

  @override
  String get expertModeLabel => 'Modo Especialista';

  @override
  String get expertModeSubtitle =>
      'Ativar gestão avançada de firmware e descargas';

  @override
  String get exportElrsLuaScriptLabel => 'Exportar Script Lua ELRS';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Guardar elrs.lua para rádios EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel =>
      'Enviar Relatório de Depuração para Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Ajude-nos a corrigir erros partilhando registos de sistema anónimos';

  @override
  String get clearFirmwareCacheTitle => 'Limpar Cache de Firmware?';

  @override
  String get clearFirmwareCacheMessage =>
      'Isto irá apagar todos os ficheiros zip de firmware descarregados. Terá de os descarregar novamente se quiser gravar offline.';

  @override
  String get clearAllLabel => 'LIMPAR TUDO';

  @override
  String get submitDebugReportTitle => 'Enviar Relatório de Depuração';

  @override
  String get submitDebugReportMessage =>
      'Isto irá enviar as informações do seu dispositivo e os registos da aplicação para o Sentry para depuração. Não serão incluídas informações pessoais, como Frases de Ligação ou palavras-passe de WiFi.';

  @override
  String get describeIssueHint =>
      'Por favor, descreva o problema que está a experienciar...';

  @override
  String get proceedLabel => 'Continuar';

  @override
  String get submittingReportProgress => 'A enviar relatório…';

  @override
  String get saveLabel => 'Guardar';

  @override
  String get notSetLabel => 'Não definido';

  @override
  String get languageOverrideLabel => 'Idioma';

  @override
  String get languageOverrideSystemDefault => 'Padrão do Sistema';

  @override
  String get legalNoticeSectionTitle => 'Aviso Legal';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile é um projeto de código aberto e gratuito (FOSS) desenvolvido independentemente por Weston Hinton. Este projeto não é um produto oficial da ExpressLRS LLC e não é oficialmente suportado, endossado ou certificado pela equipa de desenvolvimento do ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Aviso de Marca Registrada';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS e o logótipo ExpressLRS são marcas registradas da ExpressLRS LLC. O uso dessas marcas destina-se apenas a fins descritivos e de compatibilidade. Para o configurador e documentação oficiais do ExpressLRS, visite expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Suporte Oficial';

  @override
  String get officialSupportSectionText =>
      'Apoie o projeto oficial ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel => 'Doar via Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Licença de Software';

  @override
  String get gplv3NoticeText =>
      'Este projeto está licenciado sob a GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Guia de Flashing';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Recursos';

  @override
  String get resourceCommunitySupport => 'Comunidade e Suporte';

  @override
  String get resourceDiscordCommunity => 'Comunidade Discord';

  @override
  String get resourceJoinDiscord => 'Entre no Discord do ELRS';

  @override
  String get resourceGithubRepo => 'Repositório GitHub';

  @override
  String get resourceFlashRecovery => 'Recuperação de Flash';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Se o seu dispositivo parecer não responder após um flash falhado:';

  @override
  String get resourceRecoveryStep1 =>
      'Mantenha o botão BOOT pressionado enquanto liga via USB para entrar no modo bootloader.';

  @override
  String get resourceRecoveryStep2 =>
      'Use o ELRS Web Flasher em expresslrs.org/flasher para regravar (re-flash) via USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Para dispositivos com capacidade WiFi, mantenha o botão BOOT pressionado por 60 segundos para ativar o modo de recuperação do Hotspot WiFi.';

  @override
  String get resourceRecoveryStep4 =>
      'Junte-se ao canal #help no Discord do ELRS — a comunidade geralmente consegue recuperar qualquer dispositivo.';

  @override
  String get resourceBardwellGuideRecommended =>
      'O guia de recuperação (unbricking) de Joshua Bardwell é altamente recomendado:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'Vídeo de Recuperação';

  @override
  String get resourceLegalLiability => 'Questões Legais e Responsabilidade';

  @override
  String get resourceLiabilityDisclaimerText =>
      'O ELRS Mobile é fornecido como está, sem garantia de qualquer tipo. Os desenvolvedores não são responsáveis por quaisquer danos, perda de dados ou hardware não funcional resultantes do uso desta aplicação, incluindo, entre outros, recetores, transmissores ou controladores de voo \'brickados\'.\n\nAo usar esta aplicação, aceita total responsabilidade pelo seu hardware.';

  @override
  String get resourceViewFullDisclaimerButton => 'Ver Aviso Legal Completo';

  @override
  String get disclaimerTitle => 'Uso por Sua Conta e Risco';

  @override
  String get disclaimerHeader =>
      'O ELRS Mobile é fornecido como está, sem garantia de qualquer tipo.';

  @override
  String get disclaimerLiability =>
      'Os desenvolvedores não são responsáveis por quaisquer danos, perda de dados ou hardware não funcional resultantes do uso desta aplicação, incluindo, mas não se limitando a, receptores, transmissores ou controladores de voo danificados (bricked).';

  @override
  String get disclaimerAgreement =>
      'Ao usar este aplicativo, você confirma que entende os riscos de flashar firmware personalizado e aceita total responsabilidade pelo seu hardware.';

  @override
  String get disclaimerVerification =>
      'Sempre verifique o alvo e a versão do firmware antes de flashar. Mantenha um registro do seu firmware original, se possível.';

  @override
  String get disclaimerUnderstand => 'Compreendo';

  @override
  String get optionsTitle => 'Opções de Firmware';

  @override
  String get optionsSubtitle =>
      'Configure a ligação (binding) e as credenciais de rede.';

  @override
  String get wifiPasswordLabel => 'Senha do Wi-Fi';

  @override
  String get wifiOnIntervalLabel => 'Intervalo de Ativação Automática do Wi-Fi';

  @override
  String get regulatoryDomainLabel => 'Domínio Regulatório';

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
  String get regDomainUs433 => 'EUA (433MHz)';

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

  @override
  String get firmwareErrorLoadFailed => 'Could not load firmware versions.';

  @override
  String get firmwareErrorOnHotspot =>
      'Cannot download firmware while connected directly to the receiver\'s WiFi hotspot. Please disconnect or use a home network.';

  @override
  String get firmwareErrorCacheFull =>
      'Cache limit reached. Please delete an old version.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Unable to reach the firmware server. Please check your internet connection.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Download interrupted: the network connection was lost. Please check your connection and try again.';

  @override
  String get firmwareErrorDownloadFailed => 'Failed to download firmware.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Could not delete this firmware version.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Version $version';
  }

  @override
  String get readyForOfflineUse => 'Ready for offline use';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Storage Used: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Versions';
  }

  @override
  String get splashTagline => 'Independent Configuration Tool';

  @override
  String get splashDisclaimer =>
      'Not an official ExpressLRS product.\nCompatible with 3.3.x/4.x firmware.';

  @override
  String get unknownDeviceName => 'ELRS Device';

  @override
  String get unknownIpLabel => 'Unknown IP';

  @override
  String get firmwareBinariesFileType => 'Firmware Binaries';

  @override
  String helpContentLoadFailed(String error) {
    return 'Error loading help content: $error';
  }
}
