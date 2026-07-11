---
title: "Instrukcja obsługi"
slug: user_guide
sidebar:
  order: 1
---

## Przegląd
Ta aplikacja zapewnia kompleksowy interfejs mobilny do zarządzania sprzętem ExpressLRS. Umożliwia użytkownikom konfigurację parametrów odbiornika (RX) i nadajnika (TX), mapowanie wyjść PWM oraz bezpośrednie flashowanie aktualizacji firmware z urządzenia mobilnego.

---

## Instalacja

### Oficjalne sklepy z aplikacjami

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Zainstaluj z Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Pobierz w Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Zainstaluj z App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Pobierz z App Store</a>

### Alternatywna instalacja

#### GitHub Store
Idealne dla użytkowników, którzy preferują alternatywny sklep z aplikacjami.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Pobierz z GitHub Store</a>

### Instalacja ręczna
Dla zaawansowanych użytkowników lub tych, którzy preferują ręczne zarządzanie, odwiedź naszą stronę [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) po najnowsze pliki `.apk`.

---

## 🚀 Szybki start: Flashowanie pierwszego urządzenia

### Faza 1: Buforowanie firmware (Zrób to w domu)
1. Otwórz aplikację i przejdź do **Firmware Manager**.
2. Stuknij ikonę pobierania obok najnowszej stabilnej wersji.
3. Aplikacja pobierze i bezpiecznie zbuforuje wymagane definicje celu i sprzętu do użytku offline.

### Faza 2: Łączenie z urządzeniem
1. W��ącz odbiornik ExpressLRS (RX) lub nadajnik (TX).
2. Poczekaj 60 sekund (lub skonfigurowany interwał), aż urządzenie przejdzie w tryb Wi-Fi Hotspot (szybko migająca dioda LED).
3. Podłącz Wi-Fi telefonu do sieci **ExpressLRS RX** lub **ExpressLRS TX** (Hasło: `expresslrs`).
4. Otwórz aplikację. Pulpit nawigacyjny automatycznie przeskanuje sieć za pomocą mDNS i połączy się z urządzeniem.

### Faza 3: Flashowanie firmware
1. Z Pulpitu nawigacyjnego wybierz **Flash Device**.
2. **Wybierz swój sprzęt:** Użyj rozwijanych list, aby wybrać typ urządzenia, dostawcę, częstotliwość i cel (Target).
3. **Konfiguracja opcji i profili:** Wybierz **Flashing Profile** (lub stuknij przycisk **+**, aby dodać nowy nazwany profil) w celu załadowania swoich danych uwierzytelniających. Dostosuj Binding Phrase, Wi-Fi SSID, Wi-Fi password, domeny regulacyjne i interwał automatycznego włączania Wi-Fi.
4. Stuknij **FLASH**. Aplikacja złoży binarnik lokalnie i prześle go do urządzenia.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.0,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Ostrzeżenie o niezgodności celu (Target Mismatch)</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Jeśli aplikacja wykryje niezgodność celu sprzętowego między twoim wyborem a podłączonym urządzeniem, ostrzeże cię, aby zapobiec przypadkowemu uszkodzeniu. Jeśli jesteś pewien, że masz prawidłowy cel (np. odzyskujesz po nieudanym flashowaniu lub migrujesz między definicjami celów), kliknij <strong>FORCE FLASH</strong> w oknie dialogowym ostrzeżenia, aby pominąć sprawdzenie.
  </p>
</div>

### 📋 Zarządzanie profilami flashowania
Jeśli masz wiele dronów lub konfiguracji radiowych z różnymi wymaganiami konfiguracyjnymi (np. różne frazy wiązania lub domeny regulacyjne), możesz użyć nazwanych **Flashing Profiles** do zapisywania i przełączania konfiguracji:
*   **Dodaj profil**: Stuknij ikonę **+** obok rozwijanej listy "Flashing Profile", wpisz nazwę i stuknij Dodaj.
*   **Auto-zapisywanie**: Wszelkie zmiany w danych uwierzytelniających aktywnego profilu (fraza wiązania, SSID, hasło, domena lub interwał) są automatycznie zapisywane w czasie rzeczywistym.
*   **Przełącz profile**: Po prostu wybierz profil z rozwijanej listy, aby natychmiast załadować jego zapisane ustawienia.
*   **Usuń profil**: Aby posprzątać, wybierz profil z rozwijanej listy i stuknij ikonę kosza/usuwania (aby usunąć profil, musisz mieć co najmniej dwa).

---

## Szczegóły techniczne

### Łączność i wykrywanie
Aplikacja wykorzystuje solidną wielostopniową sekwencję wykrywania, aby znaleźć Twój sprzęt:
1.  **Rozpoznawanie mDNS**: Podstawowa metoda. Aplikacja skanuje w poszukiwaniu `elrs_rx.local` lub `elrs_tx.local`.
2.  **Awaryjne przełączanie na statyczny AP**: Jeśli mDNS jest zablokowane, aplikacja sprawdza oficjalny adres IP punktu dostępowego ELRS (`10.0.0.1`).
3.  **Ręczne nadpisywanie IP**: W przypadku złożonych sieci można ręcznie wprowadzić adres IP w Ustawieniach.

**Wymuszone wiązanie sieciowe**: Nowoczesne smartfony często odrzucają połączenia Wi-Fi bez dostępu do Internetu. ELRS Mobile zawiera natywną warstwę "Forced Routing", która wymusza na systemie operacyjnym utrzymywanie połączenia ze sprzętem, zapewniając 100% niezawodne wykrywanie w terenie.

---

## Tryb eksperta i audytowanie
W menu Ustawienia użytkownicy mogą włączyć **Expert Mode**. Pozwala to na zapisanie złożonego binarnego pliku firmware bezpośrednio na urządzeniu w celu audytu lub ręcznego flashowania za pomocą FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.0,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Obsługa sprzętu STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Chociaż ELRS Mobile może składać i patchować firmware dla celów STM32 (do ELRS v3.x), urządzenia te nie obsługują flashowania Over-The-Air (OTA) za pośrednictwem Wi-Fi. Jeśli wybierzesz cel STM32, aplikacja pozwoli Ci zbudować i zapisać plik binarny lokalnie, abyś mógł flashować go ręcznie za pomocą komputera przez STLink lub Betaflight Passthrough.
  </p>
</div>

Dla programistów, którzy chcą zweryfikować integralność tych plików binarnych, zobacz nasz [**Przewodnik walidacji firmware**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->