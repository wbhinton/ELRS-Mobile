# Пошаговое руководство

## Фаза 1: Кэширование прошивки
1. **Подключитесь к Интернету:** Убедитесь, что ваш телефон подключен к интернету (например, к домашнему Wi-Fi или мобильной сети).
2. **Откройте Диспетчер прошивок:** Перейдите в Firmware Manager в приложении.
3. **Скачайте релиз:** Нажмите на значок загрузки рядом с нужным релизом ExpressLRS. Это безопасно кэширует необходимые firmware targets и hardware definitions на вашем телефоне для 100% использования в автономном режиме.

## Фаза 2: Подключение к вашему устройству
1. **Включите устройство:** Включите ваш ExpressLRS Receiver (RX) или Transmitter (TX).
2. **Дождитесь точки доступа:** Дождитесь, пока устройство войдет в Wi-Fi Hotspot Mode (о чем свидетельствует быстро мигающий LED).
3. **Подключитесь к точке доступа:** Подключите Wi-Fi вашего телефона к сети `ExpressLRS RX` или `ExpressLRS TX`, используя пароль `expresslrs`.
* **Примечание:** ELRS Mobile изначально обрабатывает forced routing, гарантируя, что ваш телефон не переключится незаметно обратно на 5G/LTE.

## Фаза 3: Прошивка устройства
1. **Перейдите к прошивке устройства:** С главного Dashboard выберите **Flash Device**.
2. **Выбор цели:** Используйте cascading dropdowns, чтобы выбрать vendor и специфическую hardware target.
3. **Выбор версии:** Выберите доступную firmware version из вашего offline repository.
4. **Конфигурация и профили:** Выберите или создайте **Flashing Profile** (например, "My Quads", "Race Spec"), чтобы загрузить ваши custom credentials. Приложение сохраняет Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain и Auto-On intervals в этих именованных профилях, чтобы вам не приходилось вводить их заново при переключении между различными setups.
5. **Сборка и прошивка:** Нажмите **FLASH**. Система patches binary вашими local credentials и uploads его.
* **Крайне важно:** Всегда дожидайтесь success confirmation и возобновления мигания device LED, прежде чем unplugging!

---

# Часто задаваемые вопросы

## Нужно ли мне подключение к интернету или сотовая связь для прошивки устройства?
Нет. ELRS Mobile поддерживает **100% Offline Flashing**. Пока вы ранее загрузили firmware version через Firmware Manager, находясь в домашней сети Wi-Fi, приложение может динамически собирать и прошивать firmware полностью offline.

## Что такое Flashing Profiles и как их использовать?
Flashing Profiles позволяют сохранять и переключаться между несколькими flashing configurations (например, "My Quads", "Stock / Factory Reset", "Race Spec"). Каждый профиль безопасно хранит свою binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains и Wi-Fi auto-on interval.

Чтобы их использовать:
1. Нажмите на значок **+** (Add) рядом с выпадающим списком "Flashing Profile" в карточке **Configuration Options**.
2. Назовите свой новый профиль и customize the settings. Edits are auto-saved instantly.
3. Выберите любой профиль из выпадающего списка, чтобы автоматически swap all parameters.
4. Чтобы удалить профиль, выберите его и нажмите на значок корзины/удаления (для удаления профиля необходимо, чтобы у вас было как минимум два профиля).

## Я получаю ошибку "Not enough space" при прошивке моего приемника ESP8285.
Чипы ESP8285 (подобные тем, что используются на многих AIO boards) имеют только 1MB общего physical storage. Updating напрямую до major release (like from 3.x to 4.x) over Wi-Fi может привести к нехватке dual-partition space, потому что incoming file слишком велик для unpack alongside the currently running firmware.

**Как исправить:** Сначала прошейте ваш receiver до intermediate version (например, **3.6.3**). Как только он будет работать на leaner 3.6.3 firmware, у вас будет достаточно partition space для успешной прошивки до желаемой 4.0 target. Альтернативно, включите **Expert Mode** в Settings, сохраните built binary локально и прошейте его manually via wired Betaflight Passthrough connection.

## Где мне найти ExpressLRS Lua script для моего радио?
ELRS Mobile поставляется с универсальным, version-agnostic Lua script, встроенным прямо в него! Чтобы его получить:
1. Перейдите в **Settings** и toggle on **Expert Mode**.
2. Нажмите **Export ELRS Lua Script**.
3. Это сохранит `elrs.lua` непо��редственно в local storage вашего телефона. Включите свое радио и подключите его к телефону через USB, убедитесь, что вы выбрали "USB Storage" mode на вашем радио, и передайте файл в вашу папку `SCRIPTS/TOOLS`, используя file manager вашего телефона.

**Примечание:** Вам необходимо удалить все предыдущие версии elrs.lua script (например, elrs_v2.lua, elrs_v3.lua, etc) с SD card вашего радио перед использованием нового script.

## Что делать, если прошивка не удалась, и мое устройство перестало отвечать?
Если ваше устройство unresponsive после failed flash, вы можете легко recover его:
1. Удерживайте BOOT button на устройстве, подключая его через USB, чтобы войти в bootloader mode.
2. Используйте компьютер и ELRS Web Flasher для re-flash устройства over wired USB/UART connection.
3. Для Wi-Fi-capable devices, вы также можете удерживать BOOT

**Примечание:** На вкладке Resources Tab есть video link, которое shows how to do this.

## Могу ли я сохранить файл прошивки на свой телефон, не прошивая его?
Да. Перейдя в **Settings** и включив **Expert Mode**, вы разблокируете возможность сохранять assembled firmware binary непосредственно в local storage вашего мобильного устройства вместо немедленной прошивки Over-The-Air (OTA).

Это особенно полезно, если вы хотите прошить устройство manually using dedicated hardware programmer (like an STLink или FTDI adapter).

## Я получаю ошибку "Target Mismatch". Что мне делать?
Ошибка Target Mismatch возникает, когда hardware target, которую вы выбрали в приложении, не соответствует target прошивки, текущей работающей на устройстве.

Чтобы предотвратить accidental damage, приложение предупредит вас, если mismatch обнаружен. Однако, если вы уверены, что выбранная target верна (например, если вы converting device to different firmware variant или correcting previous incorrect flash), вы можете нажать **FORCE FLASH** в mismatch dialog, чтобы override the check и proceed with the flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->