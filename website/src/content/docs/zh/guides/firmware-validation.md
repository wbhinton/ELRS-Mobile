---
title: "固件验证工具"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: zh/firmware-validation
sidebar:
  order: 3
---

本指南详细介绍了用于根据官方“黄金”二进制文件验证 ELRS Mobile 应用程序固件组装逻辑的内部工具。

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Ground Truth 与 Configurator 二进制文件</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    在运行验证审计时，您可能会注意到 ELRS Mobile 生成的二进制文件与官方 <strong>ExpressLRS Web Flasher</strong> 完美匹配，但与使用本地 <strong>ExpressLRS Configurator (Python)</strong> 构建的二进制文件略有不同。
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    这是预期行为。ESP32 的内部 C++ JSON parser 会忽略空格，这意味着尽管由于缩小差异导致严格的逐字节 SHA256 比较失败，但这两个二进制文件在硬件上执行时是相同的。
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**位置：** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator 是一个高性能的位级比较工具。它旨在验证 ELRS Mobile 的内部修补和组装逻辑与官方 ExpressLRS 逻辑一致。

### 主要功能
-   **位级分析**：精确定位不一致字节内的确切位偏移失败。
-   **交互式选择**：��出在 `firmware_testing/binaries/` 中找到的所有二进制文件。
-   **零拷贝内存管理**：针对大型固件文件的高速分析进行了优化。

### 使用方法
1.  **准备二进制文件**：将生成的 `.bin` 或 `.gz` 文件放入 `firmware_testing/binaries/` 中。
2.  **设置与运行**：
    ```bash
    cd firmware_testing/scripts/dart/
    dart pub get
    dart run logic_validator.dart
    ```

---

## 2. Ground Truth Auditor (Python)
**位置：** `firmware_testing/scripts/python/audit_tool.py`

Auditor 是一个独立的、零依赖的脚本，旨在用于“Ground Truth”验证。它解析附加到每个 ExpressLRS 固件镜像末尾的 2704 字节配置块。

### 目的
它验证实际烧录到设备的元数据（Product Name、Lua Name、Hardware Layout 和 Options）是否正确，无论基础固件代码中存在任何布局差异。

### 使用方法
1.  **直接运行**：
    ```bash
    python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
    ```

---

## 3. 二进制文件交叉验证工作流
为确保 ELRS Mobile 正确组装固件，开发人员应定期对在 PC 上编译的“Ground Truth”二进制文件进行交叉验证审计。

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">从 ELRS Mobile 导出二进制文件</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">在“设置”中启用 <strong>专家模式</strong>，然后在“刷写器”选项卡中配置目标和选项后使用 <strong>下载二进制文件</strong> 按钮。</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">生成 PC Ground Truth</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">在您的 PC 上使用官方 ExpressLRS Configurator 构建 <strong>完全相同</strong> 的目标和版本，并使用相同的选项。</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">运行审计</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">将两个二进制文件放入 `firmware_testing/binaries/` 中，并运行 `audit_tool.py` 脚本以验证硬件和选项的完美一致性。</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->