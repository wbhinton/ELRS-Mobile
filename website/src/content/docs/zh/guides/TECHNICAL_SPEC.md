---
title: "技术规格"
slug: zh/technical_spec
sidebar:
  order: 5
---

## 架构概述

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">设计原则</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    该应用程序使用 Flutter 构建，并利用 <strong>Riverpod</strong> 状态管理框架。它通过设备板载 WiFi 模块暴露的 RESTful API 与 ELRS 硬件交互，确保低延迟通信和实时状态同步。
  </p>
</div>

## 数据层

### API 端点
系统使用以下 HTTP 端点与硬件通信：

| 方法 | 端点 | 描述 |
| :--- | :--- | :--- |
| `GET` | `/config` | 以 JSON 格式检索当前设备配置。 |
| `POST` | `/options.json` | 更新可修改的运行时选项（例如 WiFi SSID、Password 等）。 |
| `POST` | `/config` | 更新核心硬件参数和 PWM 映射。 |
| `POST` | `/reboot` | 触发硬件重置以应用更改。 |

### JSON 模式
`RuntimeConfig` 模型利用 ELRS 4.x 结构，将参数分为三个主要节点：
- `settings`：只读硬件标识符和版本字符串。
- `options`：可修改的用户偏好设置和网络凭据。
- `config`：低级硬件配置（协议，PWM 阵列）。

JSON 结构示例：
```json
{
  "product_name": "Test RX",
  "settings": {
    "version": "1.0.0",
    "module-type": "RX"
  },
  "options": {
    "bindPhrase": "example",
    "wifi-ssid": "SSID",
    "domain": 1
  },
  "config": {
    "serial-protocol": 0,
    "pwm": [
      {"channel": 0, "mode": 5}
    ]
  }
}
```

## 状态管理
该系统采用响应式架构：
- **`ConfigViewModel`**：管理实时连接状态、心跳逻辑和 IP 发现。
- **`DeviceEditorViewModel`**：包含设备配置的草稿状态，支持多步编辑和最终的“保存/取消”逻辑。
- **`FlashingController`**：协调固件下载、本地二进制修补和 XH-over-HTTP 上传过程。

## 映射层
下表定义了 API 中使用的整数标识符及其人类可读等效项之间的映射。

### 监管区域
| ID | 标签 | 描述 |
| :--- | :--- | :--- |
| 0 | AU915 | 澳大利亚/新西兰 915MHz |
| 1 | FCC915 | 北美 915MHz |
| 2 | EU868 | 欧洲 868MHz |
| 3 | IN866 | 印度 866MHz |
| 4 | AU433 | 澳大利亚 433MHz |
| 5 | EU433 | 欧洲 433MHz |
| 6 | US433 | 北美 433MHz |
| 7 | US433-Wide | 北美宽频 433MHz |


## 高级映射

### VBind (绑定存储)
决定绑定短语在设备上的存储方式。
- **0: Persistent**：保存到闪存（标准）。
- **1: Volatile**：断电后清除。
- **2: Returnable**：用于借用设备。
- **3: Administered**：用于多飞行员机队环境。


## 持久化层
该系统实现双层持久化策略：
- **`SharedPreferences`**：通过 `PersistenceService` 用于非敏感数据，例如 WiFi SSIDs 和一般应用偏好设置。
- **`FlutterSecureStorage`**：用于敏感数据，包括 Binding Phrases 和 WiFi Passwords，确保操作系统级别的加密。

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->