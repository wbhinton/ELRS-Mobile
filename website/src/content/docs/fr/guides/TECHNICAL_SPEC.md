---
title: "Spécification Technique"
slug: fr/technical_spec
sidebar:
  order: 5
---

## Vue d'ensemble de l'architecture

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Principe de conception</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    L'application est développée avec Flutter et utilise le framework de gestion d'état **Riverpod**. Elle interagit avec le matériel ELRS via une API RESTful exposée par le module WiFi embarqué de l'appareil, garantissant une communication à faible latence et une synchronisation d'état en temps réel.
  </p>
</div>

## Couche de données

### Points d'extrémité de l'API
Le système communique avec le matériel en utilisant les points d'extrémité HTTP suivants :

| Méthode | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/config` | Récupère la configuration actuelle de l'appareil au format JSON. |
| `POST` | `/options.json` | Met à jour les options d'exécution modifiables (SSID, Mot de passe, etc.). |
| `POST` | `/config` | Met à jour les paramètres matériels fondamentaux et les mappages PWM. |
| `POST` | `/reboot` | Déclenche une réinitialisation matérielle pour appliquer les modifications. |

### Schéma JSON
Le modèle `RuntimeConfig` utilise la structure ELRS 4.x, qui sépare les paramètres en trois nœuds principaux :
- `settings` : Identifiants mat��riels en lecture seule et chaînes de version.
- `options` : Préférences utilisateur modifiables et identifiants réseau.
- `config` : Configurations matérielles de bas niveau (protocoles, matrices PWM).

Exemple de structure JSON :
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

## Gestion de l'état
Le système utilise une architecture réactive :
- **`ConfigViewModel`** : Gère l'état de connexion en direct, la logique de battement de cœur et la découverte d'IP.
- **`FlashingController`** : Orchestre les téléchargements de micrologiciels, le patching binaire local et le processus de téléversement XH-over-HTTP.

## Couche de mappage
`ElrsMappings.domains900` mappe l'index du domaine réglementaire 900 MHz utilisé dans l'API à son étiquette lisible par l'homme :

| ID | Étiquette | Description |
| :--- | :--- | :--- |
| 0 | AU915 | Australie/Nouvelle-Zélande 915MHz |
| 1 | FCC915 | Amérique du Nord 915MHz |
| 2 | EU868 | Europe 868MHz |
| 3 | IN866 | Inde 866MHz |
| 4 | AU433 | Australie 433MHz |
| 5 | EU433 | Europe 433MHz |
| 6 | US433 | Amérique du Nord 433MHz |
| 7 | US433-Wide | Amérique du Nord Large 433MHz |

## Couche de persistance
Le système met en œuvre une stratégie de persistance à double couche :
- **`SharedPreferences`** : Utilisé via `PersistenceService` pour les données non sensibles telles que les SSID WiFi et les préférences générales de l'application.
- **`FlutterSecureStorage`** : Utilisé pour les données sensibles, y compris les phrases de liaison et les mots de passe WiFi, assurant le chiffrement au niveau du système d'exploitation.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->