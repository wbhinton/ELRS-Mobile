---
title: "펌웨어 검증 도구"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: ko/firmware-validation
sidebar:
  order: 3
---

이 가이드는 ELRS Mobile 애플리케이션의 펌웨어 조립 로직을 공식 "Golden" 바이너리에 대해 검증하는 데 사용되는 내부 도구에 대해 자세히 설명합니다.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Ground Truth vs. Configurator Binaries</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    유효성 검사 감사를 실행할 때, ELRS Mobile에서 생성된 바이너리가 공식 <strong>ExpressLRS Web Flasher</strong>와 완벽하게 일치하지만, 로컬 <strong>ExpressLRS Configurator (Python)</strong>를 사용하여 빌드된 바이너리와는 약간 다를 수 있다는 것을 알 수 있습니다.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    이는 예상되는 동작입니다. ESP32의 내부 C++ JSON 파서는 공백을 무시하므로, 두 바이너리는 압축 차이로 인해 엄격한 바이트 단위 SHA256 비교에 실패하더라도 하드웨어에서는 동일하게 실행됩니다.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**위치:** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator는 고성능 비트 단위 비교 도구입니다. ELRS Mobile의 내부 패치 및 조립 로직이 공식 ExpressLRS 로직을 반영하는지 확인하도록 설계되었습니다.

### 주요 기능
- **Bit-Level Analysis**: 불일치하는 바이트 내에서 정확한 비트 오프셋 실패 지점을 찾아냅니다.
- **Interactive Selection**: `firmware_testing/binaries/`에서 발견된 모든 바이너리를 나열합니다.
- **Zero-Copy Memory Management**: 대용량 펌웨어 파일의 고속 분석에 최적화되어 있습니다.

### 사용 방법
1.  **바이너리 준비**: 생성된 `.bin` 또는 `.gz` 파일을 `firmware_testing/binaries/`에 배치합니다.
2.  **설정 및 실행**:
    ```bash
    cd firmware_testing/scripts/dart/
    dart pub get
    dart run logic_validator.dart
    ```

---

## 2. Ground Truth Auditor (Python)
**위치:** `firmware_testing/scripts/python/audit_tool.py`

Auditor는 "Ground Truth" 검증을 위한 독립형, 제로-의존성 스크립트입니다. 모든 ExpressLRS 펌웨어 이미지의 끝에 추가된 2704바이트 구성 블록을 파싱합니다.

### 목적
이것은 기본 펌웨어 코드의 레이아웃 차이와 관계없이, 실제로 장치에 플래시된 메타데이터(Product Name, Lua Name, Hardware Layout, Options)가 올바른지 확인합니다.

### 사용 방법
1.  **직접 실행**:
    ```bash
    python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
    ```

---

## 3. Binary Cross-Validation Workflow
ELRS Mobile이 펌웨어를 올바르게 조립하는지 확인하기 위해 개발자는 PC에서 컴파일된 "Ground Truth" 바이너리에 대해 주기적으로 교차 검증 감사를 수행해야 합니다.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">ELRS Mobile에서 바이너리 내보내기</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">설정에서 <strong>Expert Mode</strong>를 활성화한 다음, 대상을 구성하고 옵션을 설정한 후 Flasher 탭에서 <strong>DOWNLOAD BINARY</strong> 버튼을 사용합니다.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">PC Ground Truth 생성</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">PC의 공식 ExpressLRS Configurator를 사용하여 <strong>정확히 동일한</strong> 대상 및 버전을 동일한 옵션으로 빌드합니다.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">감사 실행</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">두 바이너리를 <code>firmware_testing/binaries/</code>에 배치하고 <code>audit_tool.py</code> 스크립트를 실행하여 완벽한 하드웨어 및 옵션 일치를 확인합니다.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->