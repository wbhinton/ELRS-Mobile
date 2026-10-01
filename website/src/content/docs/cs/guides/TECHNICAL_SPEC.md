---
title: "Technická specifikace"
slug: cs/technical_spec
sidebar:
  order: 5
---

## Přehled architektury

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Princip návrhu</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Aplikace je postavena pomocí Flutter a využívá framework pro správu stavu <strong>Riverpod</strong>. Komunikuje s hardwarem ELRS prostřednictvím RESTful API zpřístupněného palubním WiFi modulem zařízení, což zajišťuje nízkou latenci komunikace a synchronizaci stavu v reálném čase.
  </p>
</div>

## Datová vrstva

### Koncové body API
Systém komunikuje s hardwarem pomocí následujících HTTP koncových bodů:

| Metoda | Koncový bod | Popis |
| :--- | :--- | :--- |
| `GET` | `/config` | Načte aktuální konfiguraci zařízení ve formátu JSON. |
| `POST` | `/options.json` | Aktualizuje modifikovatelné možnosti za běhu (SSID, heslo atd.). |
| `POST` | `/config` | Aktualizuje základní hardwarové parametry a mapování PWM. |
| `POST` | `/reboot` | Spustí hardwarový reset pro aplikování změn. |

### JSON Schema
Model `RuntimeConfig` využívá strukturu ELRS 4.x, která rozděluje parametry do tří primárních uzlů:
- `settings`: Identifikátory hardwaru a řetězce verzí pouze pro čtení.
- `options`: Modifikovatelné uživatelské preference a síťové přihlašovací údaje.
- `config`: Nízkoúrovňové hardwarové konfigurace (protokoly, pole PWM).

Příklad struktury JSON:
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

## Správa stavu
Systém využívá reaktivní architekturu:
- **`ConfigViewModel`**: Spravuje stav živého připojení, logiku heartbeat a zjišťování IP.
- **`FlashingController`**: Orchestruje stahování firmwaru, lokální binární záplaty a proces nahrávání XH-over-HTTP.

## Mapovací vrstva
`ElrsMappings.domains900` mapuje index regulační domény 900 MHz použitý v API na jeho člověkem čitelný štítek:

| ID | Štítek | Popis |
| :--- | :--- | :--- |
| 0 | AU915 | Austrálie/Nový Zéland 915MHz |
| 1 | FCC915 | Severní Amerika 915MHz |
| 2 | EU868 | Evropa 868MHz |
| 3 | IN866 | Indie 866MHz |
| 4 | AU433 | Austrálie 433MHz |
| 5 | EU433 | Evropa 433MHz |
| 6 | US433 | Severní Amerika 433MHz |
| 7 | US433-Wide | Severní Amerika Široké 433MHz |


## Vrstva perzistence
Systém implementuje dvoufázovou strategii perzistence:
- **`SharedPreferences`**: Používá se prostřednictvím `PersistenceService` pro nesenzitivní data, jako jsou WiFi SSID a obecné předvolby aplikace.
- **`FlutterSecureStorage`**: Používá se pro citlivá data, včetně Binding Phrases a WiFi hesel, zajišťující šifrování na úrovni OS.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->