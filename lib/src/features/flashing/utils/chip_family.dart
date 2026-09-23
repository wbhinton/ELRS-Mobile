// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

final _chipPattern = RegExp(r'ESP32([A-Z]\d)?|ESP82(85|66)|STM32');

/// Extracts the chip family from an ExpressLRS target name such as
/// `UNIFIED_ESP32C3_2400_RX` or a `platform` value such as `esp32-s3`.
///
/// Results use the `platform` spelling from targets.json (`esp8285`,
/// `esp32`, `esp32-c3`, `esp32-s3`, `stm32`). ESP8266 maps to `esp8285`
/// since both run the same firmware images. Returns null when the name
/// carries no chip, e.g. legacy per-product target names.
String? chipFamilyOf(String? name) {
  if (name == null) return null;
  final match = _chipPattern.firstMatch(
    name.toUpperCase().replaceAll('-', ''),
  );
  if (match == null) return null;

  final chip = match.group(0)!;
  if (chip.startsWith('ESP82')) return 'esp8285';
  if (chip == 'STM32') return 'stm32';
  final variant = match.group(1);
  return variant == null ? 'esp32' : 'esp32-${variant.toLowerCase()}';
}
