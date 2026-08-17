// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Фраза привязки';

  @override
  String get networkSsidLabel => 'Имя сети WiFi';

  @override
  String get flashingButtonLabel => 'Прошить';

  @override
  String get packetRateLabel => 'Частота пакетов';

  @override
  String get baudRateLabel => 'Скорость (Бод)';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Обновление прошивки $expressLRS на оборудовании $radioMaster или $betaFPV...';
  }

  @override
  String get flashDeviceLabel => 'Прошить устройство';

  @override
  String get deviceConfigLabel => 'Конфигурация устройства';

  @override
  String get firmwareManagerLabel => 'Менеджер прошивок';

  @override
  String get settingsLabel => 'Настройки';

  @override
  String get helpSupportLabel => 'Помощь и поддержка';

  @override
  String get noDeviceFoundLabel => 'Устройство не найдено';

  @override
  String get retryLabel => 'Повторить';

  @override
  String get manualConnectionLabel => 'Ручное подключение';

  @override
  String get manualIpOverrideLabel => 'Ручная настройка IP';

  @override
  String get connectLabel => 'Подключиться';

  @override
  String get cancelLabel => 'Отмена';

  @override
  String get matchedLabel => 'Совпадает';

  @override
  String get mismatchLabel => 'Не совпадает';

  @override
  String connectedLabel(String ip) {
    return 'Подключено: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Прошивка и WiFi';

  @override
  String get aboutSupportCategoryLabel => 'О приложении и поддержка';

  @override
  String get advancedCategoryLabel => 'Расширенные';

  @override
  String get flashingDefaultsSectionLabel => 'Настройки прошивки по умолчанию';

  @override
  String get default24GHzDomainLabel => 'Домен по умолчанию 2.4 ГГц';

  @override
  String get defaultSubGHzDomainLabel => 'Домен по умолчанию Sub-ГГц';

  @override
  String get globalBindingPhraseLabel => 'Глобальная фраза привязки';

  @override
  String get homeWifiSsidLabel => 'Имя домашней сети WiFi';

  @override
  String get homeWifiPasswordLabel => 'Пароль домашней сети WiFi';

  @override
  String get manageCachedFirmwareLabel => 'Управление кэшированными прошивками';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Загрузить или удалить офлайн-прошивки';

  @override
  String get maxCachedVersionsLabel => 'Макс. кэшированных версий';

  @override
  String get clearFirmwareCacheLabel => 'Очистить кэш прошивок';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Удалить все загруженные файлы прошивок';

  @override
  String get clearLabel => 'ОЧИСТИТЬ';

  @override
  String get aboutSectionLabel => 'О приложении';

  @override
  String get appVersionLabel => 'Версия приложения';

  @override
  String get legalLicenseLabel => 'Правовая информация и лицензия';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Стандартное уведомление об отказе от ответственности и лицензия GPLv3';

  @override
  String get supportDevelopmentLabel => 'Поддержать разработку';

  @override
  String get supportDevelopmentSubtitle =>
      'Поддержите разработчика через Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Делиться аналитикой';

  @override
  String get shareAnalyticsSubtitle =>
      'Помогите улучшить приложение, делясь анонимными данными об использовании';

  @override
  String get expertModeLabel => 'Экспертный режим';

  @override
  String get expertModeSubtitle =>
      'Включить расширенную работу с прошивками и загрузками';

  @override
  String get exportElrsLuaScriptLabel => 'Экспорт скрипта ELRS Lua';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Сохранить elrs.lua для радиопередатчиков EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel => 'Отправить отчёт об отладке в Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Помогите нам исправить ошибки, делясь анонимными системными журналами';

  @override
  String get clearFirmwareCacheTitle => 'Очистить кэш прошивок?';

  @override
  String get clearFirmwareCacheMessage =>
      'Это удалит все загруженные ZIP-файлы прошивок. Вам потребуется загрузить их заново, если вы захотите прошивать офлайн.';

  @override
  String get clearAllLabel => 'ОЧИСТИТЬ ВСЁ';

  @override
  String get submitDebugReportTitle => 'Отправить отчёт об отладке';

  @override
  String get submitDebugReportMessage =>
      'Это отправит информацию о вашем устройстве и журналы приложения в Sentry для отладки. Личные данные, такие как фразы привязки или пароли WiFi, не будут включены.';

  @override
  String get describeIssueHint =>
      'Пожалуйста, опишите проблему, с которой вы столкнулись...';

  @override
  String get proceedLabel => 'Продолжить';

  @override
  String get submittingReportProgress => 'Отправка отчёта…';

  @override
  String get saveLabel => 'Сохранить';

  @override
  String get notSetLabel => 'Не установлено';

  @override
  String get languageOverrideLabel => 'Язык';

  @override
  String get languageOverrideSystemDefault => 'Системный по умолчанию';

  @override
  String get legalNoticeSectionTitle => 'Правовая информация';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile — это бесплатный проект с открытым исходным кодом (FOSS), разработанный независимо Уэстоном Хинтоном. Этот проект не является официальным продуктом ExpressLRS LLC и не поддерживается, не одобряется и не сертифицируется официально командой разработчиков ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Уведомление о товарном знаке';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS и логотип ExpressLRS являются товарными знаками ExpressLRS LLC. Использование этих знаков предназначено исключительно для описательных целей и обеспечения совместимости. Для получения официального конфигуратора и документации ExpressLRS посетите expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Официальная поддержка';

  @override
  String get officialSupportSectionText =>
      'Поддержите официальный проект ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel => 'Пожертвовать через Open Collective';

  @override
  String get softwareLicenseSectionTitle =>
      'Лицензия на программное обеспечение';

  @override
  String get gplv3NoticeText =>
      'Этот проект распространяется по лицензии GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Руководство по прошивке';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Ресурсы';

  @override
  String get resourceCommunitySupport => 'Сообщество и поддержка';

  @override
  String get resourceDiscordCommunity => 'Сообщество в Discord';

  @override
  String get resourceJoinDiscord => 'Присоединиться к Discord ELRS';

  @override
  String get resourceGithubRepo => 'Репозиторий GitHub';

  @override
  String get resourceFlashRecovery => 'Восстановление прошивки';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Если ваше устройство не отвечает после неудачной прошивки:';

  @override
  String get resourceRecoveryStep1 =>
      'Удерживайте кнопку BOOT, подключая устройство через USB, чтобы войти в режим загрузчика.';

  @override
  String get resourceRecoveryStep2 =>
      'Используйте ELRS Web Flasher на expresslrs.org/flasher для повторной прошивки через USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Для устройств с поддержкой WiFi удерживайте BOOT в течение 60 секунд, чтобы активировать режим восстановления через точку доступа WiFi.';

  @override
  String get resourceRecoveryStep4 =>
      'Присоединитесь к каналу #help в Discord ELRS — сообщество обычно может восстановить любое устройство.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Настоятельно рекомендуется ознакомиться с руководством по восстановлению от Джошуа Бардвелла:';

  @override
  String get resourceWebFlasherButton => 'Веб-прошивальщик';

  @override
  String get resourceRecoveryVideoButton => 'Видео по восстановлению';

  @override
  String get resourceLegalLiability => 'Правовая информация и ответственность';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile предоставляется «как есть», без каких-либо гарантий. Разработчики не несут ответственности за любой ущерб, потерю данных или неработоспособность оборудования, возникшие в результате использования этого приложения, включая, помимо прочего, вышедшие из строя приемники, передатчики или полетные контроллеры.\n\nИспользуя это приложение, вы принимаете на себя полную ответственность за ваше оборудование.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Просмотреть полный отказ от ответственности';

  @override
  String get disclaimerTitle => 'Использование на свой страх и риск';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile предоставляется «как есть», без каких-либо гарантий.';

  @override
  String get disclaimerLiability =>
      'Разработчики не несут ответственности за любой ущерб, потерю данных или неработоспособность оборудования, возникшие в результате использования этого приложения, включая, помимо прочего, вышедшие из строя приемники, передатчики или полетные контроллеры.';

  @override
  String get disclaimerAgreement =>
      'Используя это приложение, вы подтверждаете, что понимаете риски прошивки пользовательского программного обеспечения и принимаете на себя полную ответственность за ваше оборудование.';

  @override
  String get disclaimerVerification =>
      'Всегда проверяйте целевое устройство и версию прошивки перед прошивкой. По возможности сохраните резервную копию вашей оригинальной прошивки.';

  @override
  String get disclaimerUnderstand => 'Я понимаю';

  @override
  String get optionsTitle => 'Параметры прошивки';

  @override
  String get optionsSubtitle => 'Настройте привязку и сетевые учетные данные.';

  @override
  String get wifiPasswordLabel => 'Пароль WiFi';

  @override
  String get wifiOnIntervalLabel => 'Интервал авто-включения Wi-Fi';

  @override
  String get regulatoryDomainLabel => 'Региональные настройки';

  @override
  String get regDomainIsm => 'ISM (2.4ГГц)';

  @override
  String get regDomainEuLbt => 'ЕС CE (2.4ГГц LBT)';

  @override
  String get regDomainAu915 => 'Австралия (915МГц)';

  @override
  String get regDomainFcc915 => 'FCC (915МГц)';

  @override
  String get regDomainEu868 => 'ЕС (868МГц)';

  @override
  String get regDomainIn866 => 'Индия (866МГц)';

  @override
  String get regDomainAu433 => 'Австралия (433МГц)';

  @override
  String get regDomainEu433 => 'ЕС (433МГц)';

  @override
  String get regDomainUs433 => 'США (433МГц)';
}
