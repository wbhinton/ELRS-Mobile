// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Frasa Pengikatan';

  @override
  String get networkSsidLabel => 'SSID WiFi';

  @override
  String get flashingButtonLabel => 'Flash';

  @override
  String get flashingStatusLocating => 'Mencari Firmware';

  @override
  String get flashingStatusUnpacking => 'Mengekstrak Firmware';

  @override
  String get flashingStatusDownloading => 'Mengunduh Firmware';

  @override
  String get flashingStatusBuilding => 'Membangun Firmware';

  @override
  String get flashingStatusUploading => 'Mengunggah ke Perangkat';

  @override
  String get flashingStatusFinalizing => 'Menulis ke Perangkat — Harap Tunggu';

  @override
  String get flashDeviceLabel => 'Flash Perangkat';

  @override
  String get deviceConfigLabel => 'Konfigurasi Perangkat';

  @override
  String get firmwareManagerLabel => 'Manajer Firmware';

  @override
  String get settingsLabel => 'Pengaturan';

  @override
  String get helpSupportLabel => 'Bantuan & Dukungan';

  @override
  String get noDeviceFoundLabel => 'Perangkat Tidak Ditemukan';

  @override
  String get retryLabel => 'Coba Lagi';

  @override
  String get manualConnectionLabel => 'Koneksi Manual';

  @override
  String get manualIpOverrideLabel => 'Timpa IP Manual';

  @override
  String get connectLabel => 'Hubungkan';

  @override
  String get cancelLabel => 'Batal';

  @override
  String get matchedLabel => 'Cocok';

  @override
  String get mismatchLabel => 'Tidak Cocok';

  @override
  String connectedLabel(String ip) {
    return 'Terhubung: $ip';
  }

  @override
  String get default24GHzDomainLabel => 'Domain Default 2.4GHz';

  @override
  String get defaultSubGHzDomainLabel => 'Domain Default Sub-GHz';

  @override
  String get globalBindingPhraseLabel => 'Frasa Pengikatan Global';

  @override
  String get homeWifiSsidLabel => 'SSID WiFi Rumah';

  @override
  String get homeWifiPasswordLabel => 'Kata Sandi WiFi Rumah';

  @override
  String get manageCachedFirmwareLabel => 'Kelola Firmware Tersimpan';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'Unduh atau hapus firmware offline';

  @override
  String get maxCachedVersionsLabel => 'Versi Tersimpan Maks';

  @override
  String get clearFirmwareCacheLabel => 'Hapus Cache Firmware';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'Hapus semua file firmware yang diunduh';

  @override
  String get clearLabel => 'HAPUS';

  @override
  String get appVersionLabel => 'Versi Aplikasi';

  @override
  String get legalLicenseLabel => 'Hukum & Lisensi';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'Penyangkalan standar dan Lisensi GPLv3';

  @override
  String get supportDevelopmentLabel => 'Dukung Pengembangan';

  @override
  String get supportDevelopmentSubtitle => 'Dukung pengembang melalui Ko-fi';

  @override
  String get shareAnalyticsLabel => 'Bagikan Analitik';

  @override
  String get shareAnalyticsSubtitle =>
      'Bantu tingkatkan aplikasi dengan membagikan data penggunaan anonim';

  @override
  String get expertModeLabel => 'Mode Ahli';

  @override
  String get expertModeSubtitle =>
      'Aktifkan penanganan dan pengunduhan firmware lanjutan';

  @override
  String get exportElrsLuaScriptLabel => 'Ekspor Skrip ELRS Lua';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'Simpan elrs.lua untuk radio EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel => 'Kirim Laporan Debug ke Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'Bantu kami memperbaiki bug dengan membagikan log sistem anonim';

  @override
  String get clearFirmwareCacheTitle => 'Hapus Cache Firmware?';

  @override
  String get clearFirmwareCacheMessage =>
      'Ini akan menghapus semua file zip firmware yang diunduh. Anda perlu mengunduhnya kembali jika ingin melakukan flash secara offline.';

  @override
  String get clearAllLabel => 'HAPUS SEMUA';

  @override
  String get submitDebugReportTitle => 'Kirim Laporan Debug';

  @override
  String get submitDebugReportMessage =>
      'Ini akan mengirim informasi perangkat dan log aplikasi Anda ke Sentry untuk debugging. Tidak ada informasi pribadi seperti Frasa Pengikatan atau kata sandi WiFi yang akan disertakan.';

  @override
  String get describeIssueHint => 'Mohon jelaskan masalah yang Anda alami...';

  @override
  String get proceedLabel => 'Lanjutkan';

  @override
  String get submittingReportProgress => 'Mengirim laporan…';

  @override
  String get saveLabel => 'Simpan';

  @override
  String get notSetLabel => 'Belum disetel';

  @override
  String get languageOverrideLabel => 'Bahasa';

  @override
  String get languageOverrideSystemDefault => 'Default Sistem';

  @override
  String get legalNoticeSectionTitle => 'Pemberitahuan Hukum';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile adalah proyek gratis dan sumber terbuka (FOSS) yang dikembangkan secara independen oleh Weston Hinton. Proyek ini bukan produk resmi ExpressLRS LLC dan tidak didukung, diakui, atau disertifikasi secara resmi oleh tim pengembangan ExpressLRS.';

  @override
  String get trademarkNoticeSectionTitle => 'Pemberitahuan Merek Dagang';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS dan logo ExpressLRS adalah merek dagang dari ExpressLRS LLC. Penggunaan merek ini hanya untuk tujuan deskriptif dan kompatibilitas. Untuk konfigurator dan dokumentasi resmi ExpressLRS, silakan kunjungi expresslrs.org.';

  @override
  String get officialSupportSectionTitle => 'Dukungan Resmi';

  @override
  String get officialSupportSectionText => 'Dukung proyek resmi ExpressLRS: ';

  @override
  String get donateOpenCollectiveLabel => 'Donasi melalui Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'Lisensi Perangkat Lunak';

  @override
  String get gplv3NoticeText =>
      'Proyek ini dilisensikan di bawah GNU General Public License v3.0.';

  @override
  String get tabFlashingGuide => 'Panduan Flashing';

  @override
  String get tabFaq => 'FAQ';

  @override
  String get tabResources => 'Sumber Daya';

  @override
  String get resourceCommunitySupport => 'Komunitas & Dukungan';

  @override
  String get resourceDiscordCommunity => 'Komunitas Discord';

  @override
  String get resourceJoinDiscord => 'Gabung Discord ELRS';

  @override
  String get resourceGithubRepo => 'Repositori GitHub';

  @override
  String get resourceFlashRecovery => 'Pemulihan Flash';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'Jika perangkat Anda tampak tidak responsif setelah gagal flash:';

  @override
  String get resourceRecoveryStep1 =>
      'Tahan tombol BOOT saat menyambungkan via USB untuk masuk mode bootloader.';

  @override
  String get resourceRecoveryStep2 =>
      'Gunakan ELRS Web Flasher di expresslrs.org/flasher untuk flash ulang via USB/UART.';

  @override
  String get resourceRecoveryStep3 =>
      'Untuk perangkat berkemampuan WiFi, tahan BOOT selama 60 detik untuk memicu mode pemulihan Hotspot WiFi.';

  @override
  String get resourceRecoveryStep4 =>
      'Gabung #help di Discord ELRS — komunitas biasanya dapat memulihkan perangkat apa pun.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Panduan unbricking Joshua Bardwell sangat direkomendasikan:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'Video Pemulihan';

  @override
  String get resourceLegalLiability => 'Hukum & Tanggung Jawab';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile disediakan apa adanya, tanpa jaminan apa pun. Pengembang tidak bertanggung jawab atas kerusakan, kehilangan data, atau perangkat keras yang tidak berfungsi akibat penggunaan aplikasi ini, termasuk namun tidak terbatas pada receiver, transmitter, atau flight controller yang \'bricked\'.\n\nDengan menggunakan aplikasi ini Anda menerima tanggung jawab penuh atas perangkat keras Anda.';

  @override
  String get resourceViewFullDisclaimerButton => 'Lihat Penafian Lengkap';

  @override
  String get disclaimerTitle => 'Gunakan dengan Risiko Anda Sendiri';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile disediakan apa adanya, tanpa jaminan apa pun.';

  @override
  String get disclaimerLiability =>
      'Pengembang tidak bertanggung jawab atas kerusakan, kehilangan data, atau perangkat keras yang tidak berfungsi akibat penggunaan aplikasi ini, termasuk namun tidak terbatas pada receiver, transmitter, atau flight controller yang \'bricked\'.';

  @override
  String get disclaimerAgreement =>
      'Dengan menggunakan aplikasi ini, Anda mengonfirmasi bahwa Anda memahami risiko flashing firmware kustom dan menerima tanggung jawab penuh atas perangkat keras Anda.';

  @override
  String get disclaimerVerification =>
      'Selalu verifikasi target dan versi firmware sebelum flashing. Simpan catatan firmware asli Anda jika memungkinkan.';

  @override
  String get disclaimerUnderstand => 'Saya Mengerti';

  @override
  String get optionsTitle => 'Opsi Firmware';

  @override
  String get optionsSubtitle =>
      'Konfigurasi pengikatan dan kredensial jaringan.';

  @override
  String get wifiPasswordLabel => 'Kata Sandi WiFi';

  @override
  String get wifiOnIntervalLabel => 'Interval Nyala Otomatis WiFi';

  @override
  String get regulatoryDomainLabel => 'Domain Regulasi';

  @override
  String get regDomainIsm => 'ISM (2.4GHz)';

  @override
  String get regDomainEuLbt => 'EU CE (2.4GHz LBT)';

  @override
  String get regDomainAu915 => 'AU (915MHz)';

  @override
  String get regDomainFcc915 => 'FCC (915MHz)';

  @override
  String get regDomainEu868 => 'EU (868MHz)';

  @override
  String get regDomainIn866 => 'IN (866MHz)';

  @override
  String get regDomainAu433 => 'AU (433MHz)';

  @override
  String get regDomainEu433 => 'EU (433MHz)';

  @override
  String get regDomainUs433 => 'US (433MHz)';

  @override
  String get flashingStatusSaved => 'Firmware Tersimpan';

  @override
  String get flashErrorNoTarget => 'Harap pilih perangkat target.';

  @override
  String get flashErrorNoVersion => 'Harap pilih versi firmware.';

  @override
  String get flashErrorNoDevice =>
      'Tidak dapat melakukan flash: tidak ada perangkat ELRS yang terhubung.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Chip tidak kompatibel: firmware ini dibuat untuk $targetChip, tetapi perangkat yang terhubung adalah $deviceChip. Pilih target untuk chip yang sama.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'Tidak ada akses internet untuk mengambil berkas yang hilang. Harap putuskan sambungan dari perangkat ELRS, unduh firmware ini melalui Manajer Firmware untuk melengkapi cache Anda, lalu coba lagi.';

  @override
  String get flashErrorOfflineDownload =>
      'Tidak ada akses internet. Anda tidak dapat mengunduh firmware saat terhubung ke hotspot perangkat ELRS. Harap putuskan sambungan, unduh versi ini melalui Manajer Firmware, lalu coba lagi.';

  @override
  String get flashErrorFlashFailed => 'Penge-flash-an gagal.';

  @override
  String get flashErrorUnconfirmed =>
      'Perangkat terputus sebelum mengonfirmasi flash, sehingga mungkin belum selesai. Ini terjadi jika perangkat kehilangan daya atau memulai ulang di tengah proses flash, dan terkadang pada tautan WiFi yang lemah setelah flash berhasil. Periksa versi firmware di Konfigurasi Perangkat, dan flash lagi jika belum berubah.';

  @override
  String get flashErrorDownloadFailed => 'Gagal mengunduh firmware.';

  @override
  String get validationSsidTooLong => 'SSID harus 32 karakter atau kurang';

  @override
  String get validationPasswordTooShort => 'Kata sandi minimal 8 karakter';

  @override
  String get validationPasswordTooLong =>
      'Kata sandi harus 63 karakter atau kurang';

  @override
  String get targetMismatchTitle => 'Target Tidak Cocok';

  @override
  String get targetMismatchMessage =>
      'Target firmware yang dipilih tidak cocok dengan perangkat keras yang sedang berjalan di perangkat. Anda yakin ingin mem-flash paksa?';

  @override
  String get forceFlashLabel => 'FLASH PAKSA';

  @override
  String get noBindPhraseTitle => 'Tidak Ada Frasa Pengikat';

  @override
  String get noBindPhraseMessage =>
      'Tidak ada frasa pengikat yang diatur. Lanjutkan dengan nilai bawaan (kosong)?';

  @override
  String get flashSuccessSnackbar => 'Flash berhasil!';

  @override
  String get firmwareSavedSnackbar => 'Firmware berhasil disimpan!';

  @override
  String get flashSuccessMessage =>
      'Penge-flash-an Berhasil! Perangkat sedang memulai ulang.';

  @override
  String get stm32OtaWarning =>
      'Target STM32 Terpilih: Flashing OTA tidak didukung untuk perangkat keras ini. Anda dapat membuat dan menyimpan firmware ini secara lokal untuk mem-flash secara manual melalui STLink atau Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'UNDUH BINER';

  @override
  String get waitingForDeviceLabel => 'MENUNGGU PERANGKAT...';

  @override
  String get otaUnavailableLabel => 'OTA Tidak Tersedia';

  @override
  String get doneLabel => 'SELESAI';

  @override
  String get targetSelectionTitle => 'Pilihan Target';

  @override
  String get deviceTypeLabel => 'Jenis Perangkat';

  @override
  String get deviceVendorLabel => 'Vendor Perangkat';

  @override
  String get regulatoryFrequencyLabel => 'Regulasi & Frekuensi';

  @override
  String get deviceTargetLabel => 'Target Perangkat';

  @override
  String get noFirmwareDownloadedButton =>
      'Tidak ada firmware diunduh. Buka Pengelola Firmware';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Hardware membutuhkan v$version atau yang lebih baru.';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'Unduh Firmware yang Kompatibel';

  @override
  String get firmwareVersionLabel => 'Versi Firmware';

  @override
  String get firmwareVersionHelper => 'Pilih versi ELRS untuk di-flash';

  @override
  String get cachedBadge => '(Tersimpan)';

  @override
  String errorLoadingVersions(String error) {
    return 'Gagal memuat versi: $error';
  }

  @override
  String get flashingProfileLabel => 'Profil Flashing';

  @override
  String get addProfileTooltip => 'Tambah Profil';

  @override
  String get deleteProfileTooltip => 'Hapus Profil';

  @override
  String get bindingPhraseHelper => 'Frasa ikatan unik Anda';

  @override
  String get addProfileTitle => 'Tambah Profil Flashing';

  @override
  String get profileNameHint => 'Nama Profil (misalnya, Quad Saya)';

  @override
  String get addLabel => 'Tambah';

  @override
  String get deleteProfileTitle => 'Hapus Profil';

  @override
  String deleteProfileMessage(String name) {
    return 'Anda yakin ingin menghapus profil \"$name\"?';
  }

  @override
  String get deleteLabel => 'Hapus';

  @override
  String get settingsCategoryProfilesNetwork => 'Profil & Jaringan';

  @override
  String get settingsCategoryAppStorage => 'Aplikasi & Penyimpanan';

  @override
  String get settingsCategoryAdvancedDebug => 'Lanjutan & Debug';

  @override
  String get settingsCategoryAboutLegal => 'Tentang & Hukum';

  @override
  String get settingsSectionRegulatoryDefaults => 'Default Regulasi';

  @override
  String get settingsSectionPreferences => 'Preferensi';

  @override
  String get settingsSectionPowerTools => 'Alat Canggih';

  @override
  String get settingsSectionDiagnostics => 'Diagnostik';

  @override
  String get regDomainUnknown => 'Tidak Diketahui';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versi',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Edit $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Masukkan $field';
  }

  @override
  String get luaScriptSavedSnackbar =>
      'elrs.lua berhasil disimpan ke perangkat!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Gagal menyimpan skrip: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Terkirim! ID Acara: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Laporan berhasil dikirim!';

  @override
  String debugReportFailed(String error) {
    return 'Gagal mengirim: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Kesalahan memuat lisensi: $error';
  }

  @override
  String get firmwareErrorLoadFailed => 'Tidak dapat memuat versi firmware.';

  @override
  String get firmwareErrorOnHotspot =>
      'Tidak dapat mengunduh firmware saat terhubung langsung ke hotspot WiFi penerima. Harap putuskan sambungan atau gunakan jaringan rumah.';

  @override
  String get firmwareErrorCacheFull =>
      'Batas cache tercapai. Harap hapus versi lama.';

  @override
  String get firmwareErrorServerUnreachable =>
      'Tidak dapat menjangkau server firmware. Harap periksa koneksi internet Anda.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'Unduhan terputus: koneksi jaringan terputus. Harap periksa koneksi Anda dan coba lagi.';

  @override
  String get firmwareErrorDownloadFailed => 'Gagal mengunduh firmware.';

  @override
  String get firmwareErrorDeleteFailed =>
      'Tidak dapat menghapus versi firmware ini.';

  @override
  String firmwareVersionTitle(String version) {
    return 'Versi $version';
  }

  @override
  String get readyForOfflineUse => 'Siap untuk penggunaan offline';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'Penyimpanan Digunakan: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit Versi';
  }

  @override
  String get splashTagline => 'Alat Konfigurasi Independen';

  @override
  String get splashDisclaimer =>
      'Bukan produk resmi ExpressLRS.\nKompatibel dengan firmware 3.3.x/4.x.';

  @override
  String get unknownDeviceName => 'Perangkat ELRS';

  @override
  String get unknownIpLabel => 'IP Tidak Dikenal';

  @override
  String get firmwareBinariesFileType => 'Biner Firmware';

  @override
  String helpContentLoadFailed(String error) {
    return 'Gagal memuat konten bantuan: $error';
  }
}
