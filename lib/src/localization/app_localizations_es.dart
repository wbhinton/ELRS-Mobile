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
  String get flashingStatusLocating => 'Localizando Firmware';

  @override
  String get flashingStatusUnpacking => 'Desempaquetando Firmware';

  @override
  String get flashingStatusDownloading => 'Descargando Firmware';

  @override
  String get flashingStatusBuilding => 'Generando Firmware';

  @override
  String get flashingStatusUploading => 'Subiendo al Dispositivo';

  @override
  String get flashingStatusFinalizing =>
      'Escribiendo en el Dispositivo — Por favor, espere';

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
  String get flashingStatusSaved => 'Firmware Guardado';

  @override
  String get flashErrorNoTarget =>
      'Por favor, seleccione un dispositivo objetivo.';

  @override
  String get flashErrorNoVersion =>
      'Por favor, seleccione una versión de firmware.';

  @override
  String get flashErrorNoDevice =>
      'No se puede flashear: ningún dispositivo ELRS conectado.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Chip incompatible: este firmware está diseñado para $targetChip, pero el dispositivo conectado es $deviceChip. Seleccione un objetivo para el mismo chip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Sin acceso a internet para obtener los archivos faltantes. Por favor, desconéctese del dispositivo ELRS, descargue este firmware a través del Administrador de Firmware para completar su caché e inténtelo de nuevo.';

  @override
  String get flashErrorOfflineDownload =>
      'Sin acceso a internet. No puede descargar firmware mientras esté conectado al punto de acceso del dispositivo ELRS. Por favor, desconéctese, descargue esta versión a través del Administrador de Firmware e inténtelo de nuevo.';

  @override
  String get flashErrorFlashFailed => 'Falló la actualización.';

  @override
  String get flashErrorUnconfirmed =>
      'El dispositivo se desconectó antes de confirmar la actualización, por lo que puede que no se haya completado. Esto ocurre si pierde alimentación o se reinicia durante la actualización, y ocasionalmente con una conexión WiFi débil después de una actualización exitosa. Verifica la versión del firmware en \'Configuración del Dispositivo\' y actualiza de nuevo si no ha cambiado.';

  @override
  String get flashErrorDownloadFailed => 'No se pudo descargar el firmware.';

  @override
  String get validationSsidTooLong =>
      'El SSID debe tener 32 caracteres o menos.';

  @override
  String get validationPasswordTooShort =>
      'La contraseña debe tener al menos 8 caracteres.';

  @override
  String get validationPasswordTooLong =>
      'La contraseña debe tener 63 caracteres o menos.';

  @override
  String get targetMismatchTitle => 'Incompatibilidad de Objetivo';

  @override
  String get targetMismatchMessage =>
      'El objetivo de firmware seleccionado no coincide con el hardware que se está ejecutando actualmente en el dispositivo. ¿Estás seguro de que quieres forzar la actualización?';

  @override
  String get forceFlashLabel => 'FORZAR ACTUALIZACIÓN';

  @override
  String get noBindPhraseTitle => 'Sin Frase de Enlace';

  @override
  String get noBindPhraseMessage =>
      'No hay frase de enlace configurada. ¿Continuar con la predeterminada (vacía)?';

  @override
  String get flashSuccessSnackbar => '¡Actualización completada con éxito!';

  @override
  String get firmwareSavedSnackbar => '¡Firmware guardado con éxito!';

  @override
  String get flashSuccessMessage =>
      '¡Actualización exitosa! El dispositivo se está reiniciando.';

  @override
  String get stm32OtaWarning =>
      'Objetivo STM32 seleccionado: la actualización OTA no es compatible con este hardware. Puedes compilar y guardar este firmware localmente para actualizarlo manualmente a través de STLink o Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'DESCARGAR BINARIO';

  @override
  String get waitingForDeviceLabel => 'ESPERANDO DISPOSITIVO...';

  @override
  String get otaUnavailableLabel => 'OTA NO DISPONIBLE';

  @override
  String get doneLabel => 'HECHO';

  @override
  String get targetSelectionTitle => 'Selección de Objetivo';

  @override
  String get deviceTypeLabel => 'Tipo de Dispositivo';

  @override
  String get deviceVendorLabel => 'Fabricante del Dispositivo';

  @override
  String get regulatoryFrequencyLabel => 'Regulación y Frecuencia';

  @override
  String get deviceTargetLabel => 'Objetivo del Dispositivo';

  @override
  String get noFirmwareDownloadedButton =>
      'No hay firmware descargado. Ir al Gestor de Firmware';

  @override
  String hardwareRequiresVersion(String version) {
    return 'El hardware requiere la v$version o superior.';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'Descargar Firmware Compatible';

  @override
  String get firmwareVersionLabel => 'Versión de Firmware';

  @override
  String get firmwareVersionHelper =>
      'Selecciona la versión de ELRS a flashear';

  @override
  String get cachedBadge => '(En caché)';

  @override
  String errorLoadingVersions(String error) {
    return 'Error al cargar versiones: $error';
  }

  @override
  String get flashingProfileLabel => 'Perfil de Flasheo';

  @override
  String get addProfileTooltip => 'Añadir Perfil';

  @override
  String get deleteProfileTooltip => 'Eliminar Perfil';

  @override
  String get bindingPhraseHelper => 'Tu frase de enlace única';

  @override
  String get addProfileTitle => 'Añadir Perfil de Flasheo';

  @override
  String get profileNameHint => 'Nombre del Perfil (ej., Mis Quads)';

  @override
  String get addLabel => 'Añadir';

  @override
  String get deleteProfileTitle => 'Eliminar Perfil';

  @override
  String deleteProfileMessage(String name) {
    return '¿Estás seguro de que quieres eliminar el perfil \"$name\"?';
  }

  @override
  String get deleteLabel => 'Eliminar';

  @override
  String get settingsCategoryProfilesNetwork => 'Perfiles y Red';

  @override
  String get settingsCategoryAppStorage => 'Aplicación y Almacenamiento';

  @override
  String get settingsCategoryAdvancedDebug => 'Avanzado y Depuración';

  @override
  String get settingsCategoryAboutLegal => 'Acerca de y Legal';

  @override
  String get settingsSectionRegulatoryDefaults =>
      'Valores Predeterminados de Regulación';

  @override
  String get settingsSectionPreferences => 'Preferencias';

  @override
  String get settingsSectionPowerTools => 'Herramientas Avanzadas';

  @override
  String get settingsSectionDiagnostics => 'Diagnósticos';

  @override
  String get regDomainUnknown => 'Desconocido';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versiones',
      one: '1 versión',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Editar $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Introducir $field';
  }

  @override
  String get luaScriptSavedSnackbar => '¡elrs.lua guardado en el dispositivo!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Error al guardar script: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return '¡Enviado! ID de Evento: $eventId…';
  }

  @override
  String get debugReportSubmitted => '¡Informe enviado con éxito!';

  @override
  String debugReportFailed(String error) {
    return 'Error al enviar: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Error al cargar licencia: $error';
  }

  @override
  String get firmwareErrorLoadFailed =>
      'No se pudieron cargar las versiones del firmware.';

  @override
  String get firmwareErrorOnHotspot =>
      'No se puede descargar el firmware mientras está conectado directamente al punto de acceso WiFi del receptor. Desconéctese o use una red doméstica.';

  @override
  String get firmwareErrorCacheFull =>
      'Límite de caché alcanzado. Elimine una versión antigua.';

  @override
  String get firmwareErrorServerUnreachable =>
      'No se puede conectar con el servidor de firmware. Compruebe su conexión a internet.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Descarga interrumpida: la conexión de red se perdió. Compruebe su conexión e inténtelo de nuevo.';

  @override
  String get firmwareErrorDownloadFailed => 'Error al descargar el firmware.';

  @override
  String get firmwareErrorDeleteFailed =>
      'No se pudo eliminar esta versión de firmware.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Versión $version';
  }

  @override
  String get readyForOfflineUse => 'Listo para uso sin conexión';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Almacenamiento usado: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count / $limit Versiones',
      one: '$count / $limit Versión',
    );
    return '$_temp0';
  }

  @override
  String get splashTagline => 'Herramienta de Configuración Independiente';

  @override
  String get splashDisclaimer =>
      'No es un producto oficial de ExpressLRS.\nCompatible con firmware 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Dispositivo ELRS';

  @override
  String get unknownIpLabel => 'IP desconocida';

  @override
  String get firmwareBinariesFileType => 'Binarios de Firmware';

  @override
  String helpContentLoadFailed(String error) {
    return 'Error al cargar el contenido de ayuda: $error';
  }
}
