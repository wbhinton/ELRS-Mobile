---
title: "Guide de l'utilisateur"
slug: user_guide
sidebar:
  order: 1
---

## Aperçu
Cette application fournit une interface mobile complète pour la gestion du matériel ExpressLRS. Elle permet aux utilisateurs de configurer les paramètres du récepteur (RX) et de l'émetteur (TX), de mapper les sorties PWM et de flasher les mises à jour de firmware directement depuis un appareil mobile.

---

## Installation

### Boutiques d'applications officielles

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Installer depuis Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Obtenir sur Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Installer depuis l'App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Télécharger sur l'App Store</a>

### Installation alternative

#### GitHub Store
Idéal pour les utilisateurs qui préfèrent une expérience de boutique d'applications alternative.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Télécharger sur GitHub Store</a>

### Installation manuelle
Pour les utilisateurs avancés ou ceux qui préfèrent une gestion manuelle, visitez notre page [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) pour les derniers fichiers `.apk`.

---

## 🚀 Démarrage rapide : Flasher votre premier appareil

### Phase 1 : Mise en cache du firmware (À faire à la maison)
1. Ouvrez l'application et accédez au **Firmware Manager**.
2. Appuyez sur l'icône de téléchargement à côté de la dernière version stable.
3. L'application téléchargera et mettra en cache de manière sécurisée les définitions de cible et de matériel requises pour une utilisation hors ligne.

### Phase 2 : Connexion à votre appareil
1. Mettez sous tension votre récepteur (RX) ou émetteur (TX) ExpressLRS.
2. Attendez 60 secondes (ou l'intervalle configuré) pour que l'appareil entre en mode point d'accès Wi-Fi (LED clignotant rapidement).
3. Connectez le Wi-Fi de votre téléphone au réseau **ExpressLRS RX** ou **ExpressLRS TX** (Mot de passe : `expresslrs`).
4. Ouvrez l'application. Le tableau de bord analysera automatiquement le réseau à l'aide de mDNS et se connectera à l'appareil.

### Phase 3 : Flashage du firmware
1. Depuis le tableau de bord, sélectionnez **Flash Device**.
2. **Sélectionnez votre matériel :** Utilisez les listes déroulantes en cascade pour sélectionner votre type d'appareil, votre fournisseur, votre fréquence et votre cible.
3. **Configurez les options et les profils :** Sélectionnez un **Flashing Profile** (ou appuyez sur le bouton **+** pour ajouter un nouveau profil nommé) pour charger vos identifiants. Personnalisez la phrase de liaison (Binding Phrase), le Wi-Fi SSID, le mot de passe Wi-Fi, les domaines réglementaires et l'intervalle d'activation automatique du Wi-Fi.
4. Appuyez sur **FLASH**. L'application assemblera le binaire localement et le transférera à l'appareil.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Avertissement de non-concordance de cible</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Si l'application détecte une non-concordance de cible matérielle entre votre sélection et l'appareil connecté, elle vous avertira pour prévenir tout dommage accidentel. Si vous êtes certain d'avoir la bonne cible (par exemple, pour récupérer après un mauvais flash ou migrer entre des définitions de cible), cliquez sur <strong>FORCE FLASH</strong> dans la boîte de dialogue d'avertissement pour contourner la vérification.
  </p>
</div>

### 📋 Gestion des profils de flashage
Si vous avez plusieurs drones ou configurations radio avec des exigences de configuration différentes (par exemple, des phrases de liaison ou des domaines réglementaires différents), vous pouvez utiliser des **Flashing Profiles** nommés pour enregistrer et basculer entre les configurations :
* **Ajouter un profil** : Appuyez sur l'icône **+** à côté de la liste déroulante "Flashing Profile", tapez un nom et appuyez sur Ajouter.
* **Enregistrement automatique** : Toute modification des identifiants du profil actif (phrase de liaison, SSID, mot de passe, domaine ou intervalle) est enregistrée automatiquement en temps réel.
* **Changer de profil** : Sélectionnez simplement un profil dans la liste déroulante pour charger instantanément ses paramètres enregistrés.
* **Supprimer un profil** : Pour nettoyer, sélectionnez le profil dans la liste déroulante et appuyez sur l'icône de la corbeille/suppression (vous devez avoir au moins deux profils pour en supprimer un).

---

## Détails techniques

### Connectivité et découverte
L'application utilise une séquence de découverte robuste en plusieurs étapes pour trouver votre matériel :
1. **Résolution mDNS** : La méthode principale. L'application recherche `elrs_rx.local` ou `elrs_tx.local`.
2. **Restauration AP statique** : Si mDNS est bloqué, l'application vérifie l'adresse IP du point d'accès officiel ELRS (`10.0.0.1`).
3. **Surcharge IP manuelle** : Pour les réseaux complexes, vous pouvez entrer manuellement une adresse IP dans les paramètres.

**Liaison réseau forcée** : Les smartphones modernes abandonnent souvent les connexions Wi-Fi sans accès à Internet. ELRS Mobile inclut une couche native de "Forced Routing" qui force le système d'exploitation à maintenir la connexion matérielle, garantissant une découverte fiable à 100% sur le terrain.

---

## Mode Expert et Audit
Dans le menu Paramètres, les utilisateurs peuvent activer le **Mode Expert**. Cela vous permet d'enregistrer le binaire de firmware assemblé directement sur votre appareil pour un audit ou un flashage manuel via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Gestion du matériel STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Bien qu'ELRS Mobile puisse assembler et patcher le firmware pour les cibles STM32 (jusqu'à ELRS v3.x), ces appareils ne prennent pas en charge le flashage Over-The-Air (OTA) via Wi-Fi. Si vous sélectionnez une cible STM32, l'application vous permettra de construire et d'enregistrer le binaire localement afin que vous puissiez le flasher manuellement à l'aide d'un PC via STLink ou Betaflight Passthrough.
  </p>
</div>

Pour les développeurs souhaitant vérifier l'intégrité de ces binaires, consultez notre [**Guide de validation du firmware**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->