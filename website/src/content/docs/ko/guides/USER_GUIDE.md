---
title: "사용자 가이드"
slug: ko/user_guide
sidebar:
  order: 1
---

## 개요
이 애플리케이션은 ExpressLRS 하드웨어를 관리하기 위한 포괄적인 모바일 인터페이스를 제공합니다. 사용자는 모바일 기기에서 직접 수신기(RX) 및 송신기(TX) 매개변수를 구성하고, PWM 출력을 매핑하고, 펌웨어 업데이트를 플래시할 수 있습니다.

---

## 설치

### 공식 앱 스토어

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Google Play에서 설치

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Google Play에서 다운로드</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
App Store에서 설치

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">App Store에서 다운로드</a>

### 대체 설치

#### GitHub Store
대체 앱 스토어 경험을 선호하는 사용자에게 이상적입니다.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">GitHub Store에서 다운로드</a>

### 수동 설치
고급 사용자 또는 수동 관리를 선호하는 사용자는 최신 `.apk` 파일을 다운로드하려면 [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) 페이지를 방문하십시오.

---

## 🚀 빠른 시작: 첫 장치 플래싱

### 1단계: 펌웨어 캐싱 (집에서 이 작업을 수행하십시오)
1. 앱을 열고 **Firmware Manager**로 이동합니다.
2. 최신 안정 릴리스 옆에 있는 다운로드 아이콘을 탭합니다.
3. 앱은 오프라인 사용에 필요한 대상 및 하드웨어 ���의를 다운로드하여 안전하게 캐시합니다.

### 2단계: 장치 연결
1. ExpressLRS 수신기(RX) 또는 송신기(TX)의 전원을 켈니다.
2. 장치가 Wi-Fi 핫스팟 모드(빠르게 깜박이는 LED)로 진입할 때까지 60초(또는 구성된 간격)를 기다립니다.
3. 휴대폰의 Wi-Fi를 **ExpressLRS RX** 또는 **ExpressLRS TX** 네트워크에 연결합니다 (비밀번호: `expresslrs`).
4. 앱을 엽니다. 대시보드가 mDNS를 사용하여 네트워크를 자동으로 스캔하고 장치에 연결합니다.

### 3단계: 펌웨어 플래싱
1. 대시보드에서 **Flash Device**를 선택합니다.
2. **하드웨어 선택:** 계층적 드롭다운을 사용하여 장치 유형, 공급업체, 주파수 및 대상을 선택합니다.
3. **옵션 및 프로필 구성:** **플래싱 프로필**을 선택하거나 (**+** 버튼을 탭하여 새 이름의 프로필 추가) 자격 증명을 로드합니다. 바인딩 구문, WiFi SSID, Wi-Fi 비밀번호, 규제 도메인 및 Wi-Fi 자동 켜짐 간격을 사용자 지정합니다.
4. **FLASH**를 탭합니다. 앱이 로컬에서 바이너리를 조립하여 장치로 푸시합니다.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">대상 불일치 경고</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    앱이 사용자의 선택과 연결된 장치 간에 하드웨어 대상 불일치를 감지하면, 우발적인 손상을 방지하기 위해 경고합니다. 올바른 대상이 확실하다면 (예: 잘못된 플래시에서 복구하거나 대상 정의 간에 마이그레이션하는 경우), 경고 대화 상자에서 <strong>FORCE FLASH</strong>를 클릭하여 검사를 우회합니다.
  </p>
</div>

### 📋 플래싱 프로필 관리
여러 드론 또는 무선 설정이 다른 구성 요구 사항(예: 다른 바인딩 구문 또�� 규제 도메인)을 가지고 있는 경우, 이름이 지정된 **플래싱 프로필**을 사용하여 구성을 저장하고 전환할 수 있습니다.
* **프로필 추가**: "플래싱 프로필" 드롭다운 옆에 있는 **+** 아이콘을 탭하고, 이름을 입력한 다음 추가를 누릅니다.
* **자동 저장**: 활성 프로필의 자격 증명(바인딩 구문, SSID, 비밀번호, 도메인 또는 간격)에 대한 모든 변경 사항은 실시간으로 자동으로 저장됩니다.
* **프로필 전환**: 드롭다운에서 프로필을 선택하기만 하면 저장된 설정이 즉시 로드됩니다.
* **프로필 삭제**: 정리하려면 드롭다운에서 프로필을 선택하고 휴지통/삭제 아이콘을 탭합니다 (프로필을 삭제하려면 최소 두 개가 있어야 합니다).

---

## 기술 세부 정보

### 연결 및 검색
앱은 하드웨어를 찾기 위해 강력한 다단계 검색 시퀀스를 사용합니다.
1. **mDNS Resolution**: 기본 방법입니다. 앱은 `elrs_rx.local` 또는 `elrs_tx.local`을 스캔합니다.
2. **정적 AP 폴백**: mDNS가 차단된 경우 앱은 공식 ELRS 액세스 포인트 IP(`10.0.0.1`)를 확인합니다.
3. **수동 IP 재정의**: 복잡한 네트워크의 경우 설정에서 IP 주소를 수동으로 입력할 수 있습니다.

**강제 네��워크 바인딩**: 최신 스마트폰은 인터넷 연결이 없는 Wi-Fi 연결을 종종 끊습니다. ELRS Mobile은 OS가 하드웨어 연결을 유지하도록 강제하는 기본 "강제 라우팅" 레이어를 포함하여 현장에서 100% 신뢰할 수 있는 검색을 보장합니다.

---

## 전문가 모드 및 감사
설정 메뉴에서 사용자는 **전문가 모드**를 활성화할 수 있습니다. 이를 통해 조립된 펌웨어 바이너리를 장치에 직접 저장하여 감사하거나 FTDI를 통해 수동으로 플래시할 수 있습니다.

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
    ELRS Mobile이 STM32 대상(ELRS v3.x까지)을 위한 펌웨어를 조립하고 패치할 수 있지만, 이 장치들은 Wi-Fi를 통한 무선(OTA) 플래싱을 지원하지 않습니다. STM32 대상을 선택하는 경우, 앱은 바이너리를 로컬로 빌드하고 저장할 수 있도록 허용하므로 STLink 또는 Betaflight Passthrough를 통해 PC를 사용하여 수동으로 플래시할 수 있습니다.
  </p>
</div>

이 바이너리의 무결성을 확인하려는 개발자는 [**펌웨어 유효성 검사 가이드**](/guides/firmware-validation)를 참조하십시오.

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->