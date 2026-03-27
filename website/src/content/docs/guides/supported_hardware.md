---
title: Supported Hardware
slug: supported_hardware
sidebar:
  order: 4
---

## Supported Platforms

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 my-8">
  <div class="p-5 rounded-2xl bg-primary/5 border border-primary/20 backdrop-blur-sm">
    <div class="flex items-center gap-2 mb-3 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm45.66,85.66-56,56a8,8,0,0,1-11.32,0l-24-24a8,8,0,0,1,11.32-11.32L112,148.69l50.34-50.35a8,8,0,0,1,11.32,11.32Z"></path></svg>
      <h3 class="text-lg font-bold m-0 italic">Supported</h3>
    </div>
    <ul class="space-y-2 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex gap-2"><span>•</span> All ESP8285, ESP32, ESP32-C3, and ESP32-S3 targets</li>
      <li class="flex gap-2"><span>•</span> Wi-Fi capable receivers and transmitters</li>
      <li class="flex gap-2"><span>•</span> ELRS Versions 2.x and 3.x</li>
    </ul>
  </div>
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-2 mb-3 text-white/70">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm37.66,130.34a8,8,0,0,1-11.32,11.32L128,139.31l-26.34,26.35a8,8,0,0,1-11.32-11.32L116.69,128,90.34,101.66a8,8,0,0,1,11.32-11.32L128,116.69l26.34-26.35a8,8,0,0,1,11.32,11.32L139.31,128Z"></path></svg>
      <h3 class="text-lg font-bold m-0 italic">Unsupported (WIP)</h3>
    </div>
    <ul class="space-y-2 text-sm text-text-muted/60 list-none pl-0 m-0">
      <li class="flex gap-2"><span>•</span> STM32 targets requiring serial STLink flashing</li>
      <li class="flex gap-2"><span>•</span> Betaflight Passthrough flashing methods</li>
      <li class="flex gap-2"><span>•</span> Direct USB/Serial connections on iOS</li>
    </ul>
  </div>
</div>

---

## Tested Hardware
The following hardware targets have been explicitly tested with ELRS Mobile:

<div class="grid grid-cols-1 sm:grid-cols-2 gap-2 my-6">
  <div class="flex items-center gap-2 p-3 rounded-xl bg-surface/40 border border-white/5 text-sm text-text-muted">
    <span class="w-1.5 h-1.5 rounded-full bg-primary/40"></span>
    BETAFPV SuperP 14Ch 900MHz RX
  </div>
  <div class="flex items-center gap-2 p-3 rounded-xl bg-surface/40 border border-white/5 text-sm text-text-muted">
    <span class="w-1.5 h-1.5 rounded-full bg-primary/40"></span>
    BETAFPV PWM 2.4GHz RX
  </div>
  <div class="flex items-center gap-2 p-3 rounded-xl bg-surface/40 border border-white/5 text-sm text-text-muted">
    <span class="w-1.5 h-1.5 rounded-full bg-primary/40"></span>
    BETAFPV SuperP 14Ch 2.4GHz RX
  </div>
  <div class="flex items-center gap-2 p-3 rounded-xl bg-surface/40 border border-white/5 text-sm text-text-muted">
    <span class="w-1.5 h-1.5 rounded-full bg-primary/40"></span>
    RadioMaster XR1 Dual Band RX
  </div>
  <div class="flex items-center gap-2 p-3 rounded-xl bg-surface/40 border border-white/5 text-sm text-text-muted">
    <span class="w-1.5 h-1.5 rounded-full bg-primary/40"></span>
    RadioMaster XR4 Dual Band True Diversity RX
  </div>
  <div class="flex items-center gap-2 p-3 rounded-xl bg-surface/40 border border-white/5 text-sm text-text-muted">
    <span class="w-1.5 h-1.5 rounded-full bg-primary/40"></span>
    HappyModel EP Dual 2.4GHz RX
  </div>
</div>

---

## Tested Binaries
The internal firmware assembler has been functionally verified against the official ExpressLRS compiler outputs for the following targets:

<div class="columns-1 sm:columns-2 md:columns-3 gap-4 space-y-2 my-6 text-sm text-text-muted/80">
  <div class="break-inside-avoid px-2 py-1">• BETAFPV 2.4GHz Micro TX</div>
  <div class="break-inside-avoid px-2 py-1">• BETAFPV PWM 2.4GHz RX</div>
  <div class="break-inside-avoid px-2 py-1">• BETAFPV SuperP 14Ch 2.4GHz RX</div>
  <div class="break-inside-avoid px-2 py-1">• Foxeer 2.4Ghz RX</div>
  <div class="break-inside-avoid px-2 py-1">• GEPRC C3 900/2400 Gemini Xrossband RX</div>
  <div class="break-inside-avoid px-2 py-1">• HappyModel AIO 2.4GHz RX+VTX</div>
  <div class="break-inside-avoid px-2 py-1">• HappyModel EP1/EP2 2.4GHz RX</div>
  <div class="break-inside-avoid px-2 py-1">• HappyModel EP Dual 2.4GHz RX</div>
  <div class="break-inside-avoid px-2 py-1">• HappyModel ES900 TX</div>
  <div class="break-inside-avoid px-2 py-1">• RadioMaster ER8 2.4GHz Diversity+8xPWM RX</div>
  <div class="break-inside-avoid px-2 py-1">• RadioMaster Nomad 2.4/900 TX</div>
  <div class="break-inside-avoid px-2 py-1">• RadioMaster Pocket Internal 2.4GHz TX</div>
  <div class="break-inside-avoid px-2 py-1">• RadioMaster XR4 Dual Band True Diversity RX</div>
  <div class="break-inside-avoid px-2 py-1">• Radiomaster Nexus-XR True Diversity 2.4GHz RX</div>
  <div class="break-inside-avoid px-2 py-1">• Squid Stick dongle V2</div>
</div>
