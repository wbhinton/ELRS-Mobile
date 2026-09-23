// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get bindingPhraseLabel => '绑定短语';

  @override
  String get networkSsidLabel => 'WiFi SSID';

  @override
  String get flashingButtonLabel => '刷写';

  @override
  String get flashingStatusLocating => '正在查找固件';

  @override
  String get flashingStatusUnpacking => '正在解压固件';

  @override
  String get flashingStatusDownloading => '正在下载固件';

  @override
  String get flashingStatusBuilding => '正在构建固件';

  @override
  String get flashingStatusUploading => '正在上传至设备';

  @override
  String get flashingStatusFinalizing => '正在写入设备 — 请稍候';

  @override
  String get flashDeviceLabel => '刷写设备';

  @override
  String get deviceConfigLabel => '设备配置';

  @override
  String get firmwareManagerLabel => '固件管理器';

  @override
  String get settingsLabel => '设置';

  @override
  String get helpSupportLabel => '帮助与支持';

  @override
  String get noDeviceFoundLabel => '未找到设备';

  @override
  String get retryLabel => '重试';

  @override
  String get manualConnectionLabel => '手动连接';

  @override
  String get manualIpOverrideLabel => '手动 IP 覆盖';

  @override
  String get connectLabel => '连接';

  @override
  String get cancelLabel => '取消';

  @override
  String get matchedLabel => '匹配';

  @override
  String get mismatchLabel => '不匹配';

  @override
  String connectedLabel(String ip) {
    return '已连接: $ip';
  }

  @override
  String get default24GHzDomainLabel => '默认 2.4GHz 域';

  @override
  String get defaultSubGHzDomainLabel => '默认 Sub-GHz 域';

  @override
  String get globalBindingPhraseLabel => '全局绑定短语';

  @override
  String get homeWifiSsidLabel => '家庭 WiFi SSID';

  @override
  String get homeWifiPasswordLabel => '家庭 WiFi 密码';

  @override
  String get manageCachedFirmwareLabel => '管理缓存固件';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel => '下载或删除离线固件';

  @override
  String get maxCachedVersionsLabel => '最大缓存版本数';

  @override
  String get clearFirmwareCacheLabel => '清除固件缓存';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel => '删除所有已下载的固件文件';

  @override
  String get clearLabel => '清除';

  @override
  String get appVersionLabel => '应用版本';

  @override
  String get legalLicenseLabel => '法律与许可';

  @override
  String get standardDisclaimerAndGplv3Label => '标准免责声明和 GPLv3 许可证';

  @override
  String get supportDevelopmentLabel => '支持开发';

  @override
  String get supportDevelopmentSubtitle => '通过 Ko-fi 支持开发者';

  @override
  String get shareAnalyticsLabel => '分享分析数据';

  @override
  String get shareAnalyticsSubtitle => '通过分享匿名使用数据来帮助改进应用';

  @override
  String get expertModeLabel => '专家模式';

  @override
  String get expertModeSubtitle => '启用高级固件处理和下载';

  @override
  String get exportElrsLuaScriptLabel => '导出 ELRS Lua 脚本';

  @override
  String get exportElrsLuaScriptSubtitle =>
      '保存 elrs.lua 文件以用于 EdgeTX/OpenTX 无线电';

  @override
  String get submitDebugReportLabel => '向 Sentry 提交调试报告';

  @override
  String get submitDebugReportSubtitle => '通过分享匿名系统日志来帮助我们修复错误';

  @override
  String get clearFirmwareCacheTitle => '清除固件缓存？';

  @override
  String get clearFirmwareCacheMessage =>
      '这将删除所有已下载的固件 zip 文件。如果您想离线刷写，将需要重新下载它们。';

  @override
  String get clearAllLabel => '全部清除';

  @override
  String get submitDebugReportTitle => '提交调试报告';

  @override
  String get submitDebugReportMessage =>
      '这将发送您的设备信息和应用日志到 Sentry 以进行调试。不包括绑定短语或 WiFi 密码等个人信息。';

  @override
  String get describeIssueHint => '请描述您遇到的问题...';

  @override
  String get proceedLabel => '继续';

  @override
  String get submittingReportProgress => '正在提交报告…';

  @override
  String get saveLabel => '保存';

  @override
  String get notSetLabel => '未设置';

  @override
  String get languageOverrideLabel => '语言';

  @override
  String get languageOverrideSystemDefault => '系统默认';

  @override
  String get legalNoticeSectionTitle => '法律声明';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile 是一个由 Weston Hinton 独立开发的免费开源 (FOSS) 项目。本项目并非 ExpressLRS LLC 的官方产品，也未获得 ExpressLRS 开发团队的官方支持、认可或认证。';

  @override
  String get trademarkNoticeSectionTitle => '商标声明';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS 和 ExpressLRS 标志是 ExpressLRS LLC 的商标。这些标志的使用仅用于描述和兼容性目的。如需官方 ExpressLRS 配置器和文档，请访问 expresslrs.org。';

  @override
  String get officialSupportSectionTitle => '官方支持';

  @override
  String get officialSupportSectionText => '支持官方 ExpressLRS 项目：';

  @override
  String get donateOpenCollectiveLabel => '通过 Open Collective 捐赠';

  @override
  String get softwareLicenseSectionTitle => '软件许可';

  @override
  String get gplv3NoticeText => '本项目采用 GNU 通用公共许可证 v3.0 授权。';

  @override
  String get tabFlashingGuide => '刷写指南';

  @override
  String get tabFaq => '常见问题';

  @override
  String get tabResources => '资源';

  @override
  String get resourceCommunitySupport => '社区与支持';

  @override
  String get resourceDiscordCommunity => 'Discord 社区';

  @override
  String get resourceJoinDiscord => '加入 ELRS Discord';

  @override
  String get resourceGithubRepo => 'GitHub 仓库';

  @override
  String get resourceFlashRecovery => '刷写恢复';

  @override
  String get resourceDeviceUnresponsiveInfo => '如果您的设备在刷写失败后无响应：';

  @override
  String get resourceRecoveryStep1 => '在通过 USB 插入时按住 BOOT 按钮进入引导加载程序模式。';

  @override
  String get resourceRecoveryStep2 =>
      '使用 expresslrs.org/flasher 上的 ELRS Web Flasher 通过 USB/UART 重新刷写。';

  @override
  String get resourceRecoveryStep3 =>
      '对于支持 WiFi 的设备，按住 BOOT 按钮 60 秒以触发 WiFi 热点恢复模式。';

  @override
  String get resourceRecoveryStep4 =>
      '加入 ELRS Discord 上的 #help 频道 — 社区通常可以恢复任何设备。';

  @override
  String get resourceBardwellGuideRecommended => '强烈推荐 Joshua Bardwell 的解砖指南：';

  @override
  String get resourceWebFlasherButton => 'Web 刷写工具';

  @override
  String get resourceRecoveryVideoButton => '恢复视频';

  @override
  String get resourceLegalLiability => '法律与责任';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile 按“原样”提供，不附带任何形式的保证。开发者不对因使用本应用程序而导致的任何损害、数据丢失或硬件功能失常负责，包括但不限于损坏的接收器、发射器或飞控。\n\n使用本应用程序即表示您对您的硬件承担全部责任。';

  @override
  String get resourceViewFullDisclaimerButton => '查看完整免责声明';

  @override
  String get disclaimerTitle => '使用风险自负';

  @override
  String get disclaimerHeader => 'ELRS Mobile 按“原样”提供，不附带任何形式的保证。';

  @override
  String get disclaimerLiability =>
      '开发者不对因使用本应用程序而导致的任何损害、数据丢失或硬件功能失常负责，包括但不限于损坏的接收器、发射器或飞控。';

  @override
  String get disclaimerAgreement => '使用本应用程序即表示您确认理解刷写自定义固件的风险，并对您的硬件承担全部责任。';

  @override
  String get disclaimerVerification => '刷写前务必验证目标设备和固件版本。如果可能，请保留您原始固件的记录。';

  @override
  String get disclaimerUnderstand => '我理解';

  @override
  String get optionsTitle => '固件选项';

  @override
  String get optionsSubtitle => '配置绑定和网络凭据。';

  @override
  String get wifiPasswordLabel => 'WiFi 密码';

  @override
  String get wifiOnIntervalLabel => 'Wi-Fi 自动开启间隔';

  @override
  String get regulatoryDomainLabel => '监管区域';

  @override
  String get regDomainIsm => 'ISM (2.4GHz)';

  @override
  String get regDomainEuLbt => '欧盟 CE (2.4GHz LBT)';

  @override
  String get regDomainAu915 => '澳大利亚 (915MHz)';

  @override
  String get regDomainFcc915 => 'FCC (915MHz)';

  @override
  String get regDomainEu868 => '欧盟 (868MHz)';

  @override
  String get regDomainIn866 => '印度 (866MHz)';

  @override
  String get regDomainAu433 => '澳大利亚 (433MHz)';

  @override
  String get regDomainEu433 => '欧盟 (433MHz)';

  @override
  String get regDomainUs433 => '美国 (433MHz)';

  @override
  String get flashingStatusSaved => '固件已保存';

  @override
  String get flashErrorNoTarget => '请选择目标设备。';

  @override
  String get flashErrorNoVersion => '请选择固件版本。';

  @override
  String get flashErrorNoDevice => '无法刷写：未连接ELRS设备。';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return '芯片不兼容：此固件适用于 $targetChip 芯片，但连接的设备是 $deviceChip 芯片。请选择相同芯片的目标。';
  }

  @override
  String get flashErrorOfflineFlash =>
      '无法访问互联网以获取缺失文件。请断开与ELRS设备的连接，通过“固件管理器”下载此固件以完成缓存，然后重试。';

  @override
  String get flashErrorOfflineDownload =>
      '无法访问互联网。连接到ELRS设备热点时无法下载固件。请断开连接，通过“固件管理器”下载此版本，然后重试。';

  @override
  String get flashErrorFlashFailed => '刷写失败。';

  @override
  String get flashErrorUnconfirmed =>
      '设备在确认刷写前已断开连接，因此可能未完成刷写。这可能发生在刷写中途设备断电或重启时，偶尔也会在弱WiFi连接下成功刷写后发生。请在“设备配置”中检查固件版本，如果未更改，请再次刷写。';

  @override
  String get flashErrorDownloadFailed => '固件下载失败。';

  @override
  String get validationSsidTooLong => 'SSID必须在32个字符以内';

  @override
  String get validationPasswordTooShort => '密码必须至少8个字符';

  @override
  String get validationPasswordTooLong => '密码必须在63个字符以内';

  @override
  String get targetMismatchTitle => '目标不匹配';

  @override
  String get targetMismatchMessage => '所选固件目标与设备上当前运行的硬件不匹配。确定要强制刷写吗？';

  @override
  String get forceFlashLabel => '强制刷写';

  @override
  String get noBindPhraseTitle => '无绑定短语';

  @override
  String get noBindPhraseMessage => '未设置绑定短语。是否继续使用默认（空）短语？';

  @override
  String get flashSuccessSnackbar => '刷写成功完成！';

  @override
  String get firmwareSavedSnackbar => '固件已成功保存！';

  @override
  String get flashSuccessMessage => '刷写成功！设备正在重启。';

  @override
  String get stm32OtaWarning =>
      '已选择STM32目标：此硬件不支持OTA刷写。您可以在本地构建并保存此固件，然后通过STLink或Betaflight Passthrough手动刷写。';

  @override
  String get downloadBinaryLabel => '下载二进制文件';

  @override
  String get waitingForDeviceLabel => '等待设备连接...';

  @override
  String get otaUnavailableLabel => 'OTA 不可用';

  @override
  String get doneLabel => '完成';

  @override
  String get targetSelectionTitle => '目标选择';

  @override
  String get deviceTypeLabel => '设备类型';

  @override
  String get deviceVendorLabel => '设备厂商';

  @override
  String get regulatoryFrequencyLabel => '法规与频率';

  @override
  String get deviceTargetLabel => '设备目标';

  @override
  String get noFirmwareDownloadedButton => '未下载固件。前往固件管理器';

  @override
  String hardwareRequiresVersion(String version) {
    return '硬件需要 v$version 或更高版本。';
  }

  @override
  String get downloadCompatibleFirmwareButton => '下载兼容固件';

  @override
  String get firmwareVersionLabel => '固件版本';

  @override
  String get firmwareVersionHelper => '选择要刷写的 ELRS 版本';

  @override
  String get cachedBadge => '(已缓存)';

  @override
  String errorLoadingVersions(String error) {
    return '加载版本出错: $error';
  }

  @override
  String get flashingProfileLabel => '刷写配置方案';

  @override
  String get addProfileTooltip => '添加配置方案';

  @override
  String get deleteProfileTooltip => '删除配置方案';

  @override
  String get bindingPhraseHelper => '您的独特绑定短语';

  @override
  String get addProfileTitle => '添加刷写配置方案';

  @override
  String get profileNameHint => '配置方案名称 (例如，我的四轴飞行器)';

  @override
  String get addLabel => '添加';

  @override
  String get deleteProfileTitle => '删除配置方案';

  @override
  String deleteProfileMessage(String name) {
    return '您确定要删除配置方案“$name”吗？';
  }

  @override
  String get deleteLabel => '删除';

  @override
  String get settingsCategoryProfilesNetwork => '配置文件与网络';

  @override
  String get settingsCategoryAppStorage => '应用与存储';

  @override
  String get settingsCategoryAdvancedDebug => '高级与调试';

  @override
  String get settingsCategoryAboutLegal => '关于与法律';

  @override
  String get settingsSectionRegulatoryDefaults => '法规默认值';

  @override
  String get settingsSectionPreferences => '偏好设置';

  @override
  String get settingsSectionPowerTools => '高级工具';

  @override
  String get settingsSectionDiagnostics => '诊断';

  @override
  String get regDomainUnknown => '未知';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个版本',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return '编辑 $field';
  }

  @override
  String enterFieldHint(String field) {
    return '输入 $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua 已保存到设备！';

  @override
  String luaScriptSaveFailed(String error) {
    return '保存脚本失败：$error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return '已提交！事件ID：$eventId…';
  }

  @override
  String get debugReportSubmitted => '报告提交成功！';

  @override
  String debugReportFailed(String error) {
    return '提交失败：$error';
  }

  @override
  String licenseLoadFailed(String error) {
    return '加载许可证失败：$error';
  }

  @override
  String get firmwareErrorLoadFailed => '无法加载固件版本。';

  @override
  String get firmwareErrorOnHotspot => '无法在连接到接收机WiFi热点时下载固件。请断开连接或使用家庭网络。';

  @override
  String get firmwareErrorCacheFull => '缓存已满。请删除旧版本。';

  @override
  String get firmwareErrorServerUnreachable => '无法连接到固件服务器。请检查您的互联网连接。';

  @override
  String get firmwareErrorDownloadInterrupted => '下载中断：网络连接已丢失。请检查您的连接并重试。';

  @override
  String get firmwareErrorDownloadFailed => '固件下载失败。';

  @override
  String get firmwareErrorDeleteFailed => '无法删除此固件版本。';

  @override
  String firmwareVersionTitle(String version) {
    return '版本 $version';
  }

  @override
  String get readyForOfflineUse => '可离线使用';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return '已用存储空间：$sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '已缓存 $count / $limit 个版本';
  }

  @override
  String get splashTagline => '独立配置工具';

  @override
  String get splashDisclaimer => '非官方ExpressLRS产品。\n兼容3.3.x/4.x固件。';

  @override
  String get unknownDeviceName => 'ELRS 设备';

  @override
  String get unknownIpLabel => '未知 IP';

  @override
  String get firmwareBinariesFileType => '固件二进制文件';

  @override
  String helpContentLoadFailed(String error) {
    return '加载帮助内容失败：$error';
  }
}
