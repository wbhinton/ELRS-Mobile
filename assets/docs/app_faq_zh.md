# 操作指南

## 阶段 1：缓存固件
1. **连接到互联网：** 确保您的手机已连接到互联网（例如，家庭 WiFi 或移动网络）。
2. **打开固件管理器：** 在应用程序中导航到 Firmware Manager。
3. **下载发布版本：** 点击您所需 ExpressLRS 发布版本旁边的下载图标。这会将所需的固件目标和硬件定义安全地缓存到您的手机上，以便 100% 离线使用。

## 阶段 2：连接到您的设备
1. **设备开机：** 启动您的 ExpressLRS Receiver (RX) 或 Transmitter (TX)。
2. **等待热点：** 等待设备进入 Wi-Fi Hotspot 模式（由快速闪烁的 LED 指示）。
3. **连接到热点：** 使用密码 `expresslrs` 将手机的 Wi-Fi 连接到 `ExpressLRS RX` 或 `ExpressLRS TX` 网络。
* **注意：** ELRS Mobile 本机处理强制路由，确保您的手机不会悄悄切换回 5G/LTE。

## 阶段 3：刷写固件
1. **导航到刷写设备：** 从主 Dashboard 中，选择 **Flash Device**。
2. **目标选择：** 使用级联下拉菜单选择供应商和特定的硬件目标。
3. **版本选择：** 从您的离线仓库中选择一个可用的固件版本。
4. **配置与配置文件：** 选择或创建一个 **Flashing Profile**（例如，“My Quads”、“Race Spec”）来加载您的自定义凭据。应用程序会将 Wi-Fi SSID、Wi-Fi Password、Binding Phrase、Regulatory Domain 和 Auto-On intervals 保存在这些命名配置文件中，这样您在不同设置之间切换时就不必重新输入它们。
5. **构建与刷写：** 点击 **FLASH**。系统会用您的本地凭据修补二进制文件并上传。
* **关键：** 在拔下设备之前，务必等待成功确认并等待设备 LED 恢复闪烁！

---

# 常见问题

## 我刷写固件需要互联网连接或蜂窝服务吗？
不需要。ELRS Mobile 具有 **100% 离线刷写**功能。只要您之前在家中 Wi-Fi 下通过 Firmware Manager 下载了固件版本，应用程序就可以完全离线动态组装和刷写固件。

## Flashing Profiles 是什么以及如何使用它们？
Flashing Profiles 允许您保存和切换多个刷写配置（���如，“My Quads”、“Stock / Factory Reset”、“Race Spec”）。每个配置文件都安全地存储其自己的 binding phrase、Wi-Fi SSID、Wi-Fi password、regulatory domains 和 Wi-Fi auto-on interval。

如何使用它们：
1. 点击 **Configuration Options** 卡片中“Flashing Profile”下拉菜单旁边的 **+**（添加）图标。
2. 命名您的新配置文件并自定义设置。编辑会即时自动保存。
3. 从下拉菜单中选择任何配置文件以自动交换所有参数。
4. 要删除配置文件，请选中它并点击垃圾桶/删除图标（必须至少有两个配置文件才能删除一个）。

## 刷写我的 ESP8285 接收器时出现“空间不足”错误。
ESP8285 芯片（例如许多 AIO 板上的芯片）总共只有 1MB 的物理存储空间。通过 Wi-Fi 直接更新到主要版本（如从 3.x 到 4.x）可能会耗尽双分区空间，因为传入文件太大，无法与当前运行的固件一起解包。

**如何修复：** 首先，将您的接收器刷写到中间版本（如 **3.6.3**）。一旦它运行更精简的 3.6.3 固件，您将有足够的空间成功刷写到您想要的 4.0 目标。或者，在 Settings 中启用 **Expert Mode**，将构建的二进制文件本地保存，然后通过有线 Betaflight Passthrough 连接手动刷写。

## 我在哪里可以找��用于我的遥控器的 ExpressLRS Lua 脚本？
ELRS Mobile 内置了通用的、与版本无关的 Lua 脚本！要获取它：
1. 转到 **Settings** 并打开 **Expert Mode**。
2. 点击 **Export ELRS Lua Script**。
3. 这会将 `elrs.lua` 直接保存到您手机的本地存储中。打开您的遥控器并通过 USB 将其插入手机，请务必在遥控器上选择“USB Storage”模式，并使用手机的文件管理器将文件传输到您的 `SCRIPTS/TOOLS` 文件夹中。

**注意：** 在使用新脚本之前，您需要从遥控器的 SD 卡中删除任何以前版本的 elrs.lua 脚本（例如 elrs_v2.lua、elrs_v3.lua 等）。

## 如果刷写失败并且我的设备无响应怎么办？
如果您的设备在刷写失败后无响应，您可以轻松恢复它：
1. 在通过 USB 插入设备时按住设备上的 BOOT 按钮以进入 bootloader 模式。
2. 使用电脑和 ELRS Web Flasher 通过有线 USB/UART 连接重新刷写设备。
3. 对于支持 Wi-Fi 的设备，您也可以按住 BOOT

**注意：** Resources Tab 上有一个视频链接，展示了如何操作。

## 我可以不刷写固件，而是将其保存到我的手机吗？
可以。通过进入 **Settings** 并启用 **Expert Mode**，您将解锁直接将组装好的固件二进制文件保存到您的移动设备的本地存储，而不是立即进行 Over-The-Air (OTA) 刷写的功能。

如果您想使用专用的硬件编程器（如 STLink 或 FTDI 适配器）手动刷写设备，这尤其有用。

## 我收到“Target Mismatch”错误。我该怎么办？
当您在应用程序中选择的硬件目标与设备当前运行的固件目标不匹配时，会发生目标不匹配错误。

为了防止意外损坏，如果检测到不匹配，应用程序会警告您。但是，如果您确定所选目标是正确的（例如，如果您正在将设备转换为不同的固件变体或纠正以前不正确的刷写），您可以在不匹配对话框中点击 **FORCE FLASH** 以覆盖检查并继续刷写。

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->