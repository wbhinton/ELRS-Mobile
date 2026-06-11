---
title: "개발 가이드"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: development
sidebar:
  order: 2
---

ELRS Mobile 개발 가이드에 오신 것을 환영합니다! 이 프로젝트는 ExpressLRS 컴파일 및 플래싱 파이프라인의 네이티브 Flutter 구현이며, 완전히 오프라인으로 작동하도록 설계되었습니다.

## 필수 조건
이 프로젝트에 기여하려면 다음 도구가 설치되어 있어야 합니다:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (안정 버전)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## 시작하기

1. **저장소 클론**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **종속성 설치**:
   ```bash
   flutter pub get
   ```

3. **애플리케이션 실행**:
   ```bash
   # Android용
   flutter run
   
   # iOS용 (Mac과 실제 기기/시뮬레이터 필요)
   flutter run
   ```

---

## 프로젝트 아키텍처
코드베이스는 `lib/src/`에 있는 기능 중심 구조를 따릅니다.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      기능
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">플래싱 파이프라인의 핵심 로직 및 UI.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">아티팩토리에서 펌웨어 다운로드 및 캐싱을 처리합니다.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Binding Phrases 및 WiFi와 같은 사용자 옵션을 설정하는 UI.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      핵심
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">하드웨어 핫스팟에 프로세스 바인딩을 위한 플랫폼별 로직.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">로컬 캐시 관리 및 SQLite 영속성.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">프라이버시 중심의 관찰 가능성 (Sentry 및 Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## 상태 관리
우리는 전역 상태 관리를 위해 **Riverpod**를 사용하고, 로컬 위젯 수준 상태를 위해 **Flutter Hooks**를 활용합니다. 이 조합은 표준 `StatefulWidgets`의 상용구 없이도 고도로 반응적인 UI를 보장합니다.

---

## 심층 분석

더 자세한 기술 정보는 다음 가이드를 참조하십시오:

- [**기술 아키텍처**](/guides/technical_architecture): `FirmwareAssembler` 및 네이티브 네트워킹 스택에 대한 심층 분석.
- [**펌웨어 유효성 검사**](/guides/firmware-validation): Dart 및 Python 도구를 사용하여 바이너리 무결성을 확인하는 방법.

---

## JSON Minification에 대한 참고

바이너리를 감사할 때, 표준 Python Configurator와 비교하여 약간의 바이트 오프셋을 발견할 수 있습니다. 이는 **JSON minification** 때문입니다.

Python Configurator는 종종 콜론 ���에 공백을 삽입하지만(예: `{"uid": [1,2,3]}`), ELRS Mobile은 압축된 JSON을 생성합니다(예: `{"uid":[1,2,3]}`). ESP32의 내부 파서가 이러한 공백을 무시하므로, 둘 다 하드웨어에서는 기능적으로 동일합니다.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->