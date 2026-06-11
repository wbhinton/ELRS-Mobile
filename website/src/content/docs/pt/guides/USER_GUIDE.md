---
title: "Guia do Usuário"
slug: user_guide
sidebar:
  order: 1
---

## Visão Geral
Esta aplicação oferece uma interface móvel abrangente para gerenciar hardware ExpressLRS. Ela permite aos usuários configurar parâmetros de receptor (RX) e transmissor (TX), mapear saídas PWM e fazer o flash de atualizações de firmware diretamente de um dispositivo móvel.

---

## Instalação

### Lojas de Aplicações Oficiais

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Instalar do Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Obter no Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Instalar da App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download na App Store</a>

### Instalação Alternativa

#### GitHub Store
Ideal para usuários que preferem uma experiência de loja de aplicações alternativa.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download na GitHub Store</a>

### Instalação Manual
Para usuários avançados ou aqueles que preferem gerenciamento manual, visite nossa página de [Lançamentos no GitHub](https://github.com/wbhinton/ELRS-Mobile/releases) para os arquivos `.apk` mais recentes.

---

## 🚀 Início Rápido: Fazendo o Flash do Seu Primeiro Dispositivo

### Fase 1: Cache de Firmware (Faça isto em casa)
1. Abra a aplicação e navegue até o **Gestor de Firmware**.
2. Toque no ícone de download ao lado da versão estável mais recente.
3. A aplicação irá baixar e armazenar em cache de forma segura as definições de alvo e hardware necessárias para uso offline.

### Fase 2: Conectando ao Seu Dispositivo
1. Ligue o seu receptor ExpressLRS (RX) ou transmissor (TX).
2. Aguarde 60 segundos (ou o seu intervalo configurado) para o dispositivo entrar no Modo Wi-Fi Hotspot (LED a piscar rapidamente).
3. Conecte o Wi-Fi do seu telefone à rede **ExpressLRS RX** ou **ExpressLRS TX** (Senha: `expresslrs`).
4. Abra a aplicação. O Painel irá escanear automaticamente a rede usando mDNS e conectar ao dispositivo.

### Fase 3: Fazendo o Flash do Firmware
1. No Painel, selecione **Fazer Flash do Dispositivo**.
2. **Selecione o seu Hardware:** Use os menus suspensos em cascata para selecionar o seu Tipo de Dispositivo, Fornecedor, Frequência e Alvo.
3. **Configurar Opções:** Defina a sua Binding Phrase personalizada, credenciais de Wi-Fi e Regulatory Domain.
4. Toque em **FLASH**. A aplicação irá montar o binário localmente e enviá-lo para o dispositivo.

---

## Detalhes Técnicos

### Conectividade e Descoberta
A aplicação usa uma sequência de descoberta robusta em várias etapas para encontrar o seu hardware:
1. **Resolução mDNS**: O método principal. A aplicação procura por `elrs_rx.local` ou `elrs_tx.local`.
2. **Fallback de AP Estático**: Se o mDNS estiver bloqueado, a aplicação verifica o IP do ponto de acesso ELRS oficial (`10.0.0.1`).
3. **Substituição Manual de IP**: Para redes complexas, pode introduzir manualmente um endereço IP nas Definições.

**Ligação de Rede Forçada**: Smartphones modernos frequentemente descartam ligações Wi-Fi sem internet. O ELRS Mobile inclui uma camada nativa de "Roteamento Forçado" que força o SO a manter a ligação ao hardware, garantindo uma descoberta 100% fiável no campo.

---

## Modo Especialista e Auditoria
Dentro do menu Definições, os utilizadores podem ativar o **Modo Especialista**. Isso permite guardar o binário de firmware montado diretamente no seu dispositivo para auditoria ou flash manual via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Manuseio de Hardware STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Embora o ELRS Mobile possa montar e aplicar patches de firmware para alvos STM32 (até ELRS v3.x), estes dispositivos não suportam o flash Over-The-Air (OTA) via Wi-Fi. Se selecionar um alvo STM32, a aplicação permitirá construir e guardar o binário localmente para que possa fazer o flash manualmente usando um PC via STLink ou Betaflight Passthrough.
  </p>
</div>

Para desenvolvedores que procuram verificar a integridade desses binários, consulte o nosso [**Guia de Validação de Firmware**](/guides/firmware-validation).

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->