# Panduan

## Fase 1: Mengunduh Firmware ke Cache
1. **Terhubung ke Internet:** Pastikan ponsel Anda terhubung ke internet (misalnya, wifi rumah atau jaringan seluler).
2. **Buka Firmware Manager:** Arahkan ke Firmware Manager di aplikasi.
3. **Unduh Rilis:** Ketuk ikon unduh di sebelah rilis ExpressLRS yang Anda inginkan. Ini akan dengan aman menyimpan target firmware dan definisi hardware yang diperlukan di ponsel Anda untuk penggunaan offline 100%.

## Fase 2: Menghubungkan ke Perangkat Anda
1. **Nyalakan Perangkat:** Nyalakan ExpressLRS Receiver (RX) atau Transmitter (TX) Anda.
2. **Tunggu Hotspot:** Tunggu perangkat masuk ke Mode Wi-Fi Hotspot (ditunjukkan oleh LED yang berkedip cepat).
3. **Hubungkan ke Hotspot:** Hubungkan Wi-Fi ponsel Anda ke jaringan `ExpressLRS RX` atau `ExpressLRS TX` menggunakan kata sandi `expresslrs`.
* **Catatan:** ELRS Mobile secara native menangani forced routing, memastikan ponsel Anda tidak secara diam-diam beralih kembali ke 5G/LTE.

## Fase 3: Melakukan Flash Firmware
1. **Arahkan ke Flash Device:** Dari Dashboard utama, pilih **Flash Device**.
2. **Pemilihan Target:** Gunakan dropdown bertingkat untuk memilih vendor dan target hardware spesifik.
3. **Pemilihan Versi:** Pilih versi firmware yang tersedia dari repositori offline Anda.
4. **Konfigurasi & Profil:** Pilih atau buat **Flashing Profile** (misalnya, "My Quads", "Race Spec") untuk memuat kredensial kustom Anda. Aplikasi menyimpan Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain, dan Auto-On intervals dalam profil-profil bernama ini sehingga Anda tidak perlu memasukkannya kembali saat beralih di antara pengaturan yang berbeda.
5. **Build & Flash:** Ketuk **FLASH**. Sistem akan menambal binary dengan kredensial lokal Anda dan mengunggahnya.
* **Penting:** Selalu tunggu konfirmasi keberhasilan dan hingga LED perangkat kembali berkedip sebelum mencabutnya!

---

# Pertanyaan yang Sering Diajukan (FAQ)

## Apakah saya memerlukan koneksi internet atau layanan seluler untuk melakukan flash firmware?
Tidak. ELRS Mobile menawarkan **100% Offline Flashing**. Selama Anda sebelumnya telah mengunduh versi firmware melalui Firmware Manager saat terhubung ke Wi-Fi rumah, aplikasi dapat secara dinamis merakit dan melakukan flash firmware sepenuhnya secara offline.

## Apa itu Flashing Profile dan bagaimana cara menggunakannya?
Flashing Profiles memungkinkan Anda untuk menyimpan dan beralih di antara beberapa konfigurasi flashing (misalnya, "My Quads", "Stock / Factory Reset", "Race Spec"). Setiap profil menyimpan frase pengikatan (binding phrase), Wi-Fi SSID, kata sandi Wi-Fi, domain regulasi, dan interval auto-on Wi-Fi-nya sendiri dengan aman.

Untuk menggunakannya:
1. Ketuk ikon **+** (Tambah) di sebelah dropdown "Flashing Profile" di kartu **Configuration Options**.
2. Beri nama profil baru Anda dan sesuaikan pengaturannya. Perubahan akan otomatis tersimpan secara instan.
3. Pilih profil mana pun dari dropdown untuk secara otomatis menukar semua parameter.
4. Untuk menghapus profil, pilih dan ketuk ikon sampah/hapus (Anda harus memiliki setidaknya dua profil untuk menghapus satu).

