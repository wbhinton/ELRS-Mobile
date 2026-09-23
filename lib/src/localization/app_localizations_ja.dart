// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get bindingPhraseLabel => 'バインディングフレーズ';

  @override
  String get networkSsidLabel => 'Wi-Fi SSID';

  @override
  String get flashingButtonLabel => 'フラッシュ';

  @override
  String get flashingStatusLocating => 'ファームウェアを検索中';

  @override
  String get flashingStatusUnpacking => 'ファームウェアを展開中';

  @override
  String get flashingStatusDownloading => 'ファームウェアをダウンロード中';

  @override
  String get flashingStatusBuilding => 'ファームウェアをビルド中';

  @override
  String get flashingStatusUploading => 'デバイスにアップロード中';

  @override
  String get flashingStatusFinalizing => 'デバイスに書き込み中 — お待ちください';

  @override
  String get flashDeviceLabel => 'ファームウェア書き込み';

  @override
  String get deviceConfigLabel => 'デバイス設定';

  @override
  String get firmwareManagerLabel => 'ファームウェア管理';

  @override
  String get settingsLabel => '設定';

  @override
  String get helpSupportLabel => 'ヘルプとサポート';

  @override
  String get noDeviceFoundLabel => 'デバイスが見つかりません';

  @override
  String get retryLabel => '再試行';

  @override
  String get manualConnectionLabel => '手動接続';

  @override
  String get manualIpOverrideLabel => 'IPアドレス手動指定';

  @override
  String get connectLabel => '接続';

  @override
  String get cancelLabel => 'キャンセル';

  @override
  String get matchedLabel => '一致';

  @override
  String get mismatchLabel => '不一致';

  @override
  String connectedLabel(String ip) {
    return '接続済み: $ip';
  }

  @override
  String get default24GHzDomainLabel => 'デフォルトの2.4GHzドメイン';

  @override
  String get defaultSubGHzDomainLabel => 'デフォルトのSub-GHzドメイン';

  @override
  String get globalBindingPhraseLabel => 'グローバルバインドフレーズ';

  @override
  String get homeWifiSsidLabel => 'ホームWi-Fi SSID';

  @override
  String get homeWifiPasswordLabel => 'ホームWi-Fiパスワード';

  @override
  String get manageCachedFirmwareLabel => 'キャッシュされたファームウェアの管理';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel => 'オフラインファームウェアをダウンロードまたは削除';

  @override
  String get maxCachedVersionsLabel => 'キャッシュされる最大バージョン数';

  @override
  String get clearFirmwareCacheLabel => 'ファームウェアキャッシュをクリア';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'ダウンロード済みのすべてのファームウェアファイルを削除';

  @override
  String get clearLabel => 'クリア';

  @override
  String get appVersionLabel => 'アプリのバージョン';

  @override
  String get legalLicenseLabel => '法律情報とライセンス';

  @override
  String get standardDisclaimerAndGplv3Label => '標準免責事項とGPLv3ライセンス';

  @override
  String get supportDevelopmentLabel => '開発支援';

  @override
  String get supportDevelopmentSubtitle => 'Ko-fiで開発者を支援';

  @override
  String get shareAnalyticsLabel => '分析データを共有';

  @override
  String get shareAnalyticsSubtitle => '匿名利用データを共有してアプリの改善にご協力ください';

  @override
  String get expertModeLabel => 'エキスパートモード';

  @override
  String get expertModeSubtitle => '高度なファームウェア処理とダウンロードを有効にします';

  @override
  String get exportElrsLuaScriptLabel => 'ELRS Luaスクリプトをエクスポート';

  @override
  String get exportElrsLuaScriptSubtitle => 'EdgeTX/OpenTX無線機用にelrs.luaを保存します';

  @override
  String get submitDebugReportLabel => 'Sentryにデバッグレポートを送信';

  @override
  String get submitDebugReportSubtitle => '匿名システムログを共有してバグ修正にご協力ください';

  @override
  String get clearFirmwareCacheTitle => 'ファームウェアキャッシュをクリアしますか？';

  @override
  String get clearFirmwareCacheMessage =>
      'これにより、ダウンロード済みのすべてのファームウェアZIPファイルが削除されます。オフラインで書き込みを行う場合は、再度ダウンロードする必要があります。';

  @override
  String get clearAllLabel => 'すべてクリア';

  @override
  String get submitDebugReportTitle => 'デバッグレポートを送信';

  @override
  String get submitDebugReportMessage =>
      'これにより、デバッグのためにデバイス情報とアプリのログがSentryに送信されます。バインドフレーズやWi-Fiパスワードなどの個人情報は含まれません。';

  @override
  String get describeIssueHint => '発生している問題を説明してください...';

  @override
  String get proceedLabel => '続行';

  @override
  String get submittingReportProgress => 'レポートを送信中…';

  @override
  String get saveLabel => '保存';

  @override
  String get notSetLabel => '未設定';

  @override
  String get languageOverrideLabel => '言語';

  @override
  String get languageOverrideSystemDefault => 'システムデフォルト';

  @override
  String get legalNoticeSectionTitle => '法的通知';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobileは、Weston Hintonによって独立して開発された自由でオープンソース（FOSS）プロジェクトです。本プロジェクトはExpressLRS LLCの公式製品ではなく、ExpressLRS開発チームによって公式にサポート、承認、または認定されているものではありません。';

  @override
  String get trademarkNoticeSectionTitle => '商標について';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRSおよびExpressLRSロゴは、ExpressLRS LLCの商標です。これらの商標の使用は、記述および互換性の目的のみに限定されます。公式のExpressLRSコンフィギュレーターおよびドキュメントについては、expresslrs.orgをご覧ください。';

  @override
  String get officialSupportSectionTitle => '公式サポート';

  @override
  String get officialSupportSectionText => '公式のExpressLRSプロジェクトをサポートする: ';

  @override
  String get donateOpenCollectiveLabel => 'Open Collectiveで寄付する';

  @override
  String get softwareLicenseSectionTitle => 'ソフトウェアライセンス';

  @override
  String get gplv3NoticeText =>
      '本プロジェクトはGNU General Public License v3.0の下でライセンスされています。';

  @override
  String get tabFlashingGuide => 'ファームウェア書き込みガイド';

  @override
  String get tabFaq => 'よくある質問';

  @override
  String get tabResources => 'リソース';

  @override
  String get resourceCommunitySupport => 'コミュニティとサポート';

  @override
  String get resourceDiscordCommunity => 'Discordコミュニティ';

  @override
  String get resourceJoinDiscord => 'ELRS Discordに参加する';

  @override
  String get resourceGithubRepo => 'GitHubリポジトリ';

  @override
  String get resourceFlashRecovery => 'ファームウェア書き込みの復旧';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'デバイスがファームウェア書き込み失敗後に反応しなくなった場合:';

  @override
  String get resourceRecoveryStep1 =>
      'USBを接続する際にBOOTボタンを押したままにして、ブートローダーモードに入ります。';

  @override
  String get resourceRecoveryStep2 =>
      'expresslrs.org/flasher のELRS Web Flasherを使用して、USB/UART経由でファームウェアを再書き込みします。';

  @override
  String get resourceRecoveryStep3 =>
      'WiFi対応デバイスの場合、BOOTボタンを60秒間押し続けて、WiFiホットスポット復旧モードをトリガーします。';

  @override
  String get resourceRecoveryStep4 =>
      'ELRS Discordの#helpチャンネルに参加してください — コミュニティは通常、どのようなデバイスでも復旧できます。';

  @override
  String get resourceBardwellGuideRecommended =>
      'Joshua Bardwell氏のunbrickingガイドを強くお勧めします:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => '復旧ビデオ';

  @override
  String get resourceLegalLiability => '法的責任';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobileは、いかなる種類の保証もなく「現状有姿」で提供されます。開発者は、本アプリケーションの使用によって生じた、受信機、送信機、フライトコントローラーの破損、データの損失、または機能不全のハードウェアを含むがこれに限定されない、いかなる損害についても責任を負いません。\n\nこのアプリを使用することにより、お客様はご自身のハードウェアに対する全責任を負うものとします。';

  @override
  String get resourceViewFullDisclaimerButton => '免責事項全文を表示';

  @override
  String get disclaimerTitle => '自己責任でご使用ください';

  @override
  String get disclaimerHeader => 'ELRSモバイルは現状有姿で提供され、いかなる保証もありません。';

  @override
  String get disclaimerLiability =>
      '開発者は、本アプリケーションの使用に起因するいかなる損害、データ損失、またはハードウェアの不具合（例：動作不能になったレシーバー、トランスミッター、フライトコントローラーなど）に対して、一切の責任を負いません。';

  @override
  String get disclaimerAgreement =>
      '本アプリを使用することにより、カスタムファームウェアのフラッシュに伴うリスクを理解し、ご自身のハードウェアに対する全責任を受け入れることに同意したものとします。';

  @override
  String get disclaimerVerification =>
      'フラッシュする前に、必ず対象とファームウェアのバージョンを確認してください。可能な場合は、元のファームウェアの記録を保管してください。';

  @override
  String get disclaimerUnderstand => '承知しました';

  @override
  String get optionsTitle => 'ファームウェア設定';

  @override
  String get optionsSubtitle => 'バインディングとネットワーク認証情報を設定します。';

  @override
  String get wifiPasswordLabel => 'Wi-Fiパスワード';

  @override
  String get wifiOnIntervalLabel => 'Wi-Fi自動オン間隔';

  @override
  String get regulatoryDomainLabel => '規制ドメイン';

  @override
  String get regDomainIsm => 'ISM (2.4GHz)';

  @override
  String get regDomainEuLbt => 'EU CE (2.4GHz LBT)';

  @override
  String get regDomainAu915 => 'AU (915MHz)';

  @override
  String get regDomainFcc915 => 'FCC (915MHz)';

  @override
  String get regDomainEu868 => 'EU (868MHz)';

  @override
  String get regDomainIn866 => 'IN (866MHz)';

  @override
  String get regDomainAu433 => 'AU (433MHz)';

  @override
  String get regDomainEu433 => 'EU (433MHz)';

  @override
  String get regDomainUs433 => 'US (433MHz)';

  @override
  String get flashingStatusSaved => 'ファームウェアを保存しました';

  @override
  String get flashErrorNoTarget => '対象デバイスを選択してください。';

  @override
  String get flashErrorNoVersion => 'ファームウェアのバージョンを選択してください。';

  @override
  String get flashErrorNoDevice => 'フラッシュできません: ELRSデバイスが接続されていません。';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return '互換性のないチップです: このファームウェアは$targetChip用にビルドされていますが、接続されているデバイスは$deviceChipです。同じチップのターゲットを選択してください。';
  }

  @override
  String get flashErrorOfflineFlash =>
      '不足しているファイルを取得するためのインターネットアクセスがありません。ELRSデバイスから切断し、「ファームウェア管理」でこのファームウェアをダウンロードしてキャッシュを完了してから、もう一度お試しください。';

  @override
  String get flashErrorOfflineDownload =>
      'インターネットアクセスがありません。ELRSデバイスのホットスポットに接続中はファームウェアをダウンロードできません。切断し、「ファームウェア管理」でこのバージョンをダウンロードしてから、もう一度お試しください。';

  @override
  String get flashErrorFlashFailed => '書き込みに失敗しました。';

  @override
  String get flashErrorUnconfirmed =>
      'デバイスが書き込みの確認前に切断されたため、完了していない可能性があります。これは、書き込み中に電源が失われたり再起動したりした場合、または書き込み成功後にWi-Fi接続が不安定になった場合に発生します。「デバイス設定」でファームウェアのバージョンを確認し、変更されていない場合は再度書き込みを行ってください。';

  @override
  String get flashErrorDownloadFailed => 'ファームウェアのダウンロードに失敗しました。';

  @override
  String get validationSsidTooLong => 'SSIDは32文字以下である必要があります';

  @override
  String get validationPasswordTooShort => 'パスワードは8文字以上である必要があります';

  @override
  String get validationPasswordTooLong => 'パスワードは63文字以下である必要があります';

  @override
  String get targetMismatchTitle => 'ターゲット不一致';

  @override
  String get targetMismatchMessage =>
      '選択されたファームウェアターゲットは、現在デバイスで実行されているハードウェアと一致しません。強制的に書き込みを続行しますか？';

  @override
  String get forceFlashLabel => '強制書き込み';

  @override
  String get noBindPhraseTitle => 'バインドフレーズがありません';

  @override
  String get noBindPhraseMessage => 'バインドフレーズが設定されていません。デフォルト（空）で続行しますか？';

  @override
  String get flashSuccessSnackbar => '書き込みが正常に完了しました！';

  @override
  String get firmwareSavedSnackbar => 'ファームウェアが正常に保存されました！';

  @override
  String get flashSuccessMessage => '書き込みが成功しました！デバイスを再起動しています。';

  @override
  String get stm32OtaWarning =>
      'STM32ターゲットが選択されました: このハードウェアではOTA書き込みはサポートされていません。このファームウェアをローカルでビルドして保存し、STLinkまたはBetaflight Passthrough経由で手動で書き込むことができます。';

  @override
  String get downloadBinaryLabel => 'バイナリをダウンロード';

  @override
  String get waitingForDeviceLabel => 'デバイスを待機中...';

  @override
  String get otaUnavailableLabel => 'OTA利用不可';

  @override
  String get doneLabel => '完了';

  @override
  String get targetSelectionTitle => 'ターゲット選択';

  @override
  String get deviceTypeLabel => 'デバイスタイプ';

  @override
  String get deviceVendorLabel => 'デバイスベンダー';

  @override
  String get regulatoryFrequencyLabel => '規制と周波数';

  @override
  String get deviceTargetLabel => 'デバイスターゲット';

  @override
  String get noFirmwareDownloadedButton =>
      'ファームウェアがダウンロードされていません。ファームウェアマネージャーへ';

  @override
  String hardwareRequiresVersion(String version) {
    return 'ハードウェアにはv$version以降が必要です。';
  }

  @override
  String get downloadCompatibleFirmwareButton => '互換性のあるファームウェアをダウンロード';

  @override
  String get firmwareVersionLabel => 'ファームウェアバージョン';

  @override
  String get firmwareVersionHelper => 'フラッシュするELRSバージョンを選択';

  @override
  String get cachedBadge => '(キャッシュ済み)';

  @override
  String errorLoadingVersions(String error) {
    return 'バージョンの読み込みエラー: $error';
  }

  @override
  String get flashingProfileLabel => 'フラッシュプロファイル';

  @override
  String get addProfileTooltip => 'プロファイルを追加';

  @override
  String get deleteProfileTooltip => 'プロファイルを削除';

  @override
  String get bindingPhraseHelper => 'あなたのユニークなバインディングフレーズ';

  @override
  String get addProfileTitle => 'フラッシュプロファイルの追加';

  @override
  String get profileNameHint => 'プロファイル名（例：My Quads）';

  @override
  String get addLabel => '追加';

  @override
  String get deleteProfileTitle => 'プロファイルの削除';

  @override
  String deleteProfileMessage(String name) {
    return 'プロファイル「$name」を本当に削除しますか？';
  }

  @override
  String get deleteLabel => '削除';

  @override
  String get settingsCategoryProfilesNetwork => 'プロファイルとネットワーク';

  @override
  String get settingsCategoryAppStorage => 'アプリとストレージ';

  @override
  String get settingsCategoryAdvancedDebug => '詳細設定とデバッグ';

  @override
  String get settingsCategoryAboutLegal => 'このアプリについて・法的情報';

  @override
  String get settingsSectionRegulatoryDefaults => '規制の既定値';

  @override
  String get settingsSectionPreferences => '環境設定';

  @override
  String get settingsSectionPowerTools => 'パワーツール';

  @override
  String get settingsSectionDiagnostics => '診断';

  @override
  String get regDomainUnknown => '不明';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countバージョン',
      one: '1バージョン',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return '$fieldを編集';
  }

  @override
  String enterFieldHint(String field) {
    return '$fieldを入力';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.luaをデバイスに保存しました！';

  @override
  String luaScriptSaveFailed(String error) {
    return 'スクリプトの保存に失敗しました: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return '送信しました！イベントID: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'レポートを正常に送信しました！';

  @override
  String debugReportFailed(String error) {
    return '送信に失敗しました: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'ライセンスの読み込みエラー: $error';
  }

  @override
  String get firmwareErrorLoadFailed => 'ファームウェアバージョンを読み込めませんでした。';

  @override
  String get firmwareErrorOnHotspot =>
      'レシーバーのWi-Fiホットスポットに直接接続している間はファームウェアをダウンロードできません。接続を切断するか、ホームネットワークを使用してください。';

  @override
  String get firmwareErrorCacheFull => 'キャッシュの上限に達しました。古いバージョンを削除してください。';

  @override
  String get firmwareErrorServerUnreachable =>
      'ファームウェアサーバーに接続できません。インターネット接続を確認してください。';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'ダウンロードが中断されました: ネットワーク接続が失われました。接続を確認してもう一度お試しください。';

  @override
  String get firmwareErrorDownloadFailed => 'ファームウェアのダウンロードに失敗しました。';

  @override
  String get firmwareErrorDeleteFailed => 'このファームウェアバージョンを削除できませんでした。';

  @override
  String firmwareVersionTitle(String version) {
    return 'バージョン $version';
  }

  @override
  String get readyForOfflineUse => 'オフラインでの使用準備ができました';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return '使用済みストレージ: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit バージョン';
  }

  @override
  String get splashTagline => '独立した設定ツール';

  @override
  String get splashDisclaimer =>
      '公式のExpressLRS製品ではありません。\n3.3.x/4.xファームウェアに対応しています。';

  @override
  String get unknownDeviceName => 'ELRSデバイス';

  @override
  String get unknownIpLabel => '不明なIP';

  @override
  String get firmwareBinariesFileType => 'ファームウェアバイナリ';

  @override
  String helpContentLoadFailed(String error) {
    return 'ヘルプコンテンツの読み込みエラー: $error';
  }
}
