---
title: "Guía del usuario"
slug: es/user_guide
sidebar:
  order: 1
---

## Resumen
Esta aplicación proporciona una interfaz móvil completa para la gestión de hardware ExpressLRS. Permite a los usuarios configurar parámetros de receptores (RX) y transmisores (TX), mapear salidas PWM y flashear actualizaciones de firmware directamente desde un dispositivo móvil.

---

## Instalación

### Tiendas de Aplicaciones Oficiales

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Instalar desde Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Descargar en Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Instalar desde la App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Descargar en App Store</a>

### Instalación Alternativa

#### GitHub Store
Ideal para usuarios que prefieren una experiencia de tienda de aplicaciones alternativa.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Descargar en GitHub Store</a>

### Instalación Manual
Para usuarios avanzados o aquellos que prefieren la gestión manual, visita nuestra página de [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) para obtener los últimos archivos `.apk`.

---

## 🚀 Inicio Rápido: Flashea Tu Primer Dispositivo

### Fase 1: Almacenamiento en caché del Firmware (Haz esto en casa)
1. Abre la aplicación y navega al **Firmware Manager**.
2. Toca el icono de descarga junto a la última versión estable.
3. La aplicación descargará y almacenará de forma segura las definiciones de target y hardware requeridas para su uso sin conexión.

### Fase 2: Conexión a tu Dispositivo
1. Enciende tu Receptor ExpressLRS (RX) o Transmisor (TX).
2. Espera 60 segundos (o tu intervalo configurado) para que el dispositivo entre en modo Wi-Fi Hotspot (LED parpadeando rápidamente).
3. Conecta el Wi-Fi de tu teléfono a la red **ExpressLRS RX** o **ExpressLRS TX** (Contraseña: `expresslrs`).
4. Abre la aplicación. El Dashboard escaneará automáticamente la red usando mDNS y se conectará al dispositivo.

### Fase 3: Flasheo del Firmware
1. Desde el Dashboard, selecciona **Flash Device**.
2. **Selecciona tu Hardware:** Utiliza los desplegables en cascada para seleccionar tu Device Type, Vendor, Frequency y Target.
3. **Configura Opciones y Perfiles:** Selecciona un **Flashing Profile** (o toca el botón **+** para añadir un nuevo perfil con nombre) para cargar tus credenciales. Personaliza la Binding Phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains y Wi-Fi auto-on interval.
4. Toca **FLASH**. La aplicación ensamblará el binary localmente y lo enviará al dispositivo.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Advertencia de Target Incompatible</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Si la aplicación detecta una incompatibilidad del target de hardware entre tu selección y el dispositivo conectado, te advertirá para evitar daños accidentales. Si estás seguro de tener el target correcto (por ejemplo, recuperándote de un flash incorrecto o migrando entre definiciones de target), haz clic en <strong>FORCE FLASH</strong> en el diálogo de advertencia para omitir la verificación.
  </p>
</div>

### 📋 Gestión de Perfiles de Flasheo
Si tienes múltiples drones o configuraciones de radio con diferentes requisitos de configuración (por ejemplo, diferentes binding phrases o regulatory domains), puedes usar **Flashing Profiles** con nombre para guardar y cambiar configuraciones:
* **Añadir un Perfil**: Toca el icono **+** junto al desplegable "Flashing Profile", escribe un nombre y pulsa Añadir.
* **Guardado Automático**: Cualquier cambio en las credenciales del perfil activo (binding phrase, SSID, password, domain o interval) se guarda automáticamente en tiempo real.
* **Cambiar Perfiles**: Simplemente selecciona un perfil del desplegable para cargar instantáneamente sus ajustes guardados.
* **Eliminar un Perfil**: Para limpiar, selecciona el perfil del desplegable y toca el icono de papelera/eliminar (debes tener al menos dos perfiles para eliminar uno).

---

## Detalles Técnicos

### Conectividad y Detección
La aplicación utiliza una secuencia robusta de detección en varias etapas para encontrar tu hardware:
1. **mDNS Resolution**: El método principal. La aplicación busca `elrs_rx.local` o `elrs_tx.local`.
2. **Static AP Fallback**: Si mDNS está bloqueado, la aplicación verifica la IP oficial del punto de acceso ELRS (`10.0.0.1`).
3. **Manual IP Override**: Para redes complejas, puedes introducir manualmente una dirección IP en Ajustes.

**Forced Network Binding**: Los smartphones modernos a menudo descartan las conexiones Wi-Fi sin internet. ELRS Mobile incluye una capa nativa de "Forced Routing" que obliga al sistema operativo a mantener la conexión de hardware, asegurando una detección 100% fiable en el campo.

---

## Modo Experto y Auditoría
Dentro del menú de Ajustes, los usuarios pueden habilitar el **Expert Mode**. Esto te permite guardar el firmware binary ensamblado directamente en tu dispositivo para auditoría o flasheo manual a través de FTDI.

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
    Aunque ELRS Mobile puede ensamblar y parchear firmware para targets STM32 (hasta ELRS v3.x), estos dispositivos no soportan el flasheo Over-The-Air (OTA) a través de Wi-Fi. Si seleccionas un target STM32, la aplicación te permitirá construir y guardar el binary localmente para que puedas flashearlo manualmente usando un PC a través de STLink o Betaflight Passthrough.
  </p>
</div>

Para los desarrolladores que buscan verificar la integridad de estos binaries, consulta nuestra [**Guía de Validación de Firmware**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->