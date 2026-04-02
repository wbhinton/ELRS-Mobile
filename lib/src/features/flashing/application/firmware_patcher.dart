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
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/patch_configuration.dart';
import '../utils/stm32_firmware_patcher.dart';
import '../../../core/utils/binding_phrase_utils.dart';

part 'firmware_patcher.g.dart';

@riverpod
FirmwarePatcher firmwarePatcher(Ref ref) {
  return FirmwarePatcher();
}

class FirmwarePatcher {
  static final _log = Logger('FirmwarePatcher');

  Future<Uint8List> patchFirmware(Uint8List original, PatchConfiguration config, {String? platform}) async {
    // ESP targets do not use magic bytes; they are patched via JSON assembly later in the pipeline
    if (platform != 'stm32') {
      return original;
    }

    try {
      // Delegate the actual bit-packing to our dedicated STM32 utility
      final patched = Stm32FirmwarePatcher.patchStm32(
        firmware: original,
        uid: BindingPhraseUtils.generateUid(config.bindPhrase),
        domain: config.domain ?? 0,
      );

      return patched;
    } catch (e, st) {
      _log.severe('STM32 firmware patching failed', e, st);
      throw Exception('Firmware patching failed: $e');
    }
  }
}
