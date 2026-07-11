---
title: "Guida per l'utente"
slug: user_guide
sidebar:
  order: 1
---

## Panoramica
Questa applicazione fornisce un'interfaccia mobile completa per la gestione dell'hardware ExpressLRS. Consente agli utenti di configurare i parametri del ricevitore (RX) e del trasmettitore (TX), mappare le uscite PWM e aggiornare il firmware direttamente da un dispositivo mobile.

---

## Installazione

### Store di App Ufficiali

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Installa da Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Ottienilo su Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Installa dall'App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Scarica dall'App Store</a>

### Installazione Alternativa

#### GitHub Store
Ideale per gli utenti che preferiscono un'esperienza di app store alternativa.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Scarica su GitHub Store</a>

### Installazione Manuale
Per gli utenti esperti o coloro che preferiscono la gestione manuale, visita la nostra pagina [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) per gli ultimi file `.apk`.

---

## 🚀 Avvio Rapido: Aggiornare il Tuo Primo Dispositivo

### Fase 1: Cache del Firmware (Fallo a casa)
1. Apri l'app e vai al **Firmware Manager**.
2. Tocca l'icona di download accanto all'ultima versione stabile.
3. L'app scaricherà e salverà in modo sicuro nella cache le definizioni del target e dell'hardware richieste per l'uso offline.

### Fase 2: Connettersi al Tuo Dispositivo
1. Accendi il tuo ricevitore ExpressLRS (RX) o trasmettitore (TX).
2. Attendi 60 secondi (o il tuo intervallo configurato) affinché il dispositivo entri in Wi-Fi Hotspot Mode (LED lampeggiante rapidamente).
3. Collega il Wi-Fi del tuo telefono alla rete **ExpressLRS RX** o **ExpressLRS TX** (Password: `expresslrs`).
4. Apri l'app. La Dashboard scannerizzerà automaticamente la rete usando mDNS e si connetterà al dispositivo.

### Fase 3: Aggiornamento del Firmware
1. Dalla Dashboard, seleziona **Flash Device**.
2. **Seleziona il tuo Hardware:** Usa i menu a cascata per selezionare il tuo Tipo di Dispositivo, Fornitore, Frequenza e Target.
3. **Configura Opzioni e Profili:** Seleziona un **Flashing Profile** (o tocca il pulsante **+** per aggiungere un nuovo profilo nominativo) per caricare le tue credenziali. Personalizza la Binding Phrase, Wi-Fi SSID, Wi-Fi password, i domini normativi e l'intervallo di accensione automatica del Wi-Fi.
4. Tocca **FLASH**. L'app assemblerá il binario localmente e lo invierà al dispositivo.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Avviso di Discrepanza Target</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Se l'app rileva una discrepanza tra il target hardware selezionato e il dispositivo connesso, ti avviserà per prevenire danni accidentali. Se sei certo di avere il target corretto (ad esempio, stai recuperando da un flash errato o migrando tra definizioni di target), clicca <strong>FORCE FLASH</strong> nella finestra di avviso per ignorare il controllo.
  </p>
</div>

### 📋 Gestione dei Profili di Flashing
Se hai più droni o configurazioni radio con requisiti diversi (ad esempio, diverse binding phrase o domini normativi), puoi usare i **Flashing Profiles** nominativi per salvare e cambiare le configurazioni:
*   **Aggiungi un Profilo**: Tocca l'icona **+** accanto al menu a discesa "Flashing Profile", digita un nome e premi Aggiungi.
*   **Salvataggio Automatico**: Qualsiasi modifica alle credenziali del profilo attivo (binding phrase, SSID, password, domain o interval) viene salvata automaticamente in tempo reale.
*   **Cambia Profili**: Seleziona semplicemente un profilo dal menu a discesa per caricare istantaneamente le sue impostazioni salvate.
*   **Elimina un Profilo**: Per fare pulizia, seleziona il profilo dal menu a discesa e tocca l'icona del cestino/elimina (devi avere almeno due profili per poterne eliminare uno).

---

## Dettagli Tecnici

### Connettività e Rilevamento
L'app utilizza una robusta sequenza di rilevamento multi-fase per trovare il tuo hardware:
1. **Risoluzione mDNS**: Il metodo principale. L'app cerca `elrs_rx.local` o `elrs_tx.local`.
2. **Fallback AP Statico**: Se mDNS è bloccato, l'app controlla l'IP ufficiale del punto di accesso ELRS (`10.0.0.1`).
3. **Override IP Manuale**: Per reti complesse, puoi inserire manualmente un indirizzo IP nelle Impostazioni.

**Associazione Forzata alla Rete**: Gli smartphone moderni spesso scartano le connessioni Wi-Fi senza accesso a internet. ELRS Mobile include un livello nativo di "Routing Forzato" che costringe il sistema operativo a mantenere la connessione hardware, garantendo un rilevamento affidabile al 100% sul campo.

---

## Modalità Esperto e Verifica
All'interno del menu Impostazioni, gli utenti possono abilitare la **Modalità Esperto**. Questo ti consente di salvare il binario del firmware assemblato direttamente sul tuo dispositivo per la verifica o il flashing manuale tramite FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Gestione Hardware STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Sebbene ELRS Mobile possa assemblare e patchare il firmware per i target STM32 (fino a ELRS v3.x), questi dispositivi non supportano il flashing Over-The-Air (OTA) tramite Wi-Fi. Se selezioni un target STM32, l'app ti permetterà di costruire e salvare il binario localmente in modo da poterlo flashare manualmente utilizzando un PC tramite STLink o Betaflight Passthrough.
  </p>
</div>

Per gli sviluppatori che desiderano verificare l'integrità di questi binari, consulta la nostra [**Guida alla Validazione del Firmware**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->