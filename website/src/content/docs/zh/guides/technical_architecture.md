---
title: "技术架构"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile 不仅仅是一个 web-wrapper；它是 ExpressLRS 编译和配置管道的原生 Dart 实现。

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">统一固件组装</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    应用程序不会依赖远程云编译器，而是会在您的设备上本地动态构建二进制文件。在烧录 ESP32/ESP8285 目标时，<code>FirmwareAssembler</code> 会执行精确的比特级修改序列：
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">从缓存的 <code>firmware.zip</code> 存档中提取基本通用固件。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">通过寻找 ESP <code>0xE9</code> 魔术字节签名来修剪基础填充。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">从 <code>hardware.json</code> 中提取特定的目标引脚排列和运行时配置。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">将产品名称 (128b)、Lua 名称 (16b)、<code>options.json</code> (512b) 和 <code>hardware.json</code> (2048b) 直接字节打包到二进制流中。</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">如果目标平台（例如 ESP8285 传统）需要，则将最终负载压缩为 <code>.gz</code> 流。</p>
    </div>
  </div>
</div>

## 外设逻辑

### 监管域注入器
应用程序能准确处理频段之间复杂的差异。对于 900MHz/双频设备，它会将您选择的域（例如 FCC, EU868）主动注入到编译后的 JSON 负载中。对于标准 2.4GHz 目标，它会利用一个布尔标志，在组装过程中将提取过程静默路由到标准 FCC/ 或欧洲 LBT/ 基本固件文件夹。

### 固件缓存与同步
强大的本地缓存系统使得离线烧录成为可能。当用户通过固件管理器下载发布时，`FirmwareCacheService` 会直接从 ExpressLRS Artifactory 拉取通用 `firmware.zip` 和设备特定的 `hardware.zip`。这些存档在设备上进行本地管理和存储，确保在现场无需任何活跃互联网连接即可立即进行组装和烧录。

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">原生网络绑定</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    移动操作系统（尤其是 Android 和 iOS）会降低缺乏互联网访问的 Wi-Fi 连接的优先级，而是静默地通过蜂窝网络路由流量。这会阻止标准应用程序访问位于 <code>10.0.0.1</code> 的 ELRS 硬件。
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile 通过 <code>NativeNetworkService</code> 解决了这个问题。当检测到硬件连接时，应用程序会调用一个特定于平台的 <code>MethodChannel</code>，在操作系统内核级别将整个 Flutter 进程绑定到 Wi-Fi 接口。这确保了所有 HTTP 和 mDNS ���量都能正确路由到硬件，无论蜂窝网络状态如何。
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->