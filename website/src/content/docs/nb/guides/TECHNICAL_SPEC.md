---
title: "Teknisk spesifikasjon"
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
    Applikasjonen er bygget med Flutter og benytter seg av <strong>Riverpod</strong> rammeverket for tilstandshåndtering. Den interagerer med ELRS-maskinvare via et RESTful API eksponert av enhetens innebygde WiFi-modul, noe som sikrer kommunikasjon med lav latens og sanntids synkronisering av tilstand.
  </p>
</div>

## Datalag

### API-endepunkter
Systemet kommuniserer med maskinvaren ved hjelp av følgende HTTP-endepunkter:

| Metode | Endepunkt | Beskrivelse |
| :--- | :--- | :--- |
| `GET` | `/config` | Henter gjeldende enhetskonfigurasjon i JSON-format. |
| `POST` | `/options.json` | Oppdaterer modifiserbare kjøretidsalternativer (WiFi SSID, passord, osv.). |
| `POST` | `/config` | Oppdaterer kjerne maskinvareparametere og PWM-tilordninger. |
| `POST` | `/reboot` | Utløser en maskinvareresett for å anvende endringer. |

### JSON-skjema
`RuntimeConfig`-modellen benytter seg av ELRS 4.x-strukturen, som deler parametere inn i tre primære noder:
- `settings`: Skrivebeskyttede maskinvareidentifikatorer og versjonsstrenger.
- `options`: Modifiserbare brukerinnstillinger og nettverkslegitimasjon.
- `config`: Lavnivå maskinvarekonfigurasjoner (protokoller, PWM Arrays).

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
- **`ConfigViewModel`**: Håndterer live tilkoblingsstatus, "heartbeat"-logikk og IP-oppdagelse.
- **`DeviceEditorViewModel`**: Inneholder utkaststatusen for en enhets konfigurasjon, noe som muliggjør redigering i flere trinn med endelig "lagre/avbryt"-logikk.
- **`FlashingController`**: Orkestrerer nedlastinger av fastvare, lokal binær patching og XH-over-HTTP opplastingsprosessen.

## Kartleggingslag
Følgende tabeller definerer kartleggingen mellom heltallsidentifikatorer brukt i API-et og deres menneskelesbare ekvivalenter.

### Regulatoriske domener
| ID | Etikett | Beskrivelse |
| :--- | :--- | :--- |
| 0 | AU915 | Australia/New Zealand 915MHz |
| 1 | FCC915 | North American 915MHz |
| 2 | EU868 | European 868MHz |
| 3 | IN866 | Indian 866MHz |
| 4 | AU433 | Australia 433MHz |
| 5 | EU433 | European 433MHz |
| 6 | US433 | North American 433MHz |
| 7 | US433-Wide | North American Wide 433MHz |


## Avanserte kartlegginger

### VBind (Bindingslagring)
Bestemmer hvordan bindingsfrasen lagres på enheten.
- **0: Persistent**: Lagres til flash-minne (standard).
- **1: Volatile**: Slettes ved strømsyklus.
- **2: Returnable**: Brukes for utlånsutstyr.
- **3: Administered**: Brukes i flerpilot-flåtemiljøer.


## Vedvarende lag
Systemet implementerer en tolags vedvarende lagringsstrategi:
- **`SharedPreferences`**: Brukes via `PersistenceService` for ikke-sensitive data som WiFi SSID-er og generelle appinnstillinger.
- **`FlutterSecureStorage`**: Brukes for sensitive data, inkludert bindingsfraser og WiFi-passord, og sikrer kryptering på OS-nivå.

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->