// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get bindingPhraseLabel => 'วลีการจับคู่';

  @override
  String get networkSsidLabel => 'ชื่อ Wi-Fi (SSID)';

  @override
  String get flashingButtonLabel => 'แฟลช';

  @override
  String get flashingStatusLocating => 'กำลังค้นหาเฟิร์มแวร์';

  @override
  String get flashingStatusUnpacking => 'กำลังแกะเฟิร์มแวร์';

  @override
  String get flashingStatusDownloading => 'กำลังดาวน์โหลดเฟิร์มแวร์';

  @override
  String get flashingStatusBuilding => 'กำลังสร้างเฟิร์มแวร์';

  @override
  String get flashingStatusUploading => 'กำลังอัปโหลดไปยังอุปกรณ์';

  @override
  String get flashingStatusFinalizing => 'กำลังเขียนลงอุปกรณ์ — โปรดรอ';

  @override
  String get flashDeviceLabel => 'แฟลชอุปกรณ์';

  @override
  String get deviceConfigLabel => 'การตั้งค่าอุปกรณ์';

  @override
  String get firmwareManagerLabel => 'ตัวจัดการเฟิร์มแวร์';

  @override
  String get settingsLabel => 'การตั้งค่า';

  @override
  String get helpSupportLabel => 'ช่วยเหลือและการสนับสนุน';

  @override
  String get noDeviceFoundLabel => 'ไม่พบอุปกรณ์';

  @override
  String get retryLabel => 'ลองใหม่';

  @override
  String get manualConnectionLabel => 'การเชื่อมต่อด้วยตนเอง';

  @override
  String get manualIpOverrideLabel => 'แทนที่ IP ด้วยตนเอง';

  @override
  String get connectLabel => 'เชื่อมต่อ';

  @override
  String get cancelLabel => 'ยกเลิก';

  @override
  String get matchedLabel => 'ตรงกัน';

  @override
  String get mismatchLabel => 'ไม่ตรงกัน';

  @override
  String connectedLabel(String ip) {
    return 'เชื่อมต่อแล้ว: $ip';
  }

  @override
  String get default24GHzDomainLabel => 'โดเมน 2.4GHz เริ่มต้น';

  @override
  String get defaultSubGHzDomainLabel => 'โดเมน Sub-GHz เริ่มต้น';

  @override
  String get globalBindingPhraseLabel => 'วลีการจับคู่ทั่วโลก';

  @override
  String get homeWifiSsidLabel => 'ชื่อ Wi-Fi ที่บ้าน (SSID)';

  @override
  String get homeWifiPasswordLabel => 'รหัสผ่าน Wi-Fi ที่บ้าน';

  @override
  String get manageCachedFirmwareLabel => 'จัดการเฟิร์มแวร์ที่แคช';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel =>
      'ดาวน์โหลดหรือลบเฟิร์มแวร์ออฟไลน์';

  @override
  String get maxCachedVersionsLabel => 'จำนวนเวอร์ชันที่แคชสูงสุด';

  @override
  String get clearFirmwareCacheLabel => 'ล้างแคชเฟิร์มแวร์';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel =>
      'ลบไฟล์เฟิร์มแวร์ที่ดาวน์โหลดทั้งหมด';

  @override
  String get clearLabel => 'ล้าง';

  @override
  String get appVersionLabel => 'เวอร์ชันแอป';

  @override
  String get legalLicenseLabel => 'กฎหมายและใบอนุญาต';

  @override
  String get standardDisclaimerAndGplv3Label =>
      'ข้อความปฏิเสธความรับผิดชอบมาตรฐานและใบอนุญาต GPLv3';

  @override
  String get supportDevelopmentLabel => 'สนับสนุนการพัฒนา';

  @override
  String get supportDevelopmentSubtitle => 'สนับสนุนผู้พัฒนาผ่าน Ko-fi';

  @override
  String get shareAnalyticsLabel => 'แชร์ข้อมูลวิเคราะห์';

  @override
  String get shareAnalyticsSubtitle =>
      'ช่วยปรับปรุงแอปโดยการแชร์ข้อมูลการใช้งานที่ไม่ระบุตัวตน';

  @override
  String get expertModeLabel => 'โหมดผู้เชี่ยวชาญ';

  @override
  String get expertModeSubtitle =>
      'เปิดใช้งานการจัดการและดาวน์โหลดเฟิร์มแวร์ขั้นสูง';

  @override
  String get exportElrsLuaScriptLabel => 'ส่งออกสคริปต์ ELRS Lua';

  @override
  String get exportElrsLuaScriptSubtitle =>
      'บันทึก elrs.lua สำหรับวิทยุ EdgeTX/OpenTX';

  @override
  String get submitDebugReportLabel => 'ส่งรายงานข้อผิดพลาดไปยัง Sentry';

  @override
  String get submitDebugReportSubtitle =>
      'ช่วยเราแก้ไขข้อผิดพลาดโดยการแชร์บันทึกระบบที่ไม่ระบุตัวตน';

  @override
  String get clearFirmwareCacheTitle => 'ล้างแคชเฟิร์มแวร์?';

  @override
  String get clearFirmwareCacheMessage =>
      'การดำเนินการนี้จะลบไฟล์ Zip เฟิร์มแวร์ที่ดาวน์โหลดทั้งหมด คุณจะต้องดาวน์โหลดใหม่อีกครั้งหากต้องการแฟลชแบบออฟไลน์';

  @override
  String get clearAllLabel => 'ล้างทั้งหมด';

  @override
  String get submitDebugReportTitle => 'ส่งรายงานข้อผิดพลาด';

  @override
  String get submitDebugReportMessage =>
      'การดำเนินการนี้จะส่งข้อมูลอุปกรณ์และบันทึกแอปของคุณไปยัง Sentry เพื่อการดีบัก จะไม่มีข้อมูลส่วนบุคคล เช่น วลีการจับคู่ หรือรหัสผ่าน Wi-Fi รวมอยู่ด้วย';

  @override
  String get describeIssueHint => 'โปรดอธิบายปัญหาที่คุณกำลังประสบ...';

  @override
  String get proceedLabel => 'ดำเนินการต่อ';

  @override
  String get submittingReportProgress => 'กำลังส่งรายงาน...';

  @override
  String get saveLabel => 'บันทึก';

  @override
  String get notSetLabel => 'ไม่ได้ตั้งค่า';

  @override
  String get languageOverrideLabel => 'ภาษา';

  @override
  String get languageOverrideSystemDefault => 'ค่าเริ่มต้นของระบบ';

  @override
  String get legalNoticeSectionTitle => 'ประกาศทางกฎหมาย';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile เป็นโครงการโอเพนซอร์ส (FOSS) ที่พัฒนาอย่างอิสระโดย Weston Hinton โครงการนี้ไม่ใช่ผลิตภัณฑ์อย่างเป็นทางการของ ExpressLRS LLC และไม่ได้รับการสนับสนุน รับรอง หรือรับรองอย่างเป็นทางการจากทีมพัฒนา ExpressLRS';

  @override
  String get trademarkNoticeSectionTitle => 'ประกาศเครื่องหมายการค้า';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS และโลโก้ ExpressLRS เป็นเครื่องหมายการค้าของ ExpressLRS LLC การใช้เครื่องหมายเหล่านี้มีวัตถุประสงค์เพื่อการอธิบายและเข้ากันได้เท่านั้น หากต้องการคอนฟิกูเรเตอร์และเอกสารประกอบอย่างเป็นทางการของ ExpressLRS โปรดเยี่ยมชม expresslrs.org';

  @override
  String get officialSupportSectionTitle => 'การสนับสนุนอย่างเป็นทางการ';

  @override
  String get officialSupportSectionText =>
      'สนับสนุนโครงการ ExpressLRS อย่างเป็นทางการ: ';

  @override
  String get donateOpenCollectiveLabel => 'บริจาคผ่าน Open Collective';

  @override
  String get softwareLicenseSectionTitle => 'ใบอนุญาตซอฟต์แวร์';

  @override
  String get gplv3NoticeText =>
      'โครงการนี้ได้รับอนุญาตภายใต้ GNU General Public License v3.0';

  @override
  String get tabFlashingGuide => 'คู่มือการแฟลช';

  @override
  String get tabFaq => 'คำถามที่พบบ่อย';

  @override
  String get tabResources => 'แหล่งข้อมูล';

  @override
  String get resourceCommunitySupport => 'ชุมชนและการสนับสนุน';

  @override
  String get resourceDiscordCommunity => 'ชุมชน Discord';

  @override
  String get resourceJoinDiscord => 'เข้าร่วม ELRS Discord';

  @override
  String get resourceGithubRepo => 'ที่เก็บ GitHub';

  @override
  String get resourceFlashRecovery => 'การกู้คืนการแฟลช';

  @override
  String get resourceDeviceUnresponsiveInfo =>
      'หากอุปกรณ์ของคุณไม่ตอบสนองหลังจากการแฟลชล้มเหลว:';

  @override
  String get resourceRecoveryStep1 =>
      'กดปุ่ม BOOT ค้างไว้ขณะเสียบสาย USB เพื่อเข้าสู่โหมดบูตโหลดเดอร์';

  @override
  String get resourceRecoveryStep2 =>
      'ใช้ ELRS Web Flasher ที่ expresslrs.org/flasher เพื่อแฟลชซ้ำผ่าน USB/UART';

  @override
  String get resourceRecoveryStep3 =>
      'สำหรับอุปกรณ์ที่รองรับ WiFi ให้กดปุ่ม BOOT ค้างไว้ 60 วินาทีเพื่อเปิดใช้งานโหมดกู้คืนฮอตสปอต WiFi';

  @override
  String get resourceRecoveryStep4 =>
      'เข้าร่วม #help บน ELRS Discord — ชุมชนมักจะสามารถกู้อุปกรณ์ใดก็ได้';

  @override
  String get resourceBardwellGuideRecommended =>
      'ขอแนะนำคู่มือการกู้คืนอุปกรณ์ที่เสียหายของ Joshua Bardwell อย่างยิ่ง:';

  @override
  String get resourceWebFlasherButton => 'Web Flasher';

  @override
  String get resourceRecoveryVideoButton => 'วิดีโอการกู้คืน';

  @override
  String get resourceLegalLiability => 'กฎหมายและความรับผิด';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile ให้บริการตามสภาพที่เป็นอยู่ โดยไม่มีการรับประกันใดๆ ผู้พัฒนาจะไม่รับผิดชอบต่อความเสียหาย การสูญหายของข้อมูล หรือฮาร์ดแวร์ที่ไม่ทำงานอันเป็นผลมาจากการใช้แอปพลิเคชันนี้ รวมถึงแต่ไม่จำกัดเพียงเครื่องรับ เครื่องส่ง หรือตัวควบคุมการบินที่เสียหายถาวร (bricked).\n\nการใช้แอปนี้แสดงว่าคุณยอมรับความรับผิดชอบทั้งหมดสำหรับฮาร์ดแวร์ของคุณ';

  @override
  String get resourceViewFullDisclaimerButton =>
      'ดูข้อจำกัดความรับผิดชอบฉบับเต็ม';

  @override
  String get disclaimerTitle => 'ใช้ด้วยความเสี่ยงของคุณเอง';

  @override
  String get disclaimerHeader =>
      'ELRS Mobile ให้บริการตามสภาพที่เป็นอยู่ โดยไม่มีการรับประกันใดๆ';

  @override
  String get disclaimerLiability =>
      'ผู้พัฒนาจะไม่รับผิดชอบต่อความเสียหาย การสูญหายของข้อมูล หรือฮาร์ดแวร์ที่ไม่ทำงานอันเป็นผลมาจากการใช้แอปพลิเคชันนี้ รวมถึงแต่ไม่จำกัดเพียงเครื่องรับ เครื่องส่ง หรือตัวควบคุมการบินที่เสียหายถาวร (bricked).';

  @override
  String get disclaimerAgreement =>
      'การใช้แอปนี้แสดงว่าคุณยืนยันว่าเข้าใจความเสี่ยงของการแฟลชเฟิร์มแวร์แบบกำหนดเอง และยอมรับความรับผิดชอบทั้งหมดสำหรับฮาร์ดแวร์ของคุณ';

  @override
  String get disclaimerVerification =>
      'ตรวจสอบเป้าหมายและเวอร์ชันเฟิร์มแวร์เสมอก่อนแฟลช เก็บบันทึกเฟิร์มแวร์เดิมของคุณไว้หากเป็นไปได้';

  @override
  String get disclaimerUnderstand => 'ฉันเข้าใจ';

  @override
  String get optionsTitle => 'ตัวเลือกเฟิร์มแวร์';

  @override
  String get optionsSubtitle =>
      'กำหนดค่าการผูก (binding) และข้อมูลประจำตัวเครือข่าย';

  @override
  String get wifiPasswordLabel => 'รหัสผ่าน WiFi';

  @override
  String get wifiOnIntervalLabel => 'ระยะเวลาเปิด WiFi อัตโนมัติ';

  @override
  String get regulatoryDomainLabel => 'โดเมนกำกับดูแล';

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
  String get flashingStatusSaved => 'บันทึกเฟิร์มแวร์แล้ว';

  @override
  String get flashErrorNoTarget => 'โปรดเลือกอุปกรณ์เป้าหมาย';

  @override
  String get flashErrorNoVersion => 'โปรดเลือกเวอร์ชันเฟิร์มแวร์';

  @override
  String get flashErrorNoDevice =>
      'ไม่สามารถแฟลชได้: ไม่มีอุปกรณ์ ELRS เชื่อมต่ออยู่';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return 'ชิปไม่เข้ากัน: เฟิร์มแวร์นี้สร้างมาสำหรับ $targetChip แต่ในอุปกรณ์ที่เชื่อมต่อคือ $deviceChip โปรดเลือกอุปกรณ์เป้าหมายสำหรับชิปตัวเดียวกัน';
  }

  @override
  String get flashErrorOfflineFlash =>
      'ไม่สามารถเข้าถึงอินเทอร์เน็ตเพื่อดึงไฟล์ที่ขาดหายไปได้ โปรดยกเลิกการเชื่อมต่อจากอุปกรณ์ ELRS ดาวน์โหลดเฟิร์มแวร์นี้ผ่านตัวจัดการเฟิร์มแวร์ เพื่อทำให้แคชของคุณสมบูรณ์ และลองอีกครั้ง';

  @override
  String get flashErrorOfflineDownload =>
      'ไม่สามารถเข้าถึงอินเทอร์เน็ตได้ คุณไม่สามารถดาวน์โหลดเฟิร์มแวร์ในขณะที่เชื่อมต่อกับฮอตสปอตอุปกรณ์ ELRS ได้ โปรดยกเลิกการเชื่อมต่อ ดาวน์โหลดเวอร์ชันนี้ผ่านตัวจัดการเฟิร์มแวร์ และลองอีกครั้ง';

  @override
  String get flashErrorFlashFailed => 'การแฟลชล้มเหลว';

  @override
  String get flashErrorUnconfirmed =>
      'อุปกรณ์หลุดการเชื่อมต่อก่อนยืนยันการแฟลช จึงอาจยังไม่สมบูรณ์ กรณีนี้เกิดขึ้นได้หากอุปกรณ์สูญเสียพลังงานหรือรีสตาร์ทกลางคันระหว่างการแฟลช และบางครั้งก็เกิดขึ้นจากการเชื่อมต่อ Wi-Fi ไม่เสถียรหลังการแฟลชสำเร็จ ตรวจสอบเวอร์ชันเฟิร์มแวร์ใน \'การตั้งค่าอุปกรณ์\' และแฟลชอีกครั้งหากยังไม่เปลี่ยนแปลง';

  @override
  String get flashErrorDownloadFailed => 'ไม่สามารถดาวน์โหลดเฟิร์มแวร์ได้';

  @override
  String get validationSsidTooLong => 'SSID ต้องมีความยาวไม่เกิน 32 ตัวอักษร';

  @override
  String get validationPasswordTooShort =>
      'รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร';

  @override
  String get validationPasswordTooLong =>
      'รหัสผ่านต้องมีความยาวไม่เกิน 63 ตัวอักษร';

  @override
  String get targetMismatchTitle => 'เป้าหมายไม่ตรงกัน';

  @override
  String get targetMismatchMessage =>
      'เป้าหมายเฟิร์มแวร์ที่เลือกไม่ตรงกับฮาร์ดแวร์ที่ใช้งานบนอุปกรณ์ปัจจุบัน คุณแน่ใจหรือไม่ว่าต้องการแฟลชแบบบังคับ?';

  @override
  String get forceFlashLabel => 'แฟลชแบบบังคับ';

  @override
  String get noBindPhraseTitle => 'ไม่มี Binding Phrase';

  @override
  String get noBindPhraseMessage =>
      'ไม่ได้ตั้งค่า Binding Phrase ดำเนินการต่อด้วยค่าเริ่มต้น (ว่างเปล่า) หรือไม่?';

  @override
  String get flashSuccessSnackbar => 'แฟลชเฟิร์มแวร์สำเร็จแล้ว!';

  @override
  String get firmwareSavedSnackbar => 'บันทึกเฟิร์มแวร์สำเร็จแล้ว!';

  @override
  String get flashSuccessMessage => 'แฟลชสำเร็จ! อุปกรณ์กำลังรีบูต';

  @override
  String get stm32OtaWarning =>
      'เลือกเป้าหมาย STM32: ฮาร์ดแวร์นี้ไม่รองรับการแฟลชแบบ OTA คุณสามารถสร้างและบันทึกเฟิร์มแวร์นี้ในเครื่องเพื่อแฟลชด้วยตนเองผ่าน STLink หรือ Betaflight Passthrough';

  @override
  String get downloadBinaryLabel => 'ดาวน์โหลดไบนารี';

  @override
  String get waitingForDeviceLabel => 'กำลังรออุปกรณ์...';

  @override
  String get otaUnavailableLabel => 'OTA ไม่พร้อมใช้งาน';

  @override
  String get doneLabel => 'เสร็จสิ้น';

  @override
  String get targetSelectionTitle => 'การเลือกเป้าหมาย';

  @override
  String get deviceTypeLabel => 'ประเภทอุปกรณ์';

  @override
  String get deviceVendorLabel => 'ผู้ผลิตอุปกรณ์';

  @override
  String get regulatoryFrequencyLabel => 'ข้อบังคับและความถี่';

  @override
  String get deviceTargetLabel => 'เป้าหมายอุปกรณ์';

  @override
  String get noFirmwareDownloadedButton =>
      'ไม่มีเฟิร์มแวร์ดาวน์โหลด ไปที่ตัวจัดการเฟิร์มแวร์';

  @override
  String hardwareRequiresVersion(String version) {
    return 'ฮาร์ดแวร์ต้องการเวอร์ชัน v$version หรือใหม่กว่า';
  }

  @override
  String get downloadCompatibleFirmwareButton =>
      'ดาวน์โหลดเฟิร์มแวร์ที่เข้ากันได้';

  @override
  String get firmwareVersionLabel => 'เวอร์ชันเฟิร์มแวร์';

  @override
  String get firmwareVersionHelper => 'เลือกเวอร์ชัน ELRS ที่จะแฟลช';

  @override
  String get cachedBadge => '(แคชไว้แล้ว)';

  @override
  String errorLoadingVersions(String error) {
    return 'ข้อผิดพลาดในการโหลดเวอร์ชัน: $error';
  }

  @override
  String get flashingProfileLabel => 'โปรไฟล์การแฟลช';

  @override
  String get addProfileTooltip => 'เพิ่มโปรไฟล์';

  @override
  String get deleteProfileTooltip => 'ลบโปรไฟล์';

  @override
  String get bindingPhraseHelper => 'วลีการผูกที่ไม่ซ้ำกันของคุณ';

  @override
  String get addProfileTitle => 'เพิ่มโปรไฟล์การแฟลช';

  @override
  String get profileNameHint => 'ชื่อโปรไฟล์ (เช่น โดรนของฉัน)';

  @override
  String get addLabel => 'เพิ่ม';

  @override
  String get deleteProfileTitle => 'ลบโปรไฟล์';

  @override
  String deleteProfileMessage(String name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบโปรไฟล์ \"$name\"?';
  }

  @override
  String get deleteLabel => 'ลบ';

  @override
  String get settingsCategoryProfilesNetwork => 'โปรไฟล์และเครือข่าย';

  @override
  String get settingsCategoryAppStorage => 'แอปและพื้นที่เก็บข้อมูล';

  @override
  String get settingsCategoryAdvancedDebug => 'ขั้นสูงและการดีบัก';

  @override
  String get settingsCategoryAboutLegal => 'เกี่ยวกับและข้อกฎหมาย';

  @override
  String get settingsSectionRegulatoryDefaults => 'ค่าเริ่มต้นตามกฎระเบียบ';

  @override
  String get settingsSectionPreferences => 'ค่ากำหนด';

  @override
  String get settingsSectionPowerTools => 'เครื่องมือขั้นสูง';

  @override
  String get settingsSectionDiagnostics => 'การวินิจฉัย';

  @override
  String get regDomainUnknown => 'ไม่ทราบ';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count เวอร์ชัน',
      one: '1 เวอร์ชัน',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return 'แก้ไข $field';
  }

  @override
  String enterFieldHint(String field) {
    return 'ป้อน $field';
  }

  @override
  String get luaScriptSavedSnackbar => 'บันทึก elrs.lua ลงอุปกรณ์แล้ว!';

  @override
  String luaScriptSaveFailed(String error) {
    return 'บันทึกสคริปต์ไม่สำเร็จ: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return 'ส่งแล้ว! ID เหตุการณ์: $eventId…';
  }

  @override
  String get debugReportSubmitted => 'รายงานถูกส่งสำเร็จแล้ว!';

  @override
  String debugReportFailed(String error) {
    return 'ส่งไม่สำเร็จ: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return 'เกิดข้อผิดพลาดในการโหลดใบอนุญาต: $error';
  }

  @override
  String get firmwareErrorLoadFailed => 'ไม่สามารถโหลดเวอร์ชันเฟิร์มแวร์ได้';

  @override
  String get firmwareErrorOnHotspot =>
      'ไม่สามารถดาวน์โหลดเฟิร์มแวร์ได้ขณะเชื่อมต่อกับฮอตสปอต Wi-Fi ของตัวรับโดยตรง โปรดตัดการเชื่อมต่อหรือใช้เครือข่ายภายในบ้าน';

  @override
  String get firmwareErrorCacheFull =>
      'ถึงขีดจำกัดแคชแล้ว โปรดลบเวอร์ชันเก่าออก';

  @override
  String get firmwareErrorServerUnreachable =>
      'ไม่สามารถเข้าถึงเซิร์ฟเวอร์เฟิร์มแวร์ได้ โปรดตรวจสอบการเชื่อมต่ออินเทอร์เน็ตของคุณ';

  @override
  String get firmwareErrorDownloadInterrupted =>
      'การดาวน์โหลดหยุดชะงัก: การเชื่อมต่อเครือข่ายหายไป โปรดตรวจสอบการเชื่อมต่อของคุณแล้วลองอีกครั้ง';

  @override
  String get firmwareErrorDownloadFailed => 'ดาวน์โหลดเฟิร์มแวร์ไม่สำเร็จ';

  @override
  String get firmwareErrorDeleteFailed => 'ไม่สามารถลบเฟิร์มแวร์เวอร์ชันนี้ได้';

  @override
  String firmwareVersionTitle(String version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get readyForOfflineUse => 'พร้อมใช้งานแบบออฟไลน์';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return 'พื้นที่เก็บข้อมูลที่ใช้: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit เวอร์ชัน';
  }

  @override
  String get splashTagline => 'เครื่องมือตั้งค่าอิสระ';

  @override
  String get splashDisclaimer =>
      'ไม่ใช่ผลิตภัณฑ์ ExpressLRS อย่างเป็นทางการ\nใช้งานร่วมกับเฟิร์มแวร์ 3.3.x/4.x ได้';

  @override
  String get unknownDeviceName => 'อุปกรณ์ ELRS';

  @override
  String get unknownIpLabel => 'IP ไม่ทราบ';

  @override
  String get firmwareBinariesFileType => 'ไฟล์ไบนารีเฟิร์มแวร์';

  @override
  String helpContentLoadFailed(String error) {
    return 'เกิดข้อผิดพลาดในการโหลดเนื้อหาช่วยเหลือ: $error';
  }
}
