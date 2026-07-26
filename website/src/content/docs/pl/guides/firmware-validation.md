---
title: "Narzędzia walidacji oprogramowania układowego"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: pl/firmware-validation
sidebar:
  order: 3
---

Ten przewodnik szczegółowo opisuje wewnętrzne narzędzia używane do walidacji logiki montażu oprogramowania układowego aplikacji ELRS Mobile w oparciu o oficjalne „złote” binaria.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Prawda absolutna (Ground Truth) vs. Binaria Konfiguratora</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Podczas przeprowadzania audytów walidacji, możesz zauważyć, że binaria generowane przez ELRS Mobile idealnie pasują do oficjalnego **ExpressLRS Web Flasher**, ale nieznacznie różnią się od binariów zbudowanych przy użyciu lokalnego **ExpressLRS Configurator (Python)**.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Jest to oczekiwane zachowanie. Wewnętrzny parser C++ JSON układu ESP32 ignoruje białe znaki, co oznacza, że oba binaria wykonują się identycznie na sprzęcie, pomimo niepowodzenia w ścisłym porównaniu SHA256 bajt po bajcie z powodu różnic w minifikacji.
  </p>
</div>

---

## 1. Walidator Logiki ExpressLRS (Dart)
**Lokalizacja:** `firmware_testing/scripts/dart/logic_validator.dart`

Walidator Logiki to wysokowydajne narzędzie do porównywania na poziomie bitów. Został zaprojektowany, aby weryfikować, czy wewnętrzna logika łatania i montażu ELRS Mobile odzwierciedla oficjalną logikę ExpressLRS.

### Kluczowe Funkcje
- **Analiza na Poziomie Bitów**: Wskazuje dokładne błędy przesunięcia bitów w rozbieżnych bajtach.
- **Interaktywny Wybór**: Wyświetla wszystkie binaria znalezione w `firmware_testing/binaries/`.
- **Zarządzanie Pamięcią bez Kopiowania (Zero-Copy)**: Zoptymalizowane pod kątem szybkiej analizy dużych plików oprogramowania układowego.

### Jak Używać
1. **Przygotuj Binaria**: Umieść wygenerowane pliki `.bin` lub `.gz` w `firmware_testing/binaries/`.
2. **Konfiguracja i Uruchomienie**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Audytor Prawdy Absolutnej (Ground Truth Auditor) (Python)
**Lokalizacja:** `firmware_testing/scripts/python/audit_tool.py`

Audytor to samodzielny skrypt bez zależności, przeznaczony do weryfikacji „Prawdy Absolutnej” (Ground Truth). Analizuje 2704-bajtowy blok konfiguracji dołączony na końcu każdego obrazu oprogramowania układowego ExpressLRS.

### Cel
Weryfikuje, czy metadane faktycznie wgrane do urządzenia (Nazwa Produktu, Nazwa Lua, Układ Sprzętowy i Opcje) są poprawne, niezależnie od różnic w układzie podstawowego kodu oprogramowania układowego.

### Jak Używać
1. **Uruchom bezpośrednio**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Proces Walidacji Krzyżowej Binariów
Aby upewnić się, że ELRS Mobile poprawnie składa oprogramowanie układowe, deweloperzy powinni okresowo przeprowadzać audyt walidacji krzyżowej w stosunku do binarnego pliku „Ground Truth” skompilowanego na komputerze PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Eksportuj Plik Binarny z ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Włącz **Tryb Eksperta** w Ustawieniach, a następnie użyj przycisku **POBIERZ BINARNY** w zakładce Flasher po skonfigurowaniu celu i opcji.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Generuj „Prawdę Absolutną” (Ground Truth) na PC</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Zbuduj **dokładnie ten sam** cel i wersję z identycznymi opcjami, używając oficjalnego ExpressLRS Configurator na swoim komputerze PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Uruchom Audyt</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Umieść oba binaria w <code>firmware_testing/binaries/</code> i uruchom skrypt <code>audit_tool.py</code>, aby zweryfikować idealną zgodność sprzętu i opcji.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->