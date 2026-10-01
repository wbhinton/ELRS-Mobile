---
title: "Teknisk specifikation"
slug: sv/technical_spec
sidebar:
  order: 5
---

## Arkitekturöversikt

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Designprincip</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Applikationen är byggd med Flutter och använder **Riverpod** ramverket för tillståndshantering. Den interagerar med ELRS-hårdvara via ett RESTful API som exponeras av enhetens inbyggda WiFi-modul, vilket säkerställer kommunikation med låg latens och synkronisering av tillstånd i realtid.
  </p>
</div>

## Datalager

### API-slutpunkter
Systemet kommunicerar med hårdvaran med följande HTTP-slutpunkter:

| Metod | Slutpunkt | Beskrivning |
| :--- | :--- | :--- |
| `GET` | `/config` | Hämtar aktuell enhetskonfiguration i JSON-format. |
| `POST` | `/options.json` | Uppdaterar ändringsbara körtidsalternativ (SSID, Password, etc.). |
| `POST` | `/config` | Uppdaterar kärnhårdvaruparametrar och PWM-mappningar. |
| `POST` | `/reboot` | Utlöser en hårdvaruåterställning för att tillämpa ändringar. |

### JSON-schema
`RuntimeConfig`-modellen utnyttjar ELRS 4.x-strukturen, som separerar parametrar i tre primära noder:
- `settings`: Skrivskyddade hårdvaruidentifierare och versionssträngar.
- `options`: Ändringsbara användarpreferenser och nätverksuppgifter.
- `config`: Lågnivå hårdvarukonfigurationer (protokoll, PWM-arrayer).

Exempel på JSON-struktur:
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

## Tillståndshantering
Systemet använder en reaktiv arkitektur:
- **`ConfigViewModel`**: Hanterar live-anslutningsstatus, heartbeat-logik och IP-upptäckt.
- **`FlashingController`**: Orkestrerar nedladdning av firmware, lokal binär patchning och XH-over-HTTP uppladdningsprocessen.

## Mappningslager
`ElrsMappings.domains900` mappar det 900 MHz regleringsdomänindex som används i API:et till dess mänskligt läsbara etikett:

| ID | Etikett | Beskrivning |
| :--- | :--- | :--- |
| 0 | AU915 | Australien/Nya Zeeland 915MHz |
| 1 | FCC915 | Nordamerika 915MHz |
| 2 | EU868 | Europa 868MHz |
| 3 | IN866 | Indien 866MHz |
| 4 | AU433 | Australien 433MHz |
| 5 | EU433 | Europa 433MHz |
| 6 | US433 | Nordamerika 433MHz |
| 7 | US433-Wide | Nordamerika Bred 433MHz |


## Beständighetslager
Systemet implementerar en strategi för beständighet i två lager:
- **`SharedPreferences`**: Används via `PersistenceService` för icke-känslig data som WiFi SSID och allmänna appinställningar.
- **`FlutterSecureStorage`**: Används för känslig data, inklusive bindningsfraser och WiFi-lösenord, vilket säkerställer kryptering på OS-nivå.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->