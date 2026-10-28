---
title: "Guia do Usuário"
slug: pt/user_guide
sidebar:
  order: 1
---

O ELRS Mobile flasha e configura receptores (RX) e transmissores (TX) ExpressLRS do seu telefone, via Wi-Fi, sem laptop e sem conexão à internet no campo. Funciona com hardware baseado em ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) e firmware ExpressLRS 3.3.x e 4.x. Veja [Hardware Suportado](/supported_hardware) para cada dispositivo compatível.

O fluxo de trabalho tem duas partes: baixar o firmware enquanto você tem internet, depois fazer o flash em qualquer lugar.

---

## Instalação

| Plataforma | Onde obter |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone e iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, sem Google Play | [Download direto do APK](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), ou [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

As versões da loja são atualizadas através do Google Play e da App Store. O APK de download direto verifica se há uma nova versão uma vez por dia e oferece o download; você também pode verificar a qualquer momento em **Configurações → Sobre e Legal → Verificar Atualizações**, pular uma versão ou ser lembrado mais tarde. Suas configurações e perfis são mantidos ao instalar uma atualização.

Quer novos recursos antecipadamente? Participe do [beta do Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) ou do [beta do TestFlight](https://testflight.apple.com/join/jwU1WrpX).

No primeiro lançamento, o aplicativo exibe um breve aviso legal. Flashear firmware sempre acarreta algum risco para o seu hardware; aceite para continuar.

---

## Início rápido: flashando seu primeiro dispositivo

### Passo 1: Baixar firmware (em casa)

1.  No Painel, abra **Gerenciador de Firmware**.
2.  Toque no ícone de download ao lado da versão ExpressLRS que você deseja. Apenas as versões 3.3.0 e mais recentes são listadas: elas são as primeiras com o firmware unificado no qual o ELRS Mobile se baseia.
3.  Quando o download terminar, a versão mostrará **Pronto para uso offline**. O firmware e as definições de hardware necessárias agora estão armazenados no seu telefone.

Baixe o firmware no seu Wi-Fi doméstico ou dados móveis. Você não pode baixar enquanto seu telefone estiver conectado ao hotspot Wi-Fi de um receptor ou transmissor, porque essa rede não tem internet.

O cabeçalho mostra quantas versões você armazenou em relação ao seu limite. Altere o limite em **Configurações → Aplicativo e Armazenamento → Máx. Versões em Cache**, e exclua as versões que você não precisa mais.

### Passo 2: Conectar ao seu dispositivo

1.  Ligue seu receptor ou transmissor e espere que ele inicie seu hotspot Wi-Fi. Por padrão, isso acontece 60 segundos após ligar se ele não tiver se conectado ao seu parceiro. Transmissores também podem iniciar o Wi-Fi a partir do script Lua do ExpressLRS no seu rádio.
2.  No seu telefone, conecte-se à rede **ExpressLRS RX** ou **ExpressLRS TX**. A senha é `expresslrs`.
3.  Abra o ELRS Mobile. O Painel encontra o dispositivo automaticamente e mostra seu nome de produto, versão do firmware, target e domínio regulatório.

Se o Painel mostrar **Nenhum Dispositivo Encontrado**, toque em **Tentar Novamente**. Se o seu dispositivo estiver em uma rede diferente (por exemplo, conectado ao seu Wi-Fi doméstico), toque no ícone de engrenagem no cartão do dispositivo e insira seu endereço IP.

Dispositivos executando firmware anterior a 3.1 também são detectados, para que você possa atualizá-los para uma versão atual.

### Passo 3: Flashar

1.  No Painel, toque em **Flashar Dispositivo**.
2.  Verifique o target. O aplicativo pré-seleciona o target que corresponde ao dispositivo conectado quando possível; caso contrário, escolha Tipo de Dispositivo, Fornecedor do Dispositivo, Regulatório e Frequência, e Target do Dispositivo.
3.  Escolha a versão do firmware. As versões que você baixou são marcadas como **(Em Cache)**. Se o hardware precisar de uma versão mais nova do que você tem, o aplicativo informará e oferecerá o download de uma versão compatível.
4.  Verifique as opções do firmware: perfil de flash, binding phrase, rede Wi-Fi e senha, domínio regulatório e intervalo de ativação automática do Wi-Fi.
5.  Toque em **Flashar**.

A barra de progresso acompanha cada etapa: localizando e desempacotando seu firmware baixado, construindo-o com suas configurações, fazendo o upload e **Escrevendo no Dispositivo — Por Favor Aguarde** enquanto o dispositivo o instala e reinicia. Quando o dispositivo confirmar, você verá **Flashing Bem-sucedido! O Dispositivo está Reiniciando**, e o Painel se reconectará assim que ele voltar.

---

## Verificações de segurança

O aplicativo verifica suas escolhas antes de flashar e para se algo parecer errado.

:::danger[Chip incompatível]
Firmware para um chip nunca pode ser executado em outro (por exemplo, firmware ESP32 em um receptor ESP8285). O aplicativo bloqueia o flash e informa qual chip é cada um. Escolha um target para o chip do seu dispositivo.
:::

:::caution[Target incompatível]
Se o target selecionado não corresponder ao produto que o dispositivo reporta, você verá **Target Incompatível**. Verifique sua seleção primeiro. Se tiver certeza de que está correto (por exemplo, recuperando de um flash ruim ou mudando para uma definição de target mais recente), toque em **Forçar Flash**.
:::

:::note[Sem binding phrase]
Flashear sem uma binding phrase funciona, mas o dispositivo só se conectará usando a frase padrão (vazia). O aplicativo pergunta antes de continuar.
:::

:::caution[Flash não confirmado]
Se o dispositivo desconectar antes de confirmar o flash (perdeu energia, reiniciou ou a conexão Wi-Fi caiu), o aplicativo não consegue saber se a atualização foi concluída. Ele mostra um aviso âmbar em vez de relatar sucesso. Reconecte e verifique a versão do firmware no Painel; se não tiver mudado, flash novamente.
:::

---

## Perfis de flash

Um perfil de flash salva uma binding phrase, rede Wi-Fi doméstica e senha, domínios regulatórios padrão e intervalo de ativação automática do Wi-Fi sob um nome. Use um por frota ou configuração de rádio, e alterne entre eles com um toque.

Gerencie perfis em **Configurações → Perfis e Rede**:

-   **Adicionar:** toque em **+**, digite um nome e toque em **Adicionar**.
-   **Alternar:** escolha um perfil na lista **Perfil de Flash**. Também está disponível na tela de flash.
-   **Editar:** altere qualquer campo; o perfil ativo salva automaticamente.
-   **Excluir:** selecione o perfil e toque no ícone de exclusão. Você sempre mantém pelo menos um perfil.

Binding phrases e senhas de Wi-Fi são armazenadas no armazenamento seguro criptografado do seu telefone.

---

## Configuração do dispositivo

No Painel, toque em **Config. Dispositivo** para abrir a página de configurações ExpressLRS do dispositivo conectado dentro do aplicativo. Use-o para alterar configurações de Wi-Fi e binding, model match, protocolo serial, mapeamento de saída PWM e outras opções do dispositivo. O aplicativo mantém a página bloqueada ao seu dispositivo.

---

## Configurações

| Seção | O que há |
| :--- | :--- |
| Perfis e Rede | Perfis de flash, binding phrase, rede Wi-Fi doméstica e senha, domínios regulatórios padrão de 2.4 GHz e sub-GHz |
| Aplicativo e Armazenamento | Máx. versões em cache, Gerenciador de Firmware, limpar o cache do firmware, idioma do aplicativo, análise de uso anônima (ativada por padrão; desative com **Compartilhar Análise**) |
| Avançado e Depuração | Modo Especialista e suas ferramentas (abaixo) |
| Sobre e Legal | Versão do aplicativo, aviso legal e licença, apoiar o desenvolvimento e **Verificar Atualizações** no APK de download direto |

Altere o idioma do aplicativo nas Configurações ou no botão de idioma na barra superior. O ELRS Mobile está disponível em 18 idiomas.

---

## Modo Especialista

Ative **Configurações → Avançado e Depuração → Modo Especialista** para desbloquear:

-   **Targets STM32.** Hardware mais antigo baseado em STM32 não pode ser flashado via Wi-Fi, e apenas o ExpressLRS 3.3.x o suporta. O aplicativo constrói o firmware com suas configurações para que você possa flashá-lo de um PC com um STLink ou Betaflight passthrough.
-   **Baixar Binário.** Salve o arquivo de firmware construído em vez de flashá-lo, para flash manual ou auditoria.
-   **Exportar Script Lua ELRS.** Salve `elrs.lua` para rádios EdgeTX e OpenTX.
-   **Enviar Relatório de Depuração.** Envie informações do dispositivo e logs do aplicativo para ajudar a corrigir um bug. Binding phrases e senhas de Wi-Fi nunca são incluídas.

---

## Solução de problemas

**O Painel não consegue encontrar meu dispositivo.** Certifique-se de que seu telefone ainda esteja conectado à rede Wi-Fi do dispositivo; alguns telefones saem de redes que não têm internet. No Android, o ELRS Mobile mantém seu tráfego nessa rede Wi-Fi mesmo sem internet. Toque em **Tentar Novamente**, ou insira o endereço IP a partir do ícone de engrenagem (`10.0.0.1` no hotspot próprio do dispositivo).

**Não consigo baixar o firmware.** Desconecte-se do hotspot do dispositivo e use uma rede com internet.

**Meu dispositivo não responde após um flash falho.** Mantenha o botão BOOT pressionado enquanto o conecta via USB para entrar no modo bootloader, então faça o re-flash com o [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Dispositivos com capacidade Wi-Fi também podem ser recuperados mantendo o BOOT pressionado por 60 segundos para iniciar o hotspot Wi-Fi. A tela de **Ajuda e Suporte** no aplicativo tem esses passos, um FAQ e links para o Discord do ExpressLRS.

**Meus perfis desapareceram após a atualização.** A atualização direta da v1.0.43 ou anterior para a v1.0.45 ou mais recente não consegue transportar perfis salvos, binding phrases e configurações de Wi-Fi através de uma atualização de armazenamento. O aplicativo informa uma vez; re-insira-os nas Configurações.

---

Desenvolvedores podem verificar o firmware que o ELRS Mobile constrói com as [Ferramentas de Validação de Firmware](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->