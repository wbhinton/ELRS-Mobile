---
title: "开发指南"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: zh/development
sidebar:
  order: 2
---

欢迎来到 ELRS Mobile 开发指南！本项目是 ExpressLRS 编译和烧录流程的原生 Flutter 实现，旨在完全离线工作。

## 先决条件
要为本项目做出贡献，您需要安装以下工具：

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK（稳定版）</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## 开始

1. **克隆仓库**：
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **安装依赖**：
   ```bash
   flutter pub get
   ```

3. **运行应用程序**：
   ```bash
   # 适用于 Android
   flutter run
   
   # 适用于 iOS（需要 Mac 和实体设备/模拟器）
   flutter run
   ```

---

## 项目架构
代码库遵循功能优先的结构，位于 `lib/src/`。

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      功能
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">烧录流程的核心逻辑和用户界面。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">处理从制品库下载和缓存固件。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">用于设置用户选项（如 Binding Phrases 和 WiFi）的用户界面。</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      核心
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">用于进程绑定到硬件热点的平台特定逻辑。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">本地缓存管理和 SQLite 持久化。</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">隐私优先的可观测性（Sentry 和 Aptabase）。</span>
      </li>
    </ul>
  </div>
</div>

---

## 状态管理
我们使用 **Riverpod** 进行全局状态管理，并使用 **Flutter Hooks** 进行局部小部件级状态管理。这种组合确保了高度响应式的用户界面，同时避免了标准 `StatefulWidgets` 的样板代码。

---

## 深入探讨

如需更详细的技术信息，请参阅以下指南：

- [**技术架构**](/guides/technical_architecture)：深入探讨 `FirmwareAssembler` 和原生网络堆栈。
- [**固件验证**](/guides/firmware-validation)：如何使用 Dart 和 Python 工具验证二进制文件的完整性。

---

## 关于 JSON 最小化的注意事项

在审计二进制文件时，您可能会注意到与标准 Python Configurator 相比存在细微的字节偏移。这是由于 **JSON 最小化**造成的。

Python Configurator 通常在冒号后注入空格（例如，`{"uid": [1,2,3]}`），而 ELRS Mobile 则生成紧凑的 JSON（例如，`{"uid":[1,2,3]}`）。两者在硬件功能上是相同的，因为 ESP32 的内部解析器会忽略这些空格。

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->