# Przewodnik

## Faza 1: Buforowanie oprogramowania układowego
1. **Połącz się z Internetem:** Upewnij się, że Twój telefon jest podłączony do internetu (np. domowe Wi-Fi lub sieć komórkowa).
2. **Otwórz Menedżera Oprogramowania Układowego:** Przejdź do Firmware Manager w aplikacji.
3. **Pobierz Wydanie:** Stuknij ikonę pobierania obok wybranego wydania ExpressLRS. Spowoduje to bezpieczne buforowanie wymaganych celów oprogramowania układowego i definicji sprzętowych na Twoim telefonie do 100% użytku offline.

## Faza 2: Łączenie się z urządzeniem
1. **Włącz Urządzenie:** Włącz swój odbiornik ExpressLRS (RX) lub nadajnik (TX).
2. **Poczekaj na Hotspot:** Poczekaj, aż urządzenie przejdzie w tryb Wi-Fi Hotspot Mode (sygnalizowane szybkim miganiem diody LED).
3. **Poł��cz się z Hotspotem:** Podłącz Wi-Fi swojego telefonu do sieci `ExpressLRS RX` lub `ExpressLRS TX` używając hasła `expresslrs`.
* **Uwaga:** ELRS Mobile natywnie obsługuje wymuszone routowanie, zapewniając, że Twój telefon nie przełączy się cicho z powrotem na 5G/LTE.

## Faza 3: Flashowanie oprogramowania układowego
1. **Przejdź do Flashowania Urządzenia:** Z głównego Pulpitu nawigacyjnego wybierz **Flash Device**.
2. **Wybór Celu:** Użyj kaskadowych list rozwijanych, aby wybrać dostawcę i konkretny cel sprzętowy.
3. **Wybór Wersji:** Wybierz dostępną wersję oprogramowania układowego z Twojego repozytorium offline.
4. **Konfiguracja:** Wprowadź swoje niestandardowe dane uwierzytelniające. Aplikacja przechowuje WiFi SSID, WiFi Password i Binding Phrase w lokalnej pamięci, dzięki czemu nie musisz ich ponownie wprowadzać.
5. **Kompilacja i Flashowanie:** Stuknij **FLASH**. System łata plik binarny Twoimi lokalnymi danymi uwierzytelniającymi i przesyła go.
* **Kluczowe:** Zawsze czekaj na potwierdzenie sukcesu i na wznowienie migania diody LED urządzenia przed odłączeniem!

---

# Najczęściej Zadawane Pytania

## Czy potrzebuję połączenia z internetem lub usługi komórkowej, aby flashować oprogramowanie układowe?
Nie. ELRS Mobile oferuje **100% Flashowanie Offline**. Tak długo, jak wcześniej pobrałeś wersję oprogramowania układowego za pośrednictwem Firmware Manager, będąc w domowym Wi-Fi, aplikacja może dynamicznie złożyć i flashować oprogramowanie układowe całkowicie offline.

## Otrzymuję błąd „Not enough space” podczas flashowania mojego odbiornika ESP8285.
Chipy ESP8285 (takie jak te, które znajdują się na wielu płytkach AIO) mają tylko 1MB całkowitej fizycznej pamięci. Bezpośrednia aktualizacja do głównego wydania (np. z 3.x do 4.x) przez Wi-Fi może spowodować brak miejsca na podwójnej partycji, ponieważ przychodzący plik jest zbyt duży, aby go rozpakować obok aktualnie działającego oprogramowania układowego.

**Jak naprawić:** Najpierw flashuj swój odbiornik do wersji pośredniej (np. **3.6.3**). Gdy będzie działał na lżejszym oprogramowaniu układowym 3.6.3, będziesz miał wystarczająco dużo miejsca na partycji, aby pomyślnie flashować do żądanego 4.0 target. Alternatywnie, włącz **Expert Mode** w Ustawieniach, zapisz zbudowany plik binarny lokalnie i flashuj go ręcznie za pomocą przewodowego połączenia Betaflight Passthrough.

## Gdzie znajdę skrypt Lua ExpressLRS dla mojego radia?
ELRS Mobile zawiera uniwersalny, niezależny od wersji Lua script wbudowany w aplikację! Aby go uzyskać:
1. Przejdź do **Settings** i włącz **Expert Mode**.
2. Stuknij **Export ELRS Lua Script**.
3. Spowoduje to zapisanie `elrs.lua` bezpośrednio w lokalnej pamięci Twojego telefonu. Włącz radio i podłącz je do telefonu przez USB, upewnij się, że wybrałeś tryb „USB Storage” na swoim radiu i przenieś plik do folderu `SCRIPTS/TOOLS` za pomocą menedżera plików w telefonie.
**Uwaga:** Musisz usunąć wszelkie poprzednie wersje skryptu elrs.lua (np. elrs_v2.lua, elrs_v3.lua itp.) z karty SD radia przed użyciem nowego skryptu.

## Co jeśli flashowanie się nie powiedzie, a moje urządzenie przestanie odpowiadać?
Jeśli Twoje urządzenie nie reaguje po nieudanym flashowaniu, możesz je łatwo odzyskać:
1. Przytrzymaj przycisk BOOT na urządzeniu podczas podłączania go przez USB, aby wejść w tryb bootloader.
2. Użyj komputera i ELRS Web Flasher, aby ponownie flashować urządzenie za pośrednictwem przewodowego połączenia USB/UART.
3. W przypadku urządzeń obsługujących Wi-Fi, możesz również przytrzymać BOOT
**Uwaga:** Na karcie Zasoby znajduje się link do filmu, który pokazuje, jak to zrobić.

## Czy mogę zapisać plik oprogramowania układowego na moim telefonie bez flashowania go?
Tak. Przechodząc do **Settings** i włączając **Expert Mode**, odblokowujesz możliwość zapisania złożonego pliku binarnego oprogramowania układowego bezpośrednio w lokalnej pamięci urządzenia mobilnego, zamiast natychmiastowego flashowania go Over-The-Air (OTA).

Jest to szczególnie przydatne, jeśli chcesz flashować urządzenie ręcznie za pomocą dedykowanego programatora sprzętowego (takiego jak STLink lub adapter FTDI).

## Otrzymuję błąd „Target Mismatch”. Co powinienem zrobić?
Błąd niezgodności celu (Target Mismatch) występuje, gdy hardware target wybrany w aplikacji nie pasuje do targetu oprogramowania układowego aktualnie działającego na urządzeniu.

Obecnie aplikacja nie obsługuje flashowania innego targetu niż ten, który jest aktualnie uruchomiony na urządzeniu.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->