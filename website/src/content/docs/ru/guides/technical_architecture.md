---
title: "Техническая архитектура"
slug: ru/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile — это не просто web-wrapper; это нативная реализация Dart для конвейера компиляции и конфигурации ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Единая сборка прошивки</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Вместо того чтобы полагаться на удаленный облачный компилятор, приложение динамически собирает бинарные файлы локально на вашем устройстве. При прошивке ESP32/ESP8285 устройств <code>FirmwareAssembler</code> выполняет точную последовательность модификаций на битовом уровне:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Извлекает базовую универсальную прошивку из кэшированного архива <code>firmware.zip</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Обрезает базовое заполнение путем поиска сигнатуры магического байта ESP <code>0xE9</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Извлекает специфичные для целевого устройства распиновки и конфигурацию времени выполнения из <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Упаковывает в байты Product Name (128b), Lua Name (16b), <code>options.json</code> (512b) и <code>hardware.json</code> (2048b) непосредственно в бинарный поток.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Сжимает конечную полезную нагрузку в поток <code>.gz</code>, если это требуется целевой платформой (например, ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Периферийная логика

### Инжектор регуляторного домена
Приложение точно обрабатывает сложные различия между частотными диапазонами. Для устройств 900MHz/Dual-Band оно активно внедряет выбранный вами домен (например, FCC, EU868) в скомпилированную полезную нагрузку JSON. Для стандартных целей 2.4GHz оно использует булевый флаг для скрытой маршрутизации процесса извлечения либо в папки базовой прошивки стандартного FCC/, либо европейского LBT/ во время сборки.

### Кэширование и синхронизация прошивки
Автономная прошивка становится возможной благодаря надежной локальной системе кэширования. Когда пользователь загружает релиз через Firmware Manager, `FirmwareCacheService` извлекает универсальный `firmware.zip` и специфичный для устройства `hardware.zip` непосредственно из ExpressLRS Artifactory. Эти архивы управляются и хранятся локально на устройстве, обеспечивая мгновенную сборку и прошивку в полевых условиях без активного подключения к Интернету.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,1,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Нативная привязка к сети</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Мобильные операционные системы (особенно Android и iOS) снижают приоритет Wi-Fi соединений, не имеющих доступа к Интернету, безмолвно перенаправляя трафик через сотовую сеть. Это не позволяет стандартным приложениям достигать оборудования ELRS по адресу <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile решает эту проблему с помощью <code>NativeNetworkService</code>. Когда обнаруживается аппаратное соединение, приложение вызывает специфичный для платформы <code>MethodChannel</code> для привязки всего процесса Flutter к интерфейсу Wi-Fi на уровне ядра ОС. Это гарантирует, что весь HTTP и mDNS трафик правильно маршрутизируется к оборудованию, независимо от состояния сотовой связи.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->