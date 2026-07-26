---
title: "Руководство по разработке"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: ru/development
sidebar:
  order: 2
---

Добро пожаловать в руководство по разработке ELRS Mobile! Этот проект представляет собой нативную реализацию Flutter конвейера компиляции и прошивки ExpressLRS, разработанную для работы полностью в автономном режиме.

## Предварительные требования
Чтобы внести свой вклад в этот проект, вам понадобятся следующие установленные инструменты:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Начало работы

1. **Клонируйте репозиторий**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Установите зависимости**:
   ```bash
   flutter pub get
   ```

3. **Запустите приложение**:
   ```bash
   # Для Android
   flutter run
   
   # Для iOS (требуется Mac и физическое устройство/симулятор)
   flutter run
   ```

---

## Архитектура проекта
Кодовая база следует структуре, ориентированной на функции, расположенной в `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Функции
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">Основная логика и пользовательский интерфейс для конвейера прошивки.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Обрабатывает загрузку и кэширование firmware из artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Пользовательский интерфейс для настройки пользовательских параметров, таких как Binding Phrases и WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Ядро
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Логика, специфичная для платформы, для привязки процессов к аппаратным точкам доступа.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Управление локальным кэшем и сохранение данных в SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Наблюдаемость, ориентированная на конфиденциальность (Sentry и Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Управление состоянием
Мы используем **Riverpod** для глобального управления состоянием и **Flutter Hooks** для локального состояния на уровне виджетов. Эта комбинация обеспечивает высокореактивный пользовательский интерфейс без шаблонного кода стандартных `StatefulWidgets`.

---

## Подробные обзоры

Для получения более подробной технической информации, пожалуйста, обратитесь к следующим руководствам:

- [**Техническая архитектура**](/guides/technical_architecture): Подробное описание `FirmwareAssembler` и нативного сетевого стека.
- [**Проверка прошивки**](/guides/firmware-validation): Как использовать инструменты Dart и Python для проверки целостности binary.

---

## Примечание о минификации JSON

При аудите binaries вы можете заметить небольшие byte-offsets по сравнению со стандартным Python Configurator. Это связано с **минификацией JSON**.

Python Configurator часто вс��авляет пробелы после двоеточий (например, `{"uid": [1,2,3]}`), в то время как ELRS Mobile генерирует плотный JSON (например, `{"uid":[1,2,3]}`). Оба функционально идентичны на аппаратном уровне, поскольку внутренний парсер ESP32 игнорирует этот whitespace.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->