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
  String get flashingStatusLocating => 'Пошук прошивки';

  @override
  String get flashingStatusUnpacking => 'Розпакування прошивки';

  @override
  String get flashingStatusDownloading => 'Завантаження прошивки';

  @override
  String get flashingStatusBuilding => 'Створення прошивки';

  @override
  String get flashingStatusUploading => 'Завантаження на пристрій';

  @override
  String get flashingStatusFinalizing =>
      'Запис на пристрій — будь ласка, зачекайте';

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
  String get appVersionLabel => 'Версія програми';

  @override
  String get legalLicenseLabel => 'Юридична інформація та ліцензія';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Стандартна відмова від відповідальності та ліцензія GPLv3';

  @override
  String get supportDevelopmentLabel => 'Підтримати розробку';

  @override
  String get supportDevelopmentSubtitle => 'Підтримати розробника через Ko-fi';

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

  @override
  String get languageOverrideLabel => 'Мова';

  @override
  String get languageOverrideSystemDefault => 'За замовчуванням системи';

  @override
  String get legalNoticeSectionTitle => 'Правова інформація';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile — це безкоштовний проєкт із відкритим вихідним кодом (FOSS), розроблений незалежно Вестоном Гінтоном. Цей проєкт не є офіційним продуктом ExpressLRS LLC і не підтримується, не схвалюється та не сертифікується офіційно командою розробників ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle =>
      'Повідомлення про торговельну марку';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS та логотип ExpressLRS є торговельними марками ExpressLRS LLC. Використання цих марок призначене лише для описових цілей та цілей сумісності. Щоб отримати офіційний конфігуратор та документацію ExpressLRS, будь ласка, відвідайте expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Офіційна підтримка';

  @override
  String get officialSupportSectionText =>
      'Підтримайте офіційний проєкт ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel => 'Пожертвувати через Open Collective';

  @override
  String get softwareLicenseSectionTitle =>
      'Ліцензія на програмне забезпечення';

  @override
  String get gplv3NoticeText =>
      'Цей проєкт ліцензовано за ліцензією GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Посібник із прошивки';

  @override
  String get tabFaq => 'ЧаПи';

  @override
  String get tabResources => 'Ресурси';

  @override
  String get resourceCommunitySupport => 'Спільнота та підтримка';

  @override
  String get resourceDiscordCommunity => 'Спільнота Discord';

  @override
  String get resourceJoinDiscord => 'Приєднатися до Discord ELRS';

  @override
  String get resourceGithubRepo => 'Репозиторій GitHub';

  @override
  String get resourceFlashRecovery => 'Відновлення прошивки';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Якщо ваш пристрій не реагує після невдалої прошивки:';

  @override
  String get resourceRecoveryStep1 =>
      'Утримуйте кнопку BOOT під час підключення через USB, щоб увійти в режим завантажувача.';

  @override
  String get resourceRecoveryStep2 =>
      'Використайте ELRS Web Flasher на expresslrs.org/flasher для повторної прошивки через USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Для пристроїв із підтримкою Wi-Fi утримуйте BOOT протягом 60 секунд, щоб активувати режим відновлення точки доступу Wi-Fi.';

  @override
  String get resourceRecoveryStep4 =>
      'Приєднайтеся до каналу #help у Discord ELRS — спільнота зазвичай може відновити будь-який пристрій.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Настійно рекомендується посібник Джошуа Бардвелла з розблокування пристроїв:';

  @override
  String get resourceWebFlasherButton => 'Веб-прошивальник';

  @override
  String get resourceRecoveryVideoButton => 'Відео з відновлення';

  @override
  String get resourceLegalLiability => 'Правові питання та відповідальність';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile надається «як є», без будь-яких гарантій. Розробники не несуть відповідальності за будь-які пошкодження, втрату даних або непрацююче обладнання, що виникли внаслідок використання цієї програми, включаючи, але не обмежуючись, непрацюючі приймачі, передавачі або польотні контролери.\n\nВикористовуючи цей додаток, ви берете на себе повну відповідальність за своє обладнання.';

  @override
  String get resourceViewFullDisclaimerButton =>
      'Переглянути повну відмову від відповідальності';

  @override
  String get disclaimerTitle => 'Використання на власний ризик';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile надається «як є», без жодних гарантій.';

  @override
  String get disclaimerLiability =>
      'Розробники не несуть відповідальності за будь-які пошкодження, втрату даних або несправне обладнання, що виникли внаслідок використання цієї програми, включаючи, але не обмежуючись, непрацездатні приймачі, передавачі або польотні контролери.';

  @override
  String get disclaimerAgreement =>
      'Використовуючи цю програму, ви підтверджуєте, що розумієте ризики прошивки стороннього програмного забезпечення та приймаєте повну відповідальність за своє обладнання.';

  @override
  String get disclaimerVerification =>
      'Завжди перевіряйте цільовий пристрій та версію прошивки перед оновленням. Збережіть копію оригінальної прошивки, якщо це можливо.';

  @override
  String get disclaimerUnderstand => 'Я розумію';

  @override
  String get optionsTitle => 'Параметри прошивки';

  @override
  String get optionsSubtitle => 'Налаштуйте біндинг та мережеві облікові дані.';

  @override
  String get wifiPasswordLabel => 'Пароль Wi-Fi';

  @override
  String get wifiOnIntervalLabel => 'Інтервал автоввімкнення Wi-Fi';

  @override
  String get regulatoryDomainLabel => 'Регуляторний домен';

  @override
  String get regDomainIsm => 'ISM (2.4 ГГц)';

  @override
  String get regDomainEuLbt => 'ЄС CE (2.4 ГГц LBT)';

  @override
  String get regDomainAu915 => 'AU (915 МГц)';

  @override
  String get regDomainFcc915 => 'FCC (915 МГц)';

  @override
  String get regDomainEu868 => 'ЄС (868 МГц)';

  @override
  String get regDomainIn866 => 'IN (866 МГц)';

  @override
  String get regDomainAu433 => 'AU (433 МГц)';

  @override
  String get regDomainEu433 => 'ЄС (433 МГц)';

  @override
  String get regDomainUs433 => 'США (433 МГц)';

  @override
  String get flashingStatusSaved => 'Прошивку збережено';

  @override
  String get flashErrorNoTarget => 'Будь ласка, оберіть цільовий пристрій.';

  @override
  String get flashErrorNoVersion => 'Будь ласка, оберіть версію прошивки.';

  @override
  String get flashErrorNoDevice =>
      'Не вдається прошити: пристрій ELRS не підключено.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Несумісний чип: ця прошивка призначена для $targetChip, але підключений пристрій — $deviceChip. Виберіть цільовий пристрій з таким самим чипом.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Немає доступу до Інтернету для завантаження відсутніх файлів. Будь ласка, від\'єднайтеся від пристрою ELRS, завантажте цю прошивку через Менеджер прошивок, щоб поповнити кеш, і спробуйте ще раз.';

  @override
  String get flashErrorOfflineDownload =>
      'Немає доступу до Інтернету. Ви не можете завантажувати прошивку, коли підключені до точки доступу пристрою ELRS. Будь ласка, від\'єднайтеся, завантажте цю версію через Менеджер прошивок і спробуйте ще раз.';

  @override
  String get flashErrorFlashFailed => 'Прошивка не вдалася.';

  @override
  String get flashErrorUnconfirmed =>
      'Пристрій відключився до підтвердження прошивки, тому вона могла не завершитися. Це відбувається, якщо пристрій втрачає живлення або перезавантажується під час прошивки, а також іноді при слабкому Wi-Fi з\'єднанні після успішної прошивки. Перевірте версію прошивки в розділі «Конфігурація пристрою» і прошийте ще раз, якщо вона не змінилася.';

  @override
  String get flashErrorDownloadFailed => 'Не вдалося завантажити прошивку.';

  @override
  String get validationSsidTooLong => 'SSID має містити 32 символи або менше.';

  @override
  String get validationPasswordTooShort =>
      'Пароль має містити щонайменше 8 символів.';

  @override
  String get validationPasswordTooLong =>
      'Пароль має містити 63 символи або менше.';

  @override
  String get targetMismatchTitle => 'Невідповідність цілі';

  @override
  String get targetMismatchMessage =>
      'Вибрана ціль прошивки не відповідає апаратному забезпеченню, що зараз працює на пристрої. Ви впевнені, що хочете примусово прошити?';

  @override
  String get forceFlashLabel => 'ПРИМУСОВА ПРОШИВКА';

  @override
  String get noBindPhraseTitle => 'Фраза прив\'язки відсутня';

  @override
  String get noBindPhraseMessage =>
      'Фраза прив\'язки не встановлена. Продовжити зі стандартною (порожньою)?';

  @override
  String get flashSuccessSnackbar => 'Прошивка успішно завершена!';

  @override
  String get firmwareSavedSnackbar => 'Прошивка успішно збережена!';

  @override
  String get flashSuccessMessage =>
      'Прошивка успішна! Пристрій перезавантажується.';

  @override
  String get stm32OtaWarning =>
      'Вибрана ціль STM32: OTA прошивка не підтримується для цього обладнання. Ви можете зібрати та зберегти цю прошивку локально, щоб прошити вручну через STLink або Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'ЗАВАНТАЖИТИ БІНАРНИЙ ФАЙЛ';

  @override
  String get waitingForDeviceLabel => 'ОЧІКУВАННЯ ПРИСТРОЮ...';

  @override
  String get otaUnavailableLabel => 'OTA недоступно';

  @override
  String get doneLabel => 'ГОТОВО';

  @override
  String get targetSelectionTitle => 'Вибір цілі';

  @override
  String get deviceTypeLabel => 'Тип пристрою';

  @override
  String get deviceVendorLabel => 'Виробник пристрою';

  @override
  String get regulatoryFrequencyLabel => 'Регулювання та частота';

  @override
  String get deviceTargetLabel => 'Цільовий пристрій';

  @override
  String get noFirmwareDownloadedButton =>
      'Прошивка не завантажена. Перейти до Менеджера прошивок';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Обладнання вимагає версії v$version або новішої.';
  }

  @override
  String get downloadCompatibleFirmwareButton => 'Завантажити сумісну прошивку';

  @override
  String get firmwareVersionLabel => 'Версія прошивки';

  @override
  String get firmwareVersionHelper => 'Оберіть версію ELRS для прошивки';

  @override
  String get cachedBadge => '(Кешовано)';

  @override
  String errorLoadingVersions(String error) {
    return 'Помилка завантаження версій: $error';
  }

  @override
  String get flashingProfileLabel => 'Профіль прошивки';

  @override
  String get addProfileTooltip => 'Додати профіль';

  @override
  String get deleteProfileTooltip => 'Видалити профіль';

  @override
  String get bindingPhraseHelper => 'Ваша унікальна фраза прив\'язки';

  @override
  String get addProfileTitle => 'Додати профіль прошивки';

  @override
  String get profileNameHint => 'Назва профілю (напр., Мої квадрокоптери)';

  @override
  String get addLabel => 'Додати';

  @override
  String get deleteProfileTitle => 'Видалити профіль';

  @override
  String deleteProfileMessage(String name) {
    return 'Ви впевнені, що хочете видалити профіль \"$name\"?';
  }

  @override
  String get deleteLabel => 'Видалити';

  @override
  String get settingsCategoryProfilesNetwork => 'Профілі та мережа';

  @override
  String get settingsCategoryAppStorage => 'Застосунок та сховище';

  @override
  String get settingsCategoryAdvancedDebug => 'Розширені та налагодження';

  @override
  String get settingsCategoryAboutLegal =>
      'Про застосунок та правова інформація';

  @override
  String get settingsSectionRegulatoryDefaults =>
      'Типові регуляторні параметри';

  @override
  String get settingsSectionPreferences => 'Налаштування';

  @override
  String get settingsSectionPowerTools => 'Експертні інструменти';

  @override
  String get settingsSectionDiagnostics => 'Діагностика';

  @override
  String get regDomainUnknown => 'Невідомо';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count версії',
      many: '$count версій',
      few: '$count версії',
      one: '$count версія',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Редагувати $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Введіть $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua збережено на пристрій!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Не вдалося зберегти скрипт: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Надіслано! Ідентифікатор події: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Звіт успішно надіслано!';

  @override
  String debugReportFailed(String error) {
    return 'Не вдалося надіслати: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Помилка завантаження ліцензії: $error';
  }

  @override
  String get firmwareErrorLoadFailed =>
      'Не вдалося завантажити версії прошивки.';

  @override
  String get firmwareErrorOnHotspot =>
      'Неможливо завантажити прошивку, якщо ви підключені безпосередньо до точки доступу Wi-Fi приймача. Будь ласка, відключіться або скористайтеся домашньою мережею.';

  @override
  String get firmwareErrorCacheFull =>
      'Досягнуто ліміту кешу. Будь ласка, видаліть стару версію.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Не вдається дістатися до сервера прошивок. Будь ласка, перевірте ваше інтернет-з\'єднання.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Завантаження перервано: з\'єднання з мережею втрачено. Будь ласка, перевірте з\'єднання та спробуйте ще раз.';

  @override
  String get firmwareErrorDownloadFailed => 'Не вдалося завантажити прошивку.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Не вдалося видалити цю версію прошивки.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Версія $version';
  }

  @override
  String get readyForOfflineUse =>
      'Готово для використання в автономному режимі';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Використано пам\'яті: $sizeString МБ';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Версій';
  }

  @override
  String get splashTagline => 'Незалежний інструмент конфігурації';

  @override
  String get splashDisclaimer =>
      'Не є офіційним продуктом ExpressLRS.\nСумісний з прошивками 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Пристрій ELRS';

  @override
  String get unknownIpLabel => 'Невідомий IP';

  @override
  String get firmwareBinariesFileType => 'Двійкові файли прошивки';

  @override
  String helpContentLoadFailed(String error) {
    return 'Помилка завантаження довідкового вмісту: $error';
  }
}
