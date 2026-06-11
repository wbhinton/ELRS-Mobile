---
title: "Guia de Desenvolvimento"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: development
sidebar:
  order: 2
---

Bem-vindo ao guia de desenvolvimento ELRS Mobile! Este projeto é uma implementação Flutter nativa do pipeline de compilação e flashing do ExpressLRS, projetado para funcionar inteiramente offline.

## Pré-requisitos
Para contribuir com este projeto, você precisará das seguintes ferramentas instaladas:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Primeiros Passos

1. **Clonar o repositório**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Instalar dependências**:
   ```bash
   flutter pub get
   ```

3. **Executar a aplicação**:
   ```bash
   # Para Android
   flutter run
   
   # Para iOS (requer um Mac e dispositivo físico/simulador)
   flutter run
   ```

---

## Arquitetura do Projeto
A base de código segue uma estrutura focada em funcionalidades localizada em `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Funcionalidades
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">A lógica central e a UI para o pipeline de flashing.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Gerencia o download e o cache de firmware do artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">UI para configurar opções do usuário como Binding Phrases e WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Núcleo
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Lógica específica da plataforma para vinculação de processo a hotspots de hardware.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Gerenciamento de cache local e persistência SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Observabilidade com privacidade em primeiro lugar (Sentry e Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Gerenciamento de Estado
Utilizamos **Riverpod** para gerenciamento de estado global e **Flutter Hooks** para estado local a nível de widget. Esta combinação garante uma UI altamente reativa sem a repetição de código (boilerplate) dos `StatefulWidgets` padrão.

---

## Aprofundamentos

Para informações técnicas mais detalhadas, consulte os seguintes guias:

- [**Arquitetura Técnica**](/guides/technical_architecture): Um aprofundamento no `FirmwareAssembler` e na pilha de rede nativa.
- [**Validação de Firmware**](/guides/firmware-validation): Como usar as ferramentas Dart e Python para verificar a integridade binária.

---

## Nota sobre Minificação JSON

Ao auditar binários, você pode notar pequenas diferenças de byte em comparação com o Python Configurator padrão. Isso se deve à **minificação JSON**. 

O Python Configurator frequentemente injeta espaços após os dois pontos (por exemplo, `{"uid": [1,2,3]}`), enquanto o ELRS Mobile gera JSON denso (por exemplo, `{"uid":[1,2,3]}`). Ambos são funcionalmente idênticos no hardware, pois o parser interno do ESP32 ignora este espaço em branco.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->