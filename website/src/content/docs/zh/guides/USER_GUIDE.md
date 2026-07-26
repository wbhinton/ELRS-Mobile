---
title: "用户指南"
slug: zh/user_guide
sidebar:
  order: 1
---

## 概述
本应用程序提供了一个全面的移动界面，用于管理 ExpressLRS 硬件。它使用户能够直接通过移动设备配置接收器 (RX) 和发射器 (TX) 参数、映射 PWM 输出以及刷写固件更新。

---

## 安装

### 官方应用商店

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
从 Google Play 安装

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">在 Google Play 获取</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
从 App Store 安装

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">在 App Store 下载</a>

### 其他安装方式

#### GitHub Store
适合偏好其他应用商店体验的用户。

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">在 GitHub Store 下载</a>

### 手动安装
对于高级用户或偏好手动管理的用户，请访问我们的 [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) 页面获取最新的 `.apk` 文件。

---

## 🚀 快速开始：刷写您的第一个设备

### 阶段 1：缓存固件 (在家中完成此步骤)
1. 打开应用程序并导航到 **固件管理器**。
2. 点击最新稳定版本旁边的下载图标。
3. 应用程序将下载并安全缓存所需的 Target 和 Hardware 定义，以供离线使用。

### 阶段 2：连接到您的设备
1. 为您的 ExpressLRS 接收器 (RX) 或发射器 (TX) 上电。
2. 等待 60 秒（或您配置的间隔），直到设备进入 Wi-Fi 热点模式（LED 快速闪烁）。
3. 将您的手机 Wi-Fi 连接到 **ExpressLRS RX** 或 **ExpressLRS TX** 网络（密码：`expresslrs`）。
4. 打开应用程序。仪表板将使用 mDNS 自动扫描网络并连接到设备。

### 阶段 3：刷写固件
1. 在仪表板中，选择 **刷写设备**。
2. **选择您的硬件：** 使用级联下拉菜单选择您的 Device Type、Vendor、Frequency 和 Target。
3. **配置选项和配置文件：** 选择一个 **刷写配置文件**（或点击 **+** 按钮添加一个新的命名配置文件）以加载您的凭据。自定义 Binding Phrase、Wi-Fi SSID、Wi-Fi password、regulatory domains 和 Wi-Fi auto-on interval。
4. 点击 **FLASH**。应用程序将在本地组装二进制文件并将其推送到设备。

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">目标不匹配警告</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    如果应用程序检测到您选择的硬件目标与连接的设备不匹配，它将发出警告以防止意外损坏。如果您确定选择了正确的 Target（例如从错误的刷写中恢复或在 Target 定义之间迁移），请在警告对话框中点击 <strong>强制刷写</strong> 以绕过检查。
  </p>
</div>

### 📋 管理刷写配置文件
如果您有多个具有不同配置要求（例如，不同的 Binding Phrase 或 regulatory domains）的无人机或无线电设置，您可以使用命名 **刷写配置文件** 来保存和切换配置：
* **添加配置文件**：点击“刷写配置文件”下拉菜单旁边的 **+** 图标，输入名称，然后点击添加。
* **自动保存**：对活动配置文件的凭据（Binding Phrase、SSID、password、domain 或 interval）的任何更改都会实时自动保存。
* **切换配置文件**：只需从下拉菜单中选择一个配置文件，即可立即加载其存储的设置��
* **删除配置文件**：要进行清理，请从下拉菜单中选择配置文件，然后点击垃圾桶/删除图标（您必须至少有两个配置文件才能删除一个）。

---

## 技术细节

### 连接和发现
该应用程序使用强大的多阶段发现序列来查找您的硬件：
1. **mDNS 解析**：主要方法。应用程序扫描 `elrs_rx.local` 或 `elrs_tx.local`。
2. **静态 AP 回退**：如果 mDNS 被阻止，应用程序会检查官方 ELRS 接入点 IP (`10.0.0.1`)。
3. **手动 IP 覆盖**：对于复杂的网络，您可以在设置中手动输入 IP 地址。

**强制网络绑定**：现代智能手机通常会丢弃没有互联网的 Wi-Fi 连接。ELRS Mobile 包含一个原生的“强制路由”层，强制操作系统保持与硬件的连接，确保现场 100% 可靠的发现。

---

## 专家模式和审计
在设置菜单中，用户可以启用 **专家模式**。这允许您将组装好的固件二进制文件直接保存到您的设备，以便通过 FTDI 进行审计或手动刷写。

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 硬件处理</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    虽然 ELRS Mobile 可以为 STM32 Target 组装和修补固件（最高支持 ELRS v3.x），但这些设备不支持通过 Wi-Fi 进行 Over-The-Air (OTA) 刷写。如果您选择 STM32 Target，应用程序将允许您在本地构建和保存二进制文件，以便您可以使用 PC 通过 STLink 或 Betaflight Passthrough 手动刷写。
  </p>
</div>

希望验证这些二进制文件完整性的开发者，请参阅我们的 [**固件验证指南**](/guides/firmware-validation)。

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->