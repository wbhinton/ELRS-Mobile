# Anleitung

## Phase 1: Firmware-Caching
1.  **Mit dem Internet verbinden:** Stellen Sie sicher, dass Ihr Telefon mit dem Internet verbunden ist (z. B. Heim-WLAN oder Mobilfunknetz).
2.  **Firmware Manager öffnen:** Navigieren Sie in der App zum Firmware Manager.
3.  **Release herunterladen:** Tippen Sie auf das Download-Symbol neben Ihrem gewünschten ExpressLRS Release. Dies speichert die erforderlichen Firmware-Ziele und Hardware-Definitionen sicher auf Ihrem Telefon für 100%ige Offline-Nutzung.

## Phase 2: Mit Ihrem Gerät verbinden
1.  **Gerät einschalten:** Schalten Sie Ihren ExpressLRS Receiver (RX) oder Transmitter (TX) ein.
2.  **Auf Hotspot warten:** Warten Sie, bis das Gerät in den Wi-Fi Hotspot Mode wechselt (angezeigt durch eine schnell blinkende LED).
3.  **Mit Hotspot verbinden:** Verbinden Sie das Wi-Fi Ihres Telefons mit dem `ExpressLRS RX` oder `ExpressLRS TX` Netzwerk unter Verwendung des Passworts `expresslrs`.
*   **Hinweis:** ELRS Mobile handhabt nativ erzwungenes Routing und stellt sicher, dass Ihr Telefon nicht stillschweigend zu 5G/LTE zurückwechselt.

## Phase 3: Firmware flashen
1.  **Zu Flash Device navigieren:** Wählen Sie im Haupt-Dashboard **Flash Device**.
2.  **Zielauswahl:** Verwenden Sie die kaskadierenden Dropdowns, um den Hersteller und das spezifische Hardware-Ziel auszuwählen.
3.  **Versionsauswahl:** Wählen Sie eine verfügbare Firmware-Version aus Ihrem Offline-Repository.
4.  **Konfiguration & Profile:** Wählen oder erstellen Sie ein **Flashing Profile** (z.B. "My Quads", "Race Spec"), um Ihre benutzerdefinierten Anmeldeinformationen zu laden. Die Anwendung speichert die Wi-Fi SSID, das Wi-Fi Password, die Binding Phrase, die Regulatory Domain und die Auto-On-Intervalle in diesen benannten Profilen, sodass Sie diese nicht erneut eingeben müssen, wenn Sie zwischen verschiedenen Setups wechseln.
5.  **Build & Flash:** Tippen Sie auf **FLASH**. Das System patcht die Binärdatei mit Ihren lokalen Anmeldeinformationen und lädt sie hoch.
*   **Wichtig:** Warten Sie immer auf die Erfolgsbestätigung und bis die Geräte-LED wieder blinkt, bevor Sie das Gerät trennen!

---

# Häufig gestellte Fragen

## Benötige ich eine Internetverbindung oder Mobilfunkdienst, um Firmware zu flashen?
Nein. ELRS Mobile bietet **100% Offline Flashing**. Solange Sie die Firmware-Version zuvor über den Firmware Manager im Heim-Wi-Fi heruntergeladen haben, kann die App die Firmware dynamisch zusammenstellen und vollständig offline flashen.

## Was sind Flashing Profiles und wie verwende ich sie?
Flashing Profiles ermöglichen es Ihnen, mehrere Flash-Konfigurationen (z.B. "My Quads", "Stock / Factory Reset", "Race Spec") zu speichern und zwischen ihnen zu wechseln. Jedes Profil speichert sicher seine eigene Binding Phrase, Wi-Fi SSID, Wi-Fi password, Regulatory Domains und Wi-Fi Auto-On-Intervalle.

So verwenden Sie sie:
1.  Tippen Sie auf das **+** (Hinzufügen) Symbol neben dem Dropdown-Menü "Flashing Profile" in der Karte **Configuration Options**.
2.  Benennen Sie Ihr neues Profil und passen Sie die Einstellungen an. Änderungen werden sofort automatisch gespeichert.
3.  Wählen Sie ein beliebiges Profil aus dem Dropdown-Menü, um alle Parameter automatisch zu tauschen.
4.  Um ein Profil zu löschen, wählen Sie es aus und tippen Sie auf das Papierkorb-/Löschen-Symbol (es müssen mindestens zwei Profile vorhanden sein, um eines zu löschen).

