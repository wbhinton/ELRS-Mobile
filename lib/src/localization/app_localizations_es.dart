// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Frase de Vinculación';

  @override
  String get networkSsidLabel => 'SSID de WiFi';

  @override
  String get flashingButtonLabel => 'Flashear';

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
  String get packetRateLabel => 'Tasa de Paquetes';

  @override
  String get baudRateLabel => 'Tasa de Baudios';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Actualizando firmware de $expressLRS en hardware $radioMaster o $betaFPV...';
  }

  @override
  String get flashDeviceLabel => 'Flashear Dispositivo';

  @override
  String get deviceConfigLabel => 'Configuración del Dispositivo';

  @override
  String get firmwareManagerLabel => 'Administrador de Firmware';

  @override
  String get settingsLabel => 'Ajustes';

  @override
  String get helpSupportLabel => 'Ayuda y Soporte';

  @override
  String get noDeviceFoundLabel => 'No se encontró ningún dispositivo';

  @override
  String get retryLabel => 'Reintentar';

  @override
  String get manualConnectionLabel => 'Conexión Manual';

  @override
  String get manualIpOverrideLabel => 'Anulación Manual de IP';

  @override
  String get connectLabel => 'Conectar';

  @override
  String get cancelLabel => 'Cancelar';

  @override
  String get matchedLabel => 'Coincide';

  @override
  String get mismatchLabel => 'No Coincide';

  @override
  String connectedLabel(String ip) {
    return 'Conectado: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Flasheo y Wi-Fi';

  @override
  String get aboutSupportCategoryLabel => 'Acerca de y Soporte';

  @override
  String get advancedCategoryLabel => 'Avanzado';

  @override
  String get flashingDefaultsSectionLabel =>
      'Valores Predeterminados de Flasheo';

  @override
  String get default24GHzDomainLabel => 'Dominio Predeterminado 2.4 GHz';

  @override
  String get defaultSubGHzDomainLabel => 'Dominio Predeterminado Sub-GHz';

  @override
  String get globalBindingPhraseLabel => 'Frase de Enlace Global';

  @override
  String get homeWifiSsidLabel => 'SSID de Wi-Fi Doméstico';

  @override
  String get homeWifiPasswordLabel => 'Contraseña de Wi-Fi Doméstico';

  @override
  String get manageCachedFirmwareLabel => 'Gestionar Firmware en Caché';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Descargar o eliminar firmware sin conexión';

  @override
  String get maxCachedVersionsLabel => 'Versiones Máx. en Caché';

  @override
  String get clearFirmwareCacheLabel => 'Borrar Caché de Firmware';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Eliminar todos los archivos de firmware descargados';

  @override
  String get clearLabel => 'BORRAR';

  @override
  String get aboutSectionLabel => 'Acerca de';

  @override
  String get appVersionLabel => 'Versión de la Aplicación';

  @override
  String get legalLicenseLabel => 'Legal y Licencia';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Descargo de responsabilidad estándar y Licencia GPLv3';

  @override
  String get supportDevelopmentLabel => 'Apoyar el desarrollo';

  @override
  String get supportDevelopmentSubtitle =>
      'Apoya al desarrollador a través de Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Compartir Análisis';

  @override
  String get shareAnalyticsSubtitle =>
      'Ayuda a mejorar la aplicación compartiendo datos de uso anónimos';

  @override
  String get expertModeLabel => 'Modo Experto';

  @override
  String get expertModeSubtitle =>
      'Habilitar la gestión y descargas avanzadas de firmware';

  @override
  String get exportElrsLuaScriptLabel => 'Exportar Script Lua ELRS';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Guardar elrs.lua para radios EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel => 'Enviar Informe de Depuración a Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Ayúdanos a corregir errores compartiendo registros del sistema anónimos';

  @override
  String get clearFirmwareCacheTitle => '¿Borrar Caché de Firmware?';

  @override
  String get clearFirmwareCacheMessage =>
      'Esto eliminará todos los archivos zip de firmware descargados. Tendrás que volver a descargarlos si quieres flashear sin conexión.';

  @override
  String get clearAllLabel => 'BORRAR TODO';

  @override
  String get submitDebugReportTitle => 'Enviar Informe de Depuración';

  @override
  String get submitDebugReportMessage =>
      'Esto enviará la información de tu dispositivo y los registros de la aplicación a Sentry para depuración. No se incluirá información personal como frases de enlace o contraseñas de Wi-Fi.';

  @override
  String get describeIssueHint =>
      'Por favor, describe el problema que estás experimentando...';

  @override
  String get proceedLabel => 'Continuar';

  @override
  String get submittingReportProgress => 'Enviando informe…';

  @override
  String get saveLabel => 'Guardar';

  @override
  String get notSetLabel => 'No configurado';

  @override
  String get languageOverrideLabel => 'Idioma';

  @override
  String get languageOverrideSystemDefault => 'Predeterminado del sistema';

  @override
  String get legalNoticeSectionTitle => 'Aviso Legal';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile es un proyecto de código abierto (FOSS) y gratuito desarrollado de forma independiente por Weston Hinton. Este proyecto no es un producto oficial de ExpressLRS LLC y no está oficialmente soportado, respaldado ni certificado por el equipo de desarrollo de ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Aviso de Marca Registrada';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS y el logotipo de ExpressLRS son marcas registradas de ExpressLRS LLC. El uso de estas marcas es únicamente para fines descriptivos y de compatibilidad. Para el configurador y la documentación oficial de ExpressLRS, por favor visite expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Soporte Oficial';

  @override
  String get officialSupportSectionText =>
      'Apoye el proyecto oficial de ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel => 'Donar a través de Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Licencia de Software';

  @override
  String get gplv3NoticeText =>
      'Este proyecto está licenciado bajo la Licencia Pública General GNU v3.0.';

  @override
  String get tabFlashingGuide => 'Guía de Flasheo';

  @override
  String get tabFaq => 'Preguntas Frecuentes';

  @override
  String get tabResources => 'Recursos';

  @override
  String get resourceCommunitySupport => 'Comunidad y Soporte';

  @override
  String get resourceDiscordCommunity => 'Comunidad de Discord';

  @override
  String get resourceJoinDiscord => 'Únase al Discord de ELRS';

  @override
  String get resourceGithubRepo => 'Repositorio de GitHub';

  @override
  String get resourceFlashRecovery => 'Recuperación de Flasheo';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Si su dispositivo no responde después de un flasheo fallido:';

  @override
  String get resourceRecoveryStep1 =>
      'Mantenga pulsado el botón BOOT mientras conecta el dispositivo por USB para entrar en modo bootloader.';

  @override
  String get resourceRecoveryStep2 =>
      'Utilice el flasheador web de ELRS en expresslrs.org/flasher para volver a flashear a través de USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Para dispositivos con capacidad WiFi, mantenga pulsado BOOT durante 60 segundos para activar el modo de recuperación de punto de acceso WiFi.';

  @override
  String get resourceRecoveryStep4 =>
      'Únase a #help en el Discord de ELRS — la comunidad suele poder recuperar cualquier dispositivo.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Se recomienda encarecidamente la guía de Joshua Bardwell para \'desbrickear\':';

  @override
  String get resourceWebFlasherButton => 'Flasheador Web';

  @override
  String get resourceRecoveryVideoButton => 'Video de Recuperación';

  @override
  String get resourceLegalLiability => 'Aspectos Legales y Responsabilidad';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile se proporciona \'tal cual\', sin garantía de ningún tipo. Los desarrolladores no son responsables de ningún daño, pérdida de datos o hardware no funcional que resulte del uso de esta aplicación, incluyendo, entre otros, receptores, transmisores o controladores de vuelo \'brickeados\'.\n\nAl usar esta aplicación, usted acepta la plena responsabilidad de su hardware.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Ver Descargo de Responsabilidad Completo';

  @override
  String get disclaimerTitle => 'Uso Bajo Su Propio Riesgo';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile se proporciona tal cual, sin garantía de ningún tipo.';

  @override
  String get disclaimerLiability =>
      'Los desarrolladores no se hacen responsables de ningún daño, pérdida de datos o hardware que deje de funcionar como resultado del uso de esta aplicación, incluyendo, entre otros, receptores, transmisores o controladores de vuelo inutilizados.';

  @override
  String get disclaimerAgreement =>
      'Al usar esta aplicación, usted confirma que entiende los riesgos de flashear firmware personalizado y acepta la responsabilidad total por su hardware.';

  @override
  String get disclaimerVerification =>
      'Verifique siempre el objetivo y la versión del firmware antes de flashear. Conserve un registro de su firmware original si es posible.';

  @override
  String get disclaimerUnderstand => 'Entiendo';

  @override
  String get optionsTitle => 'Opciones de Firmware';

  @override
  String get optionsSubtitle =>
      'Configure la vinculación y las credenciales de red.';

  @override
  String get wifiPasswordLabel => 'Contraseña de WiFi';

  @override
  String get wifiOnIntervalLabel =>
      'Intervalo de activación automática de WiFi';

  @override
  String get regulatoryDomainLabel => 'Dominio Regulatorio';

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
  String get regDomainUs433 => 'EE. UU. (433MHz)';

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
