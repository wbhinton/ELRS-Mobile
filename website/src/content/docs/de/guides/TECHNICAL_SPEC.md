---
title: "Technische Spezifikation"
slug: de/technical_spec
sidebar:
  order: 5
---

## Architekturübersicht

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Designprinzip</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Die Anwendung basiert auf Flutter und nutzt das <strong>Riverpod</strong> State-Management-Framework. Sie interagiert mit der ELRS-Hardware über eine RESTful API, die vom integrierten WiFi-Modul des Geräts bereitgestellt wird, um eine Kommunikation mit geringer Latenz und Echtzeit-Statussynchronisierung zu gewährleisten.
  </p>
</div>

## Datenschicht

### API-Endpunkte
Das System kommuniziert mit der Hardware über die folgenden HTTP-Endpunkte:

| Methode | Endpunkt | Beschreibung |
| :--- | :--- | :--- |
| `GET` | `/config` | Ruft die aktuelle Gerätekonfiguration im JSON-Format ab. |
| `POST` | `/options.json` | Aktualisiert änderbare Laufzeitoptionen (SSID, Passwort usw.). |
| `POST` | `/config` | Aktualisiert grundlegende Hardwareparameter und PWM-Zuordnungen. |
| `POST` | `/reboot` | Löst einen Hardware-Reset aus, um Änderungen anzuwenden. |

### JSON-Schema
Das `RuntimeConfig`-Modell nutzt die ELRS 4.x-Struktur, die Parameter in drei primäre Knoten unterteilt:
- `settings`: Schreibgeschützte Hardware-Identifikatoren und Versionszeichenfolgen.
- `options`: Änderbare Benutzereinstellungen und Netzwerkanmeldeinformationen.
- `config`: Low-Level-Hardwarekonfigurationen (Protokolle, PWM-Arrays).

Beispiel für eine JSON-Struktur:
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

## Zustandsverwaltung
Das System verwendet eine reaktive Architektur:
- **`ConfigViewModel`**: Verwaltet den Live-Verbindungsstatus, die Heartbeat-Logik und die IP-Erkennung.
- **`FlashingController`**: Orchestriert Firmware-Downloads, lokale Binär-Patching und den XH-over-HTTP-Upload-Prozess.

## Zuordnungsschicht
`ElrsMappings.domains900` ordnet den in der API verwendeten 900 MHz Regulierungsbereichsindex seinem menschenlesbaren Label zu:

| ID | Label | Beschreibung |
| :--- | :--- | :--- |
| 0 | AU915 | Australien/Neuseeland 915MHz |
| 1 | FCC915 | Nordamerika 915MHz |
| 2 | EU868 | Europa 868MHz |
| 3 | IN866 | Indien 866MHz |
| 4 | AU433 | Australien 433MHz |
| 5 | EU433 | Europa 433MHz |
| 6 | US433 | Nordamerika 433MHz |
| 7 | US433-Wide | Nordamerika Wide 433MHz |


## Persistenzschicht
Das System implementiert eine zweischichtige Persistenzstrategie:
- **`SharedPreferences`**: Wird über `PersistenceService` für nicht-sensible Daten wie WiFi SSIDs und allgemeine App-Einstellungen verwendet.
- **`FlutterSecureStorage`**: Wird für sensible Daten, einschließlich Binding Phrases und WiFi-Passwörter, verwendet, um die Verschlüsselung auf OS-Ebene zu gewährleisten.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->