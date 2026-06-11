---
title: "Arquitetura Técnica"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile não é apenas um web-wrapper; é uma implementação nativa em Dart do pipeline de compilação e configuração do ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Montagem Unificada de Firmware</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Em vez de depender de um compilador remoto na nuvem, o aplicativo constrói dinamicamente binários localmente no seu dispositivo. Ao fazer o flash em alvos ESP32/ESP8285, o <code>FirmwareAssembler</code> executa uma sequência precisa de modificação em nível de bit:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extrai o firmware genérico base do arquivo <code>firmware.zip</code> em cache.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Remove o preenchimento base procurando pela assinatura do byte mágico ESP <code>0xE9</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extrai pinagens de destino específicas e configuração de tempo de execução de <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Compacta o Nome do Produto (128b), Nome Lua (16b), <code>options.json</code> (512b) e <code>hardware.json</code> (2048b) diretamente no fluxo binário.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Compacta o payload final em um fluxo <code>.gz</code> se exigido pela plataforma de destino (por exemplo, ESP8285 legacy).</p>
    </div>
  </div>
</div>

## Lógica Periférica

### Injetor de Domínio Regulatório
O aplicativo lida com precisão com as complexas diferenças entre as bandas de frequência. Para dispositivos de 900MHz/Dual-Band, ele injeta ativamente o domínio escolhido (por exemplo, FCC, EU868) no payload JSON compilado. Para alvos padrão de 2.4GHz, ele utiliza um flag booleano para rotear silenciosamente o processo de extração para as pastas de firmware base padrão FCC/ ou LBT/ europeu durante a montagem.

### Cache e Sincronização de Firmware
O flash offline é possível através de um robusto sistema de cache local. Quando um usuário baixa uma versão através do Gerenciador de Firmware, o `FirmwareCacheService` puxa o `firmware.zip` genérico e o `hardware.zip` específico do dispositivo diretamente do Artifactory do ExpressLRS. Esses arquivos são gerenciados e armazenados localmente no dispositivo, garantindo que a montagem e o flash possam ocorrer instantaneamente em campo sem qualquer conexão ativa com a internet.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Ligação de Rede Nativa</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Sistemas operacionais móveis (especialmente Android e iOS) despriorizam conexões Wi-Fi que não têm acesso à internet, roteando o tráfego silenciosamente pela rede celular. Isso impede que aplicativos padrão alcancem o hardware ELRS em <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    O ELRS Mobile resolve isso através do <code>NativeNetworkService</code>. Quando uma conexão de hardware é detectada, o aplicativo invoca um <code>MethodChannel</code> específico da plataforma para vincular todo o processo Flutter à interface Wi-Fi no nível do kernel do sistema operacional. Isso garante que todo o tráfego HTTP e mDNS seja roteado corretamente para o hardware, independentemente do status da rede celular.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->