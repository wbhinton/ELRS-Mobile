# คำแนะนำการใช้งาน

## ระยะที่ 1: การแคชเฟิร์มแวร์
1. **เชื่อมต่ออินเทอร์เน็ต:** ตรวจสอบให้แน่ใจว่าโทรศัพท์ของคุณเชื่อมต่อกับอินเทอร์เน็ต (เช่น Wi-Fi ที่บ้านหรือเครือข่ายมือถือ)
2. **เปิด Firmware Manager:** ไปที่ Firmware Manager ในแอป
3. **ดาวน์โหลดเวอร์ชัน:** แตะไอคอนดาวน์โหลดถัดจาก ExpressLRS release ที่คุณต้องการ การดำเนินการนี้จะแคช firmware targets ที่จำเป็นและ hardware definitions บนโทรศัพท์ของคุณอย่างปลอดภัยสำหรับการใช้งานแบบออฟไลน์ 100%

## ระยะที่ 2: การเชื่อมต่อกับอุปกรณ์ของคุณ
1. **เปิดเครื่องอุปกรณ์:** เปิดเครื่อง ExpressLRS Receiver (RX) หรือ Transmitter (TX) ของคุณ
2. **รอ Hotspot:** รอให้อุปกรณ์เข้าสู่โหมด Wi-Fi Hotspot (สังเกตได้จาก LED ที่กระพริบถี่ๆ)
3. **เชื่อมต่อกับ Hotspot:** เชื่อมต่อ Wi-Fi ของโทรศัพท์ของคุณกับเครือข่าย `ExpressLRS RX` หรือ `ExpressLRS TX` โดยใช้รหัสผ่าน `expresslrs`
* **หมายเหตุ:** ELRS Mobile จัดการ forced routing โดยกำเนิด ทำให้มั่นใจได้ว่าโทรศัพท์ของคุณจะไม่เปลี่ยนกลับไปใช้ 5G/LTE โดยไม่รู้ตัว

## ระยะที่ 3: การแฟลชเฟิร์มแว���์
1. **ไปที่ Flash Device:** จากหน้า Dashboard หลัก ให้เลือก **Flash Device**
2. **การเลือกเป้าหมาย:** ใช้เมนูดรอปดาวน์แบบเรียงซ้อนเพื่อเลือก vendor และ specific hardware target
3. **การเลือกเวอร์ชัน:** เลือก firmware version ที่มีอยู่ใน offline repository ของคุณ
4. **การกำหนดค่าและโปรไฟล์:** เลือกหรือสร้าง **Flashing Profile** (เช่น "My Quads", "Race Spec") เพื่อโหลด custom credentials ของคุณ แอปจะบันทึก Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain และ Auto-On intervals ใน named profiles เหล่านี้ คุณจึงไม่ต้องป้อนซ้ำเมื่อสลับระหว่าง setups ต่างๆ
5. **สร้างและแฟลช:** แตะ **FLASH** ระบบจะ patches binary ด้วย local credentials ของคุณและอัปโหลด
* **สำคัญ:** ควรรอจนกว่าจะได้รับการยืนยันความสำเร็จ��ละจนกว่า LED ของอุปกรณ์จะกลับมากระพริบอีกครั้งก่อนที่จะถอดปลั๊ก!

---

# คำถามที่พบบ่อย

## ฉันจำเป็นต้องมีการเชื่อมต่ออินเทอร์เน็ตหรือบริการเซลลูลาร์เพื่อแฟลชเฟิร์มแวร์หรือไม่?
ไม่จำเป็น ELRS Mobile มีคุณสมบัติ **100% Offline Flashing** ตราบใดที่คุณได้ดาวน์โหลด firmware version ไว้ล่วงหน้าผ่าน Firmware Manager ขณะเชื่อมต่อ Wi-Fi ที่บ้าน แอปก็สามารถ dynamically assemble และ flash firmware ได้สมบูรณ์แบบโดยไม่ต้องเชื่อมต่ออินเทอร์เน็ต

## Flashing Profiles คืออะไรและใช้งานอย่างไร?
Flashing Profiles ช่วยให้คุณสามารถบันทึกและสลับไปมาระหว่าง flashing configurations หลายรายการ (เช่น "My Quads", "Stock / Factory Reset", "Race Spec") แต่ละ profile จะจัดเก็บ binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains และ Wi-Fi auto-on interval ของตนเองอย่างปลอดภัย

วิธีใช้งาน:
1. แตะไอคอน **+** (เพิ่ม) ถัดจากเมนูดรอปดาวน์ "Flashing Profile" ในการ์ด **Configuration Options**
2. ตั้งชื่อ profile ใหม่ของคุณและปรับแต่งการตั้งค่า Edits จะถูกบันทึกโดยอัตโนมัติทันที
3. เลือก profile ใดก็ได้จากเมนูดรอปดาวน์เพื่อสลับ parameters ทั้งหมดโดยอัตโนมัติ
4. หากต้องการลบ profile ให้เลือก profile นั้นแล้วแตะไอคอนถังขยะ/ลบ (ต้องมีอย่างน้อยสอง profiles จึงจะลบได้หนึ่ง profile)

