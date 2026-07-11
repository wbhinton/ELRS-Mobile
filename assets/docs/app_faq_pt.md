# Guia

## Fase 1: Cache do Firmware
1.  **Conectar à Internet:** Certifique-se de que seu telefone esteja conectado à internet (por exemplo, Wi-Fi doméstico ou rede móvel).
2.  **Abrir Gerenciador de Firmware:** Navegue até o Gerenciador de Firmware no aplicativo.
3.  **Baixar Lançamento:** Toque no ícone de download ao lado do lançamento ExpressLRS desejado. Isso armazena em cache de forma segura os destinos de firmware e definições de hardware necessários no seu telefone para uso 100% offline.

## Fase 2: Conectando ao seu Dispositivo
1.  **Ligar Dispositivo:** Ligue seu ExpressLRS Receiver (RX) ou Transmitter (TX).
2.  **Aguardar Hotspot:** Aguarde o dispositivo entrar no Modo Wi-Fi Hotspot (indicado por um LED piscando rapidamente).
3.  **Conectar ao Hotspot:** Conecte o Wi-Fi do seu telefone à rede `ExpressLRS RX` ou `ExpressLRS TX` usando a senha `expresslrs`.
*   **Nota:** O ELRS Mobile lida nativamente com o roteamento forçado, garantindo que seu telefone não volte silenciosamente para 5G/LTE.

## Fase 3: Flashing do Firmware
1.  **Navegar para Flash Device:** No Dashboard principal, selecione **Flash Device**.
2.  **Seleção de Target:** Use os menus suspensos em cascata para selecionar o fornecedor e o hardware target específico.
3.  **Seleção de Versão:** Escolha uma versão de firmware disponível no seu repositório offline.
4.  **Configuração e Perfis:** Escolha ou crie um **Perfil de Flashing** (por exemplo, "Meus Quads", "Race Spec") para carregar suas credenciais personalizadas. O aplicativo persiste o Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain e intervalos de Auto-On nesses perfis nomeados para que você não precise digitá-los novamente ao alternar entre diferentes configurações.
5.  **Compilar e Fazer Flash:** Toque em **FLASH**. O sistema aplica patches ao binário com suas credenciais locais e o carrega.
*   **Crucial:** Sempre espere pela confirmação de sucesso e para o LED do dispositivo voltar a piscar antes de desconectar!

---

# FAQ

## Preciso de conexão com a internet ou serviço de celular para fazer o flash do firmware?
Não. O ELRS Mobile oferece **Flashing 100% Offline**. Contanto que você tenha baixado previamente a versão do firmware através do Gerenciador de Firmware enquanto estava no Wi-Fi doméstico, o aplicativo pode montar e fazer o flash do firmware de forma dinâmica e completamente offline.

## O que são Perfis de Flashing e como os utilizo?
Perfis de Flashing permitem que você salve e alterne entre múltiplas configurações de flashing (por exemplo, "Meus Quads", "Padrão / Redefinição de Fábrica", "Race Spec"). Cada perfil armazena de forma segura sua própria binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains e intervalo de Wi-Fi auto-on.

Para usá-los:
1.  Toque no ícone **+** (Adicionar) ao lado do menu suspenso "Flashing Profile" no cartão **Opções de Configuração**.
2.  Nomeie seu novo perfil e personalize as configurações. As edições são salvas automaticamente de forma instantânea.
3.  Selecione qualquer perfil do menu suspenso para trocar automaticamente todos os parâmetros.
4.  Para excluir um perfil, selecione-o e toque no ícone de lixeira/excluir (é necessário ter pelo menos dois perfis para excluir um).

## Recebo um erro de "Espaço insuficiente" ao fazer o flash do meu receptor ESP8285.
Os chips ESP8285 (como os encontrados em muitas placas AIO) possuem apenas 1MB de armazenamento físico total. A atualização direta para um lançamento principal (como de 3.x para 4.x) via Wi-Fi pode ficar sem espaço de partição dupla porque o arquivo de entrada é muito grande para ser descompactado junto com o firmware atualmente em execução.

**Como corrigir:** Primeiro, faça o flash do seu receptor para uma versão intermediária (como **3.6.3**). Assim que estiver executando o firmware 3.6.3 mais leve, você terá espaço de partição suficiente para fazer o flash com sucesso para o seu 4.0 target desejado. Alternativamente, habilite o **Modo Expert** em Configurações, salve o binário compilado localmente e faça o flash manualmente via uma conexão Betaflight Passthrough com fio.

## Onde encontro o script Lua do ExpressLRS para o meu rádio?
O ELRS Mobile vem com o script Lua universal e agnóstico de versão embutido! Para obtê-lo:
1.  Vá para **Configurações** e ative o **Modo Expert**.
2.  Toque em **Exportar ELRS Lua Script**.
3.  Isso salva `elrs.lua` diretamente no armazenamento local do seu telefone. Ligue seu rádio e conecte-o ao seu telefone via USB, certifique-se de selecionar o modo "USB Storage" no seu rádio e transfira o arquivo para sua pasta `SCRIPTS/TOOLS` usando o gerenciador de arquivos do seu telefone.

**Nota:** Você precisa excluir quaisquer versões anteriores do script elrs.lua (ex: elrs_v2.lua, elrs_v3.lua, etc) do cartão SD do seu rádio antes de usar o novo script.

## E se um flash falhar e meu dispositivo ficar sem resposta?
Se seu dispositivo estiver sem resposta após um flash falho, você pode recuperá-lo facilmente:
1.  Mantenha o botão BOOT no dispositivo pressionado enquanto o conecta via USB para entrar no modo bootloader.
2.  Use um computador e o ELRS Web Flasher para fazer o re-flash do dispositivo através de uma conexão USB/UART com fio.
3.  Para dispositivos com capacidade Wi-Fi, você também pode manter o BOOT

**Nota:** Há um link de vídeo na Aba Recursos que mostra como fazer isso.

## Posso salvar o arquivo de firmware no meu telefone sem fazer o flash?
Sim. Ao ir para **Configurações** e habilitar o **Modo Expert**, você desbloqueia a capacidade de salvar o binário de firmware montado diretamente no armazenamento local do seu dispositivo móvel, em vez de fazer o flash imediatamente Over-The-Air (OTA).

Isso é especialmente útil se você quiser fazer o flash do dispositivo manualmente usando um programador de hardware dedicado (como um STLink ou adaptador FTDI).

## Estou recebendo um erro de "Target Mismatch". O que devo fazer?
Um erro de target mismatch ocorre quando o hardware target que você selecionou no aplicativo não corresponde ao target do firmware atualmente em execução no dispositivo.

Para evitar danos acidentais, o aplicativo irá avisá-lo se uma incompatibilidade for detectada. No entanto, se você tem certeza de que o target selecionado está correto (por exemplo, se você está convertendo um dispositivo para uma variante de firmware diferente ou corrigindo um flash incorreto anterior), você pode tocar em **FORCE FLASH** no diálogo de incompatibilidade para ignorar a verificação e prosseguir com o flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->