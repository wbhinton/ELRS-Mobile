---
title: "Инструменты валидации прошивки"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: ru/firmware-validation
sidebar:
  order: 3
---

В этом руководстве подробно описаны внутренние инструменты, используемые для проверки логики сборки прошивки приложения ELRS Mobile на соответствие официальным «эталонным» бинарным файлам.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Эталонные бинарные файлы против бинарных файлов конфигуратора</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    При проведении аудитов проверки вы можете заметить, что бинарные файлы, сгенерированные ELRS Mobile, идеально соответствуют официальному <strong>ExpressLRS Web Flasher</strong>, но немного отличаются от бинарных файлов, созданных с использованием локального <strong>ExpressLRS Configurator (Python)</strong>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Это ожидаемое поведение. Внутренний C++ JSON парсер ESP32 игнорирует пробелы, что означае��, что оба бинарных файла выполняются на оборудовании идентично, несмотря на то, что они не проходят строгую побайтовую проверку SHA256 из-за различий в минификации.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Местоположение:** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator — это высокопроизводительный инструмент для побитового сравнения. Он разработан для проверки того, что внутренняя логика исправления и сборки ELRS Mobile соответствует официальной логике ExpressLRS.

### Ключевые особенности
- **Побитовый анализ**: Точно определяет сбои на уровне битов в отличающихся байтах.
- **Интерактивный выбор**: Перечисляет все бинарные файлы, найденные в `firmware_testing/binaries/`.
- **Управление памятью без копирования**: Оптимизировано для высокоскоростного анализа больших файлов прошивки.

### Как использовать
1. **Подготовьте бинарные файлы**: Поместите сгенерированные файлы `.bin` или `.gz` в `firmware_testing/binaries/`.
2. **Настройка и запуск**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Аудитор эталонных данных (Python)
**Местоположение:** `firmware_testing/scripts/python/audit_tool.py`

Аудитор — это автономный скрипт без зависимостей, предназначенный для проверки «эталонных данных». Он анализирует блок конфигурации размером 2704 байта, добавленный в конец каждого образа прошивки ExpressLRS.

### Назначение
Он проверяет, что метаданные, фактически прошитые в устройство (Product Name, Lua Name, Hardware Layout и Options), верны, независимо от любых различий в компоновке базового кода прошивки.

### Как использовать
1. **Запуск напрямую**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Рабочий процесс бинарной перекрестной проверки
Чтобы убедиться, что ELRS Mobile правильно собирает прошивку, разработчикам следует периодически проводить аудит перекрестной проверки на соответствие «эталонному» бинарному файлу, скомпилированному на ПК.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Экспорт бинарного файла из ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Включите <strong>Expert Mode</strong> в Settings, затем используйте кнопку <strong>DOWNLOAD BINARY</strong> на вкладке Flasher после настройки вашей цели и опций.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Генерация эталонных данных на ПК</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Соберите <strong>точно такую же</strong> цель и версию с идентичными опциями, используя официальный ExpressLRS Configurator на вашем ПК.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Запуск аудита</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Поместите оба бинарных файла в <code>firmware_testing/binaries/</code> и запустите скрипт <code>audit_tool.py</code>, чтобы проверить идеальное соответствие аппаратного обеспечения и опций.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->