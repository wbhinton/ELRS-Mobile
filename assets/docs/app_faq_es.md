# Guía Paso a Paso

## Fase 1: Almacenamiento en Caché del Firmware
1. **Conéctate a Internet:** Asegúrate de que tu teléfono esté conectado a Internet (por ejemplo, red Wi-Fi doméstica o red móvil).
2. **Abrir el Gestor de Firmware:** Navega hasta el Gestor de Firmware en la aplicación.
3. **Descargar Versión:** Toca el icono de descarga junto a la versión de ExpressLRS deseada. Esto guarda de forma segura los objetivos de firmware y las definiciones de hardware requeridas en tu teléfono para un uso 100% offline.

## Fase 2: Conectando a tu Dispositivo
1. **Encender el Dispositivo:** Enciende tu Receptor (RX) o Transmisor (TX) ExpressLRS.
2. **Esperar al Hotspot:** Espera a que el dispositivo entre en modo Wi-Fi Hotspot (indicado por un LED que parpadea rápidamente).
3. **Conectar al Hotspot:** Conecta el Wi-Fi de tu teléfono a la red `ExpressLRS RX` o `ExpressLRS TX` usando la contraseña `expresslrs`.
* **Nota:** ELRS Mobile maneja de forma nativa el enrutamiento forzado, asegurando que tu teléfono no vuelva a 5G/LTE silenciosamente.

## Fase 3: Flasheo del Firmware
1. **Navegar a Flashear Dispositivo:** Desde el Panel principal, selecciona **Flashear Dispositivo**.
2. **Selección de Objetivo:** Utiliza los menús desplegables en cascada para seleccionar el proveedor y el objetivo de hardware específico.
3. **Selección de Versión:** Elige una versión de firmware disponible de tu repositorio offline.
4. **Configuración y Perfiles:** Elige o crea un **Perfil de Flasheo** (por ejemplo, "Mis Quads", "Race Spec") para cargar tus credenciales personalizadas. La aplicación persiste el Wi-Fi SSID, la Contraseña de Wi-Fi, la Frase de Enlace (Binding Phrase), el Dominio Regulador y los intervalos de Auto-Encendido en estos perfiles con nombre para que no tengas que volver a introducirlos al cambiar entre diferentes configuraciones.
5. **Compilar y Flashear:** Toca **FLASH**. El sistema parchea el binario con tus credenciales locales y lo sube.
* **Crucial:** ¡Espera siempre la confirmación de éxito y a que el LED del dispositivo reanude el parpadeo antes de desconectar!

---

# Preguntas Frecuentes

## ¿Necesito una conexión a internet o servicio celular para flashear el firmware?
No. ELRS Mobile cuenta con **Flasheo 100% Offline**. Siempre que hayas descargado previamente la versión de firmware a través del Gestor de Firmware mientras estabas conectado a la Wi-Fi de casa, la aplicación puede ensamblar y flashear el firmware dinámicamente de forma completamente offline.

## ¿Qué son los Perfiles de Flasheo y cómo los uso?
Los Perfiles de Flasheo te permiten guardar y alternar entre múltiples configuraciones de flasheo (por ejemplo, "Mis Quads", "Stock / Restablecimiento de Fábrica", "Race Spec"). Cada perfil almacena de forma segura su propia frase de enlace, Wi-Fi SSID, contraseña de Wi-Fi, dominios reguladores e intervalo de autoencendido de Wi-Fi.

Para usarlos:
1. Toca el icono **+** (Añadir) junto al menú desplegable "Perfil de Flasheo" en la tarjeta **Opciones de Configuración**.
2. Nombra tu nuevo perfil y personaliza la configuración. Las ediciones se guardan automáticamente al instante.
3. Selecciona cualquier perfil del menú desplegable para intercambiar automáticamente todos los parámetros.
4. Para eliminar un perfil, selecciónalo y toca el icono de la papelera/eliminar (debes tener al menos dos perfiles para poder eliminar uno).

## Recibo un error de "No hay suficiente espacio" al flashear mi receptor ESP8285.
Los chips ESP8285 (como los que se encuentran en muchas placas AIO) solo tienen 1MB de almacenamiento físico total. La actualización directa a una versión principal (como de 3.x a 4.x) a través de Wi-Fi puede quedarse sin espacio de doble partición porque el archivo entrante es demasiado grande para desempaquetarse junto con el firmware que se está ejecutando actualmente.

**Cómo solucionarlo:** Primero, flashea tu receptor a una versión intermedia (como **3.6.3**). Una vez que esté ejecutando el firmware 3.6.3, más ligero, tendrás suficiente espacio de partición para flashear con éxito a tu objetivo 4.0 deseado. Alternativamente, habilita el **Modo Experto** en Ajustes, guarda el binario construido localmente y flaséalo manualmente a través de una conexión Betaflight Passthrough cableada.

## ¿Dónde encuentro el script Lua de ExpressLRS para mi radio?
¡ELRS Mobile viene con el script Lua universal y agnóstico de versión incorporado! Para obtenerlo:
1. Ve a **Ajustes** y activa el **Modo Experto**.
2. Toca **Exportar Script Lua ELRS**.
3. Esto guarda `elrs.lua` directamente en el almacenamiento local de tu teléfono. Enciende tu radio y conéctala a tu teléfono mediante USB, asegúrate de seleccionar el modo "Almacenamiento USB" en tu radio y transfiere el archivo a tu carpeta `SCRIPTS/TOOLS` usando el gestor de archivos de tu teléfono.

**Nota:** Debes eliminar cualquier versión anterior del script elrs.lua (por ejemplo, elrs_v2.lua, elrs_v3.lua, etc.) de la tarjeta SD de tu radio antes de usar el nuevo script.

## ¿Qué sucede si un flasheo falla y mi dispositivo deja de responder?
Si tu dispositivo no responde después de un flasheo fallido, puedes recuperarlo fácilmente:
1. Mantén presionado el botón BOOT del dispositivo mientras lo conectas a través de USB para entrar en modo bootloader.
2. Usa una computadora y el ELRS Web Flasher para volver a flashear el dispositivo a través de una conexión USB/UART cableada.
3. Para dispositivos con capacidad Wi-Fi, también puedes mantener presionado el botón BOOT

**Nota:** Hay un enlace de video en la pestaña de Recursos que muestra cómo hacer esto.

## ¿Puedo guardar el archivo de firmware en mi teléfono sin flashearlo?
Sí. Al ir a **Ajustes** y habilitar el **Modo Experto**, desbloqueas la capacidad de guardar el binario de firmware ensamblado directamente en el almacenamiento local de tu dispositivo móvil en lugar de flashearlo inmediatamente Over-The-Air (OTA).

Esto es especialmente útil si deseas flashear el dispositivo manualmente usando un programador de hardware dedicado (como un STLink o un adaptador FTDI).

## Estoy recibiendo un error de "Target Mismatch". ¿Qué debo hacer?
Un error de "Target Mismatch" (Objetivo no Coincide) ocurre cuando el objetivo de hardware que seleccionaste en la aplicación no coincide con el objetivo del firmware que se está ejecutando actualmente en el dispositivo.

Para prevenir daños accidentales, la aplicación te advertirá si se detecta una discrepancia. Sin embargo, si estás seguro de que el objetivo seleccionado es correcto (por ejemplo, si estás convirtiendo un dispositivo a una variante de firmware diferente o corrigiendo un flasheo incorrecto anterior), puedes tocar **FORCE FLASH** en el cuadro de diálogo de discrepancia para anular la verificación y proceder con el flasheo.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->