## ฉันได้รับข้อผิดพลาด "Not enough space" เมื่อแฟลช ESP8285 receiver ของฉัน
ชิป ESP8285 (เช่นที่พบในบอร์ด AIO หลายตัว) มีพื้นที่จัดเก็บข้อมูลจริงรวมเพียง 1MB การอัปเดตโดยตรงไปยัง major release (เช่นจาก 3.x เป็น 4.x) ผ่าน Wi-Fi อาจทำให้ dual-partition space ไม่พอ เนื่องจากไฟล์ที่เข้ามามีขนาดใหญ่เกินไปที่จะ unpack พร้อมกับ firmware ที่กำลังทำงานอยู่

**วิธีแก้ไข:** ขั้นแรก ให้แฟลช receiver ของคุณไปยัง intermediate version (เช่น **3.6.3**) เมื่อรัน leaner 3.6.3 firmware แล้ว คุณจะมี partition space เพียงพอที่จะ flash ไปยัง 4.0 target ที่ต้องการได้สำเร็จ หรืออีกทางหนึ่ง ให้เปิดใช้งาน **Expert Mode** ใน Settings, บันทึก built binary ไว้ในเครื่อง และ flash ด้วยตนเองผ่านการเชื่อมต่อ wired Betaflight Passthrough

## ฉันจะหา ExpressLRS Lua script สำหรับวิทยุของฉันได้ที่ไหน?
ELRS Mobile มาพร้อมกับ universal, version-agnostic Lua script ที่สร้างมาพร้อมในตัว! หากต้องการ:
1. ไปที่ **Settings** และเปิดใช้งาน **Expert Mode**
2. แตะ **Export ELRS Lua Script**
3. การดำเนินการนี้จะบันทึก `elrs.lua` โดยตรงไปยัง local storage ของโทรศัพท์ของคุณ เปิดวิทยุของคุณและเสียบเข้ากับโทรศัพท์ผ่าน USB ตรวจสอบให้แน่ใจว่าได้เลือกโหมด "USB Storage" บนวิทยุของคุณแล้วโอนไฟล์ไปยังโฟลเดอร์ `SCRIPTS/TOOLS` โดยใช้ file manager ของโทรศัพท์ของคุณ

**หมายเหตุ:** คุณต้องลบ Lua script เวอร์ชันก่อนหน้า (เช่น elrs_v2.lua, elrs_v3.lua ฯลฯ) ออกจาก SD card ของวิทยุของคุณก่อนที่จะใช้ script ใหม่

## จะเกิดอะไรขึ้นหากการแฟลชล้มเหลวและอุปกรณ์ของฉันไม่��อบสนอง?
หากอุปกรณ์ของคุณไม่ตอบสนองหลังจากการแฟลชล้มเหลว คุณสามารถกู้คืนได้ง่ายๆ:
1. กดปุ่ม BOOT บนอุปกรณ์ค้างไว้ขณะเสียบผ่าน USB เพื่อเข้าสู่โหมด bootloader
2. ใช้คอมพิวเตอร์และ ELRS Web Flasher เพื่อ re-flash อุปกรณ์ซ้ำผ่านการเชื่อมต่อ wired USB/UART
3. สำหรับอุปกรณ์ที่รองรับ Wi-Fi คุณสามารถกด BOOT ค้างไว้

**หมายเหตุ:** มีลิงก์วิดีโอบนแท็บ Resources ที่แสดงวิธีการทำเช่นนี้

## ฉันสามารถบันทึกไฟล์เฟิร์มแวร์ลงในโทรศัพท์โดยไม่ต้องแฟลชได้หรือไม่?
ใช่. โดยการไปที่ **Settings** และเปิดใช้งาน **Expert Mode** คุณจะปลดล็อกความสามารถในการบันทึก assembled firmware binary โดยตรงไปยัง local storage ของอุปกรณ์มือถือของคุณ แทนที่จะแฟลชทันทีแบบ Over-The-Air (OTA)

สิ่งนี้มีประโยชน์อย่างยิ่งหากคุณต้องการแฟลชอุปกรณ์ด้วยตนเองโดยใช้ dedicated hardware programmer (เช่น STLink หรือ FTDI adapter)

## ฉันได้รับข้อผิดพลาด "Target Mismatch" ฉันควรทำอย่างไร?
ข้อผิดพลาด target mismatch เกิดขึ้นเมื่อ hardware target ที่คุณเลือกในแอปไม่ตรงกับ target ของ firmware ที่กำลังทำงานอยู่บนอุปกรณ์

เพื่อป้องกันความเสียหายโดยไม่ตั้งใจ แอปจะเตือนคุณหากตรวจพบ mismatch อย่างไรก็ตาม หากคุณแน่ใจว่า target ที่เลือกถูกต้อง (ตัวอย่างเช่น หากคุณกำลังแปลงอุปกรณ์เป็น firmware variant อื่น หรือแก้ไข previous incorrect flash) คุณสามารถแตะ **FORCE FLASH** ใน dialog mismatch เพื่อ override การตรวจสอบและดำเนินการ flash ต่อได้

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->