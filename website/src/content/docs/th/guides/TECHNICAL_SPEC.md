---
title: "เอกสารข้อมูลทางเทคนิค"
slug: th/technical_spec
sidebar:
  order: 5
---

## ภาพรวมสถาปัตยกรรม

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">หลักการออกแบบ</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    แอปพลิเคชันนี้สร้างขึ้นโดยใช้ Flutter และใช้ประโยชน์จากเฟรมเวิร์กการจัดการสถานะ <strong>Riverpod</strong> โดยจะสื่อสารกับฮาร์ดแวร์ ELRS ผ่าน RESTful API ที่เปิดเผยโดยโมดูล WiFi ในอุปกรณ์ เพื่อให้มั่นใจถึงการสื่อสารที่มีความหน่วงต่ำและการซิงโครไนซ์สถานะแบบเรียลไทม์
  </p>
</div>

## ชั้นข้อมูล

### ปลายทาง API
ระบบสื่อสารกับฮาร์ดแวร์โดยใช้ปลายทาง HTTP ต่อไปนี้:

| เมธอด | ปลายทาง | คำอธิบาย |
| :--- | :--- | :--- |
| `GET` | `/config` | ดึ��การกำหนดค่าอุปกรณ์ปัจจุบันในรูปแบบ JSON |
| `POST` | `/options.json` | อัปเดตตัวเลือกที่สามารถแก้ไขได้ในขณะรันไทม์ (SSID, รหัสผ่าน, ฯลฯ) |
| `POST` | `/config` | อัปเดตพารามิเตอร์ฮาร์ดแวร์หลักและการแมป PWM |
| `POST` | `/reboot` | ทริกเกอร์การรีเซ็ตฮาร์ดแวร์เพื่อใช้การเปลี่ยนแปลง |

### แผนผัง JSON
โมเดล `RuntimeConfig` ใช้ประโยชน์จากโครงสร้าง ELRS 4.x ซึ่งแยกพารามิเตอร์ออกเป็นสามโหนดหลัก:
- `settings`: ตัวระบุฮาร์ดแวร์แบบอ่านอย่างเดียวและสตริงเวอร์ชัน
- `options`: การตั้งค่าผู้ใช้ที่สามารถแก้ไขได้และข้อมูลประจำตัวเครือข่าย
- `config`: การกำหนดค่าฮาร์ดแวร์ระดับต่ำ (โปรโตคอล, อาร์เรย์ PWM)

ตัวอย่างโครงสร้าง JSON:
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

## การจัดการสถานะ
ระบบใช้สถาปัตยกรรมแบบ Reactive:
- **`ConfigViewModel`**: จัดการสถานะการเชื่อมต่อแบบสด, ตรรกะ Heartbeat, และการค้นหา IP
- **`FlashingController`**: จัดการการดาวน์โหลดเฟิร์มแวร์, การแก้ไขไบนารีในเครื่อง, และกระบวนการอัปโหลด XH-over-HTTP

## ชั้นการแมป
`ElrsMappings.domains900` แมปดัชนีโดเมนกำกับดูแล 900 MHz ที่ใช้ใน API กับป้ายกำกับที่มนุษย์อ่านได้:

| ID | ป้ายกำกับ | คำอธิบาย |
| :--- | :--- | :--- |
| 0 | AU915 | ออสเตรเลีย/นิวซีแลนด์ 915MHz |
| 1 | FCC915 | อเมริกาเหนือ 915MHz |
| 2 | EU868 | ยุโรป 868MHz |
| 3 | IN866 | อินเดีย 866MHz |
| 4 | AU433 | ออสเตรเลีย 433MHz |
| 5 | EU433 | ยุโรป 433MHz |
| 6 | US433 | อเมริกาเหนือ 433MHz |
| 7 | US433-Wide | อเมริกาเหนือ Wide 433MHz |


## ชั้นความคงทน
ระบบใช้กลยุทธ์ความคงทนแบบสองชั้น:
- **`SharedPreferences`**: ใช้ผ่าน `PersistenceService` สำหรับข้อมูลที่ไม่ละเอียดอ่อน เช่น WiFi SSID และการตั้งค่าแอปทั่วไป
- **`FlutterSecureStorage`**: ใช้สำหรับข้อมูลที่ละเอียดอ่อน รวมถึง Binding Phrases และ WiFi Passwords เพื่อให้แน่ใจว่ามีการเข้ารหัสที่ระดับ OS

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->