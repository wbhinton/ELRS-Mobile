---
title: "Panduan Pengguna"
slug: id/user_guide
sidebar:
  order: 1
---

Berikut adalah terjemahan dokumen markdown ke bahasa Indonesia, dengan mempertahankan semua format, tautan, dan blok kode persis seperti aslinya, serta tidak menerjemahkan istilah teknis dan nama merek yang ditentukan:

## Ikhtisar
Aplikasi ini menyediakan antarmuka seluler komprehensif untuk mengelola perangkat keras ExpressLRS. Ini memungkinkan pengguna untuk mengkonfigurasi parameter receiver (RX) dan transmitter (TX), memetakan output PWM, dan melakukan flash pembaruan firmware langsung dari perangkat seluler.

---

## Pemasangan

### Toko Aplikasi Resmi

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Instal dari Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Get it on Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Instal dari App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on App Store</a>

### Pemasangan Alternatif

#### GitHub Store
Ideal untuk pengguna yang menyukai pengalaman toko aplikasi alternatif.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on GitHub Store</a>

### Pemasangan Manual
Untuk power user atau mereka yang lebih suka manajemen manual, kunjungi halaman [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) kami untuk mendapatkan file `.apk` terbaru.

---

## 🚀 Mulai Cepat: Mem-flash Perangkat Pertama Anda

### Fase 1: Menyimpan Firmware (Lakukan ini di rumah)
1. Buka aplikasi dan navigasikan ke **Manajer Firmware**.
2. Ketuk ikon unduh di samping rilis stabil terbaru.
3. Aplikasi akan mengunduh dan menyimpan definisi target dan perangkat keras yang diperlukan dengan aman untuk penggunaan offline.

### Fase 2: Menghubungkan ke Perangkat Anda
1. Nyalakan ExpressLRS Receiver (RX) atau Transmitter (TX) Anda.
2. Tunggu 60 detik (atau interval yang Anda konfigurasikan) agar perangkat masuk ke Mode Wi-Fi Hotspot (LED berkedip cepat).
3. Hubungkan Wi-Fi ponsel Anda ke jaringan **ExpressLRS RX** atau **ExpressLRS TX** (Kata Sandi: `expresslrs`).
4. Buka aplikasi. Dashboard akan secara otomatis memindai jaringan menggunakan mDNS dan terhubung ke perangkat.

### Fase 3: Mem-flash Firmware
1. Dari Dashboard, pilih **Flash Perangkat**.
2. **Pilih Perangkat Keras Anda:** Gunakan dropdown bertingkat untuk memilih Tipe Perangkat, Vendor, Frekuensi, dan Target Anda.
3. **Konfigurasi Opsi & Profil:** Pilih **Profil Flashing** (atau ketuk tombol **+** untuk menambahkan profil baru bernama) untuk memuat kredensial Anda. Sesuaikan Binding Phrase, Wi-Fi SSID, kata sandi Wi-Fi, domain regulasi, dan interval auto-on Wi-Fi.
4. Ketuk **FLASH**. Aplikasi akan merakit binary secara lokal dan mendorongnya ke perangkat.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Target Mismatch Warning</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Jika aplikasi mendeteksi ketidakcocokan target perangkat keras antara pilihan Anda dan perangkat yang terhubung, aplikasi akan memperingatkan Anda untuk mencegah kerusakan yang tidak disengaja. Jika Anda yakin memiliki target yang benar (misalnya memulihkan dari flash yang buruk atau bermigrasi antar definisi target), klik **FORCE FLASH** di dialog peringatan untuk melewati pemeriksaan.
  </p>
</div>

### 📋 Mengelola Profil Flashing
Jika Anda memiliki beberapa drone atau pengaturan radio dengan persyaratan konfigurasi yang berbeda (misalnya, frasa pengikat atau domain regulasi yang berbeda), Anda dapat menggunakan **Profil Flashing** bernama untuk menyimpan dan beralih konfigurasi:
* **Tambah Profil**: Ketuk ikon **+** di samping dropdown "Flashing Profile", ketik nama, dan tekan Tambah.
* **Penyimpanan Otomatis**: Setiap perubahan pada kredensial profil aktif (frasa pengikat, SSID, kata sandi, domain, atau interval) disimpan secara otomatis secara real-time.
* **Beralih Profil**: Cukup pilih profil dari dropdown untuk langsung memuat pengaturannya yang tersimpan.
* **Hapus Profil**: Untuk membersihkan, pilih profil dari dropdown dan ketuk ikon sampah/hapus (Anda harus memiliki setidaknya dua profil untuk menghapus satu).

---

## Detail Teknis

### Konektivitas & Penemuan
Aplikasi menggunakan urutan penemuan multi-tahap yang kuat untuk menemukan perangkat keras Anda:
1. **Resolusi mDNS**: Metode utama. Aplikasi memindai `elrs_rx.local` atau `elrs_tx.local`.
2. **Fallback AP Statis**: Jika mDNS diblokir, aplikasi memeriksa IP access point resmi ELRS (`10.0.0.1`).
3. **Penggantian IP Manual**: Untuk jaringan yang kompleks, Anda dapat memasukkan alamat IP secara manual di Pengaturan.

**Pengikatan Jaringan Paksa**: Ponsel pintar modern seringkali memutuskan koneksi Wi-Fi tanpa internet. ELRS Mobile mencakup lapisan "Forced Routing" asli yang memaksa OS untuk tetap terhubung ke koneksi perangkat keras, memastikan penemuan 100% yang andal di lapangan.

---

## Mode Ahli & Audit
Di dalam menu Pengaturan, pengguna dapat mengaktifkan **Mode Ahli**. Ini memungkinkan Anda untuk menyimpan firmware binary yang sudah dirakit langsung ke perangkat Anda untuk audit atau flash manual melalui FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 Hardware Handling</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Meskipun ELRS Mobile dapat merakit dan menambal firmware untuk target STM32 (hingga ELRS v3.x), perangkat ini tidak mendukung flashing Over-The-Air (OTA) melalui Wi-Fi. Jika Anda memilih target STM32, aplikasi akan memungkinkan Anda untuk membangun dan menyimpan binary secara lokal sehingga Anda dapat mem-flash-nya secara manual menggunakan PC melalui STLink atau Betaflight Passthrough.
  </p>
</div>

Untuk pengembang yang ingin memverifikasi integritas binary ini, lihat [**Panduan Validasi Firmware**](/guides/firmware-validation) kami.

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->