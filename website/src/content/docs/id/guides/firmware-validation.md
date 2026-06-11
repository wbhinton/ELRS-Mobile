---
title: "Alat Validasi Firmware"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Panduan ini merinci alat internal yang digunakan untuk memvalidasi logika perakitan firmware aplikasi ELRS Mobile terhadap biner "Golden" resmi.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Biner Ground Truth vs. Konfigurator</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Saat menjalankan audit validasi, Anda mungkin menyadari bahwa biner yang dihasilkan oleh ELRS Mobile sangat cocok dengan **ExpressLRS Web Flasher** resmi, tetapi sedikit berbeda dari biner yang dibuat menggunakan **ExpressLRS Configurator (Python)** lokal.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Ini adalah perilaku yang diharapkan. Parser C++ JSON internal ESP32 mengabaikan spasi kosong, yang berarti kedua biner dieksekusi secara identik pada perangkat keras meskipun gagal dalam perbandingan SHA256 byte-demi-byte yang ketat karena perbedaan minifikasi.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Lokasi:** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator adalah alat perbandingan tingkat-bit berkinerja tinggi. Alat ini dirancang untuk memverifikasi bahwa logika patching dan perakitan internal ELRS Mobile mencerminkan logika ExpressLRS resmi.

### Fitur Utama
- **Analisis Tingkat-Bit**: Menentukan kegagalan offset-bit yang tepat dalam byte yang berbeda.
- **Pilihan Interaktif**: Mencantumkan semua biner yang ditemukan di `firmware_testing/binaries/`.
- **Manajemen Memori Zero-Copy**: Dioptimalkan untuk analisis berkecepatan tinggi pada file firmware besar.

### Cara Menggunakan
1. **Siapkan Biner**: Tempatkan file `.bin` atau `.gz` yang dihasilkan di `firmware_testing/binaries/`.
2. **Penyetelan & Jalankan**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Lokasi:** `firmware_testing/scripts/python/audit_tool.py`

Auditor adalah skrip mandiri tanpa dependensi yang ditujukan untuk verifikasi "Ground Truth". Ini mengurai blok konfigurasi 2704-byte yang ditambahkan ke akhir setiap citra firmware ExpressLRS.

### Tujuan
Ini memverifikasi bahwa metadata yang benar-benar di-flash ke perangkat (Nama Produk, Nama Lua, Tata Letak Perangkat Keras, dan Opsi) sudah benar, terlepas dari perbedaan tata letak apa pun dalam kode firmware dasar.

### Cara Menggunakan
1. **Jalankan secara langsung**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Alur Kerja Validasi Silang Biner
Untuk memastikan ELRS Mobile merakit firmware dengan benar, pengembang harus secara berkala melakukan audit validasi silang terhadap biner "Ground Truth" yang dikompilasi di PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Ekspor Biner dari ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Aktifkan **Expert Mode** di Pengaturan, lalu gunakan tombol **DOWNLOAD BINARY** di tab Flasher setelah mengonfigurasi target dan opsi Anda.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Hasilkan Ground Truth PC</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Buat target dan versi yang **persis sama** dengan opsi identik menggunakan ExpressLRS Configurator resmi di PC Anda.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Jalankan Audit</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Tempatkan kedua biner di <code>firmware_testing/binaries/</code> dan jalankan skrip <code>audit_tool.py</code> untuk memverifikasi kesesuaian perangkat keras dan opsi yang sempurna.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->