---
title: Technical Architecture
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile is not just a web-wrapper; it is a native Dart implementation of the ExpressLRS compilation and configuration pipeline.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Unified Firmware Assembly</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Instead of relying on a remote cloud compiler, the app dynamically builds binaries locally on your device. When flashing ESP32/ESP8285 targets, the <code>FirmwareAssembler</code> executes a precise bit-level modification sequence:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extracts the base generic firmware from the cached <code>firmware.zip</code> archive.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Trims the base padding by seeking the ESP <code>0xE9</code> magic byte signature.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extracts specific target pinouts and runtime configuration from <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Byte-packs Product Name (128b), Lua Name (16b), <code>options.json</code> (512b), and <code>hardware.json</code> (2048b) directly into the binary stream.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Compresses the final payload into a <code>.gz</code> stream if required by the target platform (e.g. ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Peripheral Logic

### Regulatory Domain Injector
The app accurately handles the complex differences between frequency bands. For 900MHz/Dual-Band devices, it actively injects your chosen domain (e.g., FCC, EU868) into the compiled JSON payload. For standard 2.4GHz targets, it utilizes a boolean flag to silently route the extraction process to either the standard FCC/ or European LBT/ base firmware folders during assembly.

### Firmware Caching & Sync
Offline flashing is made possible through a robust local caching system. When a user downloads a release via the Firmware Manager, the `FirmwareCacheService` pulls the generic `firmware.zip` and device-specific `hardware.zip` directly from the ExpressLRS Artifactory. These archives are managed and stored locally on the device, ensuring assembly and flashing can occur instantly in the field without any active internet connection.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Native Network Binding</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Mobile operating systems (especially Android and iOS) will deprioritize Wi-Fi connections that lack internet access, silently routing traffic over cellular instead. This prevents standard apps from reaching ELRS hardware at <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile solves this via the <code>NativeNetworkService</code>. When a hardware connection is detected, the app invokes a platform-specific <code>MethodChannel</code> to bind the entire Flutter process to the Wi-Fi interface at the OS kernel level. This ensures all HTTP and mDNS traffic routes correctly to the hardware, regardless of cellular status.
  </p>
</div>
