---
title: "ユーザーガイド"
slug: user_guide
sidebar:
  order: 1
---

## 概要
このアプリケーションは、ExpressLRS ハードウェアを管理するための包括的なモバイルインターフェースを提供します。ユーザーは、受信機 (RX) および送信機 (TX) パラメータの設定、PWM 出力のマッピング、そしてモバイルデバイスから直接ファームウェアのアップデートを行うことができます。

---

## インストール

### 公式アプリストア

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Google Playからインストール

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Google Playで入手</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
App Storeからインストール

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">App Storeでダウンロード</a>

### 代替インストール

#### GitHub Store
代替のアプリストア体験を好むユーザーに最適です。

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">GitHub Storeでダウンロード</a>

### 手動インストール
上級ユーザーや手動管理を好む方は、最新の`.apk`ファイルについては、[GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases)ページをご覧ください。

---

## 🚀 クイックスタート: 最初のデバイスをフラッシュする

### フェーズ1: ファームウェアのキャッシュ (自宅でこれを行ってください)
1. アプリを開き、**ファームウェ���マネージャー**に移動します。
2. 最新の安定版リリースの横にあるダウンロードアイコンをタップします。
3. アプリは、オフラインで使用するために必要なターゲットとハードウェア定義をダウンロードし、安全にキャッシュします。

### フェーズ2: デバイスへの接続
1. ExpressLRS 受信機 (RX) または送信機 (TX) の電源を入れます。
2. デバイスがWi-Fiホットスポットモードに入るまで (LEDが速く点滅するまで) 60秒間 (または設定された間隔) 待ちます。
3. お使いのスマートフォンのWi-Fiを、**ExpressLRS RX** または **ExpressLRS TX** ネットワークに接続します (パスワード: `expresslrs`)。
4. アプリを開きます。ダッシュボードはmDNSを使用してネットワークを自動的にスキャンし、デバイスに接続します。

### フェーズ3: ファームウェアのフラッシュ
1. ダッシュボードから、**デバイスをフラッシュ**を選択します。
2. **ハードウェアを選択:** カスケードドロップダウンを使用して、デバイスタイプ、ベンダー、周波数、ターゲットを選択します。
3. **オプションを設定:** カスタムのBinding Phrase、Wi-Fiの認証情報、およびRegulatory Domainを設定します。
4. **FLASH**をタップします。アプリはバイナリをローカルで組み立て、デバイスにプッシュします。

---

## 技術的な詳細

### 接続性および検出
このアプリは、ハードウェアを見つけるために堅牢な多段階の検出シーケンスを使用します。
1. **mDNS解決**: 主要な方法です。アプリは`elrs_rx.local`または`elrs_tx.local`をスキャンします。
2. **静的APフォールバック**: mDNSがブロックされている場合、アプリは公式のELRSアクセスポイントIP (`10.0.0.1`) を確認します。
3. **手動IPオーバーライド**: 複雑なネットワークの場合、設定でIPアドレスを手動で入力できます。

**強制ネットワークバインディング**: 現代のスマートフォンは、インターネット接続がないWi-Fi接続を破棄することがよくあります。ELRS Mobileには、OSにハードウェア接続を維持させるネイティブな「強制ルーティング」レイヤーが含まれており、現場での100%信頼性の高い検出を保証します。

---

## エキスパートモードと監査
設定メニュー内で、ユーザーは**エキスパートモード**を有効にできます。これにより、組み立てられたファー��ウェアバイナリをデバイスに直接保存して、監査やFTDIを介した手動フラッシュに使用できます。

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 ハードウェアの取り扱い</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    ELRS MobileはSTM32ターゲット用のファームウェアを組み立ててパッチを適用できますが (ELRS v3.xまで)、これらのデバイスはWi-Fiを介したOver-The-Air (OTA) フラッシュをサポートしていません。STM32ターゲットを選択した場合、アプリはバイナリをローカルでビルドして保存することを許可するため、STLinkまたはBetaflight Passthroughを介してPCを使用して手動でフラッシュできます。
  </p>
</div>

これらのバイナリの整合性を検証したい開発者の方は、[**ファームウェア検証ガイド**](/guides/firmware-validation)をご覧ください。

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->