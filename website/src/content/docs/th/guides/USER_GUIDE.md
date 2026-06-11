---
title: "คู่มือผู้ใช้"
slug: user_guide
sidebar:
  order: 1
---

## ภาพรวม
แอปพลิเคชันนี้มีอินเทอร์เฟซบนมือถือที่ครอบคลุมสำหรับการจัดการฮาร์ดแวร์ ExpressLRS ช่วยให้ผู้ใช้สามารถกำหนดค่าพารามิเตอร์ของตัวรับ (RX) และตัวส่ง (TX) กำหนดค่าเอาต์พุต PWM และแฟลชอัปเดตเฟิร์มแวร์ได้โดยตรงจากอุปกรณ์มือถือ

---

## การติดตั้ง

### App Stores อย่างเป็นทางการ

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
ติดตั้งจาก Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">ดาวน์โหลดบน Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
ติดตั้งจาก App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">ดาวน์โหลดบน App Store</a>

### การติดตั้งทางเลือก

#### GitHub Store
เหมาะสำหรับผู้ใช้ที่ต้องการประสบการณ์ App Store ทางเลือก

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">ดาวน์โหลดบน GitHub Store</a>

### การติดตั้ง��้วยตนเอง
สำหรับผู้ใช้ขั้นสูงหรือผู้ที่ต้องการจัดการด้วยตนเอง โปรดเยี่ยมชมหน้า [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) ของเราเพื่อดาวน์โหลดไฟล์ `.apk` ล่าสุด

---

## 🚀 เริ่มต้นอย่างรวดเร็ว: การแฟลชอุปกรณ์แรกของคุณ

### ขั้นตอนที่ 1: การแคชเฟิร์มแวร์ (ทำที่บ้าน)
1. เปิดแอปและไปที่ **Firmware Manager**
2. แตะไอคอนดาวน์โหลดข้างๆ รุ่นเสถียรล่าสุด
3. แอปจะดาวน์โหลดและแคชคำจำกัดความของเป้าหมายและฮาร์ดแวร์ที่จำเป็นอย่างปลอดภัยสำหรับการใช้งานแบบออฟไลน์

### ขั้นตอนที่ 2: การเชื่อมต่อกับอุปกรณ์ของคุณ
1. เปิดเครื่อง ExpressLRS Receiver (RX) หรือ Transmitter (TX) ของคุณ
2. รอ 60 วินาที (หรือช่วงเวลาที่คุณกำหนดค่าไว้) เพื่อให้อุปกรณ์เข้าสู่โหมด Wi-Fi Hotspot (ไฟ LED กระพริบเร็ว)
3. เชื่อมต่อ Wi-Fi ของโทรศัพท์ของคุณกับเครือข่าย **ExpressLRS RX** หรือ **ExpressLRS TX** (รหัสผ่าน: `expresslrs`)
4. เปิดแอป Dashboard จะสแกนเครือข่ายโดยอัตโนมัติโดยใช้ mDNS และเชื่อมต่อกับอุปกรณ์

### ขั้นตอนที่ 3: การแฟลชเฟิร์มแวร์
1. จาก Dashboard เลือก **Flash Device**
2. **เลือกฮาร์ดแวร์ของคุณ:** ใช้เมนูแบบเลื่อนลงแบบเรียงซ้อนเพื่อเลือก Device Type, Vendor, Frequency และ Target ของคุณ
3. **กำหนดค่าตัวเลือก:** ตั้งค่า Binding Phrase, Wi-Fi credentials และ Regulatory Domain แบบกำหนดเองของคุณ
4. แตะ **FLASH** แอปจะประกอบไบนารีในเครื่องและส่งไปยังอุปกรณ์

---

## รายละเอียดทางเทคนิค

### การเชื่อมต่อและการค้นหา
แอปใช้ลำดับการค้นหาหลายขั้นตอนที่แข็งแกร่งเพื่อค้นหาฮาร์ดแวร์ของคุณ:
1. **mDNS Resolution**: วิธีหลัก แอปจะสแกนหา `elrs_rx.local` หรือ `elrs_tx.local`
2. **Static AP Fallback**: หาก mDNS ถูกบล็อก แอปจะตรวจสอบ IP ของจุดเชื่อมต่อ ELRS อย่างเป็นทางการ (`10.0.0.1`)
3. **Manual IP Override**: สำหรับเครือข่ายที่ซับซ้อน คุณสามารถป้อนที่อยู่ IP ด้วยตนเองในการตั้งค่า

**Forced Network Binding**: สมาร์ทโฟนสมัยใหม่มักจะละทิ้งการเชื่อมต่อ Wi-Fi ที่ไม่มีอินเทอร์เน็ต ELRS Mobile มีเลเยอร์ "Forced Routing" ในตัวที่บังคับให้ OS ยึดติดก��บการเชื่อมต่อฮาร์ดแวร์ เพื่อให้มั่นใจว่าการค้นหาในภาคสนามเชื่อถือได้ 100%

---

## โหมดผู้เชี่ยวชาญและการตรวจสอบ
ภายในเมนู Settings ผู้ใช้สามารถเปิดใช้งาน **Expert Mode** ได้ ซึ่งช่วยให้คุณสามารถบันทึกไบนารีเฟิร์มแวร์ที่ประกอบแล้วลงในอุปกรณ์ของคุณโดยตรงเพื่อการตรวจสอบหรือแฟลชด้วยตนเองผ่าน FTDI

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">การจัดการฮาร์ดแวร์ STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    แม้ว่า ELRS Mobile จะสามารถประกอบและแพทช์เฟิร์มแวร์สำหรับเป้าหมาย STM32 ได้ (ถึง ELRS v3.x) แต่อุปกรณ์เหล่านี้ไม่รองรับการแฟลชแบบ Over-The-Air (OTA) ผ่าน Wi-Fi หากคุณเลือกเป้าหมาย STM32 แอปจะอนุญาตให้คุณสร้างและบันทึกไบนารีในเครื่อง เพื่อให้คุณสามารถแฟลชด้วยตนเองโดยใช้ PC ผ่าน STLink หรือ Betaflight Passthrough
  </p>
</div>

สำหรับนักพัฒนาที่ต้องการตรวจสอบความสมบูรณ์ของไบนารีเหล่านี้ โปรดดูที่ [**คู่มือการตรวจสอบเฟิร์มแวร์**](/guides/firmware-validation) ของเรา

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->