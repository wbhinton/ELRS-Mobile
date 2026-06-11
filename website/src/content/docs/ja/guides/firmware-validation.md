---
title: "ファームウェア検証ツール"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

このガイドでは、ELRS Mobileアプリケーションのファームウェアアセンブリロジックを公式の「ゴールデン」バイナリに対して検証するために使用される内部ツールについて詳しく説明します。

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">グラウンドトゥルースとコンフィギュレーターバイナリの比較</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    検証監査を実行する際、ELRS Mobileによって生成されたバイナリが公式の<strong>ExpressLRS Web Flasher</strong>と完全に一致する一方で、ローカルの<strong>ExpressLRS Configurator (Python)</strong>を使用してビルドされたバイナリとはわずかに異なることに気づくかもしれません。
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    これは予期される動作です。ESP32の内部C++ JSONパーサーは空白を無視するため、両方のバイナリはハードウェア上で同一に実行されますが、ミニファイの違いにより厳密なバイトごとのSHA256比較では一致しません。
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**場所:** `firmware_testing/scripts/dart/logic_validator.dart`

ロジックバリデーターは、高性能なビットレベル比較ツールです。ELRS Mobileの内部パッチ適用およびアセンブリロジックが、公式のExpressLRSロジックを反映していることを検証するように設計されています。

### 主要機能
- **ビットレベル分析**: 異なるバイト内の正確なビットオフセットの不一致箇所を特定します。
- **インタラクティブな選択**: `firmware_testing/binaries/`で見つかったすべてのバイナリをリスト表示します。
- **ゼロコピーメモリ管理**: 大規模なファームウェアファイルの高速分析に最適化されています。

### 使用方法
1. **バイナリの準備**: 生成された`.bin`または`.gz`ファイルを`firmware_testing/binaries/`に配置します。
2. **セットアップと実行**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**場所:** `firmware_testing/scripts/python/audit_tool.py`

オーディターは、「グラウンドトゥルース」検証を目的としたスタンドアロンの依存関係のないスクリプトです。ExpressLRSファームウェアイメージの最後に付加された2704バイ��の設定ブロックを解析します。

### 目的
ベースファームウェアコードのレイアウトの違いに関係なく、実際にデバイスに書き込まれたメタデータ（Product Name, Lua Name, Hardware Layout, and Options）が正しいことを検証します。

### 使用方法
1. **直接実行**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. バイナリクロス検証ワークフロー
ELRS Mobileがファームウェアを正しくアセンブリしていることを確認するために、開発者は定期的にPCでコンパイルされた「グラウンドトゥルース」バイナリに対してクロス検証監査を実行する必要があります。

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">ELRS Mobileからバイナリをエクスポートする</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">設定で<strong>Expert Mode</strong>を有効にし、ターゲットとオプションを設定した後、Flasherタブの<strong>DOWNLOAD BINARY</strong>ボタンを使用します。</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">PCグラウンドトゥルースを生成する</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">PCで公式のExpressLRS Configuratorを使用し、<strong>全く同じ</strong>ターゲットとバージョンを同一のオプションでビルドします。</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">監査を実行する</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">両方のバイナリを<code>firmware_testing/binaries/</code>に配置し、<code>audit_tool.py</code>スクリプトを実行して、ハードウェアとオプションが完全に一致していることを確認します。</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->