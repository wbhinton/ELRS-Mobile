---
title: "Outils de validation de Firmware"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Ce guide détaille les outils internes utilisés pour valider la logique d'assemblage du firmware de l'application ELRS Mobile par rapport aux binaires "Golden" officiels.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Vérité Terrain vs. Binaires du Configurateur</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Lors de l'exécution d'audits de validation, vous remarquerez peut-être que les binaires générés par ELRS Mobile correspondent parfaitement à l'**ExpressLRS Web Flasher** officiel, mais divergent légèrement des binaires construits à l'aide de l'**ExpressLRS Configurator (Python)** local.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Ceci est un comportement attendu. L'analyseur JSON C++ interne de l'ESP32 ignore les espaces blancs, ce qui signifie que les deux binaires s'exécutent de manière identique sur le matériel bien qu'ils échouent à une comparaison SHA256 stricte octet par octet en raison de différences de minification.
  </p>
</div>

---

## 1. Validateur de logique ExpressLRS (Dart)
**Emplacement :** `firmware_testing/scripts/dart/logic_validator.dart`

Le Validateur de logique est un outil de comparaison de haut niveau de performance au niveau du bit. Il est conçu pour vérifier que la logique interne de patching et d'assemblage d'ELRS Mobile reflète la logique ExpressLRS officielle.

### Fonctionnalités Clés
- **Analyse au niveau du bit** : Identifie les échecs exacts d'offset de bit au sein des octets divergents.
- **Sélection interactive** : Liste tous les binaires trouvés dans `firmware_testing/binaries/`.
- **Gestion de la mémoire sans copie** : Optimisée pour l'analyse à haute vitesse des fichiers firmware volumineux.

### Comment l'utiliser
1. **Préparer les binaires** : Placez les fichiers `.bin` ou `.gz` générés dans `firmware_testing/binaries/`.
2. **Configuration et exécution** :
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Auditeur de vérité terrain (Python)
**Emplacement :** `firmware_testing/scripts/python/audit_tool.py`

L'Auditeur est un script autonome, sans dépendance, destiné à la vérification de la "Vérité Terrain". Il analyse le bloc de configuration de 2704 octets ajouté à la fin de chaque image de firmware ExpressLRS.

### Objectif
Il vérifie que les métadonnées réellement flashées sur l'appareil (Nom du produit, Nom Lua, Disposition matérielle et Options) sont correctes, quelles que soient les différences de disposition dans le code du firmware de base.

### Comment l'utiliser
1. **Exécuter directement** :
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Flux de travail de validation croisée binaire
Pour s'assurer qu'ELRS Mobile assemble correctement le firmware, les développeurs doivent effectuer périodiquement un audit de validation croisée par rapport à un binaire de "Vérité Terrain" compilé sur un PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Exporter le binaire depuis ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Activez le **Mode Expert** dans les Paramètres, puis utilisez le bouton **TÉLÉCHARGER BINAIRE** dans l'onglet Flasher après avoir configuré votre cible et vos options.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Générer la vérité terrain PC</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Construisez la **cible et la version exactement identiques** avec des options identiques en utilisant l'ExpressLRS Configurator officiel sur votre PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Exécuter l'audit</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Placez les deux binaires dans <code>firmware_testing/binaries/</code> et exécutez le script <code>audit_tool.py</code> pour vérifier la parité parfaite du matériel et des options.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->