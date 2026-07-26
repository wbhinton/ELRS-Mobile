---
title: "Arquitectura Técnica"
slug: es/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile no es solo un web-wrapper; es una implementación nativa en Dart de la cadena de compilación y configuración de ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Ensamblaje Unificado de Firmware</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    En lugar de depender de un compilador en la nube remoto, la aplicación construye dinámicamente los binarios localmente en tu dispositivo. Al flashear objetivos ESP32/ESP8285, el <code>FirmwareAssembler</code> ejecuta una secuencia precisa de modificación a nivel de bits:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extrae el firmware genérico base del archivo <code>firmware.zip</code> en caché.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Recorta el relleno base buscando la firma del byte mágico ESP <code>0xE9</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extrae los pinouts específicos del objetivo y la configuración de tiempo de ejecución de <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Empaqueta por bytes el Nombre del Producto (128b), Nombre Lua (16b), <code>options.json</code> (512b), y <code>hardware.json</code> (2048b) directamente en el flujo binario.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Comprime la carga útil final en un flujo <code>.gz</code> si es requerido por la plataforma de destino (por ejemplo, ESP8285 legacy).</p>
    </div>
  </div>
</div>

## Lógica Periférica

### Inyector de Dominio Regulatorio
La aplicación maneja con precisión las complejas diferencias entre las bandas de frecuencia. Para dispositivos de 900MHz/Banda Dual, inyecta activamente el dominio elegido (por ejemplo, FCC, EU868) en la carga útil JSON compilada. Para objetivos estándar de 2.4GHz, utiliza un indicador booleano para enrutar silenciosamente el proceso de extracción a las carpetas de firmware base estándar FCC/ o European LBT/ durante el ensamblaje.

### Caché y Sincronización de Firmware
El flasheo sin conexión es posible gracias a un sólido sistema de almacenamiento en caché local. Cuando un usuario descarga una versión a través del Administrador de Firmware, el `FirmwareCacheService` extrae el `firmware.zip` genérico y el `hardware.zip` específico del dispositivo directamente del ExpressLRS Artifactory. Estos archivos se gestionan y almacenan localmente en el dispositivo, asegurando que el ensamblaje y el flasheo puedan realizarse instantáneamente en el campo sin necesidad de una conexión a internet activa.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Vinculación de Red Nativa</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Los sistemas operativos móviles (especialmente Android e iOS) despriorizarán las conexiones Wi-Fi que carecen de acceso a internet, enrutando silenciosamente el tráfico a través de la red celular. Esto impide que las aplicaciones estándar lleguen al hardware ELRS en <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile resuelve esto a través del <code>NativeNetworkService</code>. Cuando se detecta una conexión de hardware, la aplicación invoca un <code>MethodChannel</code> específico de la plataforma para vincular todo el proceso Flutter a la interfaz Wi-Fi a nivel del kernel del sistema operativo. Esto asegura que todo el tráfico HTTP y mDNS se enrute correctamente al hardware, independientemente del estado celular.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->