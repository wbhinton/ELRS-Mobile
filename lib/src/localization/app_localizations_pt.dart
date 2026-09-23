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
  String get flashingStatusLocating => 'Localizando Firmware';

  @override
  String get flashingStatusUnpacking => 'Desempacotando Firmware';

  @override
  String get flashingStatusDownloading => 'A Transferir Firmware';

  @override
  String get flashingStatusBuilding => 'Compilando Firmware';

  @override
  String get flashingStatusUploading => 'A Carregar para o Dispositivo';

  @override
  String get flashingStatusFinalizing =>
      'A Escrever no Dispositivo — Por favor, Aguarde';

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
  String get flashingStatusSaved => 'Firmware Guardado';

  @override
  String get flashErrorNoTarget => 'Por favor, selecione um dispositivo alvo.';

  @override
  String get flashErrorNoVersion =>
      'Por favor, selecione uma versão de firmware.';

  @override
  String get flashErrorNoDevice =>
      'Não é possível fazer flash: nenhum dispositivo ELRS conectado.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Chip incompatível: este firmware foi criado para $targetChip, mas o dispositivo conectado é $deviceChip. Selecione um alvo para o mesmo chip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Sem acesso à internet para obter os ficheiros em falta. Por favor, desconecte-se do dispositivo ELRS, transfira este firmware através do Gestor de Firmware para completar a sua cache, e tente novamente.';

  @override
  String get flashErrorOfflineDownload =>
      'Sem acesso à internet. Não pode transferir firmware enquanto estiver conectado ao hotspot do dispositivo ELRS. Por favor, desconecte-se, transfira esta versão através do Gestor de Firmware, e tente novamente.';

  @override
  String get flashErrorFlashFailed => 'Falha na gravação.';

  @override
  String get flashErrorUnconfirmed =>
      'O dispositivo foi desconectado antes de confirmar a gravação, por isso pode não ter sido concluída. Isso acontece se ele perder energia ou reiniciar no meio da gravação, e ocasionalmente em uma conexão Wi-Fi fraca após uma gravação bem-sucedida. Verifique a versão do firmware em Configurações do Dispositivo e grave novamente se não tiver sido alterada.';

  @override
  String get flashErrorDownloadFailed => 'Falha ao baixar o firmware.';

  @override
  String get validationSsidTooLong => 'O SSID deve ter 32 caracteres ou menos';

  @override
  String get validationPasswordTooShort =>
      'A senha deve ter pelo menos 8 caracteres';

  @override
  String get validationPasswordTooLong =>
      'A senha deve ter 63 caracteres ou menos';

  @override
  String get targetMismatchTitle => 'Incompatibilidade de Alvo';

  @override
  String get targetMismatchMessage =>
      'O alvo de firmware selecionado não corresponde ao hardware atualmente em execução no dispositivo. Tem certeza de que deseja forçar a gravação?';

  @override
  String get forceFlashLabel => 'FORÇAR GRAVAÇÃO';

  @override
  String get noBindPhraseTitle => 'Sem Frase de Vinculação';

  @override
  String get noBindPhraseMessage =>
      'Nenhuma frase de vinculação definida. Continuar com a padrão (vazia)?';

  @override
  String get flashSuccessSnackbar => 'Gravação concluída com sucesso!';

  @override
  String get firmwareSavedSnackbar => 'Firmware salvo com sucesso!';

  @override
  String get flashSuccessMessage =>
      'Gravação bem-sucedida! O dispositivo está reiniciando.';

  @override
  String get stm32OtaWarning =>
      'Alvo STM32 selecionado: Gravação OTA não é suportada para este hardware. Você pode compilar e salvar este firmware localmente para gravar manualmente via STLink ou Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'BAIXAR BINÁRIO';

  @override
  String get waitingForDeviceLabel => 'AGUARDANDO DISPOSITIVO...';

  @override
  String get otaUnavailableLabel => 'OTA Indisponível';

  @override
  String get doneLabel => 'PRONTO';

  @override
  String get targetSelectionTitle => 'Seleção do Alvo';

  @override
  String get deviceTypeLabel => 'Tipo de Dispositivo';

  @override
  String get deviceVendorLabel => 'Fabricante do Dispositivo';

  @override
  String get regulatoryFrequencyLabel => 'Regulamentação e Frequência';

  @override
  String get deviceTargetLabel => 'Alvo do Dispositivo';

  @override
  String get noFirmwareDownloadedButton =>
      'Nenhum firmware baixado. Ir para o Gerenciador de Firmware';

  @override
  String hardwareRequiresVersion(String version) {
    return 'O hardware requer v$version ou mais recente.';
  }

  @override
  String get downloadCompatibleFirmwareButton => 'Baixar Firmware Compatível';

  @override
  String get firmwareVersionLabel => 'Versão do Firmware';

  @override
  String get firmwareVersionHelper => 'Selecione a versão ELRS para flashar';

  @override
  String get cachedBadge => '(Em cache)';

  @override
  String errorLoadingVersions(String error) {
    return 'Erro ao carregar versões: $error';
  }

  @override
  String get flashingProfileLabel => 'Perfil de Flashing';

  @override
  String get addProfileTooltip => 'Adicionar Perfil';

  @override
  String get deleteProfileTooltip => 'Excluir Perfil';

  @override
  String get bindingPhraseHelper => 'Sua frase de ligação única';

  @override
  String get addProfileTitle => 'Adicionar Perfil de Flashing';

  @override
  String get profileNameHint => 'Nome do Perfil (ex.: Meus Quads)';

  @override
  String get addLabel => 'Adicionar';

  @override
  String get deleteProfileTitle => 'Excluir Perfil';

  @override
  String deleteProfileMessage(String name) {
    return 'Tem certeza de que deseja excluir o perfil \"$name\"?';
  }

  @override
  String get deleteLabel => 'Excluir';

  @override
  String get settingsCategoryProfilesNetwork => 'Perfis e Rede';

  @override
  String get settingsCategoryAppStorage => 'App e Armazenamento';

  @override
  String get settingsCategoryAdvancedDebug => 'Avançado e Depuração';

  @override
  String get settingsCategoryAboutLegal => 'Sobre e Legal';

  @override
  String get settingsSectionRegulatoryDefaults => 'Predefinições Regulatórias';

  @override
  String get settingsSectionPreferences => 'Preferências';

  @override
  String get settingsSectionPowerTools => 'Ferramentas Avançadas';

  @override
  String get settingsSectionDiagnostics => 'Diagnósticos';

  @override
  String get regDomainUnknown => 'Desconhecido';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versões',
      one: '1 versão',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Editar $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Introduza $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua guardado no dispositivo!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Falha ao guardar o script: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Enviado! ID do Evento: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Relatório enviado com sucesso!';

  @override
  String debugReportFailed(String error) {
    return 'Falha ao enviar: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Erro ao carregar licença: $error';
  }

  @override
  String get firmwareErrorLoadFailed =>
      'Não foi possível carregar as versões de firmware.';

  @override
  String get firmwareErrorOnHotspot =>
      'Não é possível baixar o firmware enquanto conectado diretamente ao hotspot Wi-Fi do receptor. Desconecte-se ou use uma rede doméstica.';

  @override
  String get firmwareErrorCacheFull =>
      'Limite de cache atingido. Exclua uma versão antiga.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Não foi possível conectar ao servidor de firmware. Verifique sua conexão com a internet.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Download interrompido: a conexão de rede foi perdida. Verifique sua conexão e tente novamente.';

  @override
  String get firmwareErrorDownloadFailed => 'Falha ao baixar o firmware.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Não foi possível excluir esta versão do firmware.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Versão $version';
  }

  @override
  String get readyForOfflineUse => 'Pronto para uso offline';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Armazenamento Usado: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count / $limit Versões',
      one: '$count / $limit Versão',
    );
    return '$_temp0';
  }

  @override
  String get splashTagline => 'Ferramenta de Configuração Independente';

  @override
  String get splashDisclaimer =>
      'Não é um produto oficial ExpressLRS.\nCompatível com firmware 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Dispositivo ELRS';

  @override
  String get unknownIpLabel => 'IP Desconhecido';

  @override
  String get firmwareBinariesFileType => 'Binários de Firmware';

  @override
  String helpContentLoadFailed(String error) {
    return 'Erro ao carregar conteúdo de ajuda: $error';
  }
}
