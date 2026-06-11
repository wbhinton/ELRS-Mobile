// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Фраза прив\'язки';

  @override
  String get networkSsidLabel => 'SSID Wi-Fi';

  @override
  String get flashingButtonLabel => 'Прошити';

  @override
  String get packetRateLabel => 'Частота пакетів';

  @override
  String get baudRateLabel => 'Швидкість Бод';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Оновлення прошивки $expressLRS на обладнанні $radioMaster або $betaFPV...';
  }

  @override
  String get flashDeviceLabel => 'Прошити пристрій';

  @override
  String get deviceConfigLabel => 'Конфігурація пристрою';

  @override
  String get firmwareManagerLabel => 'Менеджер прошивок';

  @override
  String get settingsLabel => 'Налаштування';

  @override
  String get helpSupportLabel => 'Допомога та підтримка';

  @override
  String get noDeviceFoundLabel => 'Пристрій не знайдено';

  @override
  String get retryLabel => 'Повторити';

  @override
  String get manualConnectionLabel => 'Ручне підключення';

  @override
  String get manualIpOverrideLabel => 'Ручне встановлення IP';

  @override
  String get connectLabel => 'Підключитися';

  @override
  String get cancelLabel => 'Скасувати';

  @override
  String get matchedLabel => 'Збігається';

  @override
  String get mismatchLabel => 'Не збігається';

  @override
  String connectedLabel(String ip) {
    return 'Підключено: $ip';
  }

  @override
  String get flashingWifiCategoryLabel => 'Прошивка та Wi-Fi';

  @override
  String get aboutSupportCategoryLabel => 'Про програму та підтримка';

  @override
  String get advancedCategoryLabel => 'Додатково';

  @override
  String get flashingDefaultsSectionLabel =>
      'Налаштування прошивки за замовчуванням';

  @override
  String get default24GHzDomainLabel => 'Домен 2.4ГГц за замовчуванням';

  @override
  String get defaultSubGHzDomainLabel => 'Домен Sub-GHz за замовчуванням';

  @override
  String get globalBindingPhraseLabel => 'Глобальна фраза прив\'язки';

  @override
  String get homeWifiSsidLabel => 'SSID домашнього Wi-Fi';

  @override
  String get homeWifiPasswordLabel => 'Пароль домашнього Wi-Fi';

  @override
  String get manageCachedFirmwareLabel => 'Керувати кешованими прошивками';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Завантажити або видалити офлайн-прошивки';

  @override
  String get maxCachedVersionsLabel => 'Макс. кількість кешованих версій';

  @override
  String get clearFirmwareCacheLabel => 'Очистити кеш прошивок';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Видалити всі завантажені файли прошивок';

  @override
  String get clearLabel => 'ОЧИСТИТИ';

  @override
  String get aboutSectionLabel => 'Про програму';

  @override
  String get appVersionLabel => 'Версія програми';

  @override
  String get legalLicenseLabel => 'Юридична інформація та ліцензія';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Стандартна відмова від відповідальності та ліцензія GPLv3';

  @override
  String get developerSectionLabel => 'Розробник';

  @override
  String get developerModeEnabledLabel => 'Режим розробника увімкнено';

  @override
  String get testSentryErrorCaptureLabel =>
      'Протестувати захоплення помилок Sentry';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'Надсилає тестову виняткову ситуацію до Sentry — перевірте панель приладів';

  @override
  String get shareAnalyticsLabel => 'Поділитися аналітикою';

  @override
  String get shareAnalyticsSubtitle =>
      'Допоможіть покращити програму, ділячись анонімними даними про використання';

  @override
  String get expertModeLabel => 'Експертний режим';

  @override
  String get expertModeSubtitle =>
      'Увімкнути розширену обробку та завантаження прошивок';

  @override
  String get exportElrsLuaScriptLabel => 'Експортувати скрипт ELRS Lua';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Зберегти elrs.lua для радіопередавачів EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel =>
      'Надіслати звіт про налагодження до Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Допоможіть нам виправити помилки, поділившись анонімними системними журналами';

  @override
  String get clearFirmwareCacheTitle => 'Очистити кеш прошивок?';

  @override
  String get clearFirmwareCacheMessage =>
      'Це видалить усі завантажені zip-архіви прошивок. Вам доведеться завантажити їх знову, якщо ви захочете прошивати в офлайн-режимі.';

  @override
  String get clearAllLabel => 'ОЧИСТИТИ ВСЕ';

  @override
  String get submitDebugReportTitle => 'Надіслати звіт про налагодження';

  @override
  String get submitDebugReportMessage =>
      'Це надішле інформацію про ваш пристрій та журнали програми до Sentry для налагодження. Жодна особиста інформація, така як фрази прив\'язки або паролі Wi-Fi, не буде включена.';

  @override
  String get describeIssueHint =>
      'Будь ласка, опишіть проблему, з якою ви зіткнулися...';

  @override
  String get proceedLabel => 'Продовжити';

  @override
  String get submittingReportProgress => 'Надсилання звіту…';

  @override
  String get saveLabel => 'Зберегти';

  @override
  String get notSetLabel => 'Не встановлено';
}
