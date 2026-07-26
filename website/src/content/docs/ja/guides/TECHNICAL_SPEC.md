---
title: "技術仕様"
slug: ja/technical_spec
sidebar:
  order: 5
---

## アーキテクチャ概要

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">設計原則</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    このアプリケーションはFlutterを使用して構築されており、<strong>Riverpod</strong>ステート管理フレームワークを活用しています。デバイスのオンボードWiFiモジュールによって公開されるRESTful APIを介してELRSハードウェアと対話し、低遅延の通信とリアルタイムの状態同期を保証します。
  </p>
</div>

## データ層

### APIエンドポイント
システムは以下のHTTPエンドポイントを使用してハードウェアと通信します。

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/config` | 現在のデバイス設定をJSON形式で取得します。 |
| `POST` | `/options.json` | 変更可能なランタイムオプション（WiFi SSID、Passwordなど）を更新します。 |
| `POST` | `/config` | コアハードウェアパラメータとPWMマッピングを更新します。 |
| `POST` | `/reboot` | 変更を適用するためにハードウェアリセットをトリガーします。 |

### JSONスキーマ
`RuntimeConfig`モデルはELRS 4.x構造を活用しており、パラメータを3つの主要なノードに分離しています。
- `settings`: 読み取り専用のハードウェア識別子とバージョン文字列。
- `options`: 変更可能なユーザー設定とネットワーク認証情報。
- `config`: 低レベルのハードウェア設定（Protocols、PWM Arrays）。

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

## ステート管理
システムはリアクティブなアーキテクチャを採用しています。
- **`ConfigViewModel`**: ライブ接続状態、ハートビートロジック、およびIPディスカバリを管理します。
- **`DeviceEditorViewModel`**: デバイス構成のドラフト状態を保持し、最終的な「保存/キャンセル」ロジックによる多段階編集を可能にします。
- **`FlashingController`**: ファームウェアのダウンロード、ローカルバイナリパッチ、およびXH-over-HTTPアップロードプロセスを編成します。

## マッピング層
以下の表は、APIで使用される��数識別子と人間が読める対応する値との間のマッピングを定義します。

### 規制ドメイン
| ID | Label | Description |
| :--- | :--- | :--- |
| 0 | AU915 | オーストラリア/ニュージーランド 915MHz |
| 1 | FCC915 | 北米 915MHz |
| 2 | EU868 | ヨーロッパ 868MHz |
| 3 | IN866 | インド 866MHz |
| 4 | AU433 | オーストラリア 433MHz |
| 5 | EU433 | ヨーロッパ 433MHz |
| 6 | US433 | 北米 433MHz |
| 7 | US433-Wide | 北米ワイド 433MHz |


## 高度なマッピング

### VBind (Binding Storage)
バインディングフレーズがデバイスにどのように保存されるかを決定します。
- **0: Persistent**: フラッシュメモリに保存されます（標準）。
- **1: Volatile**: 電源を切るとクリアされます。
- **2: Returnable**: 貸与品に使用されます。
- **3: Administered**: 複数パイロットのフリート環境で使用されます。


## 永続化層
システムは2層の永続化戦略を実装しています。
- **`SharedPreferences`**: `PersistenceService`を介して、WiFi SSIDsや一般的なアプリ設定などの機密性の低いデータに使用されます。
- **`FlutterSecureStorage`**: Binding PhrasesやWiFi Passwordsなどの機密データに使用され、OSレベルでの暗号化を保証します。

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->