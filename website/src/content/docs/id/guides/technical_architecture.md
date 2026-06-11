---
title: "Arsitektur Teknis"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile bukan hanya web-wrapper; ini adalah implementasi native Dart dari pipeline kompilasi dan konfigurasi ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Perakitan Firmware Terpadu</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Alih-alih mengandalkan kompilator cloud jarak jauh, aplikasi ini secara dinamis membangun biner secara lokal di perangkat Anda. Ketika mem-flash target ESP32/ESP8285, <code>FirmwareAssembler</code> menjalankan urutan modifikasi tingkat bit yang presisi:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Mengekstrak firmware generik dasar dari arsip <code>firmware.zip</code> yang di-cache.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Memangkas padding dasar dengan mencari tanda byte ajaib ESP <code>0xE9</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Mengekstrak pinout target spesifik dan konfigurasi runtime dari <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Mengemas byte Nama Produk (128b), Nama Lua (16b), <code>options.json</code> (512b), dan <code>hardware.json</code> (2048b) langsung ke dalam aliran biner.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Mengompres payload akhir menjadi aliran <code>.gz</code> jika diperlukan oleh platform target (misalnya ESP8285 legacy).</p>
    </div>
  </div>
</div>

## Logika Periferal

### Injektor Domain Regulasi
Aplikasi ini secara akurat menangani perbedaan kompleks antara pita frekuensi. Untuk perangkat 900MHz/Dual-Band, aplikasi ini secara aktif menyuntikkan domain pilihan Anda (misalnya, FCC, EU868) ke dalam payload JSON yang dikompilasi. Untuk target 2.4GHz standar, aplikasi ini menggunakan flag boolean untuk secara diam-diam mengarahkan proses ekstraksi ke folder firmware dasar standar FCC/ atau LBT/ Eropa selama perakitan.

### Caching & Sinkronisasi Firmware
Flashing offline dimungkinkan melalui sistem caching lokal yang kuat. Ketika pengguna mengunduh rilis melalui Firmware Manager, `FirmwareCacheService` menarik `firmware.zip` generik dan `hardware.zip` spesifik perangkat langsung dari ExpressLRS Artifactory. Arsip-arsip ini dikelola dan disimpan secara lokal di perangkat, memastikan perakitan dan flashing dapat terjadi secara instan di lapangan tanpa koneksi internet aktif.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Pengikatan Jaringan Native</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Sistem operasi seluler (terutama Android dan iOS) akan menurunkan prioritas koneksi Wi-Fi yang tidak memiliki akses internet, secara diam-diam mengarahkan lalu lintas melalui seluler sebagai gantinya. Ini mencegah aplikasi standar mencapai perangkat keras ELRS di <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile memecahkan masalah ini melalui <code>NativeNetworkService</code>. Ketika koneksi perangkat keras terdeteksi, aplikasi ini memanggil <code>MethodChannel</code> spesifik platform untuk mengikat seluruh proses Flutter ke antarmuka Wi-Fi pada tingkat kernel OS. Ini memastikan semua lalu lintas HTTP dan mDNS terarah dengan benar ke perangkat keras, terlepas dari status seluler.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->