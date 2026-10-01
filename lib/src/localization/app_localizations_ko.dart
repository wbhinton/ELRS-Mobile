// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get bindingPhraseLabel => '바인딩 문구';

  @override
  String get networkSsidLabel => 'Wi-Fi SSID';

  @override
  String get flashingButtonLabel => '플래시';

  @override
  String get flashingStatusLocating => '펌웨어 찾는 중';

  @override
  String get flashingStatusUnpacking => '펌웨어 압축 해제 중';

  @override
  String get flashingStatusDownloading => '펌웨어 다운로드 중';

  @override
  String get flashingStatusBuilding => '펌웨어 빌드 중';

  @override
  String get flashingStatusUploading => '장치에 업로드 중';

  @override
  String get flashingStatusFinalizing => '장치에 쓰는 중 — 기다려 주십시오';

  @override
  String get flashDeviceLabel => '장치 플래싱';

  @override
  String get deviceConfigLabel => '장치 설정';

  @override
  String get firmwareManagerLabel => '펌웨어 관리자';

  @override
  String get settingsLabel => '설정';

  @override
  String get helpSupportLabel => '도움말 및 지원';

  @override
  String get noDeviceFoundLabel => '장치를 찾을 수 없음';

  @override
  String get retryLabel => '다시 시도';

  @override
  String get manualConnectionLabel => '수동 연결';

  @override
  String get manualIpOverrideLabel => '수동 IP 주소 재정의';

  @override
  String get connectLabel => '연결';

  @override
  String get cancelLabel => '취소';

  @override
  String get matchedLabel => '일치함';

  @override
  String get mismatchLabel => '불일치';

  @override
  String connectedLabel(String ip) {
    return '연결됨: $ip';
  }

  @override
  String get default24GHzDomainLabel => '기본 2.4GHz 도메인';

  @override
  String get defaultSubGHzDomainLabel => '기본 Sub-GHz 도메인';

  @override
  String get globalBindingPhraseLabel => '전역 바인딩 문구';

  @override
  String get homeWifiSsidLabel => '홈 Wi-Fi SSID';

  @override
  String get homeWifiPasswordLabel => '홈 Wi-Fi 비밀번호';

  @override
  String get manageCachedFirmwareLabel => '캐시된 펌웨어 관리';

  @override
  String get downloadOrDeleteOfflineFirmwareLabel => '오프라인 펌웨어 다운로드 또는 삭제';

  @override
  String get maxCachedVersionsLabel => '최대 캐시 버전 수';

  @override
  String get clearFirmwareCacheLabel => '펌웨어 캐시 지우기';

  @override
  String get deleteAllDownloadedFirmwareFilesLabel => '다운로드된 모든 펌웨어 파일 삭제';

  @override
  String get clearLabel => '지우기';

  @override
  String get appVersionLabel => '앱 버전';

  @override
  String get legalLicenseLabel => '법률 및 라이선스';

  @override
  String get standardDisclaimerAndGplv3Label => '표준 면책 조항 및 GPLv3 라이선스';

  @override
  String get supportDevelopmentLabel => '개발 지원';

  @override
  String get supportDevelopmentSubtitle => 'Ko-fi를 통해 개발자를 지원하세요';

  @override
  String get shareAnalyticsLabel => '분석 공유';

  @override
  String get shareAnalyticsSubtitle => '익명 사용 데이터를 공유하여 앱 개선에 도움을 주세요';

  @override
  String get expertModeLabel => '전문가 모드';

  @override
  String get expertModeSubtitle => '고급 펌웨어 처리 및 다운로드 활성화';

  @override
  String get exportElrsLuaScriptLabel => 'ELRS Lua 스크립트 내보내기';

  @override
  String get exportElrsLuaScriptSubtitle => 'EdgeTX/OpenTX 라디오용 elrs.lua 저장';

  @override
  String get submitDebugReportLabel => 'Sentry에 디버그 보고서 제출';

  @override
  String get submitDebugReportSubtitle => '익명 시스템 로그를 공유하여 버그 수정에 도움을 주세요';

  @override
  String get clearFirmwareCacheTitle => '펌웨어 캐시를 지울까요?';

  @override
  String get clearFirmwareCacheMessage =>
      '다운로드된 모든 펌웨어 ZIP 파일이 삭제됩니다. 오프라인에서 플래싱하려면 다시 다운로드해야 합니다.';

  @override
  String get clearAllLabel => '모두 지우기';

  @override
  String get submitDebugReportTitle => '디버그 보고서 제출';

  @override
  String get submitDebugReportMessage =>
      '이 작업은 디버깅을 위해 장치 정보 및 앱 로그를 Sentry로 보냅니다. 바인딩 문구나 Wi-Fi 비밀번호와 같은 개인 정보는 포함되지 않습니다.';

  @override
  String get describeIssueHint => '겪고 있는 문제를 설명해 주세요...';

  @override
  String get proceedLabel => '계속';

  @override
  String get submittingReportProgress => '보고서 제출 중…';

  @override
  String get saveLabel => '저장';

  @override
  String get notSetLabel => '설정되지 않음';

  @override
  String get languageOverrideLabel => '언어';

  @override
  String get languageOverrideSystemDefault => '시스템 기본값';

  @override
  String get legalNoticeSectionTitle => '법적 고지';

  @override
  String get legalNoticeSectionText =>
      'ELRS Mobile은 Weston Hinton이 독립적으로 개발한 무료 오픈소스(FOSS) 프로젝트입니다. 본 프로젝트는 ExpressLRS LLC의 공식 제품이 아니며, ExpressLRS 개발팀에 의해 공식적으로 지원, 보증 또는 인증되지 않았습니다.';

  @override
  String get trademarkNoticeSectionTitle => '상표권 고지';

  @override
  String get trademarkNoticeSectionText =>
      'ExpressLRS 및 ExpressLRS 로고는 ExpressLRS LLC의 상표입니다. 이 상표들의 사용은 설명 및 호환성 목적으로만 허용됩니다. 공식 ExpressLRS 설정 도구 및 문서는 expresslrs.org를 방문해 주십시오.';

  @override
  String get officialSupportSectionTitle => '공식 지원';

  @override
  String get officialSupportSectionText => '공식 ExpressLRS 프로젝트를 지원하세요: ';

  @override
  String get donateOpenCollectiveLabel => 'Open Collective를 통해 기부하기';

  @override
  String get softwareLicenseSectionTitle => '소프트웨어 라이선스';

  @override
  String get gplv3NoticeText =>
      '이 프로젝트는 GNU 일반 공중 사용 허가서 v3.0에 따라 라이선스가 부여됩니다.';

  @override
  String get tabFlashingGuide => '플래싱 가이드';

  @override
  String get tabFaq => '자주 묻는 질문';

  @override
  String get tabResources => '자료';

  @override
  String get resourceCommunitySupport => '커뮤니티 및 지원';

  @override
  String get resourceDiscordCommunity => 'Discord 커뮤니티';

  @override
  String get resourceJoinDiscord => 'ELRS Discord 참여하기';

  @override
  String get resourceGithubRepo => 'GitHub 저장소';

  @override
  String get resourceFlashRecovery => '플래시 복구';

  @override
  String get resourceDeviceUnresponsiveInfo => '플래시 실패 후 장치가 응답하지 않는 경우:';

  @override
  String get resourceRecoveryStep1 =>
      'USB를 통해 연결하는 동안 BOOT 버튼을 길게 눌러 부트로더 모드로 진입하세요.';

  @override
  String get resourceRecoveryStep2 =>
      'expresslrs.org/flasher에서 ELRS 웹 플래셔를 사용하여 USB/UART를 통해 다시 플래시하세요.';

  @override
  String get resourceRecoveryStep3 =>
      'WiFi 기능이 있는 장치의 경우, BOOT 버튼을 60초간 길게 눌러 WiFi 핫스팟 복구 모드를 시작하세요.';

  @override
  String get resourceRecoveryStep4 =>
      'ELRS Discord의 #help 채널에 참여하세요 — 커뮤니티는 일반적으로 어떤 장치든 복구할 수 있습니다.';

  @override
  String get resourceBardwellGuideRecommended =>
      'Joshua Bardwell의 벽돌 복구 가이드를 강력히 추천합니다:';

  @override
  String get resourceWebFlasherButton => '웹 플래셔';

  @override
  String get resourceRecoveryVideoButton => '복구 비디오';

  @override
  String get resourceLegalLiability => '법적 책임';

  @override
  String get resourceLiabilityDisclaimerText =>
      'ELRS Mobile은 어떠한 종류의 보증 없이 \'있는 그대로\' 제공됩니다. 개발자는 이 애플리케이션 사용으로 인해 발생하는 모든 손상, 데이터 손실 또는 기능하지 않는 하드웨어(예: 벽돌이 된 수신기, 송신기 또는 비행 컨트롤러에 국한되지 않음)에 대해 책임지지 않습니다.\n\n이 앱을 사용함으로써 귀하는 귀하의 하드웨어에 대한 모든 책임을 수락합니다.';

  @override
  String get resourceViewFullDisclaimerButton => '전체 면책 조항 보기';

  @override
  String get disclaimerTitle => '사용자 책임';

  @override
  String get disclaimerHeader => 'ELRS 모바일은 어떠한 종류의 보증도 없이 현상 그대로 제공됩니다.';

  @override
  String get disclaimerLiability =>
      '개발자는 본 애플리케이션 사용으로 인해 발생하는 어떠한 손상, 데이터 손실, 또는 하드웨어 오작동(예: 벽돌이 된 수신기, 송신기, 비행 컨트롤러 등)에 대해 책임지지 않습니다.';

  @override
  String get disclaimerAgreement =>
      '본 앱을 사용함으로써 귀하는 커스텀 펌웨어 플래싱의 위험성을 이해하고, 귀하의 하드웨어에 대한 전적인 책임을 수락함을 확인합니다.';

  @override
  String get disclaimerVerification =>
      '플래싱 전에 항상 대상 장치와 펌웨어 버전을 확인하십시오. 가능한 경우 원본 펌웨어를 백업해 두십시오.';

  @override
  String get disclaimerUnderstand => '이해했습니다';

  @override
  String get optionsTitle => '펌웨어 옵션';

  @override
  String get optionsSubtitle => '바인딩 및 네트워크 자격 증명을 구성합니다.';

  @override
  String get wifiPasswordLabel => 'WiFi 비밀번호';

  @override
  String get wifiOnIntervalLabel => '와이파이 자동 켜짐 간격';

  @override
  String get regulatoryDomainLabel => '규제 도메인';

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
  String get flashingStatusSaved => '펌웨어 저장됨';

  @override
  String get flashErrorNoTarget => '대상을 선택해 주십시오.';

  @override
  String get flashErrorNoVersion => '펌웨어 버전을 선택해 주십시오.';

  @override
  String get flashErrorNoDevice => '플래시할 수 없음: ELRS 장치가 연결되지 않았습니다.';

  @override
  String flashErrorChipMismatch(String targetChip, String deviceChip) {
    return '호환되지 않는 칩: 이 펌웨어는 $targetChip용으로 빌드되었지만, 연결된 장치는 $deviceChip입니다. 동일한 칩용 대상을 선택하십시오.';
  }

  @override
  String get flashErrorOfflineFlash =>
      '누락된 파일을 가져올 인터넷 연결이 없습니다. ELRS 장치에서 연결을 해제하고, 펌웨어 관리자를 통해 이 펌웨어를 다운로드하여 캐시를 완료한 후 다시 시도하십시오.';

  @override
  String get flashErrorOfflineDownload =>
      '인터넷 연결이 없습니다. ELRS 장치 핫스팟에 연결된 동안에는 펌웨어를 다운로드할 수 없습니다. 연결을 해제하고, 펌웨어 관리자를 통해 이 버전을 다운로드한 후 다시 시도하십시오.';

  @override
  String get flashErrorFlashFailed => '플래싱에 실패했습니다.';

  @override
  String get flashErrorUnconfirmed =>
      '플래싱 확인 전에 장치 연결이 끊어져 완료되지 않았을 수 있습니다. 이는 전원 손실, 플래싱 중 재시작 또는 약한 Wi-Fi 연결로 인해 발생할 수 있습니다. 장치 설정에서 펌웨어 버전을 확인하고, 변경되지 않았다면 다시 플래싱하십시오.';

  @override
  String get flashErrorDownloadFailed => '펌웨어 다운로드에 실패했습니다.';

  @override
  String get validationSsidTooLong => 'SSID는 32자 이하여야 합니다.';

  @override
  String get validationPasswordTooShort => '비밀번호는 8자 이상이어야 합니다.';

  @override
  String get validationPasswordTooLong => '비밀번호는 63자 이하여야 합니다.';

  @override
  String get targetMismatchTitle => '대상 불일치';

  @override
  String get targetMismatchMessage =>
      '선택한 펌웨어 대상이 현재 장치에서 실행 중인 하드웨어와 일치하지 않습니다. 강제로 플래싱하시겠습니까?';

  @override
  String get forceFlashLabel => '강제 플래싱';

  @override
  String get noBindPhraseTitle => '바인딩 문구 없음';

  @override
  String get noBindPhraseMessage =>
      '바인딩 문구가 설정되지 않았습니다. 기본값(비어 있음)으로 진행하시겠습니까?';

  @override
  String get flashSuccessSnackbar => '플래싱이 성공적으로 완료되었습니다!';

  @override
  String get firmwareSavedSnackbar => '펌웨어가 성공적으로 저장되었습니다!';

  @override
  String get flashSuccessMessage => '플래싱 성공! 장치가 재부팅 중입니다.';

  @override
  String get stm32OtaWarning =>
      'STM32 대상 선택됨: 이 하드웨어는 OTA 플래싱을 지원하지 않습니다. STLink 또는 Betaflight Passthrough를 통해 수동으로 플래싱하기 위해 이 펌웨어를 로컬에 빌드하고 저장할 수 있습니다.';

  @override
  String get downloadBinaryLabel => '바이너리 다운로드';

  @override
  String get waitingForDeviceLabel => '장치 연결 대기 중...';

  @override
  String get otaUnavailableLabel => 'OTA 사용 불가';

  @override
  String get doneLabel => '완료';

  @override
  String get targetSelectionTitle => '대상 선택';

  @override
  String get deviceTypeLabel => '장치 유형';

  @override
  String get deviceVendorLabel => '장치 제조사';

  @override
  String get regulatoryFrequencyLabel => '규제 및 주파수';

  @override
  String get deviceTargetLabel => '장치 대상';

  @override
  String get noFirmwareDownloadedButton => '다운로드된 펌웨어 없음. 펌웨어 관리자로 이동';

  @override
  String hardwareRequiresVersion(String version) {
    return '하드웨어에는 v$version 이상이 필요합니다.';
  }

  @override
  String get downloadCompatibleFirmwareButton => '호환 펌웨어 다운로드';

  @override
  String get firmwareVersionLabel => '펌웨어 버전';

  @override
  String get firmwareVersionHelper => '플래싱할 ELRS 버전을 선택하세요';

  @override
  String get cachedBadge => '(캐시됨)';

  @override
  String errorLoadingVersions(String error) {
    return '버전 로딩 오류: $error';
  }

  @override
  String get flashingProfileLabel => '플래싱 프로필';

  @override
  String get addProfileTooltip => '프로필 추가';

  @override
  String get deleteProfileTooltip => '프로필 삭제';

  @override
  String get bindingPhraseHelper => '고유한 바인딩 구문';

  @override
  String get addProfileTitle => '플래싱 프로필 추가';

  @override
  String get profileNameHint => '프로필 이름 (예: 내 쿼드)';

  @override
  String get addLabel => '추가';

  @override
  String get deleteProfileTitle => '프로필 삭제';

  @override
  String deleteProfileMessage(String name) {
    return '프로필 \"$name\"을(를) 삭제하시겠습니까?';
  }

  @override
  String get deleteLabel => '삭제';

  @override
  String get settingsCategoryProfilesNetwork => '프로필 및 네트워크';

  @override
  String get settingsCategoryAppStorage => '앱 및 저장 공간';

  @override
  String get settingsCategoryAdvancedDebug => '고급 및 디버그';

  @override
  String get settingsCategoryAboutLegal => '정보 및 법률';

  @override
  String get settingsSectionRegulatoryDefaults => '규제 기본값';

  @override
  String get settingsSectionPreferences => '환경설정';

  @override
  String get settingsSectionPowerTools => '고급 도구';

  @override
  String get settingsSectionDiagnostics => '진단';

  @override
  String get regDomainUnknown => '알 수 없음';

  @override
  String maxCachedVersionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 버전',
    );
    return '$_temp0';
  }

  @override
  String editFieldTitle(String field) {
    return '$field 수정';
  }

  @override
  String enterFieldHint(String field) {
    return '$field 입력';
  }

  @override
  String get luaScriptSavedSnackbar => 'elrs.lua가 기기에 저장되었습니다!';

  @override
  String luaScriptSaveFailed(String error) {
    return '스크립트 저장 실패: $error';
  }

  @override
  String debugReportSubmittedWithId(String eventId) {
    return '제출되었습니다! 이벤트 ID: $eventId…';
  }

  @override
  String get debugReportSubmitted => '보고서가 성공적으로 제출되었습니다!';

  @override
  String debugReportFailed(String error) {
    return '제출 실패: $error';
  }

  @override
  String licenseLoadFailed(String error) {
    return '라이선스 로드 오류: $error';
  }

  @override
  String get firmwareErrorLoadFailed => '펌웨어 버전을 로드할 수 없습니다.';

  @override
  String get firmwareErrorOnHotspot =>
      '수신기 Wi-Fi 핫스팟에 직접 연결된 상태에서는 펌웨어를 다운로드할 수 없습니다. 연결을 해제하거나 홈 네트워크를 사용해 주세요.';

  @override
  String get firmwareErrorCacheFull => '캐시 한도에 도달했습니다. 이전 버전을 삭제해 주세요.';

  @override
  String get firmwareErrorServerUnreachable =>
      '펌웨어 서버에 연결할 수 없습니다. 인터넷 연결을 확인해 주세요.';

  @override
  String get firmwareErrorDownloadInterrupted =>
      '다운로드가 중단되었습니다: 네트워크 연결이 끊어졌습니다. 연결을 확인하고 다시 시도해 주세요.';

  @override
  String get firmwareErrorDownloadFailed => '펌웨어 다운로드에 실패했습니다.';

  @override
  String get firmwareErrorDeleteFailed => '이 펌웨어 버전을 삭제할 수 없습니다.';

  @override
  String firmwareVersionTitle(String version) {
    return '버전 $version';
  }

  @override
  String get readyForOfflineUse => '오프라인 사용 준비 완료';

  @override
  String storageUsedMb(double size) {
    final intl.NumberFormat sizeNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String sizeString = sizeNumberFormat.format(size);

    return '사용된 저장 공간: $sizeString MB';
  }

  @override
  String cachedVersionsOfLimit(int count, int limit) {
    return '$count / $limit 버전';
  }

  @override
  String get splashTagline => '독립적인 설정 도구';

  @override
  String get splashDisclaimer =>
      'ExpressLRS 공식 제품이 아닙니다.\n3.3.x/4.x 펌웨어와 호환됩니다.';

  @override
  String get unknownDeviceName => 'ELRS 장치';

  @override
  String get unknownIpLabel => '알 수 없는 IP';

  @override
  String get firmwareBinariesFileType => '펌웨어 바이너리';

  @override
  String helpContentLoadFailed(String error) {
    return '도움말 콘텐츠 로드 오류: $error';
  }
}
