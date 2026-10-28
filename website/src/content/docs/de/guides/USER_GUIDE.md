---
title: "Benutzerhandbuch"
slug: de/user_guide
sidebar:
  order: 1
---

ELRS Mobile flasht und konfiguriert ExpressLRS-Empfänger (RX) und -Sender (TX) von Ihrem Telefon aus, über Wi-Fi, ohne Laptop und ohne Internetverbindung im Feld. Es funktioniert mit ESP-basierter Hardware (ESP8285, ESP32, ESP32-C3, ESP32-S3) und ExpressLRS 3.3.x- und 4.x-Firmware. Alle kompatiblen Geräte finden Sie unter [Unterstützte Hardware](/supported_hardware).

Der Arbeitsablauf besteht aus zwei Teilen: Laden Sie die Firmware herunter, solange Sie Internet haben, und flashen Sie sie dann überall.

---

## Installation

| Plattform | Bezugsquelle |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone und iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, ohne Google Play | [Direkter APK-Download](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) oder [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Die Store-Versionen aktualisieren sich über Google Play und den App Store. Die direkt heruntergeladene APK prüft einmal täglich auf eine neue Version und bietet den Download an; Sie können auch jederzeit unter **Einstellungen → Über & Rechtliches → Nach Updates suchen** prüfen, eine Version überspringen oder sich später erinnern lassen. Ihre Einstellungen und Profile bleiben bei der Installation eines Updates erhalten.

Möchten Sie neue Funktionen frühzeitig erhalten? Treten Sie der [Google Play Beta](https://play.google.com/apps/testing/io.datarx.elrsmobile) oder der [TestFlight Beta](https://testflight.apple.com/join/jwU1WrpX) bei.

Beim ersten Start zeigt die App einen kurzen Haftungsausschluss. Das Flashen von Firmware birgt immer ein gewisses Risiko für Ihre Hardware; akzeptieren Sie dies, um fortzufahren.

---

## Schnellstart: Flashen Ihres ersten Geräts

### Schritt 1: Firmware herunterladen (zu Hause)

1. Öffnen Sie im Dashboard den **Firmware Manager**.
2. Tippen Sie auf das Download-Symbol neben der gewünschten ExpressLRS-Version. Nur Versionen 3.3.0 und neuer werden aufgelistet: Dies sind die ersten mit der vereinheitlichten Firmware, auf der ELRS Mobile aufbaut.
3. Wenn der Download abgeschlossen ist, zeigt die Version **Bereit für den Offline-Gebrauch** an. Die Firmware und die benötigten Hardware-Definitionen sind nun auf Ihrem Telefon gespeichert.

Laden Sie die Firmware über Ihr Heim-Wi-Fi oder mobile Daten herunter. Sie können nichts herunterladen, während Ihr Telefon mit dem Wi-Fi-Hotspot eines Empfängers oder Senders verbunden ist, da dieses Netzwerk keine Internetverbindung hat.

Der Header zeigt an, wie viele Versionen Sie im Rahmen Ihres Limits gespeichert haben. Ändern Sie das Limit unter **Einstellungen → App & Speicher → Max. zwischengespeicherte Versionen** und löschen Sie nicht mehr benötigte Versionen.

### Schritt 2: Mit Ihrem Gerät verbinden

1. Schalten Sie Ihren Empfänger oder Sender ein und warten Sie, bis dieser seinen Wi-Fi-Hotspot startet. Standardmäßig geschieht dies 60 Sekunden nach dem Einschalten, wenn er sich nicht mit seinem Partner verbunden hat. Sender können Wi-Fi auch über das ExpressLRS Lua-Skript auf Ihrem Funkgerät starten.
2. Verbinden Sie Ihr Telefon mit dem **ExpressLRS RX**- oder **ExpressLRS TX**-Netzwerk. Das Passwort lautet `expresslrs`.
3. Öffnen Sie ELRS Mobile. Das Dashboard findet das Gerät automatisch und zeigt seinen Produktnamen, die Firmware-Version, das Target und die regulatorische Domäne an.

Wenn das Dashboard **Kein Gerät gefunden** anzeigt, tippen Sie auf **Wiederholen**. Wenn Ihr Gerät in einem anderen Netzwerk ist (z. B. mit Ihrem Heim-Wi-Fi verbunden), tippen Sie auf das Zahnradsymbol auf der Gerätekart und geben Sie dessen IP-Adresse ein.

Geräte, die mit Firmware älter als 3.1 laufen, werden ebenfalls erkannt, so dass Sie diese auf eine aktuelle Version bringen können.

### Schritt 3: Flashen

1. Tippen Sie im Dashboard auf **Gerät flashen**.
2. Überprüfen Sie das Target. Die App wählt, wenn möglich, das zum verbundenen Gerät passende Target vor; andernfalls wählen Sie Gerätetyp, Gerätehersteller, Regulierung & Frequenz und Geräte-Target.
3. Wählen Sie die Firmware-Version. Von Ihnen heruntergeladene Versionen sind mit **(Zwischengespeichert)** markiert. Wenn die Hardware eine neuere Version benötigt, als Sie haben, weist die App darauf hin und bietet an, eine kompatible herunterzuladen.
4. Überprüfen Sie die Firmware-Optionen: Flash-Profil, Binding Phrase, Wi-Fi-Netzwerk und Passwort, regulatorische Domäne und Wi-Fi Auto-On-Intervall.
5. Tippen Sie auf **Flashen**.

Der Fortschrittsbalken zeigt jeden Schritt an: Auffinden und Entpacken Ihrer heruntergeladenen Firmware, Erstellen mit Ihren Einstellungen, Hochladen und **Schreiben auf das Gerät — Bitte warten**, während das Gerät sie installiert und neu startet. Wenn das Gerät bestätigt, sehen Sie **Flashen erfolgreich! Gerät wird neu gestartet**, und das Dashboard verbindet sich wieder, sobald es zurück ist.

---

## Sicherheitsprüfungen

Die App prüft Ihre Auswahl vor dem Flashen und stoppt, wenn etwas falsch aussieht.

:::danger[Inkompatibler Chip]
Firmware für einen Chip kann niemals auf einem anderen laufen (z. B. ESP32-Firmware auf einem ESP8285-Empfänger). Die App blockiert den Flash-Vorgang und zeigt Ihnen an, welcher Chip welcher ist. Wählen Sie ein Target für den Chip Ihres Geräts.
:::

:::caution[Target-Fehlübereinstimmung]
Wenn das ausgewählte Target nicht mit dem vom Gerät gemeldeten Produkt übereinstimmt, sehen Sie **Target-Fehlübereinstimmung**. Überprüfen Sie zuerst Ihre Auswahl. Wenn Sie sicher sind, dass sie korrekt ist (z. B. Wiederherstellung nach einem fehlerhaften Flash oder Wechsel zu einer neueren Target-Definition), tippen Sie auf **Flash erzwingen**.
:::

:::note[Keine Binding Phrase]
Das Flashen ohne Binding Phrase funktioniert, aber das Gerät bindet nur mit der Standard- (leeren) Phrase. Die App fragt, bevor fortgefahren wird.
:::

:::caution[Flash nicht bestätigt]
Wenn das Gerät die Verbindung trennt, bevor der Flash bestätigt wurde (es hat den Strom verloren, neu gestartet oder die Wi-Fi-Verbindung wurde unterbrochen), kann die App nicht feststellen, ob das Update abgeschlossen wurde. Sie zeigt eine orangefarbene Warnung an, anstatt einen Erfolg zu melden. Verbinden Sie sich erneut und überprüfen Sie die Firmware-Version im Dashboard; wenn sie sich nicht geändert hat, flashen Sie erneut.
:::

---

## Flash-Profile

Ein Flash-Profil speichert eine Binding Phrase, das Heim-Wi-Fi-Netzwerk und -Passwort, Standard-Regulierungsdomänen und das Wi-Fi Auto-On-Intervall unter einem Namen. Verwenden Sie eines pro Flotte oder Funkeinstellung und wechseln Sie mit einem Tippen zwischen ihnen.

Verwalten Sie Profile unter **Einstellungen → Profile & Netzwerk**:

- **Hinzufügen:** Tippen Sie auf **+**, geben Sie einen Namen ein und tippen Sie auf **Hinzufügen**.
- **Wechseln:** Wählen Sie ein Profil aus der Liste **Flash-Profil**. Es ist auch auf dem Flash-Bildschirm verfügbar.
- **Bearbeiten:** Ändern Sie ein beliebiges Feld; das aktive Profil wird automatisch gespeichert.
- **Löschen:** Wählen Sie das Profil aus und tippen Sie auf das Löschen-Symbol. Sie behalten immer mindestens ein Profil.

Binding Phrasen und Wi-Fi-Passwörter werden im verschlüsselten sicheren Speicher Ihres Telefons abgelegt.

---

## Gerätekonfiguration

Tippen Sie im Dashboard auf **Gerätekonfiguration**, um die ExpressLRS-Einstellungsseite des verbundenen Geräts innerhalb der App zu öffnen. Verwenden Sie diese, um Wi-Fi- und Binding-Einstellungen, Model Match, serielles Protokoll, PWM-Ausgangszuordnung und andere Geräteoptionen zu ändern. Die App hält die Seite an Ihr Gerät gebunden.

---

## Einstellungen

| Abschnitt | Inhalt |
| :--- | :--- |
| Profile & Netzwerk | Flash-Profile, Binding Phrase, Heim-Wi-Fi-Netzwerk und Passwort, Standard-2,4-GHz- und Sub-GHz-Regulierungsdomänen |
| App & Speicher | Max. zwischengespeicherte Versionen, Firmware Manager, Firmware-Cache leeren, App-Sprache, anonyme Nutzungsanalysen (standardmäßig aktiviert; mit **Analysedaten teilen** deaktivieren) |
| Erweitert & Debug | Expertenmodus und seine Tools (siehe unten) |
| Über & Rechtliches | App-Version, rechtliche Hinweise und Lizenz, Entwicklung unterstützen und **Nach Updates suchen** in der direkt heruntergeladenen APK |

Ändern Sie die App-Sprache in den Einstellungen oder über die Sprachschaltfläche in der oberen Leiste. ELRS Mobile ist in 18 Sprachen verfügbar.

---

## Expertenmodus

Aktivieren Sie **Einstellungen → Erweitert & Debug → Expertenmodus**, um Folgendes freizuschalten:

- **STM32-Targets.** Ältere STM32-basierte Hardware kann nicht über Wi-Fi geflasht werden, und nur ExpressLRS 3.3.x unterstützt dies. Die App erstellt die Firmware mit Ihren Einstellungen, sodass Sie sie von einem PC mit einem STLink oder Betaflight Passthrough flashen können.
- **Binärdatei herunterladen.** Speichern Sie die erstellte Firmware-Datei anstatt sie zu flashen, für manuelles Flashen oder zur Überprüfung.
- **ELRS Lua-Skript exportieren.** Speichern Sie `elrs.lua` für EdgeTX- und OpenTX-Funkgeräte.
- **Debug-Bericht senden.** Senden Sie Geräteinformationen und App-Protokolle, um bei der Fehlerbehebung zu helfen. Binding Phrasen und Wi-Fi-Passwörter sind niemals enthalten.

---

## Fehlerbehebung

**Das Dashboard findet mein Gerät nicht.** Stellen Sie sicher, dass Ihr Telefon weiterhin mit dem Wi-Fi-Netzwerk des Geräts verbunden ist; einige Telefone verlassen Netzwerke, die kein Internet haben. Auf Android behält ELRS Mobile seinen Datenverkehr in diesem Wi-Fi-Netzwerk, auch ohne Internet. Tippen Sie auf **Wiederholen**, oder geben Sie die IP-Adresse über das Zahnradsymbol ein (`10.0.0.1` im eigenen Hotspot des Geräts).

**Ich kann keine Firmware herunterladen.** Trennen Sie die Verbindung vom Hotspot des Geräts und nutzen Sie ein Netzwerk mit Internetzugang.

**Mein Gerät reagiert nach einem fehlgeschlagenen Flash-Vorgang nicht mehr.** Halten Sie die BOOT-Taste gedrückt, während Sie es über USB anschließen, um in den Bootloader-Modus zu gelangen, und flashen Sie dann erneut mit dem [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Wi-Fi-fähige Geräte können auch wiederhergestellt werden, indem Sie die BOOT-Taste 60 Sekunden lang gedrückt halten, um den Wi-Fi-Hotspot zu starten. Der In-App-Bildschirm **Hilfe & Support** enthält diese Schritte, eine FAQ und Links zum ExpressLRS Discord.

**Meine Profile sind nach dem Update verschwunden.** Ein direktes Update von v1.0.43 oder älter auf v1.0.45 oder neuer kann gespeicherte Profile, Binding Phrasen und Wi-Fi-Einstellungen nicht über ein Speicher-Upgrade hinweg übernehmen. Die App weist Sie einmal darauf hin; geben Sie diese in den Einstellungen erneut ein.

---

Entwickler können die von ELRS Mobile erstellte Firmware mit den [Firmware Validation Tools](/firmware-validation) überprüfen.

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->