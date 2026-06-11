---
title: "Guía de desarrollo"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: development
sidebar:
  order: 2
---

¡Bienvenido a la guía de desarrollo de ELRS Mobile! Este proyecto es una implementación nativa en Flutter del pipeline de compilación y flasheo de ExpressLRS, diseñado para funcionar completamente sin conexión.

## Requisitos Previos
Para contribuir a este proyecto, necesitarás las siguientes herramientas instaladas:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Estable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Primeros Pasos

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**:
   ```bash
   # Para Android
   flutter run
   
   # Para iOS (requiere una Mac y un dispositivo físico/simulador)
   flutter run
   ```

---

## Arquitectura del Proyecto
El código base sigue una estructura centrada en características, ubicada en `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Características
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">La lógica central y la interfaz de usuario para el pipeline de flashing.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Gestiona la descarga y el almacenamiento en caché del firmware desde el artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Interfaz de usuario para configurar opciones de usuario como Binding Phrases y WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Núcleo
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Lógica específica de la plataforma para la vinculación de procesos a puntos de acceso de hardware.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Gestión de caché local y persistencia de SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Observabilidad centrada en la privacidad (Sentry y Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Gestión de Estado
Utilizamos **Riverpod** para la gestión de estado global y **Flutter Hooks** para el estado local a nivel de widget. Esta combinación asegura una interfaz de usuario altamente reactiva sin la sobrecarga de los `StatefulWidgets` estándar.

---

## Análisis Detallado

Para obtener información técnica más detallada, consulta las siguientes guías:

- [**Arquitectura Técnica**](/guides/technical_architecture): Un análisis detallado del `FirmwareAssembler` y la pila de red nativa.
- [**Validación de Firmware**](/guides/firmware-validation): Cómo usar las herramientas de Dart y Python para verificar la integridad binaria.

---

## Nota sobre la Minificación de JSON

Al auditar binarios, podrías notar ligeras diferencias de bytes en comparación con el Python Configurator estándar. Esto se debe a la **minificación de JSON**.

El Python Configurator a menudo inyecta espacios después de los dos puntos (por ejemplo, `{"uid": [1,2,3]}`), mientras que ELRS Mobile genera JSON denso (por ejemplo, `{"uid":[1,2,3]}`). Ambos son funcionalmente idénticos en el hardware, ya que el analizador interno del ESP32 ignora estos espacios en blanco.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->