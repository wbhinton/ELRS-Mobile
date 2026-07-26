---
title: "Spesifikasi Teknis"
slug: id/technical_spec
sidebar:
  order: 5
---

## Ikhtisar Arsitektur

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Prinsip Desain</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Aplikasi ini dibangun menggunakan Flutter dan memanfaatkan kerangka kerja manajemen status <strong>Riverpod</strong>. Ini berinteraksi dengan perangkat keras ELRS melalui RESTful API yang diekspos oleh modul WiFi bawaan perangkat, memastikan komunikasi latensi rendah dan sinkronisasi status real-time.
  </p>
</div>

## Lapisan Data

### Titik Akhir API
Sistem berkomunikasi dengan perangkat keras menggunakan titik akhir HTTP berikut:

| Metode | Titik Akhir | Deskripsi |
| :--- | :--- | :--- |
| `GET` | `/config` | Mengambil konfigurasi perangkat saat ini dalam format JSON. |
| `POST` | `/options.json` | Memperbarui opsi runtime yang dapat dimodifikasi (SSID, Kata Sandi, dll.). |
| `POST` | `/config` | Memperbarui parameter perangkat keras inti dan pemetaan PWM. |
| `POST` | `/reboot` | Memicu reset perangkat keras untuk menerapkan perubahan. |

### Skema JSON
Model `RuntimeConfig` memanfaatkan struktur ELRS 4.x, yang memisahkan parameter menjadi tiga node utama:
- `settings`: Pengidentifikasi perangkat keras dan string versi yang hanya dapat dibaca.
- `options`: Preferensi pengguna dan kredensial jaringan yang dapat dimodifikasi.
- `config`: Konfigurasi perangkat keras tingkat rendah (Protokol, Larik PWM).

Contoh struktur JSON:
```json
{
  "product_name": "Test RX",
  "settings": {
    "version": "1.0.0",
    "module-type": "RX"
  },
  "options": {
    "bindPhrase": "example",
    "wifi-ssid": "SSID",
    "domain": 1
  },
  "config": {
    "serial-protocol": 0,
    "pwm": [
      {"channel": 0, "mode": 5}
    ]
  }
}
```

## Manajemen Status
Sistem menggunakan arsitektur reaktif:
- **`ConfigViewModel`**: Mengelola status koneksi langsung, logika heartbeat, dan penemuan IP.
- **`DeviceEditorViewModel`**: Menampung status draf konfigurasi perangkat, memungkinkan pengeditan multi-langkah dengan logika "simpan/batal" akhir.
- **`FlashingController`**: Mengatur unduhan firmware, patching biner lokal, dan proses unggah XH-over-HTTP.

## Lapisan Pemetaan
Tabel berikut mendefinisikan pemetaan antara pengidentifikasi integer yang digunakan dalam API dan padanan yang mudah dibaca manusia.

### Domain Regulasi
| ID | Label | Deskripsi |
| :--- | :--- | :--- |
| 0 | AU915 | Australia/Selandia Baru 915MHz |
| 1 | FCC915 | Amerika Utara 915MHz |
| 2 | EU868 | Eropa 868MHz |
| 3 | IN866 | India 866MHz |
| 4 | AU433 | Australia 433MHz |
| 5 | EU433 | Eropa 433MHz |
| 6 | US433 | Amerika Utara 433MHz |
| 7 | US433-Wide | Amerika Utara Lebar 433MHz |


## Pemetaan Lanjutan

### VBind (Penyimpanan Pengikatan)
Menentukan bagaimana frasa pengikatan disimpan di perangkat.
- **0: Persisten**: Disimpan ke memori flash (standar).
- **1: Volatil**: Dihapus saat siklus daya.
- **2: Dapat Dikembalikan**: Digunakan untuk peralatan pinjaman.
- **3: Dikelola**: Digunakan di lingkungan armada multi-pilot.


## Lapisan Persistensi
Sistem mengimplementasikan strategi persistensi dua lapis:
- **`SharedPreferences`**: Dimanfaatkan melalui `PersistenceService` untuk data non-sensitif seperti WiFi SSID dan preferensi aplikasi umum.
- **`FlutterSecureStorage`**: Digunakan untuk data sensitif, termasuk Frasa Pengikatan dan Kata Sandi WiFi, memastikan enkripsi pada tingkat OS.

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->