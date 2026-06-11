---
title: "Panduan Pengguna"
slug: user_guide
sidebar:
  order: 1
---

## Ikhtisar
Aplikasi ini menyediakan antarmuka seluler komprehensif untuk mengelola perangkat keras ExpressLRS. Aplikasi ini memungkinkan pengguna untuk mengonfigurasi parameter penerima (RX) dan pemancar (TX), memetakan output PWM, dan mem-flash pembaruan firmware langsung dari perangkat seluler.

---

## Instalasi

### Toko Aplikasi Resmi

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Instal dari Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Dapatkan di Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Instal dari App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Unduh di App Store</a>

### Instalasi Alternatif

#### GitHub Store
Ideal untuk pengguna yang lebih suka pengalaman toko aplikasi alternatif.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Unduh di GitHub Store</a>

### Instalasi Manual
Untuk pengguna mahir atau mereka yang lebih suka manajemen manual, kunjungi halaman [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) kami untuk file `.apk` terbaru.

---

## 🚀 Mulai Cepat: Mem-Flash Perangkat Pertama Anda

### Fase 1: Firmware Cache (Lakukan ini di rumah)
1. Buka aplikasi dan navigasikan ke **Firmware Manager**.
2. Ketuk ikon unduh di samping rilis stabil terbaru.
3. Aplikasi akan mengunduh dan menyimpan cache target serta definisi perangkat keras yang diperlukan dengan aman untuk penggunaan offline.

### Fase 2: Menghubungkan ke Perangkat Anda
1. Nyalakan ExpressLRS Receiver (RX) atau Transmitter (TX) Anda.
2. Tunggu 60 detik (atau interval yang Anda konfigurasi) hingga perangkat masuk ke Mode Wi-Fi Hotspot (LED berkedip cepat).
3. Hubungkan Wi-Fi ponsel Anda ke jaringan **ExpressLRS RX** atau **ExpressLRS TX** (Kata Sandi: `expresslrs`).
4. Buka aplikasi. Dashboard akan secara otomatis memindai jaringan menggunakan mDNS dan terhubung ke perangkat.

### Fase 3: Mem-Flash Firmware
1. Dari Dashboard, pilih **Flash Device**.
2. **Pilih Perangkat Keras Anda:** Gunakan dropdown bertingkat untuk memilih Tipe Perangkat, Vendor, Frekuensi, dan Target Anda.
3. **Konfigurasi Opsi:** Atur Frasa Pengikatan kustom Anda, kredensial Wi-Fi, dan Domain Regulasi.
4. Ketuk **FLASH**. Aplikasi akan merakit biner secara lokal dan mendorongnya ke perangkat.

---

## Detail Teknis

### Konektivitas & Penemuan
Aplikasi ini menggunakan urutan penemuan multi-tahap yang kuat untuk menemukan perangkat keras Anda:
1. **Resolusi mDNS**: Metode utama. Aplikasi memindai `elrs_rx.local` atau `elrs_tx.local`.
2. **Fallback AP Statis**: Jika mDNS diblokir, aplikasi memeriksa IP titik akses ELRS resmi (`10.0.0.1`).
3. **Override IP Manual**: Untuk jaringan kompleks, Anda dapat memasukkan alamat IP secara manual di Pengaturan.

**Pengikatan Jaringan Paksa**: Smartphone modern sering membuang koneksi Wi-Fi tanpa internet. ELRS Mobile menyertakan lapisan "Forced Routing" asli yang memaksa OS untuk tetap terhubung ke perangkat keras, memastikan penemuan 100% andal di lapangan.


---

## Mode Ahli & Audit
Di dalam menu Pengaturan, pengguna dapat mengaktifkan **Expert Mode**. Ini memungkinkan Anda menyimpan biner firmware yang telah dirakit langsung ke perangkat Anda untuk diaudit atau di-flash secara manual melalui FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Penanganan Perangkat Keras STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Meskipun ELRS Mobile dapat merakit dan menambal firmware untuk target STM32 (hingga ELRS v3.x), perangkat ini tidak mendukung flashing Over-The-Air (OTA) melalui Wi-Fi. Jika Anda memilih target STM32, aplikasi akan memungkinkan Anda untuk membuat dan menyimpan biner secara lokal sehingga Anda dapat mem-flash-nya secara manual menggunakan PC melalui STLink atau Betaflight Passthrough.
  </p>
</div>

Untuk pengembang yang ingin memverifikasi integritas biner ini, lihat [**Panduan Validasi Firmware**](/guides/firmware-validation) kami.

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->