---
title: "Guide de développement"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: fr/development
sidebar:
  order: 2
---

Bienvenue dans le guide de développement ELRS Mobile ! Ce projet est une implémentation Flutter native du pipeline de compilation et de flashage ExpressLRS, conçu pour fonctionner entièrement hors ligne.

## Prérequis
Pour contribuer à ce projet, vous aurez besoin des outils suivants installés :

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Pour commencer

1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Installer les dépendances** :
   ```bash
   flutter pub get
   ```

3. **Exécuter l'application** :
   ```bash
   # Pour Android
   flutter run
   
   # Pour iOS (nécessite un Mac et un appareil physique/simulateur)
   flutter run
   ```

---

## Architecture du projet
La base de code suit une structure axée sur les fonctionnalités, située dans `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Fonctionnalités
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">La logique centrale et l'interface utilisateur pour le pipeline de flashage.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Gère le téléchargement et la mise en cache du firmware depuis l'artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Interface utilisateur pour la configuration des options utilisateur comme les Binding Phrases et le WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Noyau
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Logique spécifique à la plateforme pour la liaison de processus aux points d'accès matériels.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Gestion du cache local et persistance SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Observabilité axée sur la confidentialité (Sentry et Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Gestion d'état
Nous utilisons **Riverpod** pour la gestion d'état global et **Flutter Hooks** pour l'état local au niveau des widgets. Cette combinaison assure une interface utilisateur très réactive sans le code passe-partout des `StatefulWidgets` standards.

---

## Plongées techniques

Pour des informations techniques plus détaillées, veuillez consulter les guides suivants :

- [**Architecture Technique**](/guides/technical_architecture) : Une plongée approfondie dans le `FirmwareAssembler` et la pile réseau native.
- [**Validation du Firmware**](/guides/firmware-validation) : Comment utiliser les outils Dart et Python pour vérifier l'intégrité binaire.

---

## Remarque sur la minification JSON

Lors de l'audit des binaires, vous pourriez remarquer de légers décalages d'octets par rapport au Configurator Python standard. Cela est dû à la **minification JSON**. 

Le Configurator Python injecte souvent des espaces après les deux-points (par exemple, `{"uid": [1,2,3]}`), tandis qu'ELRS Mobile génère du JSON dense (par exemple, `{"uid":[1,2,3]}`). Les deux sont fonctionnellement identiques sur le matériel, car l'analyseur interne de l'ESP32 ignore ces espaces blancs.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->