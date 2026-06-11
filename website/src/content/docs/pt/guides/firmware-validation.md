---
title: "Ferramentas de Validação de Firmware"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Este guia detalha as ferramentas internas usadas para validar a lógica de montagem de firmware do aplicativo ELRS Mobile contra os binários "Golden" oficiais.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Binários de Ground Truth vs. Configurator</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Ao executar auditorias de validação, você pode notar que os binários gerados pelo ELRS Mobile correspondem perfeitamente ao <strong>ExpressLRS Web Flasher</strong> oficial, mas divergem ligeiramente dos binários construídos usando o <strong>ExpressLRS Configurator (Python)</strong> local.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Este é um comportamento esperado. O parser C++ JSON interno do ESP32 ignora espaços em branco, o que significa que ambos os binários são executados de forma idêntica no hardware, apesar de falharem em uma comparação SHA256 byte a byte estrita devido a diferenças de minificação.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Localização:** `firmware_testing/scripts/dart/logic_validator.dart`

O Logic Validator é uma ferramenta de comparação de alto desempenho em nível de bit. Ele foi projetado para verificar se a lógica interna de aplicação de patches e montagem do ELRS Mobile espelha a lógica oficial do ExpressLRS.

### Principais Recursos
- **Análise Nível de Bit**: Aponta falhas exatas de deslocamento de bit dentro de bytes discrepantes.
- **Seleção Interativa**: Lista todos os binários encontrados em `firmware_testing/binaries/`.
- **Gerenciamento de Memória Zero-Copy**: Otimizado para análise de alta velocidade de grandes arquivos de firmware.

### Como Usar
1. **Preparar Binários**: Coloque os arquivos `.bin` ou `.gz` gerados em `firmware_testing/binaries/`.
2. **Configurar e Executar**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Localização:** `firmware_testing/scripts/python/audit_tool.py`

O Auditor é um script autônomo, com zero dependências, destinado à verificação de "Ground Truth". Ele analisa o bloco de configuração de 2704 bytes anexado ao final de cada imagem de firmware ExpressLRS.

### Propósito
Ele verifica se os metadados realmente gravados no dispositivo (Product Name, Lua Name, Hardware Layout e Options) estão corretos, independentemente de quaisquer diferenças de layout no código base do firmware.

### Como Usar
1. **Executar diretamente**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Fluxo de Trabalho de Validação Cruzada de Binários
Para garantir que o ELRS Mobile está montando o firmware corretamente, os desenvolvedores devem realizar periodicamente uma auditoria de validação cruzada contra um binário "Ground Truth" compilado em um PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Exportar Binário do ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Ative o <strong>Modo Expert</strong> em Configurações, então use o botão <strong>DOWNLOAD BINARY</strong> na aba Flasher após configurar seu alvo e opções.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Gerar Ground Truth no PC</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Construa o <strong>mesmo</strong> alvo e versão com opções idênticas usando o ExpressLRS Configurator oficial no seu PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Executar a Auditoria</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Coloque ambos os binários em <code>firmware_testing/binaries/</code> e execute o script <code>audit_tool.py</code> para verificar a paridade perfeita de hardware e opções.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->