---
title: "เครื่องมือตรวจสอบความถูกต้องของเฟิร์มแวร์"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: th/firmware-validation
sidebar:
  order: 3
---

คู่มือนี้จะให้รายละเอียดเกี่ยวกับเครื่องมือภายในที่ใช้ในการตรวจสอบความถูกต้องของตรรกะการประกอบเฟิร์มแวร์ของแอปพลิเคชัน ELRS Mobile โดยเทียบกับ "Golden" binaries อย่างเป็นทางการ

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">ความจริงหลัก (Ground Truth) เทียบกับ Configurator Binaries</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    เมื่อทำการตรวจสอบความถูกต้อง คุณอาจสังเกตเห็นว่าไบนารีที่สร้างโดย ELRS Mobile ตรงกับ <strong>ExpressLRS Web Flasher</strong> อย่างเป็นทางการอย่างสมบูรณ์แบบ แต่แตกต่างกันเล็กน้อยจากไบนารีที่สร้างโดยใช้ <strong>ExpressLRS Configurator (Python)</strong> ในเครื่อง
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    นี่คือพฤติกรรมที่คาดไว้ C++ JSON parser ภายในของ ESP32 จะไม่สนใจช่องว่าง ซึ่งหมายความว่าไบนารีทั้งสองจะทำงานเหมือนกันบนฮาร์ดแวร์ แม้ว่าจะไม่ผ่านการเปรียบเทียบ SHA256 แบบไบต์ต่อไบต์อย่างเคร่งครัด เนื่องจากความแตกต่างในการย่อขนาด
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**ที่ตั้ง:** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator เป็นเครื่องมือเปรียบเทียบระดับบิตประสิทธิภาพสูง ออกแบบมาเพื่อตรวจสอบว่าตรรกะการแพตช์และการประกอบภายในของ ELRS Mobile สะท้อนถึงตรรกะ ExpressLRS อย่างเป็นทางการ

### คุณสมบัติหลัก
- **การวิเคราะห์ระดับบิต**: ระบุตำแหน่งบิตที่ผิดพลาดภายในไบต์ที่ไม่ตรงกันได้อย่างแม่นยำ
- **การเลือกแบบโต้ตอบ**: แสดงรายการไบนารีทั้งหมดที่พบใน `firmware_testing/binaries/`
- **การจัดการหน่วยความจำแบบ Zero-Copy**: ปรับให้เหมาะสมสำหรับการวิเคราะห์ไฟล์เฟิร์มแวร์ขนาดใหญ่ด้วยความเร็วสูง

### วิธีใช้งาน
1.  **เตรียมไบนารี**: วางไฟล์ `.bin` หรือ `.gz` ที่สร้างขึ้นใน `firmware_testing/binaries/`
2.  **ตั้งค่าและเรียกใช้**:
    ```bash
    cd firmware_testing/scripts/dart/
    dart pub get
    dart run logic_validator.dart
    ```

---

## 2. Ground Truth Auditor (Python)
**ที่ตั้ง:** `firmware_testing/scripts/python/audit_tool.py`

Auditor เป็นสคริปต์แบบสแตนด์อโลนที่ไม่มีการพึ่งพาใดๆ ซึ่งมีวัตถุประสงค์เพื่อการต��วจสอบ "Ground Truth" โดยจะแยกวิเคราะห์บล็อกการกำหนดค่าขนาด 2704 ไบต์ที่ต่อท้ายไฟล์ภาพเฟิร์มแวร์ ExpressLRS ทุกไฟล์

### วัตถุประสงค์
เป็นการตรวจสอบว่าเมตาดาต้าที่แฟลชลงบนอุปกรณ์จริง (Product Name, Lua Name, Hardware Layout, และ Options) ถูกต้องหรือไม่ โดยไม่คำนึงถึงความแตกต่างของโครงสร้างในโค้ดเฟิร์มแวร์พื้นฐาน

### วิธีใช้งาน
1.  **เรียกใช้โดยตรง**:
    ```bash
    python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
    ```

---

## 3. ขั้นตอนการตรวจสอบความถูกต้องแบบ Binary Cross-Validation
เพื่อให้แน่ใจว่า ELRS Mobile ประกอบเฟิร์มแวร์ได้อย่างถูกต้อง นักพัฒนาควรทำการตรวจสอบ Cross-validation เป็นระยะ โดยเทียบกับ��บนารี "Ground Truth" ที่คอมไพล์บน PC

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">ส่งออกไบนารีจาก ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">เปิดใช้งาน <strong>Expert Mode</strong> ใน Settings จากนั้นใช้ปุ่ม <strong>DOWNLOAD BINARY</strong> ในแท็บ Flasher หลังจากกำหนดค่าเป้าหมายและตัวเลือกของคุณ</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">สร้าง PC Ground Truth</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">สร้างเป้าหมายและเวอร์ชัน <strong>เดียวกันเป๊ะ</strong> พร้อมตัวเลือกที่เหมือนกัน โดยใช้ ExpressLRS Configurator อย่างเป็นทางการบน PC ของคุณ</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">เรียกใช้การตรวจสอบ</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">วางไบนารีทั้งสองใน <code>firmware_testing/binaries/</code> และเรียกใช้สคริปต์ <code>audit_tool.py</code> เพื่อตรวจสอบความเท่าเทียมกันของฮาร์ดแวร์และตัวเลือกที่สมบูรณ์แบบ</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->