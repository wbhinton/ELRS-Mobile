---
title: "Technische Specificatie"
slug: nl/technical_spec
sidebar:
  order: 5
---

## Architectuuroverzicht

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Ontwerpprincipe</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    De applicatie is gebouwd met Flutter en maakt gebruik van het <strong>Riverpod</strong> state management framework. Het communiceert met ELRS-hardware via een RESTful API die wordt blootgesteld door de ingebouwde WiFi-module van het apparaat, wat zorgt voor communicatie met lage latentie en real-time statussynchronisatie.
  </p>
</div>

## Gegevenslaag

### API-eindpunten
Het systeem communiceert met de hardware via de volgende HTTP-eindpunten:

| Methode | Eindpunt | Beschrijving |
| :--- | :--- | :--- |
| `GET` | `/config` | Haalt de huidige apparaatconfiguratie op in JSON-formaat. |
| `POST` | `/options.json` | Werkt aanpasbare runtime-opties bij (SSID, Wachtwoord, enz.). |
| `POST` | `/config` | Werkt kernhardwareparameters en PWM-toewijzingen bij. |
| `POST` | `/reboot` | Activeert een hardware-reset om wijzigingen toe te passen. |

### JSON-schema
Het `RuntimeConfig`-model maakt gebruik van de ELRS 4.x-structuur, die parameters scheidt in drie primaire knooppunten:
- `settings`: Alleen-lezen hardware-identificatoren en versietekstreeksen.
- `options`: Aanpasbare gebruikersvoorkeuren en netwerkreferenties.
- `config`: Laag-niveau hardwareconfiguraties (Protocollen, PWM-arrays).

Voorbeeld JSON-structuur:
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

## Statusbeheer
Het systeem maakt gebruik van een reactieve architectuur:
- **`ConfigViewModel`**: Beheert de live verbindingsstatus, hartslaglogica en IP-detectie.
- **`FlashingController`**: Coördineert firmware-downloads, lokale binaire patching en het XH-over-HTTP uploadproces.

## Toewijzingslaag
`ElrsMappings.domains900` koppelt de 900 MHz reguliere domeinindex die in de API wordt gebruikt aan het menselijk leesbare label:

| ID | Label | Beschrijving |
| :--- | :--- | :--- |
| 0 | AU915 | Australië/Nieuw-Zeeland 915MHz |
| 1 | FCC915 | Noord-Amerikaans 915MHz |
| 2 | EU868 | Europees 868MHz |
| 3 | IN866 | Indiaas 866MHz |
| 4 | AU433 | Australië 433MHz |
| 5 | EU433 | Europees 433MHz |
| 6 | US433 | Noord-Amerikaans 433MHz |
| 7 | US433-Wide | Noord-Amerikaans Breed 433MHz |


## Persistentielaag
Het systeem implementeert een tweeledige persistentie-strategie:
- **`SharedPreferences`**: Gebruikt via `PersistenceService` voor niet-gevoelige gegevens zoals WiFi SSIDs en algemene app-voorkeuren.
- **`FlutterSecureStorage`**: Gebruikt voor gevoelige gegevens, waaronder bindingszinnen en WiFi-wachtwoorden, wat encryptie op OS-niveau garandeert.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->