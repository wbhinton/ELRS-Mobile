---
title: "Benutzerhandbuch"
slug: user_guide
sidebar:
  order: 1
---

## Überblick
Diese Anwendung bietet eine umfassende mobile Benutzeroberfläche zur Verwaltung von ExpressLRS-Hardware. Sie ermöglicht es Benutzern, Receiver (RX)- und Transmitter (TX)-Parameter zu konfigurieren, PWM-Ausgänge zuzuordnen und Firmware-Updates direkt von einem mobilen Gerät aus zu flashen.

---

## Installation

### Offizielle App Stores

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Installieren aus Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Jetzt bei Google Play herunterladen</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Installieren aus dem App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Jetzt im App Store laden</a>

### Alternative Installation

#### GitHub Store
Ideal für Benutzer, die ein alternatives App-Store-Erlebnis bevorzugen.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Jetzt im GitHub Store herunterladen</a>

### Manuelle Installation
Für Power-User oder diejenigen, die eine manuelle Verwaltung bevorzugen, besuchen Sie unsere [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases)-Seite für die neuesten `.apk`-Dateien.

---

## 🚀 Schnellstart: Ihr erstes Gerät flashen

### Phase 1: Firmware-Caching (Machen Sie dies zu Hause)
1. Öffnen Sie die App und navigieren Sie zum **Firmware Manager**.
2. Tippen Sie auf das Download-Symbol neben der neuesten stabilen Version.
3. Die App lädt die erforderlichen Target- und Hardware-Definitionen herunter und speichert sie sicher für die Offline-Nutzung im Cache.

### Phase 2: Verbindung zu Ihrem Gerät herstellen
1. Schalten Sie Ihren ExpressLRS Receiver (RX) oder Transmitter (TX) ein.
2. Warten Sie 60 Sekunden (oder Ihr konfiguriertes Intervall), bis das Gerät in den Wi-Fi Hotspot Mode wechselt (schnell blinkende LED).
3. Verbinden Sie das WLAN Ihres Telefons mit dem Netzwerk **ExpressLRS RX** oder **ExpressLRS TX** (Passwort: `expresslrs`).
4. Öffnen Sie die App. Das Dashboard scannt das Netzwerk automatisch mittels mDNS und stellt eine Verbindung zum Gerät her.

### Phase 3: Firmware flashen
1. Wählen Sie im Dashboard **Gerät flashen**.
2. **Wählen Sie Ihre Hardware aus:** Verwenden Sie die Dropdown-Menüs, um Ihren Gerätetyp, Hersteller, Frequenz und Target auszuwählen.
3. **Optionen konfigurieren:** Legen Sie Ihre benutzerdefinierte Binding Phrase, Wi-Fi-Anmeldeinformationen und Regulatory Domain fest.
4. Tippen Sie auf **FLASHEN**. Die App wird das Binary lokal erstellen und auf das Gerät übertragen.

---

## Technische Details

### Konnektivität & Erkennung
Die App verwendet eine robuste, mehrstufige Erkennungssequenz, um Ihre Hardware zu finden:
1. **mDNS-Auflösung**: Die primäre Methode. Die App scannt nach `elrs_rx.local` oder `elrs_tx.local`.
2. **Statischer AP-Fallback**: Wenn mDNS blockiert ist, überprüft die App die offizielle ELRS-Zugangspunkt-IP (`10.0.0.1`).
3. **Manuelle IP-Überschreibung**: Für komplexe Netzwerke können Sie in den Einstellungen manuell eine IP-Adresse eingeben.

**Erzwungene Netzwerkbindung**: Moderne Smartphones trennen oft Wi-Fi-Verbindungen ohne Internetzugang. ELRS Mobile enthält eine native "Forced Routing"-Schicht, die das Betriebssystem zwingt, an der Hardware-Verbindung festzuhalten, um eine 100% zuverlässige Erkennung im Feld zu gewährleisten.

---

## Expertenmodus & Auditierung
Im Einstellungsmenü können Benutzer den **Expertenmodus** aktivieren. Dies ermöglicht es Ihnen, das zusammengestellte Firmware-Binary direkt auf Ihrem Gerät zur Überprüfung oder zum manuellen Flashen via FTDI zu speichern.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 Hardware-Handhabung</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Obwohl ELRS Mobile Firmware für STM32 Targets (bis ELRS v3.x) zusammenstellen und patchen kann, unterstützen diese Geräte kein Over-The-Air (OTA) Flashing via Wi-Fi. Wenn Sie ein STM32 Target auswählen, ermöglicht Ihnen die App, das Binary lokal zu erstellen und zu speichern, sodass Sie es manuell mit einem PC via STLink oder Betaflight Passthrough flashen können.
  </p>
</div>

Für Entwickler, die die Integrität dieser Binaries überprüfen möchten, siehe unseren [**Leitfaden zur Firmware-Validierung**](/guides/firmware-validation).

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->