## Ich erhalte eine "Nicht genügend Speicherplatz"-Fehlermeldung beim Flashen meines ESP8285 Receivers.
ESP8285 Chips (wie sie auf vielen AIO-Boards zu finden sind) verfügen nur über 1 MB Gesamtspeicherplatz. Das direkte Aktualisieren auf ein Major Release (wie von 3.x auf 4.x) über Wi-Fi kann zu einem Mangel an Dual-Partition-Speicherplatz führen, da die eingehende Datei zu groß ist, um neben der aktuell laufenden Firmware entpackt zu werden.

**So beheben Sie das Problem:** Flashen Sie Ihren Receiver zunächst auf eine Zwischenversion (z.B. **3.6.3**). Sobald die schlankere 3.6.3 Firmware läuft, haben Sie genügend Partitionsplatz, um erfolgreich auf Ihr gewünschtes 4.0 Ziel zu flashen. Alternativ aktivieren Sie den **Expert Mode** in den Settings, speichern die erstellte Binärdatei lokal und flashen sie manuell über eine kabelgebundene Betaflight Passthrough Verbindung.

## Wo finde ich das ExpressLRS Lua script für mein Radio?
ELRS Mobile enthält das universelle, versionsunabhängige Lua script direkt integriert! So erhalten Sie es:
1.  Gehen Sie zu **Settings** und aktivieren Sie den **Expert Mode**.
2.  Tippen Sie auf **Export ELRS Lua Script**.
3.  Dies speichert `elrs.lua` direkt im lokalen Speicher Ihres Telefons. Schalten Sie Ihr Radio ein und verbinden Sie es über USB mit Ihrem Telefon. Stellen Sie sicher, dass Sie den "USB Storage" Mode auf Ihrem Radio auswählen, und übertragen Sie die Datei mit dem Dateimanager Ihres Telefons in Ihren `SCRIPTS/TOOLS` Ordner.

**Hinweis:** Sie müssen alle früheren Versionen des elrs.lua script (z.B. elrs_v2.lua, elrs_v3.lua, etc.) von der SD-Karte Ihres Radios löschen, bevor Sie das neue script verwenden.

## Was passiert, wenn ein Flash fehlschlägt und mein Gerät nicht mehr reagiert?
Wenn Ihr Gerät nach einem fehlgeschlagenen Flash nicht mehr reagiert, können Sie es einfach wiederherstellen:
1.  Halten Sie den BOOT button auf dem Gerät gedrückt, während Sie es über USB anschließen, um in den Bootloader-Modus zu gelangen.
2.  Verwenden Sie einen Computer und den ELRS Web Flasher, um das Gerät über eine kabelgebundene USB/UART Verbindung neu zu flashen.
3.  Bei Wi-Fi-fähigen Geräten können Sie auch den BOOT gedrückt halten

**Hinweis:** Auf dem Tab "Ressourcen" gibt es einen Videolink, der zeigt, wie das geht.

## Kann ich die Firmware-Datei auf meinem Telefon speichern, ohne sie zu flashen?
Ja. Indem Sie in die **Settings** gehen und den **Expert Mode** aktivieren, schalten Sie die Möglichkeit frei, die zusammengefügte Firmware-Binärdatei direkt im lokalen Speicher Ihres Mobilgeräts zu speichern, anstatt sie sofort Over-The-Air (OTA) zu flashen.

Dies ist besonders nützlich, wenn Sie das Gerät manuell mit einem dedizierten Hardware-Programmer (wie einem STLink oder FTDI adapter) flashen möchten.

## Ich erhalte eine "Target Mismatch" Fehlermeldung. Was soll ich tun?
Ein Target Mismatch Fehler tritt auf, wenn das in der App ausgewählte Hardware-Ziel nicht mit dem Ziel der aktuell auf dem Gerät laufenden Firmware übereinstimmt.

Um versehentliche Schäden zu vermeiden, warnt Sie die App, wenn eine Abweichung erkannt wird. Wenn Sie jedoch sicher sind, dass das ausgewählte Ziel korrekt ist (zum Beispiel, wenn Sie ein Gerät in eine andere Firmware-Variante umwandeln oder einen früheren fehlerhaften Flash korrigieren), können Sie im Mismatch-Dialog auf **FORCE FLASH** tippen, um die Prüfung zu überschreiben und mit dem Flash fortzufahren.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->