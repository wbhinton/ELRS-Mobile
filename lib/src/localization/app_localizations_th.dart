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
  String get packetRateLabel => 'อัตราแพ็กเก็ต';

  @override
  String get baudRateLabel => 'อัตราบอด';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'กำลังอัปเดตเฟิร์มแวร์ $expressLRS บนฮาร์ดแวร์ $radioMaster หรือ $betaFPV...';
  }

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
  String get flashingWifiCategoryLabel => 'แฟลชและ Wi-Fi';

  @override
  String get aboutSupportCategoryLabel => 'เกี่ยวกับและสนับสนุน';

  @override
  String get advancedCategoryLabel => 'ขั้นสูง';

  @override
  String get flashingDefaultsSectionLabel => 'ค่าเริ่มต้นการแฟลช';

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
  String get aboutSectionLabel => 'เกี่ยวกับ';

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
}
