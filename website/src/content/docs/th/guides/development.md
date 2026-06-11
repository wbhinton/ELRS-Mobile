---
title: "คู่มือการพัฒนา"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: development
sidebar:
  order: 2
---

ยินดีต้อนรับสู่คู่มือการพัฒนา ELRS Mobile! โปรเจกต์นี้เป็นการนำ Flutter มาใช้ในการสร้าง ExpressLRS compilation และ flashing pipeline ซึ่งออกแบบมาให้ทำงานแบบออฟไลน์ได้อย่างสมบูรณ์

## สิ่งที่ต้องมีก่อนเริ่ม
ในการร่วมพัฒนาโปรเจกต์นี้ คุณจะต้องติดตั้งเครื่องมือดังต่อไปนี้:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## เริ่มต้นใช้งาน

1. **โคลน repository**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **ติดตั้ง dependencies**:
   ```bash
   flutter pub get
   ```

3. **เรียกใช้งานแอปพลิเคชัน**:
   ```bash
   # สำหรับ Android
   flutter run
   
   # สำหรับ iOS (ต้องใช้ Mac และอุปกรณ์จริง/simulator)
   flutter run
   ```

---

## สถาปัตยกรรมโปรเจกต์
โค้ดเบสนี้ใช้โครงสร้างแบบ feature-first ซึ่งอยู่ใน `lib/src/`

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      คุณสมบัติ
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">ตรรกะหลักและ UI สำหรับ flashing pipeline</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">จัดการการดาวน์โหลดและแคช firmware จาก artifactory</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">UI สำหรับการตั้งค่าตัวเลือกผู้ใช้ เช่น Binding Phrases และ WiFi</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      แกนหลัก
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">ตรรกะเฉพาะแพลตฟอร์มสำหรับการผูก process เข้ากับฮอตสปอตของฮาร์ดแวร์</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">การจัดการแคชภายในและการคงอยู่ของข้อมูลด้วย SQLite</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">การตรวจสอบที่เน้นความเป็นส่วนตัวเป็นอันดับแรก (Sentry และ Aptabase)</span>
      </li>
    </ul>
  </div>
</div>

---

## การจัดการสถานะ
เราใช้ **Riverpod** สำหรับการจัดการสถานะแบบ global และ **Flutter Hooks** สำหรับสถานะระดับ widget ในท้องถิ่น การผสมผสานนี้ทำให้มั่นใจได้ถึง UI ที่ตอบสนองสูง โดยไม่ต้องมี boilerplate ของ `StatefulWidgets` มาตรฐาน

---

## เจาะลึก

สำหรับข้อมูลทางเทคนิคโดยละเอียดเพิ่มเติม โปรดดูคู่มือต่อไปนี้:

- [**สถาปัตยกรรมทางเทคนิค**](/guides/technical_architecture): เจาะลึก `FirmwareAssembler` และ native networking stack
- [**การตรวจสอบ Firmware**](/guides/firmware-validation): วิธีใช้เครื่องมือ Dart และ Python เพื่อยืนยันความสมบูรณ์ของไบนารี

---

## หมายเหตุเกี่ยวกับการย่อขนาด JSON

เมื่อตรวจสอบไบนารี คุณอาจสังเกตเห็นการเยื้องไบต์เล็กน้อยเมื่อเทียบกับ Python Configurator มาตรฐาน นี่เป็นเพราะ **การย่อขนาด JSON**

Python Configurator มักจะแทรกช่องว่างหลังเครื่องหมายโคลอน (เช่น `{"uid": [1,2,3]}`) ในขณะที่ ELRS Mobile สร้าง JSON ที่หนาแน่นกว่า (เช่น `{"uid":[1,2,3]}`) ทั้งสองแบบทำงานได้เหมือนกันบนฮาร์ดแวร์ เนื่องจากตัวแยกวิเคราะห์ภายในของ ESP32 จะละเว้นช่องว่างเหล่านี้

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->