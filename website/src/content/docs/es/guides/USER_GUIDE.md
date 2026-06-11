---
title: "Guía del Usuario"
slug: user_guide
sidebar:
  order: 1
---

## Resumen
Esta aplicación proporciona una interfaz móvil completa para gestionar hardware ExpressLRS. Permite a los usuarios configurar los parámetros del receptor (RX) y del transmisor (TX), mapear las salidas PWM y flashear actualizaciones de firmware directamente desde un dispositivo móvil.

---

## Instalación

### Tiendas de Aplicaciones Oficiales

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Instalar desde Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Consíguelo en Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Instalar desde la App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Descargar en App Store</a>

### Instalación Alternativa

#### GitHub Store
Ideal para usuarios que prefieren una experiencia de tienda de aplicaciones alternativa.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Descargar en GitHub Store</a>

### Instalación Manual
Para usuarios avanzados o aquellos que prefieren la gestión manual, visite nuestra página de [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) para obtener los últimos archivos `.apk`.

---

## 🚀 Inicio Rápido: Flasheando Tu Primer Dispositivo

### Fase 1: Caché de Firmware (Haz esto en casa)
1. Abre la aplicación y navega al **Administrador de Firmware**.
2. Toca el icono de descarga junto a la última versión estable.
3. La aplicación descargará y almacenará de forma segura las definiciones de target y hardware requeridas para uso sin conexión.

### Fase 2: Conectando a Tu Dispositivo
1. Enciende tu receptor (RX) o transmisor (TX) ExpressLRS.
2. Espera 60 segundos (o tu intervalo configurado) para que el dispositivo entre en modo de punto de acceso Wi-Fi (LED parpadeando rápidamente).
3. Conecta el Wi-Fi de tu teléfono a la red **ExpressLRS RX** o **ExpressLRS TX** (Contraseña: `expresslrs`).
4. Abre la aplicación. El Dashboard escaneará automáticamente la red usando mDNS y se conectará al dispositivo.

### Fase 3: Flasheando Firmware
1. Desde el Dashboard, selecciona **Flashear Dispositivo**.
2. **Selecciona tu Hardware:** Usa los menús desplegables en cascada para seleccionar tu Tipo de Dispositivo, Proveedor, Frecuencia y Target.
3. **Configura Opciones:** Establece tu Binding Phrase personalizado, credenciales de Wi-Fi y Dominio Regulatorio.
4. Toca **FLASH**. La aplicación ensamblará el binario localmente y lo enviará al dispositivo.

---

## Detalles Técnicos

### Conectividad y Detección
La aplicación utiliza una secuencia de detección robusta de múltiples etapas para encontrar tu hardware:
1. **Resolución mDNS**: El método principal. La aplicación busca `elrs_rx.local` o `elrs_tx.local`.
2. **Respaldo de AP Estático**: Si mDNS está bloqueado, la aplicación verifica la IP oficial del punto de acceso ELRS (`10.0.0.1`).
3. **Anulación Manual de IP**: Para redes complejas, puedes ingresar manualmente una dirección IP en la Configuración.

**Enlace Forzado de Red**: Los smartphones modernos a menudo descartan las conexiones Wi-Fi sin internet. ELRS Mobile incluye una capa nativa de "Enrutamiento Forzado" que obliga al sistema operativo a mantener la conexión con el hardware, asegurando una detección 100% fiable en el campo.

---

## Modo Experto y Auditoría
Dentro del menú de Configuración, los usuarios pueden habilitar el **Modo Experto**. Esto te permite guardar el binario de firmware ensamblado directamente en tu dispositivo para auditorías o flasheo manual a través de FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Manejo de Hardware STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Aunque ELRS Mobile puede ensamblar y parchear firmware para targets STM32 (hasta ELRS v3.x), estos dispositivos no soportan el flasheo Over-The-Air (OTA) vía Wi-Fi. Si seleccionas un target STM32, la aplicación te permitirá construir y guardar el binario localmente para que puedas flashearlo manualmente usando una PC vía STLink o Betaflight Passthrough.
  </p>
</div>

Para desarrolladores que buscan verificar la integridad de estos binarios, consulta nuestra [**Guía de Validación de Firmware**](/guides/firmware-validation).

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->