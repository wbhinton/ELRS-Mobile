---
title: "สถาปัตยกรรมทางเทคนิค"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile ไม่ใช่แค่ web-wrapper; แต่เป็นการใช้งาน Dart แบบเนทีฟของไปป์ไลน์การคอมไพล์และการกำหนดค่า ExpressLRS

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">การประกอบเฟิร์มแวร์แบบรวมศูนย์</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    แทนที่จะพึ่งพาคอมไพเลอร์คลาวด์ระยะไกล แอปจะสร้างไบนารีบนอุปกรณ์ของคุณแบบไดนามิกในเครื่อง เมื่อทำการแฟลชเป้าหมาย ESP32/ESP8285 <code>FirmwareAssembler</code> จะดำเนินการลำดับการแก้ไขระดับบิตที่แม่นยำดังนี้:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">แยกเฟิร์มแวร์ทั่วไปพื้นฐานออกจากไฟล์เก็บถาวร <code>firmware.zip</code> ที่ถูกแคชไว้</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">ตัดส่วนเสริมพื้นฐานโดยการค้นหาลายเซ็นไบต์วิเศษ <code>0xE9</code> ของ ESP</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">แยก Pinout เป้าหมายเฉพาะและการกำหนดค่ารันไทม์จาก <code>hardware.json</code></p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Byte-pack Product Name (128b), Lua Name (16b), <code>options.json</code> (512b), และ <code>hardware.json</code> (2048b) ลงในสตรีมไบนารีโดยตรง</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">บีบอัด payload สุดท้ายเป็นสตรีม <code>.gz</code> หากแพลตฟอร์มเป้าหมายต้องการ (เช่น ESP8285 legacy)</p>
    </div>
  </div>
</div>

## ตรรกะอุปกรณ์ต่อพ่วง

### ตัวฉีดโดเมนข้อบังคับ
แอปจัดการความแตกต่างที่ซับซ้อนระหว่างย่านความถี่ได้อย่างถูกต้อง สำหรับอุปกรณ์ 900MHz/Dual-Band แอปจะฉีดโดเมนที่คุณเลือก (เช่น FCC, EU868) เข้าไปใน JSON payload ที่คอมไพล์แล้ว สำหรับเป้าหมาย 2.4GHz มาตรฐาน แอปจะใช้ boolean flag เพื่อกำหนดเส้นทางกระบวนการแยกข้อมูลไปยังโฟลเดอร์เฟิร์มแวร์พื้นฐาน FCC/ มาตรฐาน หรือ LBT/ ของยุโรปโดยเงียบ ๆ ระหว่างการประกอบ

### การแคชและซิงค์เฟิร์มแวร์
การแฟลชแบบออฟไลน์ทำได้ผ่านระบบแคชในเครื่องที่แข็งแกร่ง เมื่อผู้ใช้ดาวน์โหลดรุ่นผ่าน Firmware Manager, `FirmwareCacheService` จะดึง `firmware.zip` ทั่วไปและ `hardware.zip` เฉพาะอุปกรณ์โดยตรงจาก ExpressLRS Artifactory ไฟล์เก็บถาวรเหล่านี้จะถูกจัดการและจัดเก็บไว้ในเครื่องบนอุปกรณ์ ทำให้มั่นใจได้ว่าการประกอบและการแฟลชสามารถเกิดขึ้นได้ทันทีในพื้นที่ โดยไม่ต้องมีการเชื่อมต่ออินเทอร์เน็ตที่ใช้งานอยู่

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">การผูกเครือข่ายเนทีฟ</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    ระบบปฏิบัติการมือถือ (โดยเฉพาะ Android และ iOS) จะลดลำดับความสำคัญของการเชื่อมต่อ Wi-Fi ที่ไม่มีอินเทอร์เน็ต ทำให้ส่งทราฟฟิกผ่านเซลลูลาร์แทนโดยอัตโนมัติ ซึ่งจะป้องกันไม่ให้แอปมาตรฐานเข้าถึงฮาร์ดแวร์ ELRS ที่ <code>10.0.0.1</code>
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile แก้ปัญหานี้ผ่าน <code>NativeNetworkService</code> เมื่อตรวจพบการเชื่อมต่อฮาร์ดแวร์ แอปจะเรียกใช้ <code>MethodChannel</code> เฉพาะแพลตฟอร์มเพื่อผูกกระบวนการ Flutter ทั้งหมดเข้ากับอินเทอร์เฟซ Wi-Fi ในระดับ OS kernel ซึ่งช่วยให้มั่นใจได้ว่าทราฟฟิก HTTP และ mDNS ทั้งหมดจะถูกกำหนดเส้นทางไปยังฮาร์ดแวร์ได้อย่างถูกต้อง โดยไม่คำนึงถึงสถานะเซลลูลาร์
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->