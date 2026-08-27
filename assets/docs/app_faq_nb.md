# Gjennomgang

## Fase 1: Mellomlagring av fastvare
1.  **Koble til Internett:** Sørg for at telefonen din er koblet til internett (f.eks. hjemme-Wi-Fi eller mobilnettverk).
2.  **Åpne fastvarebehandling:** Naviger til fastvarebehandlingen (Firmware Manager) i appen.
3.  **Last ned utgivelse:** Trykk på nedlastingsikonet ved siden av ønsket ExpressLRS-utgivelse. Dette mellomlagrer sikkert de nødvendige firmware targets og hardware definitions på telefonen din for 100 % offline bruk.

## Fase 2: Koble til enheten din
1.  **Slå på enheten:** Slå på din ExpressLRS Receiver (RX) eller Transmitter (TX).
2.  **Vent på Hotspot:** Vent til enheten går inn i Wi-Fi Hotspot Mode (indikert av en raskt blinkende LED).
3.  **Koble til Hotspot:** Koble telefonens Wi-Fi til `ExpressLRS RX`- eller `ExpressLRS TX`-nettverket med passordet `expresslrs`.
    *   **Merk:** ELRS Mobile håndterer tvungen ruting lokalt, noe som sikrer at telefonen din ikke stille bytter tilbake til 5G/LTE.

## Fase 3: Flashing av fastvare
1.  **Naviger til Flash Device:** Fra hoveddashbordet velger du **Flash Device**.
2.  **Målvalg:** Bruk rullegardinmenyene til å velge vendor og spesifikt hardware target.
3.  **Versjonsvalg:** Velg en tilgjengelig firmware version fra ditt offline-arkiv.
4.  **Konfigurasjon og profiler:** Velg eller opprett en **Flashing Profile** (f.eks. "My Quads", "Race Spec") for å laste inn dine custom credentials. Applikasjonen lagrer Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain og Auto-On intervals i disse navngitte profilene, slik at du ikke trenger å angi dem på nytt når du bytter mellom ulike setups.
5.  **Bygg og Flash:** Trykk **FLASH**. Systemet patches the binary med dine local credentials og uploads it.
    *   **Viktig:** Vent alltid på success confirmation og for the device LED to resume blinking før du unplugging!

---

# Ofte stilte spørsmål

## Trenger jeg en internettforbindelse eller mobildekning for å flashe fastvare?
Nei. ELRS Mobile har **100 % Offline Flashing**. Så lenge du tidligere har lastet ned firmware version via Firmware Manager mens du var på hjemme-Wi-Fi, kan appen dynamisk assemble og flashe firmwaren helt offline.

## Hva er Flashing Profiles og hvordan bruker jeg dem?
Flashing Profiles lar deg lagre og bytte mellom flere flashing configurations (f.eks. "My Quads", "Stock / Factory Reset", "Race Spec"). Hver profile lagrer sikkert sin egen binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains og Wi-Fi auto-on interval.

Slik bruker du dem:
1.  Trykk på **+** (Legg til)-ikonet ved siden av "Flashing Profile"-rullegardinmenyen i kortet **Configuration Options**.
2.  Gi den nye profilen din et navn og tilpass innstillingene. Edits er auto-saved instantly.
3.  Velg en hvilken som helst profile fra dropdown for å automatisk swap all parameters.
4.  For å slette en profile, select it og tap the trash/delete icon (must have at least two profiles to delete one).

## Jeg får en "Ikke nok plass"-feil når jeg flasher min ESP8285-mottaker.
ESP8285-chips (som de som finnes på mange AIO boards) har bare 1 MB total physical storage. Updating directly to a major release (like from 3.x to 4.x) over Wi-Fi kan run out of dual-partition space because the incoming file is too large to unpack alongside the currently running firmware.

**Slik løser du det:** Først, flash mottakeren din til en intermediate version (som **3.6.3**). Når den kjører den leaner 3.6.3 firmware, vil du ha enough partition space til å successfully flash til ditt desired 4.0 target. Alternativt kan du enable **Expert Mode** i Settings, save the built binary locally, og flash it manually via a wired Betaflight Passthrough connection.

## Hvor finner jeg ExpressLRS Lua-skriptet til radioen min?
ELRS Mobile kommer med det universal, version-agnostic Lua script built right in! Slik får du det:
1.  Gå til **Settings** og toggle on **Expert Mode**.
2.  Trykk **Export ELRS Lua Script**.
3.  Dette lagrer `elrs.lua` directly til telefonens local storage. Turn on your radio og plug it into your phone via USB, be sure to select "USB Storage" mode on your radio og transfer the file into your `SCRIPTS/TOOLS`-folder using your phone's file manager.

**Merk:** Du need to delete any previous versions of the elrs.lua script (eg. elrs_v2.lua, elrs_v3.lua, etc) from your radio's SD card før du using the new script.

## Hva om en flash mislykkes og enheten min blir uresponsiv?
Hvis enheten din er unresponsive etter en failed flash, kan du easily recover it:
1.  Hold the BOOT button on the device while plugging it in via USB to enter bootloader mode.
2.  Use a computer og the ELRS Web Flasher to re-flash the device over a wired USB/UART connection.
3.  For Wi-Fi-capable devices, you can also hold the BOOT

**Merk:** There is a video link on the Resources Tab som shows how to do this.

## Kan jeg lagre fastvarefilen på telefonen min uten å flashe den?
Ja. Ved å gå inn i **Settings** og enabling **Expert Mode**, låser du opp the ability to save the assembled firmware binary directly til mobilenhetens local storage instead of immediately flashing it Over-The-Air (OTA).

Dette er especially useful hvis du want to flash the device manually using a dedicated hardware programmer (like an STLink or FTDI adapter).

## Jeg får en "Target Mismatch"-feil. Hva skal jeg gjøre?
A target mismatch error occurs when the hardware target du selected in the app does not match the target of the firmware currently running on the device.

To prevent accidental damage, the app will warn you if a mismatch is detected. However, if you are sure that the selected target is correct (for example, if you are converting a device to a different firmware variant or correcting a previous incorrect flash), you can tap **FORCE FLASH** in the mismatch dialog to override the check and proceed with the flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->