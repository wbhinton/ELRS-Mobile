---
title: "技術アーキテクチャ"
slug: ja/technical_architecture
sidebar:
  order: 6
---

ELRS Mobileは単なるウェブラッパーではなく、ExpressLRSコンパイルおよび設定パイプラインのネイティブDart実装です。

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">統合ファームウェアアセンブリ</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    リモートのクラウドコンパイラに依存する代わりに、アプリはデバイス上でローカルにバイナリを動的にビルドします。ESP32/ESP8285ターゲットをフラッシュする際、<code>FirmwareAssembler</code>は精密なビットレベルの修正シーケンスを実行します。
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">キャッシュされた<code>firmware.zip</code>アーカイブから汎用ベースファームウェアを抽出します。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">ESP <code>0xE9</code>マジックバイトシグネチャを探索することで、ベースパディングをトリムします。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">特定のターゲットピン配列とランタイム設定を<code>hardware.json</code>から抽出します。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">製品名 (128b)、Lua名 (16b)、<code>options.json</code> (512b)、および<code>hardware.json</code> (2048b) をバイナリストリームに直接バイト単位でパッキングします。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">ターゲットプラットフォームが必要とする場合 (例: ESP8285レガシー)、最終ペイロードを<code>.gz</code>ストリームに圧縮します。</p>
    </div>
  </div>
</div>

## 周辺ロジック

### 規制ドメインインジェクター
アプリは、周波数帯間の複雑な違いを正確に処理します。900MHz/デュアルバンドデバイスの場合、選択されたドメイン (例: FCC, EU868) をコンパイルされたJSONペイロードにアクティブに注入します。標準の2.4GHzターゲットの場合、ブール値フラグを使用して、アセンブリ中に抽出プロセスを標準のFCC/またはヨーロッパのLBT/ベースファームウェ���フォルダのいずれかにサイレントにルーティングします。

### ファームウェアのキャッシュと同期
堅牢なローカルキャッシュシステムにより、オフラインでのフラッシュが可能になります。ユーザーがファームウェアマネージャー経由でリリースをダウンロードすると、`FirmwareCacheService`は汎用`firmware.zip`とデバイス固有の`hardware.zip`をExpressLRS Artifactoryから直接プルします。これらのアーカイブはデバイス上でローカルに管理および保存され、アクティブなインターネット接続なしに、現場で即座にアセンブリとフラッシュが可能になることが保証されます。

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">ネイティブネットワークバインディング</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    モバイルオペレーティングシステム (特にAndroidとiOS) は、インターネットアクセスがないWi-Fi接続の優先度を下げ、代わりにサイレントにセルラー経由でトラフィックをルーティングします。これにより、標準アプリが<code>10.0.0.1</code>のELRSハードウェアにアクセスできなくなります。
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobileは、<code>NativeNetworkService</code>を介してこれを解決します。ハードウェア接続が検出されると、アプリはプラットフォーム固有の<code>MethodChannel</code>を呼び出して、OSカーネルレベルでFlutterプロセス全体をWi-Fiインターフェースにバインドします。これにより、セルラーの状態に関係なく、すべてのHTTPおよびmDNSトラフィックがハードウェアに正しくルーティングされることが保証されます。
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->