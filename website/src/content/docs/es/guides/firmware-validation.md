---
title: "Herramientas de Validación de Firmware"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: es/firmware-validation
sidebar:
  order: 3
---

Esta guía detalla las herramientas internas utilizadas para validar la lógica de ensamblaje del firmware de la aplicación ELRS Mobile contra los binarios "Golden" oficiales.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Binarios de Ground Truth vs. Configurator</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Al realizar auditorías de validación, es posible que observes que los binarios generados por ELRS Mobile coinciden perfectamente con el **ExpressLRS Web Flasher** oficial, pero difieren ligeramente de los binarios construidos utilizando el **ExpressLRS Configurator (Python)** local.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Este es un comportamiento esperado. El analizador JSON de C++ interno del ESP32 ignora los espacios en blanco, lo que significa que ambos binarios se ejecutan de forma idéntica en el hardware a pesar de fallar una comparación estricta byte a byte de SHA256 debido a diferencias de minificación.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Ubicación:** `firmware_testing/scripts/dart/logic_validator.dart`

El Logic Validator es una herramienta de comparación de alto rendimiento a nivel de bit. Está diseñada para verificar que la lógica interna de parcheo y ensamblaje de ELRS Mobile refleje la lógica oficial de ExpressLRS.

### Características Clave
- **Análisis a Nivel de Bit**: Localiza fallas exactas en el desplazamiento de bits dentro de bytes discrepantes.
- **Selección Interactiva**: Lista todos los binarios encontrados en `firmware_testing/binaries/`.
- **Gestión de Memoria de Copia Cero**: Optimizada para un análisis de alta velocidad de archivos de firmware grandes.

### Cómo Usar
1. **Preparar Binarios**: Coloca los archivos `.bin` o `.gz` generados en `firmware_testing/binaries/`.
2. **Configurar y Ejecutar**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Ubicación:** `firmware_testing/scripts/python/audit_tool.py`

El Auditor es un script independiente, sin dependencias, destinado a la verificación de "Ground Truth". Analiza el bloque de configuración de 2704 bytes adjunto al final de cada imagen de firmware de ExpressLRS.

### Propósito
Verifica que los metadatos realmente flasheados al dispositivo (Product Name, Lua Name, Hardware Layout y Options) sean correctos, independientemente de cualquier diferencia de diseño en el código base del firmware.

### Cómo Usar
1. **Ejecutar directamente**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Flujo de Trabajo de Validación Cruzada de Binarios
Para asegurar que ELRS Mobile esté ensamblando el firmware correctamente, los desarrolladores deben realizar periódicamente una auditoría de validación cruzada contra un binario "Ground Truth" compilado en un PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Exportar Binario desde ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Habilita el **Modo Experto** en Ajustes, luego usa el botón **DESCARGAR BINARIO** en la pestaña Flasher después de configurar tu objetivo y opciones.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Generar Ground Truth para PC</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Compila el **mismo** objetivo y versión con opciones idénticas utilizando el ExpressLRS Configurator oficial en tu PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Ejecutar la Auditoría</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Coloca ambos binarios en <code>firmware_testing/binaries/</code> y ejecuta el script <code>audit_tool.py</code> para verificar una paridad perfecta de hardware y opciones.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->