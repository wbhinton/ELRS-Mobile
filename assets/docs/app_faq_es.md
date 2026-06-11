# Guía

## Fase 1: Almacenar Firmware en Caché
1. **Conéctate a Internet:** Asegúrate de que tu teléfono esté conectado a Internet (por ejemplo, Wi-Fi doméstico o red móvil).
2. **Abre el Gestor de Firmware:** Ve al Gestor de Firmware en la aplicación.
3. **Descarga la Versión:** Toca el icono de descarga junto a la versión de ExpressLRS deseada. Esto almacena de forma segura los objetivos de firmware y las definiciones de hardware requeridos en tu teléfono para un uso 100% offline.

## Fase 2: Conectarse a tu Dispositivo
1. **Enciende el Dispositivo:** Enciende tu Receptor ExpressLRS (RX) o Transmisor (TX).
2. **Espera el Hotspot:** Espera a que el dispositivo entre en modo Wi-Fi Hotspot (indicado por un LED parpadeante rápidamente).
3. **Conéctate al Hotspot:** Conecta el Wi-Fi de tu teléfono a la red `ExpressLRS RX` o `ExpressLRS TX` usando la contraseña `expresslrs`.
* **Nota:** ELRS Mobile gestiona de forma nativa el enrutamiento forzado, asegurando que tu teléfono no vuelva a cambiar silenciosamente a 5G/LTE.

## Fase 3: Flashear Firmware
1. **Navega a Flashear Dispositivo:** Desde el Panel de Control principal, selecciona **Flashear Dispositivo**.
2. **Selección de Objetivo:** Utiliza los menús desplegables en cascada para seleccionar el fabricante y el objetivo de hardware específico.
3. **Selección de Versión:** Elige una versión de firmware disponible de tu repositorio offline.
4. **Configuración:** Introduce tus credenciales personalizadas. La aplicación persiste el WiFi SSID, la WiFi Password y la Binding Phrase en el almacenamiento local para que no tengas que volver a introducirlas.
5. **Compilar y Flashear:** Toca **FLASH**. El sistema parchea el binario con tus credenciales locales y lo sube.
* **Crucial:** ¡Espera siempre la confirmación de éxito y a que el LED del dispositivo reanude su parpadeo antes de desconectarlo!

---

# Preguntas Frecuentes

## ¿Necesito una conexión a internet o servicio celular para flashear el firmware?
No. ELRS Mobile ofrece **Flasheo 100% Offline**. Siempre que hayas descargado previamente la versión de firmware a través del Gestor de Firmware mientras estabas conectado a tu Wi-Fi doméstico, la aplicación puede ensamblar y flashear dinámicamente el firmware completamente offline.

## Recibo un error de "Not enough space" al flashear mi receptor ESP8285.
Los chips ESP8285 (como los que se encuentran en muchas placas AIO) solo tienen 1MB de almacenamiento físico total. La actualización directa a una versión principal (como de 3.x a 4.x) a través de Wi-Fi puede agotar el espacio de doble partición porque el archivo entrante es demasiado grande para descomprimirse junto con el firmware que se está ejecutando actualmente.

**Cómo solucionarlo:** Primero, flashea tu receptor a una versión intermedia (como **3.6.3**). Una vez que esté ejecutando el firmware 3.6.3 más ligero, tendrás suficiente espacio de partición para flashear con éxito a tu objetivo 4.0 deseado. Alternativamente, habilita el **Modo Experto** en Ajustes, guarda el binario compilado localmente y flashea manualmente a través de una conexión Betaflight Passthrough cableada.

## ¿Dónde encuentro el script Lua de ExpressLRS para mi radio?
¡ELRS Mobile viene con el script Lua universal, agnóstico a la versión, incorporado! Para conseguirlo:
1. Ve a **Ajustes** y activa el **Modo Experto**.
2. Toca **Exportar Script Lua ELRS**.
3. Esto guarda `elrs.lua` directamente en el almacenamiento local de tu teléfono. Enciende tu radio y conéctala a tu teléfono mediante USB, asegúrate de seleccionar el modo "USB Storage" en tu radio y transfiere el archivo a tu carpeta `SCRIPTS/TOOLS` utilizando el gestor de archivos de tu teléfono.

**Nota:** Debes eliminar cualquier versión anterior del script elrs.lua (p. ej., elrs_v2.lua, elrs_v3.lua, etc.) de la tarjeta SD de tu radio antes de usar el nuevo script.

## ¿Qué pasa si un flasheo falla y mi dispositivo deja de responder?
Si tu dispositivo no responde después de un flasheo fallido, puedes recuperarlo fácilmente:
1. Mantén presionado el botón BOOT en el dispositivo mientras lo conectas a través de USB para entrar en modo bootloader.
2. Utiliza una computadora y el ELRS Web Flasher para volver a flashear el dispositivo a través de una conexión USB/UART cableada.
3. Para dispositivos con capacidad Wi-Fi, también puedes mantener presionado el BOOT

**Nota:** Hay un enlace a un video en la Pestaña de Recursos que muestra cómo hacerlo.

## ¿Puedo guardar el archivo de firmware en mi teléfono sin flashearlo?
Sí. Al ir a **Ajustes** y habilitar el **Modo Experto**, desbloqueas la capacidad de guardar el binario de firmware ensamblado directamente en el almacenamiento local de tu dispositivo móvil en lugar de flashearlo inmediatamente Over-The-Air (OTA).

Esto es especialmente útil si deseas flashear el dispositivo manualmente utilizando un programador de hardware dedicado (como un adaptador STLink o FTDI).

## Recibo un error de "Target Mismatch". ¿Qué debo hacer?
Un error de "Target Mismatch" ocurre cuando el objetivo de hardware que seleccionaste en la aplicación no coincide con el objetivo del firmware que se está ejecutando actualmente en el dispositivo.

Actualmente, la aplicación no soporta flashear un objetivo diferente al que se está ejecutando actualmente en el dispositivo.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->