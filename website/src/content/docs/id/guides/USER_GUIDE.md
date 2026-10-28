---
title: "Panduan Pengguna"
slug: id/user_guide
sidebar:
  order: 1
---

ELRS Mobile mem-flash dan mengonfigurasi receiver (RX) dan transmitter (TX) ExpressLRS dari ponsel Anda, melalui Wi-Fi, tanpa laptop dan tanpa koneksi internet di lapangan. Ini berfungsi dengan perangkat keras berbasis ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) dan firmware ExpressLRS 3.3.x dan 4.x. Lihat [Perangkat Keras yang Didukung](/supported_hardware) untuk setiap perangkat yang kompatibel.

Alur kerjanya memiliki dua bagian: unduh firmware saat Anda memiliki internet, lalu flash di mana saja.

---

## Instalasi

| Platform | Tempat mendapatkannya |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone dan iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, tanpa Google Play | [Unduh APK Langsung](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), atau [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Versi toko diperbarui melalui Google Play dan App Store. APK unduhan langsung memeriksa rilis baru sekali sehari dan menawarkan untuk mengunduhnya; Anda juga dapat memeriksa kapan saja dari **Settings → About & Legal → Check for Updates**, melewatkan versi, atau diingatkan nanti. Pengaturan dan profil Anda tetap tersimpan saat Anda menginstal pembaruan.

Ingin fitur baru lebih awal? Bergabunglah dengan [beta Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) atau [beta TestFlight](https://testflight.apple.com/join/jwU1WrpX).

Saat peluncuran pertama, aplikasi menampilkan penafian singkat. Flashing firmware selalu membawa beberapa risiko pada perangkat keras Anda; terima untuk melanjutkan.

---

## Mulai cepat: mem-flash perangkat pertama Anda

### Langkah 1: Unduh firmware (di rumah)

1. Di Dashboard, buka **Firmware Manager**.
2. Ketuk ikon unduh di samping versi ExpressLRS yang Anda inginkan. Hanya versi 3.3.0 dan yang lebih baru yang terdaftar: ini adalah yang pertama dengan firmware terpadu yang dibangun oleh ELRS Mobile.
3. Saat unduhan selesai, versi menunjukkan **Ready for offline use** (Siap untuk penggunaan offline). Firmware dan definisi perangkat keras yang dibutuhkan sekarang tersimpan di ponsel Anda.

Unduh firmware melalui Wi-Fi rumah atau data seluler Anda. Anda tidak dapat mengunduh saat ponsel Anda terhubung ke hotspot Wi-Fi receiver atau transmitter, karena jaringan tersebut tidak memiliki internet.

Header menunjukkan berapa banyak versi yang telah Anda simpan dari batas Anda. Ubah batas di **Settings → App & Storage → Max Cached Versions**, dan hapus versi yang tidak lagi Anda butuhkan.

### Langkah 2: Sambungkan ke perangkat Anda

1. Nyalakan receiver atau transmitter Anda dan tunggu hingga hotspot Wi-Fi-nya menyala. Secara default ini terjadi 60 detik setelah dinyalakan jika belum terhubung dengan pasangannya. Transmitter juga dapat menyalakan Wi-Fi dari skrip ExpressLRS Lua di radio Anda.
2. Di ponsel Anda, gabungkan jaringan **ExpressLRS RX** atau **ExpressLRS TX**. Kata sandinya adalah `expresslrs`.
3. Buka ELRS Mobile. Dashboard menemukan perangkat secara otomatis dan menampilkan nama produknya, versi firmware, target, dan domain regulasi.

Jika Dashboard menunjukkan **No Device Found** (Perangkat Tidak Ditemukan), ketuk **Retry** (Coba Lagi). Jika perangkat Anda berada di jaringan yang berbeda (misalnya, terhubung ke Wi-Fi rumah Anda), ketuk ikon roda gigi pada kartu perangkat dan masukkan alamat IP-nya.

Perangkat yang menjalankan firmware yang lebih lama dari 3.1 juga terdeteksi, sehingga Anda dapat memperbaruinya ke rilis saat ini.

### Langkah 3: Flash

1. Di Dashboard, ketuk **Flash Device**.
2. Periksa target. Aplikasi akan memilih target yang cocok dengan perangkat yang terhubung jika memungkinkan; jika tidak, pilih Tipe Perangkat, Vendor Perangkat, Regulasi & Frekuensi, dan Target Perangkat.
3. Pilih versi firmware. Versi yang sudah Anda unduh ditandai **(Cached)**. Jika perangkat keras membutuhkan versi yang lebih baru dari yang Anda miliki, aplikasi akan memberitahu dan menawarkan untuk mengunduh versi yang kompatibel.
4. Periksa opsi firmware: profil flashing, frasa pengikat (binding phrase), jaringan dan kata sandi Wi-Fi, domain regulasi, dan interval Wi-Fi otomatis menyala.
5. Ketuk **Flash**.

Bilah kemajuan mengikuti setiap langkah: menemukan dan membongkar firmware yang Anda unduh, membangunnya dengan pengaturan Anda, mengunggahnya, dan **Writing to Device — Please Wait** (Menulis ke Perangkat — Harap Tunggu) sementara perangkat menginstalnya dan memulai ulang. Ketika perangkat mengkonfirmasi, Anda akan melihat **Flashing Successful! Device is rebooting** (Flashing Berhasil! Perangkat sedang memulai ulang), dan Dashboard akan terhubung kembali setelah perangkat kembali.

---

## Pemeriksaan keamanan

Aplikasi memeriksa pilihan Anda sebelum flashing dan berhenti jika ada yang terlihat salah.

:::danger[Chip tidak kompatibel]
Firmware untuk satu chip tidak akan pernah bisa berjalan di chip lain (misalnya, firmware ESP32 pada receiver ESP8285). Aplikasi akan memblokir proses flash dan memberi tahu Anda chip mana itu. Pilih target untuk chip perangkat Anda.
:::

:::caution[Target tidak cocok]
Jika target yang dipilih tidak cocok dengan produk yang dilaporkan perangkat, Anda akan melihat **Target Mismatch** (Target Tidak Cocok). Periksa pilihan Anda terlebih dahulu. Jika Anda yakin itu benar (misalnya, memulihkan dari flash yang buruk atau beralih ke definisi target yang lebih baru), ketuk **Force Flash** (Paksa Flash).
:::

:::note[Tidak ada frasa pengikat]
Flashing tanpa frasa pengikat akan berhasil, tetapi perangkat hanya akan terhubung menggunakan frasa default (kosong). Aplikasi akan bertanya sebelum melanjutkan.
:::

:::caution[Flash tidak dikonfirmasi]
Jika perangkat terputus sebelum mengkonfirmasi flash (kehilangan daya, restart, atau koneksi Wi-Fi terputus), aplikasi tidak dapat mengetahui apakah pembaruan selesai. Ini menampilkan peringatan berwarna amber alih-alih melaporkan keberhasilan. Sambungkan kembali dan periksa versi firmware di Dashboard; jika belum berubah, flash lagi.
:::

---

## Profil flashing

Profil flashing menyimpan frasa pengikat (binding phrase), jaringan dan kata sandi Wi-Fi rumah, domain regulasi default, dan interval Wi-Fi otomatis menyala di bawah sebuah nama. Gunakan satu per armada atau pengaturan radio, dan beralih di antara mereka dalam satu ketukan.

Kelola profil di **Settings → Profiles & Network**:

- **Add (Tambah):** ketuk **+**, ketik nama, dan ketuk **Add (Tambah)**.
- **Switch (Beralih):** pilih profil dari daftar **Flashing Profile**. Ini juga tersedia di layar flashing.
- **Edit (Ubah):** ubah bidang apa pun; profil aktif tersimpan secara otomatis.
- **Delete (Hapus):** pilih profil dan ketuk ikon hapus. Anda selalu menyimpan setidaknya satu profil.

Frasa pengikat (binding phrase) dan kata sandi Wi-Fi disimpan dalam penyimpanan aman terenkripsi ponsel Anda.

---

## Konfigurasi perangkat

Di Dashboard, ketuk **Device Config** untuk membuka halaman pengaturan ExpressLRS perangkat yang terhubung di dalam aplikasi. Gunakan untuk mengubah pengaturan Wi-Fi dan pengikatan (binding), pencocokan model, protokol serial, pemetaan output PWM, dan opsi perangkat lainnya. Aplikasi menjaga halaman tetap terkunci ke perangkat Anda.

---

## Pengaturan

| Bagian | Isinya |
| :--- | :--- |
| Profiles & Network | Profil flashing, frasa pengikat (binding phrase), jaringan dan kata sandi Wi-Fi rumah, domain regulasi default 2.4 GHz dan sub-GHz |
| App & Storage | Versi cache maks, Firmware Manager, hapus cache firmware, bahasa aplikasi, analitik penggunaan anonim (aktif secara default; matikan dengan **Share Analytics**) |
| Advanced & Debug | Expert Mode dan alat-alatnya (di bawah) |
| About & Legal | Versi aplikasi, pemberitahuan hukum dan lisensi, dukungan pengembangan, dan **Check for Updates** di APK unduhan langsung |

Ubah bahasa aplikasi dari Settings atau tombol bahasa di bilah atas. ELRS Mobile tersedia dalam 18 bahasa.

---

## Expert Mode

Nyalakan **Settings → Advanced & Debug → Expert Mode** untuk membuka kunci:

- **STM32 targets.** Perangkat keras berbasis STM32 yang lebih lama tidak dapat di-flash melalui Wi-Fi, dan hanya ExpressLRS 3.3.x yang mendukungnya. Aplikasi ini membangun firmware dengan pengaturan Anda sehingga Anda dapat mem-flash-nya dari PC dengan STLink atau passthrough Betaflight.
- **Download Binary.** Simpan file firmware yang telah dibangun alih-alih mem-flash-nya, untuk flashing manual atau audit.
- **Export ELRS Lua Script.** Simpan `elrs.lua` untuk radio EdgeTX dan OpenTX.
- **Submit Debug Report.** Kirim informasi perangkat dan log aplikasi untuk membantu memperbaiki bug. Frasa pengikat (binding phrase) dan kata sandi Wi-Fi tidak pernah disertakan.

---

## Pemecahan Masalah

**Dashboard tidak dapat menemukan perangkat saya.** Pastikan ponsel Anda masih terhubung ke jaringan Wi-Fi perangkat; beberapa ponsel meninggalkan jaringan yang tidak memiliki internet. Di Android, ELRS Mobile menjaga lalu lintasnya pada jaringan Wi-Fi tersebut bahkan tanpa internet. Ketuk **Retry** (Coba Lagi), atau masukkan alamat IP dari ikon roda gigi (`10.0.0.1` pada hotspot perangkat itu sendiri).

**Saya tidak dapat mengunduh firmware.** Putuskan sambungan dari hotspot perangkat dan gunakan jaringan dengan internet.

**Perangkat saya tidak responsif setelah flash gagal.** Tahan tombol BOOT saat menyambungkannya melalui USB untuk masuk mode bootloader, lalu flash ulang dengan [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Perangkat yang mampu Wi-Fi juga dapat dipulihkan dengan menahan BOOT selama 60 detik untuk menyalakan hotspot Wi-Fi. Layar **Help & Support** dalam aplikasi memiliki langkah-langkah ini, FAQ, dan tautan ke ExpressLRS Discord.

**Profil saya hilang setelah pembaruan.** Pembaruan langsung dari v1.0.43 atau lebih lama ke v1.0.45 atau lebih baru tidak dapat membawa profil tersimpan, frasa pengikat (binding phrase), dan pengaturan Wi-Fi melalui peningkatan penyimpanan. Aplikasi memberitahu Anda sekali; masukkan kembali di Settings.

---

Pengembang dapat memverifikasi firmware yang dibangun ELRS Mobile dengan [Firmware Validation Tools](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->