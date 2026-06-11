# Walkthrough

## Fase 1: Cache de Firmware
1. **Conectar à Internet:** Certifique-se de que seu telefone esteja conectado à internet (por exemplo, Wi-Fi doméstico ou rede móvel).
2. **Abrir o Gerenciador de Firmware:** Navegue até o Firmware Manager no aplicativo.
3. **Baixar Versão:** Toque no ícone de download ao lado da sua versão ExpressLRS desejada. Isso armazena em cache de forma segura os firmware targets necessários e as definições de hardware em seu telefone para uso 100% offline.

## Fase 2: Conectando ao Seu Dispositivo
1. **Ligar Dispositivo:** Ligue seu ExpressLRS Receiver (RX) ou Transmitter (TX).
2. **Aguardar Hotspot:** Espere o dispositivo entrar no Modo Wi-Fi Hotspot (indicado por um LED piscando rapidamente).
3. **Conectar ao Hotspot:** Conecte o Wi-Fi do seu telefone à rede `ExpressLRS RX` ou `ExpressLRS TX` usando a senha `expresslrs`.
* **Nota:** O ELRS Mobile gerencia nativamente o roteamento forçado, garantindo que seu telefone não volte silenciosamente para 5G/LTE.

## Fase 3: Gravação de Firmware
1. **Navegar para Flash Device:** No Painel Principal (Dashboard), selecione **Flash Device**.
2. **Seleção de Target:** Use os menus suspensos em cascata para selecionar o fornecedor e o hardware target específico.
3. **Seleção de Versão:** Escolha uma versão de firmware disponível do seu repositório offline.
4. **Configuração:** Insira suas credenciais personalizadas. O aplicativo persiste o WiFi SSID, WiFi Password e Binding Phrase no armazenamento local para que você não precise digitá-los novamente.
5. **Compilar e Gravar:** Toque em **FLASH**. O sistema aplica patches ao binário com suas credenciais locais e o carrega.
* **Crucial:** Sempre espere pela confirmação de sucesso e para o LED do dispositivo voltar a piscar antes de desconectar!

---

# FAQ

## Preciso de uma conexão com a internet ou serviço de celular para gravar o firmware?
Não. O ELRS Mobile oferece **Flash 100% Offline**. Contanto que você tenha baixado previamente a versão do firmware através do Firmware Manager enquanto estava em um Wi-Fi doméstico, o aplicativo pode montar e gravar o firmware dinamicamente de forma completamente offline.

## Recebo um erro de "Not enough space" ao gravar meu receiver ESP8285.
Chips ESP8285 (como os encontrados em muitas placas AIO) possuem apenas 1MB de armazenamento físico total. A atualização direta para uma versão principal (como de 3.x para 4.x) via Wi-Fi pode ficar sem espaço na partição dupla porque o arquivo de entrada é muito grande para ser descompactado junto com o firmware atualmente em execução.

**Como corrigir:** Primeiro, grave seu receiver para uma versão intermediária (como **3.6.3**). Assim que estiver executando o firmware 3.6.3 mais leve, você terá espaço de partição suficiente para gravar com sucesso para o seu 4.0 target desejado. Alternativamente, ative o **Expert Mode** em Configurações, salve o binário construído localmente e grave-o manualmente via uma conexão Betaflight Passthrough com fio.

## Onde encontro o script Lua do ExpressLRS para o meu rádio?
O ELRS Mobile vem com o script Lua universal e agnóstico de versão embutido! Para obtê-lo:
1. Vá para **Configurações** e ative o **Expert Mode**.
2. Toque em **Exportar Script Lua ELRS**.
3. Isso salva `elrs.lua` diretamente no armazenamento local do seu telefone. Ligue seu rádio e conecte-o ao seu telefone via USB, certifique-se de selecionar o modo "USB Storage" no seu rádio e transfira o arquivo para sua pasta `SCRIPTS/TOOLS` usando o gerenciador de arquivos do seu telefone.

**Nota:** Você precisa excluir quaisquer versões anteriores do script elrs.lua (ex: elrs_v2.lua, elrs_v3.lua, etc.) do cartão SD do seu rádio antes de usar o novo script.

## E se um flash falhar e meu dispositivo ficar sem resposta?
Se o seu dispositivo estiver sem resposta após um flash falho, você pode recuperá-lo facilmente:
1. Segure o botão BOOT no dispositivo enquanto o conecta via USB para entrar no modo bootloader.
2. Use um computador e o ELRS Web Flasher para regravar o dispositivo através de uma conexão USB/UART com fio.
3. Para dispositivos com capacidade Wi-Fi, você também pode segurar o BOOT

**Nota:** Há um link de vídeo na aba Recursos (Resources Tab) que mostra como fazer isso.

## Posso salvar o arquivo de firmware no meu telefone sem gravá-lo?
Sim. Ao entrar em **Configurações** e ativar o **Expert Mode**, você desbloqueia a capacidade de salvar o binário do firmware montado diretamente no armazenamento local do seu dispositivo móvel, em vez de gravá-lo imediatamente Over-The-Air (OTA).

Isso é especialmente útil se você deseja gravar o dispositivo manualmente usando um programador de hardware dedicado (como um STLink ou adaptador FTDI).

## Estou recebendo um erro de "Target Mismatch". O que devo fazer?
Um erro de target mismatch ocorre quando o hardware target selecionado no aplicativo não corresponde ao target do firmware atualmente em execução no dispositivo.

Atualmente, o aplicativo não suporta a gravação de um target diferente daquele atualmente em execução no dispositivo.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->