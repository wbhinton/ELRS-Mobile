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
  String get developerSectionLabel => 'Desarrollador';

  @override
  String get developerModeEnabledLabel => 'Modo Desarrollador Habilitado';

  @override
  String get testSentryErrorCaptureLabel => 'Probar Captura de Errores Sentry';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Envía una excepción de prueba a Sentry — revisa el panel de control';

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
}
