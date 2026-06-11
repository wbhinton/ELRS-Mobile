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
  String get packetRateLabel => 'パケットレート';

  @override
  String get baudRateLabel => 'ボーレート';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return '$radioMaster または $betaFPV ハードウェアの $expressLRS ファームウェアを更新しています...';
  }

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
  String get flashingWifiCategoryLabel => 'ファームウェア書き込みとWi-Fi';

  @override
  String get aboutSupportCategoryLabel => 'バージョン情報とサポート';

  @override
  String get advancedCategoryLabel => '詳細設定';

  @override
  String get flashingDefaultsSectionLabel => 'ファームウェア書き込みのデフォルト設定';

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
  String get aboutSectionLabel => 'このアプリについて';

  @override
  String get appVersionLabel => 'アプリのバージョン';

  @override
  String get legalLicenseLabel => '法律情報とライセンス';

  @override
  String get standardDisclaimerAndGplv3Label => '標準免責事項とGPLv3ライセンス';

  @override
  String get developerSectionLabel => '開発者向け';

  @override
  String get developerModeEnabledLabel => '開発者モード有効';

  @override
  String get testSentryErrorCaptureLabel => 'Sentryエラーキャプチャのテスト';

  @override
  String get testSentryErrorCaptureSubtitle =>
      'テスト例外をSentryに送信します — ダッシュボードで確認してください';

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
}
