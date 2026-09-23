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
  String get flashingStatusLocating => 'Locating Firmware';

  @override
  String get flashingStatusUnpacking => 'Unpacking Firmware';

  @override
  String get flashingStatusDownloading => 'Downloading Firmware';

  @override
  String get flashingStatusBuilding => 'Building Firmware';

  @override
  String get flashingStatusUploading => 'Uploading to Device';

  @override
  String get flashingStatusFinalizing => 'Writing to Device — Please Wait';

  @override
  String get packetRateLabel => 'Laju Paket';

  @override
  String get baudRateLabel => 'Baud Rate';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Memperbarui firmware $expressLRS pada perangkat keras $radioMaster atau $betaFPV...';
  }

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
  String get flashingWifiCategoryLabel => 'Flashing & WiFi';

  @override
  String get aboutSupportCategoryLabel => 'Tentang & Dukungan';

  @override
  String get advancedCategoryLabel => 'Lanjutan';

  @override
  String get flashingDefaultsSectionLabel => 'Default Flashing';

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
  String get aboutSectionLabel => 'Tentang';

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
  String get flashingStatusSaved => 'Firmware Saved';

  @override
  String get flashErrorNoTarget => 'Please select a target device.';

  @override
  String get flashErrorNoVersion => 'Please select a firmware version.';

  @override
  String get flashErrorNoDevice => 'Cannot flash: no ELRS device connected.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'Incompatible chip: this firmware is built for $targetChip, but the connected device is $deviceChip. Select a target for the same chip.';
  }

  @override
  String get flashErrorOfflineFlash =>
      'No internet access to fetch missing files. Please disconnect from the ELRS device, download this firmware via the Firmware Manager to complete your cache, and try again.';

  @override
  String get flashErrorOfflineDownload =>
      'No internet access. You cannot download firmware while connected to the ELRS device hotspot. Please disconnect, download this version via the Firmware Manager, and try again.';

  @override
  String get flashErrorFlashFailed => 'Flashing failed.';

  @override
  String get flashErrorUnconfirmed =>
      'The device disconnected before confirming the flash, so it may not have completed. This happens if it loses power or restarts mid-flash, and occasionally on a weak WiFi link after a successful flash. Check the firmware version in Device Config, and flash again if it hasn\'t changed.';

  @override
  String get flashErrorDownloadFailed => 'Failed to download firmware.';

  @override
  String get validationSsidTooLong => 'SSID must be 32 characters or less';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get validationPasswordTooLong =>
      'Password must be 63 characters or less';

  @override
  String get targetMismatchTitle => 'Target Mismatch';

  @override
  String get targetMismatchMessage =>
      'The selected firmware target does not match the hardware currently running on the device. Are you sure you want to force flash?';

  @override
  String get forceFlashLabel => 'Force Flash';

  @override
  String get noBindPhraseTitle => 'No Binding Phrase';

  @override
  String get noBindPhraseMessage =>
      'No binding phrase set. Proceed with the default (empty)?';

  @override
  String get flashSuccessSnackbar => 'Flashing completed successfully!';

  @override
  String get firmwareSavedSnackbar => 'Firmware saved successfully!';

  @override
  String get flashSuccessMessage => 'Flashing Successful! Device is rebooting.';

  @override
  String get stm32OtaWarning =>
      'STM32 Target Selected: OTA flashing is not supported for this hardware. You can build and save this firmware locally to flash manually via STLink or Betaflight Passthrough.';

  @override
  String get downloadBinaryLabel => 'Download Binary';

  @override
  String get waitingForDeviceLabel => 'Waiting for Device...';

  @override
  String get otaUnavailableLabel => 'OTA Unavailable';

  @override
  String get doneLabel => 'Done';

  @override
  String get targetSelectionTitle => 'Target Selection';

  @override
  String get deviceTypeLabel => 'Device Type';

  @override
  String get deviceVendorLabel => 'Device Vendor';

  @override
  String get regulatoryFrequencyLabel => 'Regulatory & Frequency';

  @override
  String get deviceTargetLabel => 'Device Target';

  @override
  String get noFirmwareDownloadedButton =>
      'No firmware downloaded. Go to Firmware Manager';

  @override
  String hardwareRequiresVersion(String version) {
    return 'Hardware requires v$version or newer.';
  }

  @override
  String get downloadCompatibleFirmwareButton => 'Download Compatible Firmware';

  @override
  String get firmwareVersionLabel => 'Firmware Version';

  @override
  String get firmwareVersionHelper => 'Select the ELRS version to flash';

  @override
  String get cachedBadge => '(Cached)';

  @override
  String errorLoadingVersions(String error) {
    return 'Error loading versions: $error';
  }

  @override
  String get flashingProfileLabel => 'Flashing Profile';

  @override
  String get addProfileTooltip => 'Add Profile';

  @override
  String get deleteProfileTooltip => 'Delete Profile';

  @override
  String get bindingPhraseHelper => 'Your unique binding phrase';

  @override
  String get addProfileTitle => 'Add Flashing Profile';

  @override
  String get profileNameHint => 'Profile Name (e.g., My Quads)';

  @override
  String get addLabel => 'Add';

  @override
  String get deleteProfileTitle => 'Delete Profile';

  @override
  String deleteProfileMessage(String name) {
    return 'Are you sure you want to delete the profile \"$name\"?';
  }

  @override
  String get deleteLabel => 'Delete';

  @override
  String get settingsCategoryProfilesNetwork => 'Profiles & Network';

  @override
  String get settingsCategoryAppStorage => 'App & Storage';

  @override
  String get settingsCategoryAdvancedDebug => 'Advanced & Debug';

  @override
  String get settingsCategoryAboutLegal => 'About & Legal';

  @override
  String get settingsSectionRegulatoryDefaults => 'Regulatory Defaults';

  @override
  String get settingsSectionPreferences => 'Preferences';

  @override
  String get settingsSectionPowerTools => 'Power Tools';

  @override
  String get settingsSectionDiagnostics => 'Diagnostics';

  @override
  String get regDomainUnknown => 'Unknown';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versions',
      one: '1 version',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'Edit $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'Enter $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua saved to device!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'Failed to save script: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'Submitted! Event ID: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'Report submitted successfully!';

  @override
  String debugReportFailed(String error) {
    return 'Failed to submit: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'Error loading license: $error';
  }
}
