---
title: "사용자 가이드"
slug: user_guide
sidebar:
  order: 1
---

## 개요
이 애플리케이션은 ExpressLRS 하드웨어 관리를 위한 포괄적인 모바일 인터페이스를 제공합니다. 사용자는 수신기(RX) 및 송신기(TX) 매개변수를 구성하고, PWM 출력을 매핑하며, 모바일 장치에서 직접 펌웨어 업데이트를 플래시할 수 있습니다.

---

## 설치

### 공식 앱 스토어

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Google Play에서 설치

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Get it on Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
App Store에서 설치

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on App Store</a>

### 대체 설치

#### GitHub Store
대체 앱 스토어 경험을 선호하는 사용자에게 적합합니다.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on GitHub Store</a>

### 수동 설치
숙련된 사용자 또는 수동 관리를 선호하는 사용자는 최신 `.apk` 파일을 위해 [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) 페이지를 방문하십시오.

---

## 🚀 빠른 시작: 첫 장치 플래싱

### 1단계: 펌웨어 캐싱 (집에서 수행하세요)
1. 앱을 열고 **Firmware Manager**로 이동합니다.
2. 최신 안정 릴리스 옆에 있는 다운로드 아이콘을 누릅니다.
3. 앱이 오프라인 사용에 필요한 타겟 및 하드웨어 정의를 다운로드하고 안전하게 캐싱합니다.

### 2단계: 장치에 연결
1. ExpressLRS 수신기(RX) 또는 송신기(TX)의 전원을 켭니다.
2. 장치가 Wi-Fi Hotspot 모드(빠른 LED 깜박임)로 진입할 때까지 60초(또는 구성된 간격)를 기다립니다.
3. 휴대폰의 Wi-Fi를 **ExpressLRS RX** 또는 **ExpressLRS TX** 네트워크에 연결합니다 (비밀번호: `expresslrs`).
4. 앱을 엽니다. 대시보드는 mDNS를 사용하여 네트워크를 자동으로 스캔하고 장치에 연결합니다.

### 3단계: 펌웨어 플래싱
1. 대시보드에서 **Flash Device**를 선택합니다.
2. **하드웨어 선택:** 계단식 드롭다운을 사용하여 장치 유형, 공급업체, 주파수 및 타겟을 선택합니다.
3. **옵션 구성:** 사용자 지정 Binding Phrase, Wi-Fi 자격 증명 및 Regulatory Domain을 설정합니다.
4. **FLASH**를 누릅니다. 앱은 바이너리를 로컬에서 조립하여 장치로 푸시합니다.

---

## 기술 세부 정보

### 연결 및 검색
이 앱은 하드웨어를 찾기 위해 강력한 다단계 검색 시퀀스를 사용합니다:
1. **mDNS Resolution**: 기본 방법입니다. 앱은 `elrs_rx.local` 또는 `elrs_tx.local`을 스캔합니다.
2. **Static AP Fallback**: mDNS가 차단된 경우, 앱은 공식 ELRS 액세스 포인트 IP (`10.0.0.1`)를 확인합니다.
3. **Manual IP Override**: 복잡한 네트워크의 경우, 설정에서 IP 주소를 수동으로 입력할 수 있습니다.

**강제 네트워크 바인딩**: 최신 스마트폰은 인터넷 연결이 없는 Wi-Fi 연결을 종종 해제합니다. ELRS Mobile은 OS가 하드웨어 연결을 유지하도록 강제하는 네이티브 "Forced Routing" 레이어를 포함하여 현장에서 100% 안정적인 검색을 보장합니다.

---

## 전문가 모드 및 감사
설정 메뉴에서 사용자는 **Expert Mode**를 활성화할 수 있습니다. 이를 통해 조립된 펌웨어 바이너리를 장치에 직접 저장하여 감사하거나 FTDI를 통해 수동으로 플래싱할 수 있습니다.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 하드웨어 처리</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    ELRS Mobile은 STM32 타겟용 펌웨어(ELRS v3.x까지)를 조립하고 패치할 수 있지만, 이러한 장치는 Wi-Fi를 통한 Over-The-Air(OTA) 플래싱을 지원하지 않습니다. STM32 타겟을 선택하면 앱에서 바이너리를 로컬로 빌드하고 저장할 수 있으므로, PC를 사용하여 STLink 또는 Betaflight Passthrough를 통해 수동으로 플래시할 수 있습니다.
  </p>
</div>

이러한 바이너리의 무결성을 확인하려는 개발자는 [**펌웨어 유효성 검사 가이드**](/guides/firmware-validation)를 참조하십시오.

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->