---
title: "ユーザーガイド"
slug: ja/user_guide
sidebar:
  order: 1
---

## 概要
このアプリケーションは、ExpressLRS ハードウェアを管理するための包括的なモバイルインターフェースを提供します。これにより、ユーザーはレシーバー (RX) およびトランスミッター (TX) パラメータの設定、PWM 出力のマッピング、そしてファームウェアアップデートのフラッシュをモバイルデバイスから直接行うことができます。

---

## インストール

### 公式アプリストア

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Google Playからインストール

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Get it on Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
App Storeからインストール

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on App Store</a>

### その他のインストール方法

#### GitHub Store
代替アプリストアの利用を好むユーザーに最適です。

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on GitHub Store</a>

### 手動インストール
パワーユーザーや手動管理を好むユーザー向けに、最新の`.apk`ファイルについては、[GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases)ページをご覧ください。

---

## 🚀 クイックスタート: 最初のデバイスをフラッシュする

### フェーズ1: ファームウェアのキャッシュ (ご自宅で実施)
1. アプリを開き、**ファームウェアマネージャー**に移動します。
2. 最新の安定版リリースの隣にあるダウンロードアイコンをタップします。
3. アプリは、オフラインで使用するために必要なターゲットおよびハードウェア定義をダウンロードし、安全にキャッシュします。

### フェーズ2: デバイスへの接続
1. ExpressLRS レシーバー (RX) またはトランスミッター (TX) の電源を入れます。
2. デバイスがWi-Fiホットスポットモード（LEDが素早く点滅）に入るまで、60秒間（または設定した間隔）待ちます。
3. スマートフォンのWi-Fiを**ExpressLRS RX**または**ExpressLRS TX**ネットワークに接続します (パスワード: `expresslrs`)。
4. アプリを開きます。ダッシュボードはmDNSを使用してネットワークを自動的にスキャンし、デバイスに接続します。

### フェーズ3: ファームウェアのフラッシュ
1. ダッシュボードから、**デバイスをフラッシュ**を選択します。
2. **ハードウェアの選択:** カスケードドロップダウンを使用して、デバイスタイプ、ベンダー、周波数、ターゲットを選択します。
3. **オプションとプロファイルの構成:** **フ���ッシュプロファイル**を選択（または**+**ボタンをタップして新しい名前付きプロファイルを追加）して、認証情報をロードします。Binding Phrase、Wi-Fi SSID、Wi-Fiパスワード、規制ドメイン、Wi-Fi自動オン間隔をカスタマイズします。
4. **フラッシュ**をタップします。アプリはバイナリをローカルでアセンブルし、デバイスにプッシュします。

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">ターゲット不一致の警告</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    アプリが選択したハードウェアターゲットと接続されているデバイスとの間に不一致を検出した場合、意図しない損傷を防ぐために警告します。正しいターゲットであることを確信している場合（例：不良なフラッシュからの復旧やターゲット定義間の移行）は、警告ダイアログで**強制フラッシュ**をクリックして、チェックをバイパスします。
  </p>
</div>

### 📋 フラッシュプロファイルの管理
複数のドローンや無線設定があり、異なる設定要件（例：異なるBinding Phraseや規制ドメイン）がある場合、名前付き**フラッシュプロファイル**を使用して設定を保存および切り替えることができます。
* **プロファイルの追加**: 「フラッシュプロファイル」ドロップダウンの隣にある**+**アイコンをタップし、名前を入力して追加ボタンを押します。
* **自動保存**: アクティブなプロファイルの認証情報（Binding Phrase、SSID、パスワード、ドメイン、または間隔）への変更は、リアルタイムで自動的に保存されます。
* **プロファイルの切り替え**: ドロップダウンから��ロファイルを選択するだけで、保存された設定を瞬時にロードできます。
* **プロファイルの削除**: クリーンアップするには、ドロップダウンからプロファイルを選択し、ゴミ箱/削除アイコンをタップします（プロファイルを削除するには、少なくとも2つのプロファイルが必要です）。

---

## 技術的詳細

### 接続と検出
このアプリは、ハードウェアを検出するために堅牢な多段階検出シーケンスを使用します。
1. **mDNS解決**: 主要な方法です。アプリは`elrs_rx.local`または`elrs_tx.local`をスキャンします。
2. **静的APフォールバック**: mDNSがブロックされている場合、アプリは公式のELRSアクセスポイントIP (`10.0.0.1`) を確認します。
3. **手動IPオーバーライド**: 複雑なネットワークの場合、設定でIPアドレスを手動で入力できます。

**強制ネットワークバインディング**: 最新のスマートフォンは、インターネット接続がないWi-Fi接続を破棄することがよくあります。ELRS Mobileには、OSにハードウェア接続を維持させるネイティブの「強制ルーティング」レイヤーが含まれており、現場での100%信頼性の高い検出を保証します。

---

## エキスパートモードと監査
設定メニュー内で、ユーザーは**エキスパートモード**を有効にできます。これにより、アセンブルされたファームウェアバイナリをデバイスに直接保存し、監査やFTDIを介した手動フラッシュを行うことができます。

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32ハードウェアの取り扱い</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    ELRS MobileはSTM32ターゲット（ELRS v3.xま��）のファームウェアをアセンブルおよびパッチ適用できますが、これらのデバイスはWi-Fiを介したOver-The-Air（OTA）フラッシュをサポートしていません。STM32ターゲットを選択した場合、アプリはバイナリをローカルでビルドして保存することを許可するため、STLinkまたはBetaflight Passthroughを介してPCを使用して手動でフラッシュできます。
  </p>
</div>

これらのバイナリの整合性を確認したい開発者の方へ、[**ファームウェア検証ガイド**](/guides/firmware-validation)をご覧ください。

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->