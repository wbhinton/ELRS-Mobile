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
