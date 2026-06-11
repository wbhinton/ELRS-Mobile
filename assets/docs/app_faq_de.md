# Anleitung

## Phase 1: Firmware-Caching
1.  **Mit dem Internet verbinden:** Stellen Sie sicher, dass Ihr Telefon mit dem Internet verbunden ist (z.B. Heim-WLAN oder mobiles Netzwerk).
2.  **Firmware Manager öffnen:** Navigieren Sie in der App zum Firmware Manager.
3.  **Release herunterladen:** Tippen Sie auf das Download-Symbol neben dem gewünschten ExpressLRS Release. Dies speichert die erforderlichen Firmware-Targets und Hardware-Definitionen sicher auf Ihrem Telefon für eine 100%ige Offline-Nutzung.

## Phase 2: Verbindung zu Ihrem Gerät herstellen
1.  **Gerät einschalten:** Schalten Sie Ihren ExpressLRS Receiver (RX) oder Transmitter (TX) ein.
2.  **Auf Hotspot warten:** Warten Sie, bis das Gerät in den Wi-Fi Hotspot-Modus wechselt (angezeigt durch eine schnell blinkende LED).
3.  **Mit Hotspot verbinden:** Verbinden Sie das WLAN Ihres Telefons mit dem Netzwerk `ExpressLRS RX` oder `ExpressLRS TX` unter Verwendung des Passworts `expresslrs`.
*   **Hinweis:** ELRS Mobile handhabt die erzwungene Weiterleitung nativ, um sicherzustellen, dass Ihr Telefon nicht stillschweigend auf 5G/LTE zurückwechselt.

## Phase 3: Firmware flashen
1.  **Zu "Gerät flashen" navigieren:** Wählen Sie vom Haupt-Dashboard aus **Gerät flashen**.
2.  **Target-Auswahl:** Verwenden Sie die kaskadierenden Dropdowns, um den Hersteller und das spezifische Hardware-Target auszuwählen.
3.  **Versionsauswahl:** Wählen Sie eine verfügbare Firmware-Version aus Ihrem Offline-Repository.
4.  **Konfiguration:** Geben Sie Ihre benutzerdefinierten Anmeldeinformationen ein. Die Anwendung speichert die WiFi SSID, das WiFi Password und die Binding Phrase im lokalen Speicher, sodass Sie diese nicht erneut eingeben müssen.
5.  **Build & Flash:** Tippen Sie auf **FLASH**. Das System patcht die Binärdatei mit Ihren lokalen Anmeldeinformationen und lädt sie hoch.
*   **Wichtig:** Warten Sie immer auf die Erfolgsbestätigung und bis die Geräte-LED wieder blinkt, bevor Sie das Gerät trennen!

---

# Häufig gestellte Fragen

## Benötige ich eine Internetverbindung oder einen Mobilfunkdienst, um Firmware zu flashen?
Nein. ELRS Mobile bietet **100% Offline-Flashing**. Solange Sie die Firmware-Version zuvor über den Firmware Manager im Heim-WLAN heruntergeladen haben, kann die App die Firmware vollständig offline dynamisch zusammenstellen und flashen.

## Ich erhalte einen "Nicht genug Speicherplatz"-Fehler beim Flashen meines ESP8285 Receivers.
ESP8285 Chips (wie sie auf vielen AIO-Boards zu finden sind) haben nur 1 MB physikalischen Gesamtspeicher. Ein direktes Update auf ein großes Release (z.B. von 3.x auf 4.x) über Wi-Fi kann dazu führen, dass der Dual-Partitions-Speicherplatz nicht ausreicht, da die eingehende Datei zu groß ist, um sie neben der aktuell laufenden Firmware zu entpacken.

**So beheben Sie das Problem:** Flashen Sie Ihren Receiver zunächst auf eine Zwischenversion (z.B. **3.6.3**). Sobald die schlankere 3.6.3 Firmware läuft, haben Sie genügend Partitions-Speicherplatz, um erfolgreich auf Ihr gewünschtes 4.0 Target zu flashen. Alternativ aktivieren Sie den **Expert Mode** in den Einstellungen, speichern die erstellte Binärdatei lokal und flashen sie manuell über eine kabelgebundene Betaflight Passthrough-Verbindung.

## Wo finde ich das ExpressLRS Lua-Skript für mein Radio?
ELRS Mobile wird mit dem universellen, versionsunabhängigen Lua-Skript geliefert, das direkt integriert ist! So erhalten Sie es:
1.  Gehen Sie zu **Einstellungen** und aktivieren Sie den **Expert Mode**.
2.  Tippen Sie auf **ELRS Lua-Skript exportieren**.
3.  Dies speichert `elrs.lua` direkt im lokalen Speicher Ihres Telefons. Schalten Sie Ihr Radio ein und verbinden Sie es über USB mit Ihrem Telefon. Stellen Sie sicher, dass Sie am Radio den Modus "USB Storage" auswählen und übertragen Sie die Datei mit dem Dateimanager Ihres Telefons in Ihren Ordner `SCRIPTS/TOOLS`.

**Hinweis:** Sie müssen alle vorherigen Versionen des elrs.lua-Skripts (z.B. elrs_v2.lua, elrs_v3.lua usw.) von der SD-Karte Ihres Radios löschen, bevor Sie das neue Skript verwenden.

## Was, wenn ein Flash fehlschlägt und mein Gerät nicht mehr reagiert?
Wenn Ihr Gerät nach einem fehlgeschlagenen Flash nicht mehr reagiert, können Sie es leicht wiederherstellen:
1.  Halten Sie die BOOT-Taste am Gerät gedrückt, während Sie es über USB anschließen, um in den Bootloader-Modus zu gelangen.
2.  Verwenden Sie einen Computer und den ELRS Web Flasher, um das Gerät über eine kabelgebundene USB/UART-Verbindung neu zu flashen.
3.  Bei Wi-Fi-fähigen Geräten können Sie auch die BOOT-Taste gedrückt halten

**Hinweis:** Auf der Registerkarte "Ressourcen" befindet sich ein Videolink, der zeigt, wie das geht.

## Kann ich die Firmware-Datei auf meinem Telefon speichern, ohne sie zu flashen?
Ja. Indem Sie in die **Einstellungen** gehen und den **Expert Mode** aktivieren, schalten Sie die Möglichkeit frei, die zusammengestellte Firmware-Binärdatei direkt im lokalen Speicher Ihres Mobilgeräts zu speichern, anstatt sie sofort Over-The-Air (OTA) zu flashen.

Dies ist besonders nützlich, wenn Sie das Gerät manuell mit einem dedizierten Hardware-Programmierer (wie einem STLink- oder FTDI-Adapter) flashen möchten.

## Ich erhalte einen "Target Mismatch"-Fehler. Was soll ich tun?
Ein Target Mismatch-Fehler tritt auf, wenn das in der App ausgewählte Hardware-Target nicht mit dem Target der Firmware übereinstimmt, die derzeit auf dem Gerät läuft.

Derzeit unterstützt die App das Flashen eines anderen Targets als das aktuell auf dem Gerät laufende nicht.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->