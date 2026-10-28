# 教程

## 阶段 1：缓存固件
1. **连接到互联网：** 确保您的手机已连接到互联网（例如，家庭 Wi-Fi 或移动网络）。
2. **打开固件管理器：** 在应用程序中导航到 Firmware Manager。
3. **下载版本：** 点击您所需 ExpressLRS release 旁边的下载图标。这会将所需的 firmware targets 和 hardware definitions 安全地缓存到您的手机上，以实现 100% 离线使用。

## 阶段 2：连接到您的设备
1. **开启设备电源：** 开启您的 ExpressLRS Receiver (RX) 或 Transmitter (TX) 的电源。
2. **等待热点：** 等待设备进入 Wi-Fi Hotspot Mode（由快速闪烁的 LED 指示）。
3. **连接到热点：** 使用密码 `expresslrs` 将您手机的 Wi-Fi 连接到 `ExpressLRS RX` 或 `ExpressLRS TX` 网络。
* **注意：** ELRS Mobile 本机处理强制路由，确保您的手机不会悄悄切换回 5G/LTE。

## 阶段 3：刷写固件
1. **导航到刷写设备：** 从主 Dashboard，选择 **Flash Device**。
2. **目标选择：** 使用级联下拉菜单选择 vendor 和特定的 hardware target。
3. **版本选择：** 从您的 offline repository 中选择一个可用的 firmware version。
4. **配置与配置文件：** 选择或创建一个 **Flashing Profile**（例如，“My Quads”、“Race Spec”）来加载您的 custom credentials。应用程序会将 Wi-Fi SSID、Wi-Fi Password、Binding Phrase、Regulatory Domain 和 Auto-On intervals 保存在这些命名 profiles 中，这样您在切换不同 setups 时就无需重新输入它们。
5. **构建与刷写：** 点击 **FLASH**。系统会使用您的 local credentials 修补 binary 并上传。
* **重要：** 在拔掉电源之前，务必等待 success confirmation 并且设备 LED 恢复闪烁！

---

# 常见问题

## 刷写固件需要互联网连接或蜂窝服务吗？
不需要。ELRS Mobile 具有 **100% 离线刷写** 功能。只要您之前在家用 Wi-Fi 环境下通过 Firmware Manager 下载了 firmware version，应用程序就可以完全离线地动态组装和刷写 firmware。

## 什么是 Flashing Profiles 以及如何使用它们？
Flashing Profiles 允许您保存和切换多个 flashing configurations（例如，“My Quads”、“Stock / Factory Reset”、“Race Spec”）。每个 profile 都安全地存储其自己的 binding phrase、Wi-Fi SSID、Wi-Fi password、regulatory domains 和 Wi-Fi auto-on interval。

如何使用它们：
1. 在 **Configuration Options** 卡中的“Flashing Profile”下拉菜单旁边，点击 **+** (添加) 图标。
2. 命名您的新 profile 并自定义 settings。编辑会即时 auto-saved。
3. 从下拉菜单中选择任何 profile 以自动 swap 所有 parameters。
4. 要删除一个 profile，请选择它并点击垃圾桶/删除图标（必须至少有两个 profile 才能删除一个）。

## 刷写我的 ESP8285 接收机时收到“空间不足”错误。
ESP8285 芯片（如许多 AIO 板上发现的）只有 1MB 的总物理存储空间。通过 Wi-Fi 直接更新到 major release（例如从 3.x 到 4.x）可能会耗尽 dual-partition space，因为传入文件太大，无法与当前运行的 firmware 一起 unpack。

**如何解决：** 首先，将您的 receiver 刷写到 intermediate version（例如 **3.6.3**）。一旦它运行了 leaner 3.6.3 firmware，您将有足够的 partition space 成功刷写到您所需的 4.0 target。或者，在 Settings 中启用 **Expert Mode**，将构建的 binary 本地保存，并通过有线 Betaflight Passthrough 连接手动刷写。

## 我的 radio 的 ExpressLRS Lua 脚本在哪里可以找到？
ELRS Mobile 内置了通用的、version-agnostic Lua script！要获取它：
1. 进入 **Settings** 并打开 **Expert Mode**。
2. 点击 **Export ELRS Lua Script**。
3. 这会将 `elrs.lua` 直接保存到您手机的 local storage。打开您的 radio 并通过 USB 将其插入您的手机，请务必在您的 radio 上选择“USB Storage”模式，并使用手机的文件管理器将文件传输到您的 `SCRIPTS/TOOLS` 文件夹中。

**注意：** 在使用新 script 之前，您需要从 radio 的 SD card 中删除任何以前版本的 elrs.lua script（例如 elrs_v2.lua、elrs_v3.lua 等）。

## 如果刷写失败，我的设备无响应怎么办？
如果您的设备在刷写失败后无响应，您可以轻松恢复它：
1. 在通过 USB 插入设备时按住设备上的 BOOT 按钮，以进入 bootloader mode。
2. 使用计算机和 ELRS Web Flasher 通过有线 USB/UART 连接重新刷写设备。
3. 对于支持 Wi-Fi 的设备，您也可以按住 BOOT

**注意：** 在 Resources Tab 上有一个视频链接展示了如何操作。

## 我可以将 firmware 文件保存到手机而不刷写它吗？
是的。通过进入 **Settings** 并启用 **Expert Mode**，您将解锁将组装好的 firmware binary 直接保存到您的 mobile device 的 local storage，而不是立即通过 Over-The-Air (OTA) 刷写它。

这在您希望使用专用 hardware programmer（例如 STLink 或 FTDI adapter）手动刷写设备时特别有用。

## 我收到“Target Mismatch”错误。我该怎么办？
当您在应用程序中选择的 hardware target 与设备上当前运行的 firmware 的 target 不匹配时，就会发生 target mismatch 错误。

为了防止 accidental damage，如果检测到 mismatch，应用程序将警告您。但是，如果您确定所选的 target 是正确的（例如，如果您正在将设备转换为不同的 firmware variant 或纠正之前 incorrect flash），您可以在 mismatch dialog 中点击 **FORCE FLASH** 以 override the check 并proceed with the flash。

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->