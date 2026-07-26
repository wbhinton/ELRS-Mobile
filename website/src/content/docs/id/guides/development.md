---
title: "Panduan Pengembangan"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: id/development
sidebar:
  order: 2
---

Selamat datang di panduan pengembangan ELRS Mobile! Proyek ini adalah implementasi Flutter asli dari pipeline kompilasi dan flashing ExpressLRS, dirancang untuk bekerja sepenuhnya offline.

## Prasyarat
Untuk berkontribusi pada proyek ini, Anda akan memerlukan alat berikut yang terinstal:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stabil)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Memulai

1.  **Kloning repositori**:
    ```bash
    git clone https://github.com/wbhinton/ELRS-Mobile.git
    cd ELRS-Mobile
    ```

2.  **Instal dependensi**:
    ```bash
    flutter pub get
    ```

3.  **Jalankan aplikasi**:
    ```bash
    # Untuk Android
    flutter run
    
    # Untuk iOS (membutuhkan Mac dan perangkat fisik/simulator)
    flutter run
    ```

---

## Arsitektur Proyek
Codebase mengikuti struktur fitur-pertama yang terletak di `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Fitur
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">Logika inti dan UI untuk pipeline flashing.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Menangani pengunduhan dan caching firmware dari artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">UI untuk mengatur opsi pengguna seperti Binding Phrases dan WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Inti
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Logika spesifik platform untuk pengikatan proses ke hotspot perangkat keras.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Manajemen cache lokal dan persistensi SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Observabilitas yang mengutamakan privasi (Sentry dan Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Manajemen State
Kami menggunakan **Riverpod** untuk manajemen state global dan **Flutter Hooks** untuk state tingkat widget lokal. Kombinasi ini memastikan UI yang sangat reaktif tanpa boilerplate `StatefulWidgets` standar.

---

## Pembahasan Mendalam

Untuk informasi teknis lebih rinci, silakan lihat panduan berikut:

- [**Arsitektur Teknis**](/guides/technical_architecture): Pembahasan mendalam tentang `FirmwareAssembler` dan native networking stack.
- [**Validasi Firmware**](/guides/firmware-validation): Cara menggunakan Dart dan Python tools untuk memverifikasi integritas biner.

---

## Catatan tentang Minifikasi JSON

Saat mengaudit biner, Anda mungkin melihat sedikit perbedaan offset byte dibandingkan dengan Python Configurator standar. Ini disebabkan oleh **JSON minification**. Python Configurator sering menyisipkan spasi setelah titik dua (misalnya, `{"uid": [1,2,3]}`), sementara ELRS Mobile menghasilkan JSON padat (misalnya, `{"uid":[1,2,3]}`). Keduanya secara fungsional identik pada hardware, karena parser internal ESP32 mengabaikan spasi kosong ini.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->