# Przewodnik

## Faza 1: Buforowanie oprogramowania układowego (Firmware)
1. **Połącz się z Internetem:** Upewnij się, że Twój telefon jest połączony z internetem (np. domowe Wi-Fi lub sieć komórkowa).
2. **Otwórz Menedżer Firmware:** Przejdź do Firmware Manager w aplikacji.
3. **Pobierz wersję:** Dotknij ikonę pobierania obok wybranej wersji ExpressLRS. Spowoduje to bezpieczne buforowanie wymaganych celów firmware i definicji sprzętowych na Twoim telefonie do 100% użytku offline.

## Faza 2: Łączenie się z Twoim urządzeniem
1. **Włącz urządzenie:** Włącz swój odbiornik ExpressLRS (RX) lub nadajnik (TX).
2. **Poczekaj na Hotspot:** Poczekaj, aż urządzenie przejdzie w tryb Wi-Fi Hotspot (wskazany przez szybko migającą diodę LED).
3. **Połącz się z Hotspotem:** Połącz Wi-Fi swojego telefonu z siecią `ExpressLRS RX` lub `ExpressLRS TX` używając hasła `expresslrs`.
* **Uwaga:** ELRS Mobile natywnie obsługuje wymuszone routowanie, zapewniając, że Twój telefon nie przełączy się cicho z powrotem na 5G/LTE.

## Faza 3: Flashowanie oprogramowania układowego (Firmware)
1. **Przejdź do Flash Device:** Z głównego Dashboard, wybierz **Flash Device**.
2. **Wybór celu:** Użyj rozwijanych list kaskadowych, aby wybrać dostawcę i konkretny hardware target.
3. **Wybór wersji:** Wybierz dostępną wersję firmware z Twojego repozytorium offline.
4. **Konfiguracja i profile:** Wybierz lub utwórz **Flashing Profile** (np. "My Quads", "Race Spec"), aby załadować Twoje niestandardowe poświadczenia. Aplikacja przechowuje Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain i Auto-On intervals w tych nazwanych profilach, dzięki czemu nie musisz ich ponownie wprowadzać podczas przełączania między różnymi konfiguracjami.
5. **Zbuduj i Flashuj:** Dotknij **FLASH**. System patchuje binarny plik Twoimi lokalnymi poświadczeniami i przesyła go.
* **Ważne:** Zawsze czekaj na potwierdzenie sukcesu i na to, aby dioda LED urządzenia wznowiła miganie przed odłączeniem!

---

# FAQ

## Czy potrzebuję połączenia internetowego lub sieci komórkowej, aby flashować firmware?
Nie. ELRS Mobile oferuje **100% Offline Flashing**. Dopóki wcześniej pobrałeś wersję firmware za pośrednictwem Firmware Manager, będąc w domowym Wi-Fi, aplikacja może dynamicznie złożyć i flashować firmware całkowicie offline.

## Czym są Flashing Profiles i jak ich używać?
Flashing Profiles umożliwiają zapisywanie i przełączanie się między wieloma konfiguracjami flashowania (np. "My Quads", "Stock / Factory Reset", "Race Spec"). Każdy profil bezpiecznie przechowuje własną binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains i Wi-Fi auto-on interval.

Aby ich użyć:
1. Dotknij ikonę **+** (Dodaj) obok rozwijanej listy "Flashing Profile" w karcie **Configuration Options**.
2. Nazwij swój nowy profil i dostosuj ustawienia. Edycje są natychmiast automatycznie zapisywane.
3. Wybierz dowolny profil z rozwijanej listy, aby automatycznie zamienić wszystkie parametry.
4. Aby usunąć profil, wybierz go i dotknij ikony kosza/usuwania (musisz mieć co najmniej dwa profile, aby móc jeden usunąć).

