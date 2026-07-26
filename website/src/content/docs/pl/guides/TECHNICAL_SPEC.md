---
title: "Specyfikacja Techniczna"
slug: pl/technical_spec
sidebar:
  order: 5
---

## Architektura – przegląd

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Zasada projektowania</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Aplikacja jest zbudowana przy użyciu Flutter i wykorzystuje framework zarządzania stanem <strong>Riverpod</strong>. Współdziała ze sprzętem ExpressLRS za pośrednictwem RESTful API udostępnianego przez wbudowany moduł WiFi urządzenia, zapewniając niskie opóźnienia komunikacji i synchronizację stanu w czasie rzeczywistym.
  </p>
</div>

## Warstwa danych

### Punkty końcowe API
System komunikuje się ze sprzętem za pomocą następujących punktów końcowych HTTP:

| Metoda | Punkt końcowy | Opis |
| :--- | :--- | :--- |
| `GET` | `/config` | Pobiera bieżącą konfigurację urządzenia w formacie JSON. |
| `POST` | `/options.json` | Aktualizuje modyfikowalne opcje środowiska uruchomieniowego (WiFi SSID, hasło itp.). |
| `POST` | `/config` | Aktualizuje podstawowe parametry sprzętowe i mapowania PWM. |
| `POST` | `/reboot` | Wyzwala reset sprzętu w celu zastosowania zmian. |

### Schemat JSON
Model `RuntimeConfig` wykorzystuje strukturę ExpressLRS 4.x, która rozdziela parametry na trzy główne węzły:
- `settings`: Identyfikatory sprzętowe i ciągi wersji tylko do odczytu.
- `options`: Modyfikowalne preferencje użytkownika i dane uwierzytelniające sieć.
- `config`: Niskopoziomowe konfiguracje sprzętowe (Protocols, PWM Arrays).

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

## Zarządzanie stanem
System wykorzystuje architekturę reaktywną:
- **`ConfigViewModel`**: Zarządza stanem połączenia na żywo, logiką pulsu i wykrywaniem IP.
- **`DeviceEditorViewModel`**: Przechowuje stan roboczy konfiguracji urządzenia, umożliwiając wieloetapowe edycje z końcową logiką „zapisz/anuluj”.
- **`FlashingController`**: Koordynuje pobieranie firmware'u, lokalne łatanie plików binarnych i proces przesyłania XH-over-HTTP.

## Warstwa mapowania
Poniższe tabele definiują mapowanie między identyfikatorami całkowitymi używanymi w API a ich czytelnymi dla człowieka odpowiednikami.

### Domeny regulacyjne
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


## Zaawansowane mapowania

### VBind (Przechowywanie wiązań)
Określa sposób przechowywania frazy wiązania na urządzeniu.
- **0: Persistent**: Zapisane w pamięci flash (standard).
- **1: Volatile**: Usunięte po cyklu zasilania.
- **2: Returnable**: Używane dla sprzętu wypożyczonego.
- **3: Administered**: Używane w środowiskach flotowych z wieloma pilotami.

## Warstwa persystencji
System implementuje dwuwarstwową strategię persystencji:
- **`SharedPreferences`**: Wykorzystywane za pośrednictwem `PersistenceService` do danych niepoufnych, takich jak WiFi SSID i ogólne preferencje aplikacji.
- **`FlutterSecureStorage`**: Używane do danych poufnych, w tym fraz wiązania i haseł WiFi, zapewniając szyfrowanie na poziomie systemu operacyjnego.

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->