# 演练

## 阶段 1：缓存固件
1. **连接到互联网：** 确保您的手机已连接到互联网（例如家庭 Wi-Fi 或移动网络）。
2. **打开固件管理器：** 在应用程序中导航到固件管理器。
3. **下载版本：** 点击所需 ExpressLRS 版本旁边的下载图标。这会将所需的 firmware targets 和 hardware definitions 安全地缓存在您的手机上，以便 100% 离线使用。

## 阶段 2：连接到您的设备
1. **开启设备电源：** 开启您的 ExpressLRS Receiver (RX) 或 Transmitter (TX) 的电源。
2. **等待热点：** 等待设备进入 Wi-Fi Hotspot Mode（通过 LED 快速闪烁指示）。
3. **连接到热点：** 使用密码 `expresslrs` 将您手机的 Wi-Fi 连接到 `ExpressLRS RX` 或 `ExpressLRS TX` 网络。
* **注意���** ELRS Mobile 原生处理强制路由，确保您的手机不会悄悄切换回 5G/LTE。

## 阶段 3：刷写固件
1. **导航到刷写设备：** 从主 Dashboard 中，选择 **Flash Device**。
2. **目标选择：** 使用级联下拉菜单选择 vendor 和特定的 hardware target。
3. **版本选择：** 从您的离线 repository 中选择一个可用的 firmware version。
4. **配置：** 输入您的自定义 credentials。应用程序会将 WiFi SSID、WiFi Password 和 Binding Phrase 保存在 local storage 中，这样您就不必重新输入它们。
5. **构建并刷写：** 点击 **FLASH**。系统会用您的本地 credentials 打补丁 binary 并上传。
* **关键：** 务必等待成功确认并且设备 LED 恢复闪烁后再拔下！

---

# 常见问题

## 我需要互联网连接或蜂窝服务来刷写固件吗？
不需要。ELRS Mobile 具有 **100% 离线刷写**功能。只要您之前在家用 Wi-Fi 上通过 Firmware Manager 下载过 firmware version，该应用程序就可以完全离线地动态组装和刷写固件。

## 当我刷写我的 ESP8285 接收器时，出现“空间不足”错误。
ESP8285 chips（例如许多 AIO boards 上发现的）总共只有 1MB 的物理存储空间。通过 Wi-Fi 直接更新到主要版本（例如从 3.x 到 4.x）可能会耗尽 dual-partition 空间，因为传入文件太大，无法与当前运行的固件一起解压。

**如何修复：** 首先，将您的接收器刷写到 intermediate version（例如 **3.6.3**）。一旦它运行了更精简的 3.6.3 firmware，您将有足够的 partition space 成功刷写到您所需的 4.0 target。或者，在 Settings 中启用 **Expert Mode**，将构建的 binary 保存到本地，并通过有线 Betaflight Passthrough connection 手动刷写。

## 我在哪里可以找到我的 radio 的 ExpressLRS Lua script？
ELRS Mobile 内置了通用的、version-agnostic 的 Lua script！要获取它：
1. 转到 **Settings** 并打开 **Expert Mode**。
2. 点击 **Export ELRS Lua Script**。
3. 这会将 `elrs.lua` 直接保存到您手机的 local storage 中。打开您的 radio 并通过 USB 将其插入您的手机，请务必在您的 radio 上选择“USB Storage”模式，并使用您手机的文件管理器将文件传输到您的 `SCRIPTS/TOOLS` 文件夹中。

**注意：** 在使用新 script 之前，您需要从 radio 的 SD 卡中删除任何以前版本的 elrs.lua script（例如 elrs_v2.lua、elrs_v3.lua 等）。

## 如果刷写失败，我的设备变得无响应怎么办？
如果您的设备在刷写失败后无响应，您可以轻松恢复它：
1. 在通过 USB 插入设备时按住设备上的 BOOT button，以进入 bootloader mode。
2. 使用计算机和 ELRS Web Flasher 通过有线 USB/UART connection 重新刷写设备。
3. 对于支持 Wi-Fi 的设备，您也可以按住 BOOT

**注意：** Resources Tab 上有一个视频链接显示了如何操作。

## 我可以将 firmware 文件保存到我的手机而不刷写它吗？
是的。通过进入 **Settings** 并启用 **Expert Mode**，您将解锁将组装好的 firmware binary 直接保存到移动设备的 local storage 的能力，而不是立即通过 Over-The-Air (OTA) 进行刷写。

如果您想使用专用的 hardware programmer（例如 STLink 或 FTDI adapter）手动刷写设备，这尤其有用。

## 我收到“Target Mismatch”错误。我该怎么办？
当您在应用程序中选择的 hardware target 与设备上当前运行的 firmware target 不匹配时，会发生 target mismatch 错误。

目前，该应用程序不支持刷写与设备上当前运行的 target 不同的 target。

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->