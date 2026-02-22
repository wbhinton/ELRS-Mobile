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

import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:binary/binary.dart';
import '../domain/patch_configuration.dart';

part 'firmware_patcher.g.dart';

@riverpod
FirmwarePatcher firmwarePatcher(Ref ref) {
  return FirmwarePatcher();
}

class FirmwarePatcher {
  // Mock Magic Header for MVP (0xBE, 0xEF, 0xCA, 0xFE)
  static const List<int> _mockMagicHeader = [0xBE, 0xEF, 0xCA, 0xFE];
  
  // Offset of UID relative to the header found (This is arbitrary for MVP)
  static const int _uidOffsetFromHeader = 4;

  Future<Uint8List> patchFirmware(Uint8List original, PatchConfiguration config) async {
    // 1. Clone the original data to avoid mutating the input
    final patched = Uint8List.fromList(original);

    // 2. Generate UID from bind phrase
    final uid = _generateUid(config.bindPhrase);

    // 3. Find the header and inject UID
    final headerIndex = _findHeader(patched, _mockMagicHeader);
    
    if (headerIndex != -1) {
      _injectBytes(patched, headerIndex + _uidOffsetFromHeader, uid);
    } else {
      // In a real app we might throw an exception, but for this mock we'll just 
      // append it or do nothing. The requirement says "Scan the binary...".
      // Let's assume for the test we WILL provide a binary with this header.
      // If not found, we could throw.
      throw Exception('Magic header not found in firmware binary');
    }

    return patched;
  }

  List<int> _generateUid(String bindPhrase) {
    if (bindPhrase.isEmpty) return List.filled(6, 0);
    
    // MD5 hash
    final digest = md5.convert(utf8.encode(bindPhrase));
    final bytes = digest.bytes;
    
    // Take first 6 bytes for ELRS UID
    return bytes.sublist(0, 6);
  }

  int _findHeader(Uint8List data, List<int> sequence) {
    if (sequence.isEmpty) return -1;
    if (data.length < sequence.length) return -1;

    for (int i = 0; i <= data.length - sequence.length; i++) {
      bool found = true;
      for (int j = 0; j < sequence.length; j++) {
        if (data[i + j] != sequence[j]) {
          found = false;
          break;
        }
      }
      if (found) return i;
    }
    return -1;
  }

  void _injectBytes(Uint8List source, int offset, List<int> data) {
    if (offset + data.length > source.length) {
       throw Exception('Patching out of bounds');
    }
    for (int i = 0; i < data.length; i++) {
      source[offset + i] = Uint8(data[i]).toInt();
    }
  }
}
