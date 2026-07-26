---
title: "Architecture Technique"
slug: fr/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile n'est pas seulement un web-wrapper ; c'est une implémentation native en Dart du pipeline de compilation et de configuration ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Assemblage Unifié du Firmware</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Au lieu de s'appuyer sur un compilateur cloud distant, l'application construit dynamiquement les binaires localement sur votre appareil. Lors du flashage des cibles ESP32/ESP8285, le `FirmwareAssembler` exécute une séquence précise de modification au niveau du bit :
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extrait le firmware générique de base de l'archive `firmware.zip` mise en cache.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Élague le remplissage de base en recherchant la signature du byte magique ESP `0xE9`.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extrait les broches spécifiques de la cible et la configuration d'exécution à partir de `hardware.json`.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Compresse en octets le Nom du Produit (128b), le Nom Lua (16b), `options.json` (512b) et `hardware.json` (2048b) directement dans le flux binaire.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Compresse la charge utile finale dans un flux `.gz` si requis par la plateforme cible (ex. ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Logique Périphérique

### Injecteur de Domaine Réglementaire
L'application gère avec précision les différences complexes entre les bandes de fréquences. Pour les appareils 900MHz/Dual-Band, elle injecte activement le domaine choisi (ex. FCC, EU868) dans la charge utile JSON compilée. Pour les cibles 2.4GHz standard, elle utilise un drapeau booléen pour acheminer silencieusement le processus d'extraction vers les dossiers de firmware de base FCC/ standard ou LBT/ européen pendant l'assemblage.

### Mise en Cache et Synchronisation du Firmware
Le flashage hors ligne est rendu possible grâce à un système de mise en cache local robuste. Lorsqu'un utilisateur télécharge une version via le Gestionnaire de Firmware, le `FirmwareCacheService` extrait le `firmware.zip` générique et le `hardware.zip` spécifique à l'appareil directement depuis l'ExpressLRS Artifactory. Ces archives sont gérées et stockées localement sur l'appareil, garantissant que l'assemblage et le flashage peuvent avoir lieu instantanément sur le terrain sans aucune connexion internet active.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Liaison Réseau Native</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Les systèmes d'exploitation mobiles (notamment Android et iOS) déprioriseront les connexions Wi-Fi qui n'ont pas d'accès à Internet, acheminant silencieusement le trafic via le réseau cellulaire à la place. Cela empêche les applications standard d'atteindre le matériel ELRS à `10.0.0.1`.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile résout ce problème via le `NativeNetworkService`. Lorsqu'une connexion matérielle est détectée, l'application invoque un `MethodChannel` spécifique à la plateforme pour lier l'ensemble du processus Flutter à l'interface Wi-Fi au niveau du noyau du système d'exploitation. Cela garantit que tout le trafic HTTP et mDNS est acheminé correctement vers le matériel, quelle que soit l'état cellulaire.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->