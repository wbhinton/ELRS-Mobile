---
title: "Przewodnik użytkownika"
slug: pl/user_guide
sidebar:
  order: 1
---

ELRS Mobile flashuje i konfiguruje odbiorniki (RX) oraz nadajniki (TX) ExpressLRS z Twojego telefonu, przez Wi-Fi, bez laptopa i bez połączenia z internetem w terenie. Działa z urządzeniami opartymi na ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) oraz firmware'em ExpressLRS 3.3.x i 4.x. Zobacz [Obsługiwany sprzęt](/supported_hardware), aby znaleźć każde kompatybilne urządzenie.

Proces pracy składa się z dwóch części: pobieranie firmware'u, gdy masz internet, a następnie flashowanie w dowolnym miejscu.

---

## Instalacja

| Platforma | Gdzie pobrać |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone i iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, bez Google Play | [Bezpośrednie pobieranie pliku APK](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) lub [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Wersje ze sklepów aktualizują się przez Google Play i App Store. Plik APK pobrany bezpośrednio sprawdza dostępność nowej wersji raz dziennie i oferuje jej pobranie; możesz również sprawdzić w dowolnym momencie z poziomu **Ustawienia → Informacje i zasady → Sprawdź aktualizacje**, pominąć wersję lub ustawić przypomnienie na później. Twoje ustawienia i profile są zachowywane podczas instalacji aktualizacji.

Chcesz mieć wczesny dostęp do nowych funkcji? Dołącz do [bety Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) lub [bety TestFlight](https://testflight.apple.com/join/jwU1WrpX).

Przy pierwszym uruchomieniu aplikacja wyświetla krótkie zastrzeżenie. Flashowanie firmware'u zawsze wiąże się z pewnym ryzykiem dla Twojego sprzętu; zaakceptuj je, aby kontynuować.

---

## Szybki start: flashowanie pierwszego urządzenia

### Krok 1: Pobieranie firmware'u (w domu)

1.  Na Pulpicie (Dashboard) otwórz **Menedżer Firmware'u**.
2.  Stuknij ikonę pobierania obok wersji ExpressLRS, którą chcesz. Wyświetlane są tylko wersje 3.3.0 i nowsze: są to pierwsze wersje z ujednoliconym firmware'em, na którym bazuje ELRS Mobile.
3.  Po zakończeniu pobierania wersja wyświetli **Gotowy do użytku offline**. Firmware i wymagane definicje sprzętowe są teraz przechowywane na Twoim telefonie.

Pobierz firmware na domowym Wi-Fi lub danych mobilnych. Nie możesz pobierać, gdy Twój telefon jest podłączony do hotspota Wi-Fi odbiornika lub nadajnika, ponieważ ta sieć nie ma dostępu do internetu.

Nagłówek pokazuje, ile wersji zapisałeś w ramach swojego limitu. Zmień limit w **Ustawienia → Aplikacja i Pamięć → Maksymalna liczba buforowanych wersji** i usuń wersje, których już nie potrzebujesz.

### Krok 2: Podłączanie do urządzenia

1.  Włącz odbiornik lub nadajnik i poczekaj, aż uruchomi swój hotspot Wi-Fi. Domyślnie dzieje się to 60 sekund po włączeniu, jeśli nie połączył się ze swoim partnerem. Nadajniki mogą również uruchamiać Wi-Fi ze skryptu Lua ExpressLRS w Twoim radiu.
2.  Na swoim telefonie dołącz do sieci **ExpressLRS RX** lub **ExpressLRS TX**. Hasło to `expresslrs`.
3.  Otwórz ELRS Mobile. Pulpit (Dashboard) automatycznie znajdzie urządzenie i wyświetli jego nazwę produktu, wersję firmware'u, target i domenę regulacyjną.

Jeśli Pulpit (Dashboard) pokazuje **Nie znaleziono urządzenia**, stuknij **Ponów próbę**. Jeśli Twoje urządzenie jest w innej sieci (na przykład połączone z Twoim domowym Wi-Fi), stuknij ikonę zębatki na karcie urządzenia i wprowadź jego adres IP.

Urządzenia z firmware'em starszym niż 3.1 również są wykrywane, dzięki czemu możesz je zaktualizować do bieżącej wersji.

### Krok 3: Flashowanie

1.  Na Pulpicie (Dashboard) stuknij **Flashuj urządzenie**.
2.  Sprawdź target. Aplikacja wstępnie wybiera target pasujący do podłączonego urządzenia, jeśli jest to możliwe; w przeciwnym razie wybierz Typ urządzenia, Dostawcę urządzenia, Domenę regulacyjną i częstotliwość oraz Target urządzenia.
3.  Wybierz wersję firmware'u. Wersje, które pobrałeś, są oznaczone jako **(Buforowane)**. Jeśli sprzęt wymaga nowszej wersji niż ta, którą masz, aplikacja poinformuje o tym i zaproponuje pobranie kompatybilnej.
4.  Sprawdź opcje firmware'u: profil flashowania, frazę wiążącą, sieć Wi-Fi i hasło, domenę regulacyjną oraz interwał automatycznego włączania Wi-Fi.
5.  Stuknij **Flashuj**.

Pasek postępu śledzi każdy krok: lokalizowanie i rozpakowywanie pobranego firmware'u, budowanie go z Twoimi ustawieniami, przesyłanie go oraz **Zapisywanie do urządzenia — Proszę czekać**, podczas gdy urządzenie instaluje go i restartuje. Gdy urządzenie potwierdzi, zobaczysz **Flashowanie zakończone sukcesem! Urządzenie restartuje**, a Pulpit (Dashboard) ponownie połączy się, gdy urządzenie wróci do pracy.

---

## Kontrole bezpieczeństwa

Aplikacja sprawdza Twoje wybory przed flashowaniem i zatrzymuje się, jeśli coś wygląda na błędne.

:::danger[Niekompatybilny chip]
Firmware dla jednego chipa nigdy nie może działać na innym (na przykład firmware ESP32 na odbiorniku ESP8285). Aplikacja blokuje flashowanie i informuje, który chip jest który. Wybierz target dla chipa swojego urządzenia.
:::

:::caution[Niezgodność targetu]
Jeśli wybrany target nie pasuje do produktu zgłaszanego przez urządzenie, zobaczysz **Niezgodność targetu**. Najpierw sprawdź swój wybór. Jeśli jesteś pewien, że jest poprawny (na przykład odzyskujesz po nieudanym flashowaniu lub przechodzisz na nowszą definicję targetu), stuknij **Wymuś Flashowanie**.
:::

:::note[Brak frazy wiążącej]
Flashowanie bez frazy wiążącej działa, ale urządzenie połączy się tylko przy użyciu domyślnej (pustej) frazy. Aplikacja pyta przed kontynuowaniem.
:::

:::caution[Flashowanie niepotwierdzone]
Jeśli urządzenie rozłączy się przed potwierdzeniem flashowania (straciło zasilanie, zrestartowało się lub połączenie Wi-Fi zostało zerwane), aplikacja nie może stwierdzić, czy aktualizacja została zakończona. Zamiast zgłaszać sukces, wyświetla bursztynowe ostrzeżenie. Połącz się ponownie i sprawdź wersję firmware'u na Pulpicie (Dashboard); jeśli się nie zmieniła, flashuj ponownie.
:::

---

## Profile flashowania

Profil flashowania zapisuje frazę wiążącą, domową sieć Wi-Fi i hasło, domyślne domeny regulacyjne oraz interwał automatycznego włączania Wi-Fi pod wybraną nazwą. Używaj jednego na flotę lub konfigurację radiową i przełączaj się między nimi jednym stuknięciem.

Zarządzaj profilami w **Ustawienia → Profile i Sieć**:

-   **Dodaj:** stuknij **+**, wpisz nazwę i stuknij **Dodaj**.
-   **Przełącz:** wybierz profil z listy **Profil flashowania**. Jest on również dostępny na ekranie flashowania.
-   **Edytuj:** zmień dowolne pole; aktywny profil zapisuje się automatycznie.
-   **Usuń:** wybierz profil i stuknij ikonę usuwania. Zawsze zachowujesz co najmniej jeden profil.

Frazy wiążące i hasła Wi-Fi są przechowywane w zaszyfrowanej bezpiecznej pamięci Twojego telefonu.

---

## Konfiguracja urządzenia

Na Pulpicie (Dashboard) stuknij **Konfiguracja urządzenia**, aby otworzyć stronę ustawień ExpressLRS podłączonego urządzenia wewnątrz aplikacji. Użyj jej do zmiany ustawień Wi-Fi i wiązania, dopasowania modelu, protokołu szeregowego, mapowania wyjść PWM i innych opcji urządzenia. Aplikacja utrzymuje stronę zablokowaną dla Twojego urządzenia.

---

## Ustawienia

| Sekcja | Co się tam znajduje |
| :--- | :--- |
| Profile i Sieć | Profile flashowania, fraza wiążąca, domowa sieć Wi-Fi i hasło, domyślne domeny regulacyjne 2.4 GHz i sub-GHz |
| Aplikacja i Pamięć | Maksymalna liczba buforowanych wersji, Menedżer Firmware'u, wyczyść pamięć podręczną firmware'u, język aplikacji, anonimowe analizy użytkowania (domyślnie włączone; wyłącz za pomocą **Udostępnij Analizy**) |
| Zaawansowane i Debugowanie | Tryb eksperta i jego narzędzia (poniżej) |
| Informacje i Zasady | Wersja aplikacji, nota prawna i licencja, wsparcie rozwoju oraz **Sprawdź aktualizacje** w pliku APK pobranym bezpośrednio |

Zmień język aplikacji z Ustawień lub przycisku języka na górnym pasku. ELRS Mobile jest dostępne w 18 językach.

---

## Tryb eksperta

Włącz **Ustawienia → Zaawansowane i Debugowanie → Tryb eksperta**, aby odblokować:

-   **Targety STM32.** Starsze urządzenia oparte na STM32 nie mogą być flashowane przez Wi-Fi, a wspiera to tylko ExpressLRS 3.3.x. Aplikacja buduje firmware z Twoimi ustawieniami, dzięki czemu możesz go flashować z komputera za pomocą STLink lub passthrough Betaflight.
-   **Pobierz Plik Binarny.** Zapisz zbudowany plik firmware'u zamiast go flashować, do ręcznego flashowania lub audytu.
-   **Eksportuj skrypt ELRS Lua.** Zapisz `elrs.lua` dla radiów EdgeTX i OpenTX.
-   **Wyślij Raport Debugowania.** Wyślij informacje o urządzeniu i logi aplikacji, aby pomóc w naprawieniu błędu. Frazy wiążące i hasła Wi-Fi nigdy nie są dołączane.

---

## Rozwiązywanie problemów

**Pulpit (Dashboard) nie może znaleźć mojego urządzenia.** Upewnij się, że Twój telefon jest nadal podłączony do sieci Wi-Fi urządzenia; niektóre telefony opuszczają sieci, które nie mają dostępu do internetu. Na Androidzie, ELRS Mobile utrzymuje swój ruch na tej sieci Wi-Fi nawet bez internetu. Stuknij **Ponów próbę** lub wprowadź adres IP z ikony zębatki (`10.0.0.1` w hotspocie samego urządzenia).

**Nie mogę pobrać firmware'u.** Odłącz się od hotspota urządzenia i użyj sieci z dostępem do internetu.

**Moje urządzenie nie reaguje po nieudanym flashowaniu.** Przytrzymaj przycisk BOOT podczas podłączania go przez USB, aby wejść w tryb bootloader'a, a następnie ponownie flashuj za pomocą [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Urządzenia z obsługą Wi-Fi można również odzyskać, przytrzymując BOOT przez 60 sekund, aby uruchomić hotspot Wi-Fi. Ekran **Pomoc i Wsparcie** w aplikacji zawiera te kroki, FAQ oraz linki do ExpressLRS Discord.

**Moje profile zniknęły po aktualizacji.** Bezpośrednia aktualizacja z wersji v1.0.43 lub starszej do v1.0.45 lub nowszej nie może przenieść zapisanych profili, fraz wiążących i ustawień Wi-Fi przez aktualizację pamięci. Aplikacja informuje o tym raz; wprowadź je ponownie w Ustawieniach.

---

Deweloperzy mogą zweryfikować firmware budowany przez ELRS Mobile za pomocą [Narzędzi Walidacji Firmware'u](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->