## Otrzymuję błąd "Not enough space" podczas flashowania mojego odbiornika ESP8285.
Chipy ESP8285 (takie jak te znajdujące się na wielu płytach AIO) mają tylko 1MB całkowitej fizycznej pamięci. Bezpośrednia aktualizacja do głównej wersji (np. z 3.x do 4.x) przez Wi-Fi może spowodować brak miejsca na podwójnej partycji, ponieważ przychodzący plik jest zbyt duży, aby rozpakować go obok aktualnie działającego firmware.

**Jak naprawić:** Najpierw flashuj swój odbiornik do wersji pośredniej (np. **3.6.3**). Gdy będzie działać na lżejszym firmware 3.6.3, będziesz miał wystarczająco dużo miejsca na partycji, aby pomyślnie flashować do żądanego celu 4.0. Alternatywnie, włącz **Expert Mode** w Settings, zapisz zbudowany plik binarny lokalnie i flashuj go ręcznie za pośrednictwem przewodowego połączenia Betaflight Passthrough.

## Gdzie znajdę skrypt Lua ExpressLRS dla mojego radia?
ELRS Mobile zawiera uniwersalny, niezależny od wersji skrypt Lua wbudowany w aplikację! Aby go uzyskać:
1. Przejdź do **Settings** i włącz **Expert Mode**.
2. Dotknij **Export ELRS Lua Script**.
3. Spowoduje to zapisanie `elrs.lua` bezpośrednio w pamięci lokalnej Twojego telefonu. Włącz radio i podłącz je do telefonu przez USB, upewnij się, że wybrałeś tryb "USB Storage" w radiu i przenieś plik do folderu `SCRIPTS/TOOLS` za pomocą menedżera plików Twojego telefonu.

**Uwaga:** Musisz usunąć wszystkie poprzednie wersje skryptu elrs.lua (np. elrs_v2.lua, elrs_v3.lua itp.) z karty SD Twojego radia przed użyciem nowego skryptu.

## Co jeśli flashowanie zakończy się niepowodzeniem, a moje urządzenie przestanie odpowiadać?
Jeśli Twoje urządzenie nie odpowiada po nieudanym flashowaniu, możesz je łatwo odzyskać:
1. Przytrzymaj przycisk BOOT na urządzeniu podczas podłączania go przez USB, aby wejść w tryb bootloadera.
2. Użyj komputera i ELRS Web Flasher, aby ponownie flashować urządzenie przez przewodowe połączenie USB/UART.
3. W przypadku urządzeń obsługujących Wi-Fi, możesz również przytrzymać BOOT

**Uwaga:** Na zakładce Resources znajduje się link do filmu, który pokazuje, jak to zrobić.

## Czy mogę zapisać plik firmware na moim telefonie bez flashowania go?
Tak. Przechodząc do **Settings** i włączając **Expert Mode**, odblokowujesz możliwość zapisania złożonego binarnego firmware bezpośrednio w pamięci lokalnej Twojego urządzenia mobilnego, zamiast natychmiastowego flashowania go Over-The-Air (OTA).

Jest to szczególnie przydatne, jeśli chcesz flashować urządzenie ręcznie za pomocą dedykowanego programatora sprzętowego (np. adaptera STLink lub FTDI).

## Otrzymuję błąd "Target Mismatch". Co powinienem zrobić?
Błąd Target Mismatch występuje, gdy wybrany hardware target w aplikacji nie pasuje do celu firmware aktualnie działającego na urządzeniu.

Aby zapobiec przypadkowemu uszkodzeniu, aplikacja ostrzeże Cię, jeśli zostanie wykryte niedopasowanie. Jeśli jednak jesteś pewien, że wybrany cel jest poprawny (na przykład, jeśli konwertujesz urządzenie na inny wariant firmware lub korygujesz poprzednie nieprawidłowe flashowanie), możesz dotknąć **FORCE FLASH** w oknie dialogowym niedopasowania, aby pominąć sprawdzenie i kontynuować flashowanie.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->