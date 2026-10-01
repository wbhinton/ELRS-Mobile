---
title: "Especificação Técnica"
slug: pt/technical_spec
sidebar:
  order: 5
---

## Visão Geral da Arquitetura

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Princípio de Design</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    O aplicativo é construído usando Flutter e aproveita o framework de gerenciamento de estado **Riverpod**. Ele interage com o hardware ELRS via uma API RESTful exposta pelo módulo WiFi integrado do dispositivo, garantindo comunicação de baixa latência e sincronização de estado em tempo real.
  </p>
</div>

## Camada de Dados

### Endpoints da API
O sistema se comunica com o hardware usando os seguintes endpoints HTTP:

| Método | Endpoint | Descrição |
| :--- | :--- | :--- |
| `GET` | `/config` | Recupera a configuração atual do dispositivo em formato JSON. |
| `POST` | `/options.json` | Atualiza opções de tempo de execução modificáveis (SSID, Password, etc.). |
| `POST` | `/config` | Atualiza parâmetros de hardware essenciais e mapeamentos PWM. |
| `POST` | `/reboot` | Aciona um reset de hardware para aplicar as mudanças. |

### Esquema JSON
O modelo `RuntimeConfig` aproveita a estrutura ExpressLRS 4.x, que separa os parâmetros em três nós principais:
- `settings`: Identificadores de hardware e strings de versão somente leitura.
- `options`: Preferências do usuário modificáveis e credenciais de rede.
- `config`: Configurações de hardware de baixo nível (Protocolos, Arrays PWM).

Exemplo de estrutura JSON:
```json
{
  "product_name": "Test RX",
  "settings": {
    "version": "1.0.0",
    "module-type": "RX"
  },
  "options": {
    "bindPhrase": "example",
    "wifi-ssid": "SSID",
    "domain": 1
  },
  "config": {
    "serial-protocol": 0,
    "pwm": [
      {"channel": 0, "mode": 5}
    ]
  }
}
```

## Gerenciamento de Estado
O sistema emprega uma arquitetura reativa:
- **`ConfigViewModel`**: Gerencia o estado da conexão em tempo real, lógica de heartbeat e descoberta de IP.
- **`FlashingController`**: Orquestra downloads de firmware, patch binário local e o processo de upload XH-over-HTTP.

## Camada de Mapeamento
`ElrsMappings.domains900` mapeia o índice do domínio regulatório de 900 MHz usado na API para seu rótulo legível por humanos:

| ID | Rótulo | Descrição |
| :--- | :--- | :--- |
| 0 | AU915 | Austrália/Nova Zelândia 915MHz |
| 1 | FCC915 | América do Norte 915MHz |
| 2 | EU868 | Europeu 868MHz |
| 3 | IN866 | Indiano 866MHz |
| 4 | AU433 | Austrália 433MHz |
| 5 | EU433 | Europeu 433MHz |
| 6 | US433 | América do Norte 433MHz |
| 7 | US433-Wide | América do Norte Ampla 433MHz |


## Camada de Persistência
O sistema implementa uma estratégia de persistência de duas camadas:
- **`SharedPreferences`**: Utilizado via `PersistenceService` para dados não sensíveis, como SSIDs WiFi e preferências gerais do aplicativo.
- **`FlutterSecureStorage`**: Usado para dados sensíveis, incluindo Binding Phrases e Senhas WiFi, garantindo criptografia no nível do sistema operacional.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->