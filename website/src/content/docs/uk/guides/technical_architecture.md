---
title: "Технічна архітектура"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile — це не просто веб-оболонка; це нативна реалізація на Dart конвеєра компіляції та конфігурації ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Уніфікована збірка прошивки</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Замість того, щоб покладатися на віддалений хмарний компілятор, застосунок динамічно створює бінарні файли локально на вашому пристрої. Під час прошивки цілей ESP32/ESP8285, <code>FirmwareAssembler</code> виконує точну послідовність модифікацій на бітовому рівні:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Витягує базову універсальну прошивку з кешованого архіву <code>firmware.zip</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Обрізає базове доповнення, шукаючи сигнатуру магічного байта ESP <code>0xE9</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Витягує специфічні розпіновки цілі та конфігурацію під час виконання з <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Байтово пакує Назву Продукту (128b), Lua Назву (16b), <code>options.json</code> (512b) та <code>hardware.json</code> (2048b) безпосередньо в бінарний потік.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Стискає кінцевий пакет у потік <code>.gz</code>, якщо це вимагається цільовою платформою (наприклад, ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Периферійна логіка

### Інжектор регулятивного домену
Застосунок точно обробляє складні відмінності між діапазонами частот. Для пристрої�� 900МГц/Dual-Band він активно вводить обраний вами домен (наприклад, FCC, EU868) у скомпільований JSON-пакет. Для стандартних цілей 2.4ГГц він використовує булевий прапорець для тихого направлення процесу вилучення до стандартних папок базової прошивки FCC/ або європейської LBT/ під час збірки.

### Кешування та синхронізація прошивки
Офлайн-прошивка стає можливою завдяки надійній локальній системі кешування. Коли користувач завантажує випуск через Firmware Manager, <code>FirmwareCacheService</code> завантажує універсальний <code>firmware.zip</code> та специфічний для пристрою <code>hardware.zip</code> безпосередньо з ExpressLRS Artifactory. Ці архіви керуються та зберігаються локально на пристрої, забезпечуючи миттєву збірку та прошивку в польових умовах без активного підключ��ння до Інтернету.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,1,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Нативна прив'язка до мережі</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Мобільні операційні системи (особливо Android та iOS) знижують пріоритет Wi-Fi з'єднань, які не мають доступу до Інтернету, тихо перенаправляючи трафік через мобільну мережу. Це перешкоджає стандартним застосункам досягати обладнання ELRS за адресою <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile вирішує цю проблему за допомогою <code>NativeNetworkService</code>. Коли виявляється апаратне підключення, застосунок викликає платформо-специфічний <code>MethodChannel</code>, щоб прив'язати весь процес Flutter до інтерфейсу Wi-Fi на рівні ядра ОС. Це забезпечує правильне спрямування всього HTTP та mDNS трафіку до обладнання, незалежно від статусу мобільного зв'язку.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->