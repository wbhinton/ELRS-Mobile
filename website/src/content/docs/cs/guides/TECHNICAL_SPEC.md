---
title: "Technická specifikace"
slug: cs/technical_spec
sidebar:
  order: 5
---

## Architektura – Přehled

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Princip návrhu</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Aplikace je postavena pomocí Flutter a využívá framework pro správu stavu **Riverpod**. Komunikuje s hardwarem ELRS prostřednictvím RESTful API vystaveného palubním WiFi modulem zařízení, což zajišťuje nízkou latenci komunikace a synchronizaci stavu v reálném čase.
  </p>
</div>

## Vrstva dat

### Koncové body API
Systém komunikuje s hardwarem pomocí následujících HTTP koncových bodů:

| Metoda | Koncový bod | Popis |
| :--- | :--- | :--- |
| `GET` | `/config` | Načítá aktuální konfiguraci zařízení ve formátu JSON. |
| `POST` | `/options.json` | Aktualizuje modifikovatelné možnosti za běhu (SSID, Heslo atd.). |
| `POST` | `/config` | Aktualizuje základní hardwarové parametry a mapování PWM. |
| `POST` | `/reboot` | Spouští hardwarový reset pro aplikaci změn. |

### JSON schéma
Model `RuntimeConfig` využívá strukturu ELRS 4.x, která rozděluje parametry do tří primárních uzlů:
- `settings`: Pouze pro čtení – identifikátory hardwaru a řetězce verzí.
- `options`: Modifikovatelné uživatelské preference a síťové přihlašovací údaje.
- `config`: Nízkoúrovňové konfigurace hardwaru (Protocols, PWM Arrays).

Příklad JSON struktury:
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
- **`ConfigViewModel`**: Spravuje živý stav připojení, logiku heartbeat a detekci IP adres.
- **`DeviceEditorViewModel`**: Udržuje koncept stavu konfigurace zařízení, což umožňuje vícestupňové úpravy s finální logikou "uložit/zrušit".
- **`FlashingController`**: Orchestuje stahování firmwaru, lokální binární záplatování a proces nahrávání XH-over-HTTP.

## Vrstva mapování
Následující tabulky definují mapování mezi celočíselnými identifikátory používanými v API a jejich lidsky čitelnými ekvivalenty.

### Regulační domény
| ID | Popisek | Popis |
| :--- | :--- | :--- |
| 0 | AU915 | Austrálie/Nový Zéland 915MHz |
| 1 | FCC915 | Severní Amerika 915MHz |
| 2 | EU868 | Evropa 868MHz |
| 3 | IN866 | Indie 866MHz |
| 4 | AU433 | Austrálie 433MHz |
| 5 | EU433 | Evropa 433MHz |
| 6 | US433 | Severní Amerika 433MHz |
| 7 | US433-Wide | Severní Amerika širokopásmové 433MHz |


## Pokročilá mapování

### VBind (Úložiště vazeb)
Určuje, jak je vazební fráze uložena v zařízení.
- **0: Persistentní**: Uloženo do flash paměti (standardní).
- **1: Volatilní**: Smazáno po vypnutí/zapnutí.
- **2: Vratné**: Používáno pro zapůjčené vybavení.
- **3: Administrované**: Používáno v prostředí s více piloty.


## Vrstva perzistence
Systém implementuje dvoufázovou strategii perzistence:
- **`SharedPreferences`**: Využíváno prostřednictvím `PersistenceService` pro nesenzitivní data, jako jsou WiFi SSID a obecné preference aplikace.
- **`FlutterSecureStorage`**: Používáno pro citlivá data, včetně vazebních frází a hesel WiFi, což zajišťuje šifrování na úrovni OS.

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->