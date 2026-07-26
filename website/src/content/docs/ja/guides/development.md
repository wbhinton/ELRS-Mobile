---
title: "開発ガイド"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: ja/development
sidebar:
  order: 2
---

ELRS Mobile開発ガイドへようこそ！このプロジェクトは、ExpressLRSのコンパイルおよびフラッシュパイプラインをネイティブのFlutterで実装したもので、完全にオフラインで動作するように設計されています。

## 前提条件
このプロジェクトに貢献するには、以下のツールをインストールする必要があります。

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## はじめに

1. **リポジトリをクローンする**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **依存関係をインストールする**:
   ```bash
   flutter pub get
   ```

3. **アプリケーションを実行する**:
   ```bash
   # For Android
   flutter run
   
   # For iOS (requires a Mac and physical device/simulator)
   flutter run
   ```

---

## プロジェクトアーキテクチャ
コードベースは `lib/src/` にあるフィーチャーファースト構造に従っています。

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Features
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">フラッシュパイプラインのコアロジックとUI。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">アーティファクトリからファームウェアをダウンロードおよびキャッシュする処理を扱います。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Binding PhrasesやWiFiなどのユーザーオプションを設定するためのUI。</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Core
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">ハードウェアホットスポットへのプロセスバインディングのためのプラット���ォーム固有のロジック。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">ローカルキャッシュ管理とSQLiteによる永続化。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">プライバシーを重視したオブザーバビリティ（SentryとAptabase）。</span>
      </li>
    </ul>
  </div>
</div>

---

## 状態管理
グローバルな状態管理には**Riverpod**を、ローカルなウィジェットレベルの状態には**Flutter Hooks**を利用しています。この組み合わせにより、標準の`StatefulWidgets`のような定型コードなしに、高い反応性のUIが実現されます。

---

## 詳細ガイド

詳細な技術情報については、以下のガイドを参照してください。

- [**Technical Architecture**](/guides/technical_architecture): `FirmwareAssembler`とネイティブネットワークスタックの詳細な解説。
- [**Firmware Validation**](/guides/firmware-validation): バイナリの整合性を検証するためのDartおよびPythonツールを使用する方法。

---

## JSONミニファイに関する注意

バイナリを監査する際、標準のPython Configuratorと比較してわずかなバイトオフセットに気づくかもしれません。これは**JSONミニファイ**によるものです。

Python Configuratorはコロンの後にスペースを挿入することがよくありますが（例： `{"uid": [1,2,3]}`）、ELRS Mobileは密なJSONを生成します（例： `{"uid":[1,2,3]}`）。ESP32の内部パーサーはこの空白を無視するため、どちらもハードウェア上では機能的に同一です。

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->