---
title: "Benutzerhandbuch"
slug: user_guide
sidebar:
  order: 1
---

## Übersicht
Diese Anwendung bietet eine umfassende mobile Schnittstelle zur Verwaltung von ExpressLRS-Hardware. Sie ermöglicht es Benutzern, Empfänger (RX)- und Sender (TX)-Parameter zu konfigurieren, PWM-Ausgänge zuzuordnen und Firmware-Updates direkt von einem mobilen Gerät aus zu flashen.

---

## Installation

### Offizielle App Stores

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Im Google Play Store installieren

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Im Google Play Store herunterladen</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Im App Store installieren

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Im App Store herunterladen</a>

### Alternative Installation

#### GitHub Store
Ideal für Benutzer, die ein alternatives App-Store-Erlebnis bevorzugen.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Im GitHub Store herunterladen</a>

### Manuelle Installation
Für Power-User oder diejenigen, die eine manuelle Verwaltung bevorzugen, besuchen Sie unsere [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases)-Seite für die neuesten `.apk`-Dateien.

---

## 🚀 Schnellstart: Ihr erstes Gerät flashen

### Phase 1: Firmware-Caching (Zuhause erledigen)
1.  Öffnen Sie die App und navigieren Sie zum **Firmware-Manager**.
2.  Tippen Sie auf das Download-Symbol neben der neuesten stabilen Version.
3.  Die App lädt die erforderlichen Ziel- und Hardware-Definitionen herunter und speichert sie sicher für die Offline-Nutzung im Cache.

### Phase 2: Verbindung mit Ihrem Gerät herstellen
1.  Schalten Sie Ihren ExpressLRS-Empfänger (RX) oder Sender (TX) ein.
2.  Warten Sie 60 Sekunden (oder Ihr konfiguriertes Intervall), bis das Gerät in den Wi-Fi Hotspot-Modus wechselt (schnell blinkende LED).
3.  Verbinden Sie das WLAN Ihres Telefons mit dem **ExpressLRS RX**- oder **ExpressLRS TX**-Netzwerk (Passwort: `expresslrs`).
4.  Öffnen Sie die App. Das Dashboard scannt das Netzwerk automatisch über mDNS und verbindet sich mit dem Gerät.

### Phase 3: Firmware flashen
1.  Wählen Sie im Dashboard **Gerät flashen**.
2.  **Wählen Sie Ihre Hardware:** Verwenden Sie die kaskadierenden Dropdowns, um Ihren Gerätetyp, Hersteller, Frequenz und Target auszuwählen.
3.  **Optionen & Profile konfigurieren:** Wählen Sie ein **Flashing-Profil** (oder tippen Sie auf die Schaltfläche **+**, um ein neues benanntes Profil hinzuzufügen), um Ihre Anmeldeinformationen zu laden. Passen Sie die Binding Phrase, Wi-Fi SSID, Wi-Fi-Passwort, regulatorische Domänen und das Wi-Fi-Auto-On-Intervall an.
4.  Tippen Sie auf **FLASHEN**. Die App wird die Binärdatei lokal zusammenstellen und auf das Gerät übertragen.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Warnung: Target-Fehlanpassung</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Wenn die App eine Hardware-Ziel-Fehlanpassung zwischen Ihrer Auswahl und dem verbundenen Gerät erkennt, warnt sie Sie, um versehentliche Schäden zu vermeiden. Wenn Sie sicher sind, dass Sie das richtige Ziel haben (z.B. nach einem fehlerhaften Flash oder bei der Migration zwischen Ziel-Definitionen), klicken Sie auf **FLASH ERZWINGEN** im Warndialog, um die Überprüfung zu umgehen.
  </p>
</div>

### 📋 Flashing-Profile verwalten
Wenn Sie mehrere Drohnen oder Funk-Setups mit unterschiedlichen Konfigurationsanforderungen haben (z.B. verschiedene Binding Phrases oder regulatorische Domänen), können Sie benannte **Flashing-Profile** verwenden, um Konfigurationen zu speichern und zu wechseln:
*   **Profil hinzufügen**: Tippen Sie auf das **+**-Symbol neben dem Dropdown-Menü „Flashing-Profil“, geben Sie einen Namen ein und tippen Sie auf Hinzufügen.
*   **Automatisches Speichern**: Alle Änderungen an den Anmeldeinformationen des aktiven Profils (Binding Phrase, SSID, Passwort, Domäne oder Intervall) werden automatisch und in Echtzeit gespeichert.
*   **Profile wechseln**: Wählen Sie einfach ein Profil aus dem Dropdown-Menü, um dessen gespeicherte Einstellungen sofort zu laden.
*   **Profil löschen**: Zum Aufräumen wählen Sie das Profil aus dem Dropdown-Menü und tippen auf das Mülleimer-/Löschen-Symbol (Sie müssen mindestens zwei Profile haben, um eines zu löschen).

---

## Technische Details

### Konnektivität & Erkennung
Die App verwendet eine robuste mehrstufige Erkennungssequenz, um Ihre Hardware zu finden:
1.  **mDNS-Auflösung**: Die primäre Methode. Die App sucht nach `elrs_rx.local` oder `elrs_tx.local`.
2.  **Statischer AP-Fallback**: Wenn mDNS blockiert ist, prüft die App die offizielle ELRS-Zugangspunkt-IP (`10.0.0.1`).
3.  **Manuelle IP-Überschreibung**: Für komplexe Netzwerke können Sie eine IP-Adresse manuell in den Einstellungen eingeben.

**Erzwungene Netzwerkbindung**: Moderne Smartphones trennen oft Wi-Fi-Verbindungen ohne Internetzugang. ELRS Mobile enthält eine native „Forced Routing“-Schicht, die das Betriebssystem dazu zwingt, an der Hardware-Verbindung festzuhalten, wodurch eine 100% zuverlässige Erkennung im Feld gewährleistet ist.

---

## Expertenmodus & Überprüfung
Im Einstellungsmenü können Benutzer den **Expertenmodus** aktivieren. Dies ermöglicht es Ihnen, die zusammengestellte Firmware-Binärdatei direkt auf Ihrem Gerät zu speichern, zur Überprüfung oder zum manuellen Flashen via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Umgang mit STM32-Hardware</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Obwohl ELRS Mobile Firmware für STM32-Targets (bis ELRS v3.x) zusammenstellen und patchen kann, unterstützen diese Geräte kein Over-The-Air (OTA) Flashen über Wi-Fi. Wenn Sie ein STM32-Target auswählen, ermöglicht Ihnen die App, die Binärdatei lokal zu erstellen und zu speichern, damit Sie sie manuell über einen PC via STLink oder Betaflight Passthrough flashen können.
  </p>
</div>

Für Entwickler, die die Integrität dieser Binärdateien überprüfen möchten, konsultieren Sie unseren [**Firmware-Validierungsleitfaden**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->