---
title: "Guia do Usuário"
slug: user_guide
sidebar:
  order: 1
---

## Visão Geral
Esta aplicação oferece uma interface móvel abrangente para gerenciar hardware ExpressLRS. Ela permite aos usuários configurar parâmetros de receptor (RX) e transmissor (TX), mapear saídas PWM e atualizar o firmware diretamente de um dispositivo móvel.

---

## Instalação

### Lojas de Aplicativos Oficiais

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Instalar do Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Obtenha no Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Instalar da App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Baixe na App Store</a>

### Instalação Alternativa

#### GitHub Store
Ideal para usuários que preferem uma experiência de loja de aplicativos alternativa.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Baixe na GitHub Store</a>

### Instalação Manual
Para usuários avançados ou aqueles que preferem gerenciamento manual, visite nossa página de [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) para os arquivos `.apk` mais recentes.

---

## 🚀 Início Rápido: Atualizando Seu Primeiro Dispositivo

### Fase 1: Cache de Firmware (Faça isso em casa)
1. Abra o aplicativo e navegue até o **Firmware Manager**.
2. Toque no ícone de download ao lado da versão estável mais recente.
3. O aplicativo fará o download e armazenará em cache de forma segura as definições de alvo e hardware necessárias para uso offline.

### Fase 2: Conectando-se ao Seu Dispositivo
1. Ligue seu ExpressLRS Receiver (RX) ou Transmitter (TX).
2. Espere 60 segundos (ou seu intervalo configurado) para que o dispositivo entre no Modo Hotspot Wi-Fi (LED piscando rapidamente).
3. Conecte o Wi-Fi do seu telefone à rede **ExpressLRS RX** ou **ExpressLRS TX** (Senha: `expresslrs`).
4. Abra o aplicativo. O Dashboard escaneará automaticamente a rede usando mDNS e se conectará ao dispositivo.

### Fase 3: Atualizando o Firmware
1. No Dashboard, selecione **Flash Device**.
2. **Selecione seu Hardware:** Use os menus suspensos em cascata para selecionar seu Tipo de Dispositivo, Fornecedor, Frequência e Alvo.
3. **Configure Opções e Perfis:** Selecione um **Flashing Profile** (ou toque no botão **+** para adicionar um novo perfil nomeado) para carregar suas credenciais. Personalize a Binding Phrase, WiFi SSID, senha do Wi-Fi, domínios regulatórios e intervalo de ativação automática do Wi-Fi.
4. Toque em **FLASH**. O aplicativo montará o binário localmente e o enviará para o dispositivo.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Aviso de Incompatibilidade de Alvo</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Se o aplicativo detectar uma incompatibilidade de alvo de hardware entre sua seleção e o dispositivo conectado, ele o avisará para evitar danos acidentais. Se você tiver certeza de que possui o alvo correto (por exemplo, recuperando-se de uma atualização com falha ou migrando entre definições de alvo), clique em <strong>FORCE FLASH</strong> na caixa de diálogo de aviso para ignorar a verificação.
  </p>
</div>

### 📋 Gerenciando Perfis de Flashing
Se você tiver vários drones ou configurações de rádio com diferentes requisitos de configuração (por exemplo, diferentes Binding Phrases ou domínios regulatórios), você pode usar **Flashing Profiles** nomeados para salvar e alternar configurações:
* **Adicionar um Perfil**: Toque no ícone **+** ao lado do menu suspenso "Flashing Profile", digite um nome e toque em Adicionar.
* **Salvamento Automático**: Quaisquer alterações nas credenciais do perfil ativo (Binding Phrase, SSID, senha, domínio ou intervalo) são salvas automaticamente em tempo real.
* **Trocar Perfis**: Basta selecionar um perfil no menu suspenso para carregar instantaneamente suas configurações armazenadas.
* **Excluir um Perfil**: Para limpar, selecione o perfil no menu suspenso e toque no ícone de lixeira/excluir (você deve ter pelo menos dois perfis para excluir um).

---

## Detalhes Técnicos

### Conectividade e Descoberta
O aplicativo usa uma robusta sequência de descoberta em várias etapas para encontrar seu hardware:
1. **Resolução mDNS**: O método primário. O aplicativo procura por `elrs_rx.local` ou `elrs_tx.local`.
2. **Fallback para AP Estático**: Se o mDNS estiver bloqueado, o aplicativo verifica o IP oficial do ponto de acesso ELRS (`10.0.0.1`).
3. **Substituição Manual de IP**: Para redes complexas, você pode inserir manualmente um endereço IP em Configurações.

**Forced Network Binding**: Smartphones modernos geralmente descartam conexões Wi-Fi sem internet. O ELRS Mobile inclui uma camada nativa de "Forced Routing" que força o sistema operacional a manter a conexão de hardware, garantindo uma descoberta 100% confiável em campo.

---

## Modo Especialista e Auditoria
No menu Configurações, os usuários podem ativar o **Expert Mode**. Isso permite salvar o binário do firmware montado diretamente no seu dispositivo para auditoria ou flashing manual via FTDI.

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
    Embora o ELRS Mobile possa montar e aplicar patches de firmware para alvos STM32 (até ELRS v3.x), esses dispositivos não suportam flashing Over-The-Air (OTA) via Wi-Fi. Se você selecionar um alvo STM32, o aplicativo permitirá que você compile e salve o binário localmente para que possa atualizá-lo manualmente usando um PC via STLink ou Betaflight Passthrough.
  </p>
</div>

Para desenvolvedores que procuram verificar a integridade desses binários, consulte nosso [**Guia de Validação de Firmware**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->