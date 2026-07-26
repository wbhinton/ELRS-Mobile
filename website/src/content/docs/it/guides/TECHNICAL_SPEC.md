---
title: "Specifiche Tecniche"
slug: it/technical_spec
sidebar:
  order: 5
---

## Panoramica dell'Architettura

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Principio di Progettazione</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    L'applicazione è sviluppata utilizzando Flutter e sfrutta il framework di gestione dello stato <strong>Riverpod</strong>. Interagisce con l'hardware ELRS tramite un'API RESTful esposta dal modulo WiFi integrato nel dispositivo, garantendo comunicazioni a bassa latenza e sincronizzazione dello stato in tempo reale.
  </p>
</div>

## Livello Dati

### Endpoint API
Il sistema comunica con l'hardware utilizzando i seguenti endpoint HTTP:

| Metodo | Endpoint | Descrizione |
| :--- | :--- | :--- |
| `GET` | `/config` | Recupera la configurazione corrente del dispositivo in formato JSON. |
| `POST` | `/options.json` | Aggiorna le opzioni di runtime modificabili (SSID, Password, ecc.). |
| `POST` | `/config` | Aggiorna i parametri hardware principali e le mappature PWM. |
| `POST` | `/reboot` | Attiva un reset hardware per applicare le modifiche. |

### JSON Schema
Il modello `RuntimeConfig` sfrutta la struttura ELRS 4.x, che separa i parametri in tre nodi principali:
- `settings`: identificatori hardware di sola lettura e stringhe di versione.
- `options`: preferenze utente modificabili e credenziali di rete.
- `config`: configurazioni hardware di basso livello (Protocols, PWM Arrays).

Esempio di struttura JSON:
```json
{
  "product_name": "Test RX",
  "settings": {
    "version": "1.0.0",
    "module-type": "RX"
  },
  "options": {
    "bindPhrase": "example",
    "wifi-ssid": "SSID",
    "domain": 1
  },
  "config": {
    "serial-protocol": 0,
    "pwm": [
      {"channel": 0, "mode": 5}
    ]
  }
}
```

## Gestione dello Stato
Il sistema impiega un'architettura reattiva:
- **`ConfigViewModel`**: Gestisce lo stato della connessione in tempo reale, la logica heartbeat e la scoperta IP.
- **`DeviceEditorViewModel`**: Contiene lo stato di bozza della configurazione di un dispositivo, consentendo modifiche a più passaggi con logica finale di "salva/annulla".
- **`FlashingController`**: Orchestra i download del firmware, il patching binario locale e il processo di caricamento XH-over-HTTP.

## Livello di Mappatura
Le seguenti tabelle definiscono la mappatura tra gli identificatori interi utilizzati nell'API e i loro equivalenti leggibili dall'uomo.

### Domini Normativi
| ID | Etichetta | Descrizione |
| :--- | :--- | :--- |
| 0 | AU915 | Australia/Nuova Zelanda 915MHz |
| 1 | FCC915 | Nord America 915MHz |
| 2 | EU868 | Europeo 868MHz |
| 3 | IN866 | Indiano 866MHz |
| 4 | AU433 | Australia 433MHz |
| 5 | EU433 | Europeo 433MHz |
| 6 | US433 | Nord America 433MHz |
| 7 | US433-Wide | Nord America Wide 433MHz |


## Mappature Avanzate

### VBind (Memorizzazione del Binding)
Determina come la binding phrase viene memorizzata sul dispositivo.
- **0: Persistent**: Salva nella memoria flash (standard).
- **1: Volatile**: Cancellato al ciclo di alimentazione.
- **2: Returnable**: Usato per attrezzatura in prestito.
- **3: Administered**: Usato in ambienti di flotte multi-pilota.


## Livello di Persistenza
Il sistema implementa una strategia di persistenza a doppio strato:
- **`SharedPreferences`**: Utilizzato tramite `PersistenceService` per dati non sensibili come i WiFi SSID e le preferenze generali dell'app.
- **`FlutterSecureStorage`**: Utilizzato per dati sensibili, inclusi le Binding Phrases e le WiFi Passwords, garantendo la crittografia a livello di sistema operativo.

<!-- source_hash: 860927a6dde3698e9797d33bf1b4c557 -->