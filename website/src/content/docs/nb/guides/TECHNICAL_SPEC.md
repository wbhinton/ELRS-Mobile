---
title: "Teknisk Spesifikasjon"
slug: nb/technical_spec
sidebar:
  order: 5
---

## Arkitekturoversikt

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Designprinsipp</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Applikasjonen er bygget med Flutter og benytter **Riverpod** rammeverket for tilstandshåndtering. Den kommuniserer med ELRS-maskinvare via et RESTful API eksponert av enhetens innebygde WiFi-modul, noe som sikrer kommunikasjon med lav latens og sanntids tilstandssynkronisering.
  </p>
</div>

## Datalag

### API-endepunkter
Systemet kommuniserer med maskinvaren ved hjelp av følgende HTTP-endepunkter:

| Metode | Endepunkt | Beskrivelse |
| :--- | :--- | :--- |
| `GET` | `/config` | Henter gjeldende enhetskonfigurasjon i JSON-format. |
| `POST` | `/options.json` | Oppdaterer modifiserbare kjøretidsalternativer (SSID, passord, osv.). |
| `POST` | `/config` | Oppdaterer kjerne maskinvareparametre og PWM-tilordninger. |
| `POST` | `/reboot` | Utløser en maskinvarereset for å anvende endringer. |

### JSON-skjema
`RuntimeConfig`-modellen utnytter ELRS 4.x-strukturen, som skiller parametere i tre primære noder:
- `settings`: Skrivebeskyttede maskinvareidentifikatorer og versjonsstrenger.
- `options`: Modifiserbare brukerinnstillinger og nettverkslegitimasjon.
- `config`: Lavnivå maskinvarekonfigurasjoner (protokoller, PWM-matriser).

Eksempel på JSON-struktur:
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

## Tilstandshåndtering
Systemet benytter en reaktiv arkitektur:
- **`ConfigViewModel`**: Håndterer live tilkoblingstilstand, hjertebanklogikk og IP-oppdagelse.
- **`FlashingController`**: Orkestrerer nedlastinger av fastvare, lokal binær patching og XH-over-HTTP opplastingsprosessen.

## Tilordningslag
`ElrsMappings.domains900` tilordner 900 MHz regulatorisk domeneindeks brukt i API-et til dens menneskelesbare etikett:

| ID | Etikett | Beskrivelse |
| :--- | :--- | :--- |
| 0 | AU915 | Australia/New Zealand 915MHz |
| 1 | FCC915 | Nordamerikansk 915MHz |
| 2 | EU868 | Europeisk 868MHz |
| 3 | IN866 | Indisk 866MHz |
| 4 | AU433 | Australia 433MHz |
| 5 | EU433 | Europeisk 433MHz |
| 6 | US433 | Nordamerikansk 433MHz |
| 7 | US433-Wide | Nordamerikansk Bred 433MHz |


## Persistenslag
Systemet implementerer en to-lags persistensstrategi:
- **`SharedPreferences`**: Brukt via `PersistenceService` for ikke-sensitive data som WiFi SSIDs og generelle appinnstillinger.
- **`FlutterSecureStorage`**: Brukt for sensitive data, inkludert Binding Phrases og WiFi-passord, noe som sikrer kryptering på OS-nivå.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->