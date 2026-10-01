---
title: "Specyfikacja Techniczna"
slug: pl/technical_spec
sidebar:
  order: 5
---

## Przegląd Architektury

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Zasada Projektowania</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Aplikacja została zbudowana przy użyciu Fluttera i wykorzystuje framework zarządzania stanem <strong>Riverpod</strong>. Komunikuje się ze sprzętem ELRS za pośrednictwem API RESTful udostępnianego przez wbudowany moduł WiFi urządzenia, zapewniając niskie opóźnienia komunikacji i synchronizację stanu w czasie rzeczywistym.
  </p>
</div>

## Warstwa Danych

### Punkty Końcowe API
System komunikuje się ze sprzętem za pomocą następujących punktów końcowych HTTP:

| Metoda | Punkt Końcowy | Opis |
| :--- | :--- | :--- |
| `GET` | `/config` | Pobiera aktualną konfigurację urządzenia w formacie JSON. |
| `POST` | `/options.json` | Aktualizuje modyfikowalne opcje wykonawcze (SSID, Hasło itp.). |
| `POST` | `/config` | Aktualizuje podstawowe parametry sprzętowe i mapowania PWM. |
| `POST` | `/reboot` | Wyzwala reset sprzętowy w celu zastosowania zmian. |

### Schemat JSON
Model `RuntimeConfig` wykorzystuje strukturę ELRS 4.x, która rozdziela parametry na trzy główne węzły:
- `settings`: Identyfikatory sprzętowe tylko do odczytu i łańcuchy wersji.
- `options`: Modyfikowalne preferencje użytkownika i dane uwierzytelniające sieciowe.
- `config`: Niskopoziomowe konfiguracje sprzętowe (Protokoły, Tablice PWM).

Przykładowa struktura JSON:
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

## Zarządzanie Stanem
System wykorzystuje architekturę reaktywną:
- **`ConfigViewModel`**: Zarządza stanem aktywnego połączenia, logiką sygnału życia (heartbeat) i wykrywaniem IP.
- **`FlashingController`**: Koordynuje pobieranie firmware'u, lokalne łatanie binarne i proces przesyłania XH-over-HTTP.

## Warstwa Mapowania
`ElrsMappings.domains900` mapuje indeks domeny regulacyjnej 900 MHz używany w API do jej czytelnej dla człowieka etykiety:

| ID | Etykieta | Opis |
| :--- | :--- | :--- |
| 0 | AU915 | Australia/Nowa Zelandia 915MHz |
| 1 | FCC915 | Ameryka Północna 915MHz |
| 2 | EU868 | Europa 868MHz |
| 3 | IN866 | Indie 866MHz |
| 4 | AU433 | Australia 433MHz |
| 5 | EU433 | Europa 433MHz |
| 6 | US433 | Ameryka Północna 433MHz |
| 7 | US433-Wide | Ameryka Północna Szeroka 433MHz |


## Warstwa Trwałości
System implementuje dwuwarstwową strategię trwałości danych:
- **`SharedPreferences`**: Wykorzystywane za pośrednictwem `PersistenceService` dla danych niewrażliwych, takich jak WiFi SSID i ogólne preferencje aplikacji.
- **`FlutterSecureStorage`**: Używane dla danych wrażliwych, w tym Fraz Wiązania (Binding Phrases) i Haseł WiFi, zapewniając szyfrowanie na poziomie systemu operacyjnego.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->