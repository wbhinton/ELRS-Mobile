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

import 'dart:convert';
import 'dart:typed_data';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:binary/binary.dart';

class FirmwareAssembler {
  static final _log = Logger('FirmwareAssembler');
  
  /// Updates the firmware options map with the validated regulatory domain.
  static void updateDomainOption(
    Map<String, dynamic> options,
    int rawDomainValue,
  ) {
    // Use checkRange to log any bounds errors to Sentry if it overflows.
    int? domain;
    try {
      domain = Uint8.checkRange(rawDomainValue).toInt();
    } catch (e) {
      Sentry.captureMessage(
        'Firmware Assembler Overflow: Domain $rawDomainValue exceeds Uint8 bounds',
        level: SentryLevel.error,
      );
      throw Exception('Domain value out of bounds: $rawDomainValue');
    }

    // Inject into the options map as the fixed-width extension type.
    options['domain'] = domain;

    // Debugging: Verify the injected domain mask.
    // print('Injected Domain: ${domain.toBinaryString()}');
  }

  /// Assembles the EspUnified Firmware binary.
  ///
  /// Structure:
  /// [Trimmed Firmware]
  /// [Product Name (128 bytes)]
  /// [Lua Name (16 bytes)]
  /// [Options JSON (512 bytes)]
  /// [Hardware Layout JSON (2048 bytes)]
  static Uint8List assembleEspUnified({
    required Uint8List firmware,
    required String productName,
    required String luaName,
    required List<int> uid,
    required Map<String, dynamic> hardwareLayout,
    required String platform,
    String wifiSsid = '',
    String wifiPassword = '',
    int? flashDiscriminator,
    int? domain,
    required bool isTx,
  }) {
    final builder = BytesBuilder();

    // 1. Trim Firmware
    _log.fine('Original Firmware Size: ${firmware.length}');
    final end = findFirmwareEnd(firmware, platform);
    _log.fine('Calculated True End (Surgical): $end');
    _log.fine(
      'Bytes Stripped (Padding + Old Config): ${firmware.length - end}',
    );

    final trimmedFirmware = firmware.sublist(0, end);
    builder.add(trimmedFirmware);

    // 2. Product Name (128 bytes)
    builder.add(_paddedString(productName, 128));

    // 3. Lua Name (16 bytes)
    builder.add(_paddedString(luaName, 16));

    // 4. Options JSON (512 bytes)
    // Deterministic Options: Build from scratch based on Web Flasher forensics.
    final sanitizedSsid = wifiSsid.trim().replaceAll('\x00', '');
    final sanitizedPassword = wifiPassword.trim().replaceAll('\x00', '');

    final Map<String, dynamic> finalOptions = {
      'flash-discriminator':
          flashDiscriminator ??
          Uint32.fromWrapped(DateTime.now().millisecondsSinceEpoch).toInt(),
      'wifi-on-interval': 60,
    };

    if (isTx) {
      finalOptions['tlm-interval'] = 240;
      finalOptions['fan-runtime'] = 30;
      finalOptions['uart-inverted'] = true;
      finalOptions['unlock-higher-power'] = false;
    } else {
      finalOptions['rcvr-uart-baud'] = 420000;
      finalOptions['lock-on-first-connection'] = true;
    }

    if (uid.isNotEmpty && uid.any((byte) => byte != 0)) {
      finalOptions['uid'] = uid;
    }

    if (sanitizedSsid.isNotEmpty) {
      finalOptions['wifi-ssid'] = sanitizedSsid;
      finalOptions['wifi-password'] = sanitizedPassword;
    }

    if (domain != null) {
      updateDomainOption(finalOptions, domain);
    }

    final optionsJson = jsonEncode(finalOptions);
    final optionsBytes = utf8.encode(optionsJson);
    if (optionsBytes.length > 512) {
      throw Exception(
        'Options JSON exceeds 512 bytes (${optionsBytes.length} bytes).',
      );
    }
    builder.add(_paddedString(optionsJson, 512));

    // 5. Hardware Layout JSON (2048 bytes)
    // Strict Hardware Layout Padding: Minify and pad to exactly 2048 bytes.
    final layoutJson = jsonEncode(hardwareLayout);
    final minifiedLayout = layoutJson.replaceAll(RegExp(r'\s+'), '');
    final layoutBytes = utf8.encode(minifiedLayout);

    if (layoutBytes.length > 2048) {
      throw Exception(
        'Hardware layout JSON exceeds 2048 bytes (${layoutBytes.length} bytes).',
      );
    }

    final paddedLayout = Uint8List(2048);
    paddedLayout.setRange(0, layoutBytes.length, layoutBytes);
    builder.add(paddedLayout);

    return builder.toBytes();
  }

  /// Pads (or truncates) string to exact byte length.
  static Uint8List _paddedString(String text, int length) {
    final bytes = utf8.encode(text);
    if (bytes.length > length) {
      return Uint8List.fromList(bytes.sublist(0, length));
    }

    final padded = Uint8List(length);
    padded.setRange(0, bytes.length, bytes);
    return padded;
  }

  static int findFirmwareEnd(Uint8List binary, String platform) {
    int pos = 0;
    if (platform == 'esp8285') pos = 0x1000;

    // Magic byte check (0xE9)
    if (pos >= binary.length || binary[pos] != 0xE9) {
      _log.warning('Magic byte not found, returning full length');
      return binary.length;
    }

    int segments = binary[pos + 1];
    pos = platform.startsWith('esp32') ? 24 : 0x1008;

    for (int i = 0; i < segments; i++) {
      if (pos + 8 > binary.length) {
        _log.warning('Expected more segments but hit end of file.');
        break;
      }

      // Read 32-bit size (Little Endian) using Uint32 constructor (calls fit() internally).
      final s0 = binary[pos + 4];
      final s1 = binary[pos + 5] << 8;
      final s2 = binary[pos + 6] << 16;
      final s3 = binary[pos + 7] << 24;
      final size = Uint32.fromWrapped(s0 | s1 | s2 | s3).toInt();
      pos += 8 + size;
    }

    // THE FIX: Exact bitwise match to official JS using Uint32.fromWrapped for robust alignment
    pos = (Uint32.fromWrapped((pos + 16)) & Uint32.fromWrapped(~15)).toInt();
    if (platform.startsWith('esp32')) {
      pos += 32; // Mandatory ESP32 gap
    }

    return pos;
  }
}
