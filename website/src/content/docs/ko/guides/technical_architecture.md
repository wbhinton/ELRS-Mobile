---
title: "기술 아키텍처"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile은 단순한 웹 래퍼가 아닙니다. ExpressLRS 컴파일 및 구성 파이프라인의 네이티브 Dart 구현입니다.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">통합 펌웨어 어셈블리</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    원격 클라우드 컴파일러에 의존하는 대신, 앱은 장치에서 로컬로 동적으로 바이너리를 빌드합니다. ESP32/ESP8285 대상에 플래싱할 때, <code>FirmwareAssembler</code>는 정밀한 비트 수준 수정 시퀀스를 실행합니다:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">캐시된 <code>firmware.zip</code> 아카이브에서 기본 제네릭 펌웨어를 추출합니다.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">ESP <code>0xE9</code> 매직 바이트 시그니처를 찾아 기본 패딩을 제거합니다.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0"><code>hardware.json</code>에서 특정 대상 핀아웃 및 런타임 구성을 추출합니다.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Product Name (128b), Lua Name (16b), <code>options.json</code> (512b), <code>hardware.json</code> (2048b)을 바이너리 스트림에 직접 바이트 팩합니다.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">대상 플랫폼(예: ESP8285 레거시)에서 필요한 경우 최종 페이로드를 <code>.gz</code> 스트림으로 압축합니다.</p>
    </div>
  </div>
</div>

## 주변 장치 논리

### 규제 도메인 인젝터
이 앱은 주파수 대역 간의 복잡한 차이를 정확하게 처리합니다. 900MHz/듀얼 밴드 장치의 경우, 선택한 도메인(예: FCC, EU868)을 컴파일된 JSON 페이로드에 적극적으로 주입합니다. 표준 2.4GHz 대상의 경우, 부울 플래그를 사용하여 어셈블리 중에 추출 프로세스를 표준 FCC/ 또는 유럽 LBT/ 기본 펌웨어 폴더로 자동으로 라우팅합니다.

### 펌웨어 캐싱 및 동기화
강력한 로컬 캐싱 시스템을 통해 오프라인 플래싱이 가능합니다. 사용자가 펌웨어 관리자를 통해 릴리스를 다운로드하면, `FirmwareCacheService`는 ExpressLRS Artifactory에서 제네릭 `firmware.zip`과 장치별 `hardware.zip`을 직접 가져옵니다. 이 아카이브들은 장치에 로컬로 관리 및 저장되어, 현장에서 활성 인터넷 연결 없이도 즉시 어셈블리 및 플래싱이 가능하도록 합니다.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">네이티브 네트워크 바인딩</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    모바일 운영 체제(특히 Android 및 iOS)는 인터넷 연결이 없는 Wi-Fi 연결의 우선순위를 낮추고, 대신 모바일 데이터를 통해 트래픽을 자동으로 라우팅합니다. 이는 일반 앱이 <code>10.0.0.1</code>�� 있는 ELRS 하드웨어에 접근하는 것을 방해합니다.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile은 <code>NativeNetworkService</code>를 통해 이 문제를 해결합니다. 하드웨어 연결이 감지되면, 앱은 플랫폼별 <code>MethodChannel</code>을 호출하여 전체 Flutter 프로세스를 OS 커널 수준에서 Wi-Fi 인터페이스에 바인딩합니다. 이를 통해 모바일 데이터 상태에 관계없이 모든 HTTP 및 mDNS 트래픽이 하드웨어로 올바르게 라우팅됩니다.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->