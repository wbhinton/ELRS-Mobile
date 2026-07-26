---
title: "기술 사양"
slug: ko/technical_spec
sidebar:
  order: 5
---

## 아키텍처 개요

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">설계 원칙</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    이 애플리케이션은 Flutter를 사용하여 구축되었으며 <strong>Riverpod</strong> 상태 관리 프레임워크를 활용합니다. 장치의 온보드 WiFi 모듈이 노출하는 RESTful API를 통해 ELRS 하드웨어와 상호 작용하여 낮은 지연 시간 통신 및 실시간 상태 동기화를 보장합니다.
  </p>
</div>

## 데이터 계층

### API 엔드포인트
시스템은 다음 HTTP 엔드포인트를 사용하여 하드웨어와 통신합니다:

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/config` | 현재 장치 구성을 JSON 형식으로 검색합니다. |
| `POST` | `/options.json` | 수정 가능한 런타임 옵션(SSID, Password 등)을 업데이트합니다. |
| `POST` | `/config` | 핵심 하드웨어 매개변수 및 PWM 매핑을 업데이트합니다. |
| `POST` | `/reboot` | 변경 사항을 적용하기 위해 하드웨어 재설정을 트리거합니다. |

### JSON 스키마
`RuntimeConfig` 모델은 ELRS 4.x 구조를 활용하며, 이 구조는 매개변수를 세 가지 주요 노드로 분리합니다.
- `settings`: 읽기 전용 하드웨어 식별자 및 버전 문자열.
- `options`: 수정 가능한 사용자 기본 설정 및 네트워크 자격 증명.
- `config`: 저수준 하드웨어 구성(Protocols, PWM Arrays).

JSON 구조 예시:
```json
{
  "product_name": "Test RX",
  "settings": {
    "version": "1.0.0",
    "module-type": "RX"
  },
  "options": {
    "bindPhrase": "example",
    "wifi-ssid": "SSID",
    "domain": 1
  },
  "config": {
    "serial-protocol": 0,
    "pwm": [
      {"channel": 0, "mode": 5}
    ]
  }
}
```

## 상태 관리
시스템은 반응형 아키텍처를 사용합니다:
- **`ConfigViewModel`**: 실시간 연결 상태, 하트비트 로직 및 IP 검색을 관리합니다.
- **`DeviceEditorViewModel`**: 장치 구성의 초안 상태를 저장하여 최종 "저장/취소" 로직으로 다단계 편집을 가능하게 합니다.
- **`FlashingController`**: 펌웨어 다운로드, 로컬 바이너리 패치 및 XH-over-HTTP 업로드 프로세스를 조율합니다.

## 매핑 계층
다음 표는 API에서 사용되는 정수 식별자와 사람이 읽을 수 있는 해당 값 간의 매핑을 정의합니다.

### 규제 도메인
| ID | Label | Description |
| :--- | :--- | :--- |
| 0 | AU915 | 호주/뉴질랜드 915MHz |
| 1 | FCC915 | 북미 915MHz |
| 2 | EU868 | 유럽 868MHz |
| 3 | IN866 | 인도 866MHz |
| 4 | AU433 | 호주 433MHz |
| 5 | EU433 | 유럽 433MHz |
| 6 | US433 | 북미 433MHz |
| 7 | US433-Wide | 북미 광대역 433MHz |


## 고급 매핑

### VBind (바인딩 저장)
바인딩 문구가 장치에 저장되는 방식을 결정합니다.
- **0: Persistent**: 플래시 메모리에 저장됨(표준).
- **1: Volatile**: 전원 주기에 따라 지워짐.
- **2: Returnable**: 대여 장비에 사용됨.
- **3: Administered**: 다중 파일럿 플릿 환경에서 사용됨.


## 영구 저장 계층
시스템은 이중 계층 영구 저장 전략을 구현합니다:
- **`SharedPreferences`**: WiFi SSIDs 및 일반 앱 기본 설정과 같은 민감하지 않은 데이터에 대해 `PersistenceService`를 통해 활용됩니다.
- **`FlutterSecureStorage`**: Binding Phrases 및 WiFi Passwords를 포함한 민감한 데이터에 사용되며, OS 수준에서 암호화를 보장합니다.

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->