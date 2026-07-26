---
title: "Посібник розробника"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: uk/development
sidebar:
  order: 2
---

Ласкаво просимо до посібника з розробки ELRS Mobile! Цей проєкт є нативною Flutter реалізацією конвеєра компіляції та прошивки ExpressLRS, розробленою для роботи повністю офлайн.

## Передумови
Щоб зробити внесок у цей проєкт, вам знадобляться встановлені наступні інструменти:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Початок роботи

1.  **Клонуйте репозиторій**:
    ```bash
    git clone https://github.com/wbhinton/ELRS-Mobile.git
    cd ELRS-Mobile
    ```

2.  **Встановіть залежності**:
    ```bash
    flutter pub get
    ```

3.  **Запустіть застосунок**:
    ```bash
    # Для Android
    flutter run
    
    # Для iOS (потрібен Mac та фізичний пристрій/симулятор)
    flutter run
    ```

---

## Архітектура проєкту
Кодова база дотримується структури, орієнтованої на функції, розташованої в `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Функції
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">Основна логіка та інтерфейс користувача для конвеєра прошивки.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Керує завантаженням та кешуванням прошивок з artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Інтерфейс користувача для встановлення користувацьких опцій, таких як Binding Phrases та WiFi.</span>
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
        <span class="text-xs text-text-muted/70">Платформно-специфічна логіка для прив'язки процесів до апаратних точок доступу.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Управління локальним кешем та збереженням даних у SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Observability з пріоритетом на конфіденційність (Sentry та Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Управління станом
Ми використовуємо **Riverpod** для глобального управління станом та **Flutter Hooks** для локального стану на рівні віджетів. Ця комбінація забезпечує високореактивний інтерфейс користувача без шаблонного коду стандартних `StatefulWidgets`.

---

## Поглиблені огляди

Для отримання більш детальної технічної інформації, будь ласка, зверніться до наступних посібників:

- [**Технічна архітектура**](/guides/technical_architecture): Детальний огляд `FirmwareAssembler` та нативного мережевого стека.
- [**Перевірка прошивки**](/guides/firmware-validation): Як використовувати інструменти Dart та Python для перевірки цілісності бінарних файлів.

---

## Примітка щодо мініфікації JSON

Під час аудиту бінарних файлів ви можете помітити невеликі зміщення байтів порівняно зі стандартним Python Configurator. Це пов'язано з **мініфікацією JSON**. 

Python Configurator часто вставляє пробіли після двокрапок (наприклад, `{"uid": [1,2,3]}`), тоді як ELRS Mobile генерує ��ільний JSON (наприклад, `{"uid":[1,2,3]}`). Обидва функціонально ідентичні на апаратному рівні, оскільки внутрішній парсер ESP32 ігнорує ці пробіли.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->