## Saya mendapatkan kesalahan "Not enough space" saat melakukan flash receiver ESP8285 saya.
Chip ESP8285 (seperti yang ditemukan pada banyak papan AIO) hanya memiliki total penyimpanan fisik 1MB. Memperbarui langsung ke rilis mayor (seperti dari 3.x ke 4.x) melalui Wi-Fi dapat kehabisan ruang partisi ganda karena file yang masuk terlalu besar untuk di-unpack bersamaan dengan firmware yang sedang berjalan.

**Cara mengatasi:** Pertama, lakukan flash receiver Anda ke versi menengah (seperti **3.6.3**). Setelah menjalankan firmware 3.6.3 yang lebih ringan, Anda akan memiliki cukup ruang partisi untuk berhasil melakukan flash ke target 4.0 yang Anda inginkan. Alternatifnya, aktifkan **Expert Mode** di Settings, simpan built binary secara lokal, dan lakukan flash secara manual melalui koneksi Betaflight Passthrough berkabel.

## Di mana saya menemukan script ExpressLRS Lua untuk radio saya?
ELRS Mobile hadir dengan script Lua universal yang tidak tergantung versi yang sudah terpasang di dalamnya! Untuk mendapatkannya:
1. Buka **Settings** dan aktifkan **Expert Mode**.
2. Ketuk **Export ELRS Lua Script**.
3. Ini menyimpan `elrs.lua` langsung ke penyimpanan lokal ponsel Anda. Nyalakan radio Anda dan sambungkan ke ponsel Anda melalui USB, pastikan untuk memilih mode "USB Storage" di radio Anda dan transfer file ke folder `SCRIPTS/TOOLS` Anda menggunakan pengelola file ponsel Anda.

**Catatan:** Anda perlu menghapus versi sebelumnya dari script elrs.lua (misalnya, elrs_v2.lua, elrs_v3.lua, dll) dari kartu SD radio Anda sebelum menggunakan script baru.

## Bagaimana jika proses flash gagal dan perangkat saya menjadi tidak responsif?
Jika perangkat Anda tidak responsif setelah flash yang gagal, Anda dapat dengan mudah memulihkannya:
1. Tahan tombol BOOT pada perangkat saat mencolokkannya melalui USB untuk masuk ke mode bootloader.
2. Gunakan komputer dan ELRS Web Flasher untuk melakukan re-flash perangkat melalui koneksi USB/UART berkabel.
3. Untuk perangkat yang mendukung Wi-Fi, Anda juga bisa menahan BOOT

**Catatan:** Ada tautan video di Tab Sumber Daya yang menunjukkan cara melakukannya.

## Bisakah saya menyimpan file firmware ke ponsel saya tanpa melakukan flash?
Ya. Dengan masuk ke **Settings** dan mengaktifkan **Expert Mode**, Anda membuka kemampuan untuk menyimpan built binary firmware langsung ke penyimpanan lokal perangkat seluler Anda daripada langsung melakukan flash secara Over-The-Air (OTA).

Ini sangat berguna jika Anda ingin melakukan flash perangkat secara manual menggunakan programmer hardware khusus (seperti STLink atau adaptor FTDI).

## Saya mendapatkan kesalahan "Target Mismatch". Apa yang harus saya lakukan?
Kesalahan "Target Mismatch" terjadi ketika target hardware yang Anda pilih di aplikasi tidak cocok dengan target firmware yang sedang berjalan di perangkat.

Untuk mencegah kerusakan yang tidak disengaja, aplikasi akan memperingatkan Anda jika terdeteksi ketidakcocokan. Namun, jika Anda yakin bahwa target yang dipilih sudah benar (misalnya, jika Anda mengonversi perangkat ke varian firmware yang berbeda atau mengoreksi flash yang salah sebelumnya), Anda dapat mengetuk **FORCE FLASH** di dialog ketidakcocokan untuk mengesampingkan pemeriksaan dan melanjutkan proses flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->