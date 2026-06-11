Berikut adalah terjemahan dokumen markdown Anda ke dalam bahasa Indonesia ('id'), dengan tetap mempertahankan semua pemformatan markdown, header, tautan, blok kode, dan istilah teknis yang tidak diterjemahkan:

# Panduan

## Fase 1: Menyimpan Firmware dalam Cache
1. **Hubungkan ke Internet:** Pastikan ponsel Anda terhubung ke internet (misalnya, WiFi rumah atau jaringan seluler).
2. **Buka Firmware Manager:** Arahkan ke Firmware Manager di aplikasi.
3. **Unduh Rilis:** Ketuk ikon unduh di sebelah rilis ExpressLRS yang Anda inginkan. Ini akan menyimpan target firmware yang diperlukan dan definisi hardware dengan aman di ponsel Anda untuk penggunaan 100% offline.

## Fase 2: Menghubungkan ke Perangkat Anda
1. **Nyalakan Perangkat:** Nyalakan ExpressLRS Receiver (RX) atau Transmitter (TX) Anda.
2. **Tunggu Hotspot:** Tunggu hingga perangkat masuk ke Mode Hotspot Wi-Fi (ditunjukkan dengan LED berkedip cepat).
3. **Hubungkan ke Hotspot:** Hubungkan Wi-Fi ponsel Anda ke jaringan `ExpressLRS RX` atau `ExpressLRS TX` menggunakan kata sandi `expresslrs`.
* **Catatan:** ELRS Mobile secara bawaan menangani forced routing, memastikan ponsel Anda tidak secara diam-diam beralih kembali ke 5G/LTE.

## Fase 3: Melakukan Flashing Firmware
1. **Arahkan ke Flash Device:** Dari Dashboard utama, pilih **Flash Device**.
2. **Pemilihan Target:** Gunakan dropdown berjenjang untuk memilih vendor dan target hardware spesifik.
3. **Pemilihan Versi:** Pilih versi firmware yang tersedia dari repositori offline Anda.
4. **Konfigurasi:** Masukkan kredensial kustom Anda. Aplikasi menyimpan WiFi SSID, WiFi Password, dan Binding Phrase di penyimpanan lokal sehingga Anda tidak perlu memasukkannya kembali.
5. **Build & Flash:** Ketuk **FLASH**. Sistem akan menambal binary dengan kredensial lokal Anda dan mengunggahnya.
* **Penting:** Selalu tunggu konfirmasi keberhasilan dan hingga LED perangkat berkedip kembali sebelum mencabutnya!

---

# Pertanyaan yang Sering Diajukan (FAQ)

## Apakah saya memerlukan koneksi internet atau layanan seluler untuk mem-flash firmware?
Tidak. ELRS Mobile memiliki fitur **100% Offline Flashing**. Selama Anda sebelumnya telah mengunduh versi firmware melalui Firmware Manager saat terhubung ke Wi-Fi rumah, aplikasi dapat secara dinamis merakit dan mem-flash firmware sepenuhnya secara offline.

## Saya mendapatkan kesalahan "Not enough space" saat mem-flash receiver ESP8285 saya.
Chip ESP8285 (seperti yang ditemukan di banyak board AIO) hanya memiliki total penyimpanan fisik 1MB. Memperbarui langsung ke rilis utama (seperti dari 3.x ke 4.x) melalui Wi-Fi dapat kehabisan ruang dual-partition karena file yang masuk terlalu besar untuk di-unpack bersama firmware yang sedang berjalan.

**Cara memperbaikinya:** Pertama, flash receiver Anda ke versi perantara (seperti **3.6.3**). Setelah menjalankan firmware 3.6.3 yang lebih ringan, Anda akan memiliki cukup ruang partisi untuk berhasil mem-flash ke target 4.0 yang Anda inginkan. Atau, aktifkan **Expert Mode** di Settings, simpan binary yang telah dibuat secara lokal, dan flash secara manual melalui koneksi Betaflight Passthrough berkabel.

## Di mana saya menemukan script ExpressLRS Lua untuk radio saya?
ELRS Mobile dilengkapi dengan script Lua universal yang agnostik versi, yang sudah terpasang! Untuk mendapatkannya:
1. Buka **Settings** dan aktifkan **Expert Mode**.
2. Ketuk **Export ELRS Lua Script**.
3. Ini menyimpan `elrs.lua` langsung ke penyimpanan lokal ponsel Anda. Nyalakan radio Anda dan sambungkan ke ponsel Anda melalui USB, pastikan untuk memilih mode "USB Storage" di radio Anda dan transfer file tersebut ke folder `SCRIPTS/TOOLS` menggunakan pengelola file ponsel Anda.

**Catatan:** Anda perlu menghapus versi sebelumnya dari script elrs.lua (misalnya, elrs_v2.lua, elrs_v3.lua, dll) dari kartu SD radio Anda sebelum menggunakan script baru.

## Bagaimana jika flashing gagal dan perangkat saya menjadi tidak responsif?
Jika perangkat Anda tidak responsif setelah flashing gagal, Anda dapat dengan mudah memulihkannya:
1. Tahan tombol BOOT pada perangkat saat mencolokkannya melalui USB untuk masuk ke mode bootloader.
2. Gunakan komputer dan ELRS Web Flasher untuk mem-flash ulang perangkat melalui koneksi USB/UART berkabel.
3. Untuk perangkat yang mendukung Wi-Fi, Anda juga dapat menahan BOOT

**Catatan:** Ada tautan video di Tab Resources yang menunjukkan cara melakukannya.

## Bisakah saya menyimpan file firmware ke ponsel saya tanpa mem-flashnya?
Ya. Dengan masuk ke **Settings** dan mengaktifkan **Expert Mode**, Anda membuka kemampuan untuk menyimpan binary firmware yang telah dirakit langsung ke penyimpanan lokal perangkat seluler Anda alih-alih langsung mem-flash-nya Over-The-Air (OTA).

Ini sangat berguna jika Anda ingin mem-flash perangkat secara manual menggunakan programmer hardware khusus (seperti STLink atau adapter FTDI).

## Saya mendapatkan kesalahan "Target Mismatch". Apa yang harus saya lakukan?
Kesalahan target mismatch terjadi ketika target hardware yang Anda pilih di aplikasi tidak cocok dengan target firmware yang sedang berjalan di perangkat

Saat ini aplikasi tidak mendukung flashing target yang berbeda dari yang sedang berjalan di perangkat.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->