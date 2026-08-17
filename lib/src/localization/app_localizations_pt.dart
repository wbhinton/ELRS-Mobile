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
  String get packetRateLabel => 'Taxa de Pacotes';

  @override
  String get baudRateLabel => 'Taxa de Baud';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'A atualizar o firmware $expressLRS no hardware $radioMaster ou $betaFPV...';
  }

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
  String get flashingWifiCategoryLabel => 'Gravação e WiFi';

  @override
  String get aboutSupportCategoryLabel => 'Sobre e Suporte';

  @override
  String get advancedCategoryLabel => 'Avançado';

  @override
  String get flashingDefaultsSectionLabel => 'Padrões de Gravação';

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
  String get aboutSectionLabel => 'Sobre';

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
}
