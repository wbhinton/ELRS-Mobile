---
title: "Especificación Técnica"
slug: es/technical_spec
sidebar:
  order: 5
---

## Visión General de la Arquitectura

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Principio de Diseño</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    La aplicación está construida usando Flutter y aprovecha el marco de gestión de estado <strong>Riverpod</strong>. Interactúa con el hardware de ELRS a través de una API RESTful expuesta por el módulo WiFi integrado del dispositivo, asegurando una comunicación de baja latencia y una sincronización de estado en tiempo real.
  </p>
</div>

## Capa de Datos

### Puntos de Conexión de la API
El sistema se comunica con el hardware utilizando los siguientes puntos de conexión HTTP:

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `GET` | `/config` | Recupera la configuración actual del dispositivo en formato JSON. |
| `POST` | `/options.json` | Actualiza las opciones de tiempo de ejecución modificables (SSID, Contraseña, etc.). |
| `POST` | `/config` | Actualiza los parámetros de hardware principales y las asignaciones PWM. |
| `POST` | `/reboot` | Activa un reinicio de hardware para aplicar los cambios. |

### Esquema JSON
El modelo `RuntimeConfig` aprovecha la estructura de ELRS 4.x, que separa los parámetros en tres nodos principales:
- `settings`: Identificadores de hardware de solo lectura y cadenas de versión.
- `options`: Preferencias de usuario modificables y credenciales de red.
- `config`: Configuraciones de hardware de bajo nivel (Protocolos, Arrays PWM).

Ejemplo de estructura JSON:
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

## Gestión de Estado
El sistema emplea una arquitectura reactiva:
- **`ConfigViewModel`**: Gestiona el estado de conexión en vivo, la lógica de latido (heartbeat) y el descubrimiento de IP.
- **`FlashingController`**: Orquesta las descargas de firmware, la aplicación de parches binarios locales y el proceso de carga XH-over-HTTP.

## Capa de Mapeo
`ElrsMappings.domains900` mapea el índice de dominio regulatorio de 900 MHz utilizado en la API a su etiqueta legible por humanos:

| ID | Etiqueta | Descripción |
| :--- | :--- | :--- |
| 0 | AU915 | Australia/Nueva Zelanda 915MHz |
| 1 | FCC915 | Norteamérica 915MHz |
| 2 | EU868 | Europa 868MHz |
| 3 | IN866 | India 866MHz |
| 4 | AU433 | Australia 433MHz |
| 5 | EU433 | Europa 433MHz |
| 6 | US433 | Norteamérica 433MHz |
| 7 | US433-Wide | Norteamérica Ancho 433MHz |


## Capa de Persistencia
El sistema implementa una estrategia de persistencia de doble capa:
- **`SharedPreferences`**: Utilizado a través de `PersistenceService` para datos no sensibles como los WiFi SSIDs y las preferencias generales de la aplicación.
- **`FlutterSecureStorage`**: Utilizado para datos sensibles, incluyendo frases de enlace (Binding Phrases) y contraseñas WiFi, asegurando el cifrado a nivel del sistema operativo.

<!-- source_hash: 0bd5ffd19bfb551d01661ad0365af7b5 -->