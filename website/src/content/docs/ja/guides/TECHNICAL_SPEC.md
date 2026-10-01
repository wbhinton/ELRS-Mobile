---
title: "技術仕様"
slug: ja/technical_spec
sidebar:
  order: 5
---

## アーキテクチャの概要

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">設計原則</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    このアプリケーションはFlutterを使用して構築されており、<strong>Riverpod</strong>ステート管理フレームワークを活用しています。デバイスの内蔵WiFiモジュールによって公開されるRESTful APIを介してELRSハードウェアと連携し、低遅延の通信とリアルタイムの状態同期を実現します。
  </p>
</div>

## データ層

### APIエンドポイント
システムは以下のHTTPエンドポイントを使用してハードウェアと通信します：

| メソッド | エンドポイント | 説明 |
| :--- | :--- | :--- |
| `GET` | `/config` | 現在のデバイス構成をJSON形式で取得します。 |
| `POST` | `/options.json` | 変更可能なランタイムオプション（SSID、パスワードなど）を更新します。 |
| `POST` | `/config` | コアハードウェアパラメーターとPWMマッピングを更新します。 |
| `POST` | `/reboot` | 変更を適用するためにハードウェアのリセットをトリガーします。 |

### JSONスキーマ
`RuntimeConfig`モデルは���ELRS 4.xの構造を活用しており、パラメーターを3つの主要なノードに分けています：
- `settings`: 読み取り専用のハードウェア識別子とバージョン文字列。
- `options`: 変更可能なユーザー設定とネットワーク認証情報。
- `config`: 低レベルのハードウェア構成（Protocols、PWM Arrays）。

JSON構造の例：
```json
{
  "product_name": "Test RX",
  "settings": {
    "version": "1.0.0",
    "module-type": "RX"
  },
  "options": {
    "bindPhrase": "example",
    "wifi-ssid": "SSID",
    "domain": 1
  },
  "config": {
    "serial-protocol": 0,
    "pwm": [
      {"channel": 0, "mode": 5}
    ]
  }
}
```

## 状態管理
システムはリアクティブアーキテクチャを採用しています：
- **`ConfigViewModel`**: ライブ接続状態、ハートビートロジック、およびIPディスカバリを管理します。
- **`FlashingController`**: ファームウェアのダウンロード、ローカルバイナリパッチ適用、およびXH-over-HTTPアップロードプロセスを編成します。

## マッピング層
`ElrsMappings.domains900`は、APIで使用される900 MHz規制ドメインインデックスを人間が読めるラベルにマッピングします：

| ID | ラベ��� | 説明 |
| :--- | :--- | :--- |
| 0 | AU915 | オーストラリア/ニュージーランド 915MHz |
| 1 | FCC915 | 北米 915MHz |
| 2 | EU868 | ヨーロッパ 868MHz |
| 3 | IN866 | インド 866MHz |
| 4 | AU433 | オーストラリア 433MHz |
| 5 | EU433 | ヨーロッパ 433MHz |
| 6 | US433 | 北米 433MHz |
| 7 | US433-Wide | 北米ワイド 433MHz |


## 永続化層
システムは2層の永続化戦略を実装しています：
- **`SharedPreferences`**: WiFi SSIDや一般的なアプリ設定など、機密性の低いデータに対して`PersistenceService`を介して利用されます。
- **`FlutterSecureStorage`**: Binding PhrasesやWiFi Passwordsを含む機密データに使用され、OSレベルでの暗号化を保証します。

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->