---
title: "Guía del Usuario"
slug: es/user_guide
sidebar:
  order: 1
---

ELRS Mobile flashea y configura receptores (RX) y transmisores (TX) de ExpressLRS desde tu teléfono, a través de Wi-Fi, sin necesidad de un portátil ni conexión a internet en el campo. Funciona con hardware basado en ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) y firmware ExpressLRS 3.3.x y 4.x. Consulta [Hardware compatible](/supported_hardware) para ver todos los dispositivos compatibles.

El flujo de trabajo tiene dos partes: descargar el firmware mientras tienes internet, luego flashear en cualquier lugar.

---

## Instalación

| Plataforma | Dónde conseguirlo |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone y iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, sin Google Play | [Descarga directa de APK](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), o [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Las versiones de la tienda se actualizan a través de Google Play y la App Store. El APK de descarga directa busca una nueva versión una vez al día y ofrece descargarla; también puedes verificarlo en cualquier momento desde **Ajustes → Acerca de y legal → Buscar actualizaciones**, omitir una versión o recibir un recordatorio más tarde. Tus ajustes y perfiles se conservan cuando instalas una actualización.

¿Quieres las nuevas funciones antes? Únete a la [beta de Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) o a la [beta de TestFlight](https://testflight.apple.com/join/jwU1WrpX).

En el primer inicio, la aplicación muestra una breve exención de responsabilidad. Flashear firmware siempre conlleva cierto riesgo para tu hardware; acéptalo para continuar.

---

## Inicio rápido: flashea tu primer dispositivo

### Paso 1: Descargar firmware (en casa)

1. En el Dashboard (Panel de control), abre el **Gestor de firmware**.
2. Toca el icono de descarga junto a la versión de ExpressLRS que desees. Solo se listan las versiones 3.3.0 y posteriores: son las primeras con el firmware unificado en el que se basa ELRS Mobile.
3. Cuando finaliza la descarga, la versión muestra **Listo para uso sin conexión**. El firmware y las definiciones de hardware que necesita ahora están almacenados en tu teléfono.

Descarga el firmware con tu Wi-Fi doméstico o datos móviles. No puedes descargar mientras tu teléfono está conectado al punto de acceso Wi-Fi de un receptor o transmisor, porque esa red no tiene internet.

El encabezado muestra cuántas versiones has almacenado en relación con tu límite. Cambia el límite en **Ajustes → Aplicación y Almacenamiento → Versiones máximas en caché**, y elimina las versiones que ya no necesites.

### Paso 2: Conectarse a tu dispositivo

1. Enciende tu receptor o transmisor y espera a que inicie su punto de acceso Wi-Fi. Por defecto, esto ocurre 60 segundos después de encenderlo si no se ha conectado a su compañero. Los transmisores también pueden iniciar Wi-Fi desde el script ExpressLRS Lua en tu radio.
2. En tu teléfono, únete a la red **ExpressLRS RX** o **ExpressLRS TX**. La contraseña es `expresslrs`.
3. Abre ELRS Mobile. El Dashboard encuentra el dispositivo automáticamente y muestra su nombre de producto, versión de firmware, objetivo y dominio regulatorio.

Si el Dashboard muestra **No se encontró ningún dispositivo**, toca **Reintentar**. Si tu dispositivo está en una red diferente (por ejemplo, conectado a tu Wi-Fi doméstico), toca el icono de engranaje en la tarjeta del dispositivo e introduce su dirección IP.

Los dispositivos que ejecutan firmware anterior a 3.1 también se detectan, para que puedas actualizarlos a una versión actual.

### Paso 3: Flashear

1. En el Dashboard, toca **Flashear dispositivo**.
2. Verifica el objetivo. La aplicación preselecciona el objetivo que coincide con el dispositivo conectado cuando es posible; de lo contrario, elige Tipo de dispositivo, Proveedor de dispositivo, Dominio regulatorio y Frecuencia, y Objetivo del dispositivo.
3. Elige la versión del firmware. Las versiones que has descargado están marcadas como **(En caché)**. Si el hardware necesita una versión más nueva de la que tienes, la aplicación lo indica y ofrece descargar una compatible.
4. Verifica las opciones del firmware: perfil de flasheo, frase de enlace (binding phrase), red Wi-Fi y contraseña, dominio regulatorio y el intervalo de activación automática de Wi-Fi.
5. Toca **Flashear**.

La barra de progreso sigue cada paso: localizando y descomprimiendo el firmware descargado, compilándolo con tus ajustes, subiéndolo, y **Escribiendo en el dispositivo — Espera** mientras el dispositivo lo instala y se reinicia. Cuando el dispositivo confirma, verás **¡Flasheo exitoso! El dispositivo se está reiniciando**, y el Dashboard se reconecta una vez que vuelve.

---

## Comprobaciones de seguridad

La aplicación verifica tus elecciones antes de flashear y se detiene si algo parece incorrecto.

:::danger[Chip incompatible]
El firmware para un chip nunca puede ejecutarse en otro (por ejemplo, firmware ESP32 en un receptor ESP8285). La aplicación bloquea el flasheo y te indica qué chip es cada uno. Elige un objetivo para el chip de tu dispositivo.
:::

:::caution[Desajuste de objetivo]
Si el objetivo seleccionado no coincide con el producto que informa el dispositivo, verás **Desajuste de objetivo**. Verifica tu selección primero. Si estás seguro de que es correcto (por ejemplo, recuperándote de un flasheo incorrecto o moviéndote a una definición de objetivo más nueva), toca **Flasheo forzado**.
:::

:::note[Sin frase de enlace]
Flashear sin una frase de enlace funciona, pero el dispositivo solo se enlazará usando la frase predeterminada (vacía). La aplicación te preguntará antes de continuar.
:::

:::caution[Flasheo no confirmado]
Si el dispositivo se desconecta antes de confirmar el flasheo (perdió energía, se reinició o la conexión Wi-Fi se cayó), la aplicación no puede saber si la actualización finalizó. Muestra una advertencia ámbar en lugar de informar éxito. Vuelve a conectar y verifica la versión del firmware en el Dashboard; si no ha cambiado, flashea de nuevo.
:::

---

## Perfiles de flasheo

Un perfil de flasheo guarda una frase de enlace (binding phrase), la red Wi-Fi doméstica y su contraseña, los dominios regulatorios predeterminados y el intervalo de activación automática de Wi-Fi bajo un nombre. Usa uno por flota o configuración de radio, y cámbiate entre ellos con un toque.

Gestiona los perfiles en **Ajustes → Perfiles y red**:

- **Añadir:** toca **+**, escribe un nombre y toca **Añadir**.
- **Cambiar:** elige un perfil de la lista **Perfil de flasheo**. También está disponible en la pantalla de flasheo.
- **Editar:** cambia cualquier campo; el perfil activo se guarda automáticamente.
- **Eliminar:** selecciona el perfil y toca el icono de eliminar. Siempre mantendrás al menos un perfil.

Las frases de enlace y las contraseñas de Wi-Fi se almacenan en el almacenamiento seguro cifrado de tu teléfono.

---

## Configuración del dispositivo

En el Dashboard, toca **Configuración del dispositivo** para abrir la página de ajustes de ExpressLRS del dispositivo conectado dentro de la aplicación. Úsala para cambiar los ajustes de Wi-Fi y enlace, la coincidencia de modelo (model match), el protocolo serie, el mapeo de salida PWM y otras opciones del dispositivo. La aplicación mantiene la página bloqueada a tu dispositivo.

---

## Ajustes

| Sección | Qué hay |
| :--- | :--- |
| Perfiles y red | Perfiles de flasheo, frase de enlace (binding phrase), red Wi-Fi doméstica y contraseña, dominios regulatorios predeterminados de 2.4 GHz y sub-GHz |
| Aplicación y almacenamiento | Versiones máximas en caché, Gestor de firmware, borrar la caché del firmware, idioma de la aplicación, análisis de uso anónimo (activado por defecto; desactívalo con **Compartir análisis**) |
| Avanzado y depuración | Modo experto y sus herramientas (abajo) |
| Acerca de y legal | Versión de la aplicación, aviso legal y licencia, apoyar el desarrollo y **Buscar actualizaciones** en el APK de descarga directa |

Cambia el idioma de la aplicación desde Ajustes o el botón de idioma en la barra superior. ELRS Mobile está disponible en 18 idiomas.

---

## Modo Experto

Activa **Ajustes → Avanzado y depuración → Modo experto** para desbloquear:

- **Objetivos STM32.** El hardware antiguo basado en STM32 no se puede flashear a través de Wi-Fi, y solo ExpressLRS 3.3.x lo soporta. La aplicación construye el firmware con tus ajustes para que puedas flashearlo desde un PC con un STLink o Betaflight passthrough.
- **Descargar Binario.** Guarda el archivo de firmware construido en lugar de flashearlo, para flasheo manual o auditoría.
- **Exportar script ELRS Lua.** Guarda `elrs.lua` para radios EdgeTX y OpenTX.
- **Enviar informe de depuración.** Envía información del dispositivo y registros de la aplicación para ayudar a solucionar un error. Las frases de enlace y las contraseñas de Wi-Fi nunca se incluyen.

---

## Solución de problemas

**El Dashboard no encuentra mi dispositivo.** Asegúrate de que tu teléfono sigue conectado a la red Wi-Fi del dispositivo; algunos teléfonos abandonan las redes que no tienen internet. En Android, ELRS Mobile mantiene su tráfico en esa red Wi-Fi incluso sin internet. Toca **Reintentar**, o introduce la dirección IP desde el icono de engranaje (`10.0.0.1` en el punto de acceso propio del dispositivo).

**No puedo descargar firmware.** Desconéctate del punto de acceso del dispositivo y usa una red con internet.

**Mi dispositivo no responde después de un flasheo fallido.** Mantén presionado el botón BOOT mientras lo conectas por USB para entrar en modo bootloader, luego vuelve a flashear con el [Flasheador Web de ExpressLRS](https://expresslrs.org/flasher). Los dispositivos con capacidad Wi-Fi también pueden recuperarse manteniendo presionado BOOT durante 60 segundos para iniciar el punto de acceso Wi-Fi. La pantalla de **Ayuda y Soporte** de la aplicación tiene estos pasos, una FAQ y enlaces al Discord de ExpressLRS.

**Mis perfiles desaparecieron después de actualizar.** Actualizar directamente de la v1.0.43 o anterior a la v1.0.45 o posterior no puede transferir los perfiles guardados, las frases de enlace y los ajustes de Wi-Fi a través de una actualización de almacenamiento. La aplicación te lo indicará una vez; vuelve a introducirlos en Ajustes.

---

Los desarrolladores pueden verificar el firmware que ELRS Mobile construye con las [Herramientas de validación de firmware](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->