---
title: "Instrukcja obsługi"
slug: user_guide
sidebar:
  order: 1
---

## Przegląd
Ta aplikacja zapewnia kompleksowy interfejs mobilny do zarządzania sprzętem ExpressLRS. Umożliwia użytkownikom konfigurowanie parametrów odbiornika (RX) i nadajnika (TX), mapowanie wyjść PWM oraz flashowanie aktualizacji firmware bezpośrednio z urządzenia mobilnego.

---

## Instalacja

### Oficjalne Sklepy z Aplikacjami

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Zainstaluj z Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Pobierz z Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Zainstaluj z App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Pobierz z App Store</a>

### Alternatywna Instalacja

#### GitHub Store
Idealne dla użytkowników, którzy preferują alternatywne sklepy z aplikacjami.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Pobierz z GitHub Store</a>

### Instalacja Ręczna
Dla zaawansowanych użytkowników lub tych, którzy preferują ręczne zarządzanie, odwiedź naszą stronę [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) w celu uzyskania najnowszych plików `.apk`.

---

## 🚀 Szybki Start: Flashowanie Pierwszego Urządzenia

### Faza 1: Buforowanie Firmware (Zrób to w domu)
1. Otwórz aplikację i przejdź do **Menedżera Firmware**.
2. Stuknij ikonę pobierania obok najnowszej stabilnej wersji.
3. Aplikacja pobierze i bezpiecznie zbuforuje wymagane definicje celu i sprzętu do użytku offline.

### Faza 2: Łączenie z Urządzeniem
1. Włącz swój odbiornik (RX) lub nadajnik (TX) ExpressLRS.
2. Poczekaj 60 sekund (lub skonfigurowany interwał), aż urządzenie przejdzie w tryb Wi-Fi Hotspot (szybko migająca dioda LED).
3. Połącz Wi-Fi swojego telefonu z siecią **ExpressLRS RX** lub **ExpressLRS TX** (Hasło: `expresslrs`).
4. Otwórz aplikację. Pulpit nawigacyjny automatycznie przeskanuje sieć używając mDNS i połączy się z urządzeniem.

### Faza 3: Flashowanie Firmware
1. Z Pulpitu nawigacyjnego wybierz **Flash Device**.
2. **Wybierz sprzęt:** Użyj rozwijanych list kaskadowych, aby wybrać Typ Urządzenia, Producenta, Częstotliwość i Cel.
3. **Skonfiguruj Opcje:** Ustaw swoją niestandardową Frazy Bindowania, dane logowania Wi-Fi i Domenę Regulacyjną.
4. Stuknij **FLASH**. Aplikacja lokalnie skompiluje plik binarny i wyśle go do urządzenia.

---

## Szczegóły Techniczne

### Łączność i Wykrywanie
Aplikacja wykorzystuje solidną, wieloetapową sekwencję wykrywania, aby znaleźć Twój sprzęt:
1. **Rozpoznawanie mDNS**: Główna metoda. Aplikacja skanuje w poszukiwaniu `elrs_rx.local` lub `elrs_tx.local`.
2. **Awaryjny statyczny punkt dostępu**: Jeśli mDNS jest zablokowane, aplikacja sprawdza oficjalny adres IP punktu dostępu ELRS (`10.0.0.1`).
3. **Ręczne nadpisywanie IP**: Dla złożonych sieci możesz ręcznie wprowadzić adres IP w Ustawieniach.

**Wymuszone Powiązanie Sieciowe**: Nowoczesne smartfony często rozłączają połączenia Wi-Fi bez dostępu do Internetu. ELRS Mobile zawiera natywną warstwę „Wymuszonego Routingu”, która zmusza system operacyjny do utrzymania połączenia ze sprzętem, zapewniając 100% niezawodne wykrywanie w terenie.

---

## Tryb Eksperta i Audyt
W menu Ustawienia użytkownicy mogą włączyć **Tryb Eksperta**. Umożliwia to zapisanie skompilowanego pliku binarnego firmware bezpośrednio na urządzeniu w celu audytu lub ręcznego flashowania za pośrednictwem FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Obsługa sprzętu STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Chociaż ELRS Mobile może kompilować i łatać firmware dla celów STM32 (do ELRS v3.x), urządzenia te nie obsługują flashowania Over-The-Air (OTA) za pośrednictwem Wi-Fi. Jeśli wybierzesz cel STM32, aplikacja umożliwi Ci zbudowanie i lokalne zapisanie pliku binarnego, abyś mógł go ręcznie flashować za pomocą komputera przez STLink lub Betaflight Passthrough.
  </p>
</div>

Dla deweloperów chcących zweryfikować integralność tych plików binarnych, zapoznaj się z naszym [**Przewodnikiem Walidacji Firmware**](/guides/firmware-validation).

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->