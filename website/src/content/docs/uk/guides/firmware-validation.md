---
title: "Інструменти валідації прошивки"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Цей посібник детально описує внутрішні інструменти, що використовуються для перевірки логіки збірки прошивки програми ELRS Mobile проти офіційних "Золотих" бінарних файлів.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Ground Truth vs. Configurator Binaries</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Під час проведення перевірок ви можете помітити, що бінарні файли, згенеровані ELRS Mobile, ідеально збігаються з офіційним <strong>ExpressLRS Web Flasher</strong>, але дещо відрізняються від бінарних файлів, створених за допомогою локального <strong>ExpressLRS Configurator (Python)</strong>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Це очікувана поведінка. Внутрішній C++ JSON парсер ESP32 ігнорує пробіли, що означає, що обидва бінарні файли виконуються ідентично на апаратному рівні, незважаючи на те, що вони не проходять строге побайтове порівняння SHA256 через відмінності в мініфікації.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Розташування:** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator – це високопродуктивний інструмент для побітового порівняння. Він розроблений для перевірки того, що внутрішня логіка патчів та збірки ELRS Mobile відображає офіційну логіку ExpressLRS.

### Основні функції
- **Побітовий аналіз**: Точно визначає збої зі зміщенням бітів у відмінних байтах.
- **Інтерактивний вибір**: Перераховує всі бінарні файли, знайдені в `firmware_testing/binaries/`.
- **Керування пам'яттю без копіювання (Zero-Copy)**: Оптимізовано для високошвидкісного аналізу великих файлів прошивки.

### Як використовувати
1. **Підготуйте бінарні файли**: Розмістіть згенеровані фа��ли `.bin` або `.gz` у `firmware_testing/binaries/`.
2. **Налаштування та запуск**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Розташування:** `firmware_testing/scripts/python/audit_tool.py`

Auditor – це автономний скрипт без залежностей, призначений для перевірки "Ground Truth". Він аналізує 2704-байтовий блок конфігурації, доданий до кінця кожного образу прошивки ExpressLRS.

### Призначення
Він перевіряє, що метадані, фактично завантажені на пристрій (Product Name, Lua Name, Hardware Layout та Options), є правильними, незалежно від будь-яких відмінностей у компонуванні базового коду прошивки.

### Як використовувати
1. **Запустіть безпосередньо**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Робочий процес двійкової перехресної перевірки
Щоб переконатися, що ELRS Mobile правильно збирає прошивку, розробники повинні періодично проводити аудит перехресної перевірки проти "Ground Truth" бінарного файлу, скомпільованого на ПК.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Експорт бінарного файлу з ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Увімкніть <strong>Expert Mode</strong> у Налаштуваннях, потім використовуйте кнопку <strong>DOWNLOAD BINARY</strong> на вкладці Flasher після налаштування вашої цілі та опцій.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Згенеруйте PC Ground Truth</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Створіть <strong>точно таку ж</strong> ціль та версію з ідентичними опціями за допомогою офіційного ExpressLRS Configurator на вашому ПК.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Запустіть аудит</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Розмістіть обидва бінарні файли в `firmware_testing/binaries/` і запустіть скрипт `audit_tool.py`, щоб перевірити ідеальну відповідність апаратного забезпечення та опцій.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->