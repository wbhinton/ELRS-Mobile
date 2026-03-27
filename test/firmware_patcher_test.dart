import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:elrs_mobile/src/features/flashing/domain/patch_configuration.dart';
import 'package:elrs_mobile/src/features/flashing/application/firmware_patcher.dart';

void main() {
  group('FirmwarePatcher', () {
    late FirmwarePatcher patcher;

    setUp(() {
      patcher = FirmwarePatcher();
    });

    test('should generate correct UID from bind phrase and patch stm32 binary', () async {
      const phrase = "my_secret_phrase";
      final config = PatchConfiguration(bindPhrase: phrase);

      // Real STM32 Header: 0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D
      final binary = Uint8List(1024);
      final headerOffset = 100;
      final header = [0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D];
      for (int i = 0; i < header.length; i++) {
        binary[headerOffset + i] = header[i];
      }
      
      // Version at BaseOffset (headerOffset + 8) = 1 (uint16 little endian)
      binary[headerOffset + 8] = 0x01;
      binary[headerOffset + 9] = 0x00;

      final patched = await patcher.patchFirmware(binary, config, platform: 'stm32');

      // Hash of "my_secret_phrase" (md5) first 6 bytes:
      // [119, 183, 36, 151, 38, 16]
      final expectedUid = [119, 183, 36, 151, 38, 16];

      // Stm32FirmwarePatcher writes UID at offset + 2 (since version != 0) + 2 (skip domain and flag)
      // offset is baseOffset (headerOffset + 8)
      // writeOffset = offset + 2 = headerOffset + 10
      // Domain at writeOffset + 0 = headerOffset + 10
      // Flag at writeOffset + 1 = headerOffset + 11
      // UID at writeOffset + 2 = headerOffset + 12
      final uidOffset = headerOffset + 12;

      for (int i = 0; i < 6; i++) {
        expect(
          patched[uidOffset + i],
          equals(expectedUid[i]),
          reason: 'Byte at index $i does not match',
        );
      }
    });

    test('should return original bytes for non-stm32 platform', () async {
      final binary = Uint8List(10);
      final config = PatchConfiguration(bindPhrase: "test");
      
      final result = await patcher.patchFirmware(binary, config, platform: 'esp32');
      
      expect(result, same(binary));
    });

    test('should throw specific exception if header not found on stm32', () async {
      final binary = Uint8List(1024); // No header
      final config = PatchConfiguration(bindPhrase: "test");

      try {
        await patcher.patchFirmware(binary, config, platform: 'stm32');
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e.toString(), contains('Flashing failed: Wrong Magic Byte'));
      }
    });

    test('should not modify original binary', () async {
      final binary = Uint8List(1024);
      final header = [0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D];
      for (int i = 0; i < header.length; i++) {
        binary[i] = header[i];
      }
      binary[8] = 0x01; // version

      final originalByte = binary[20];
      final config = PatchConfiguration(bindPhrase: "test");

      await patcher.patchFirmware(binary, config, platform: 'stm32');

      expect(binary[20], equals(originalByte));
    });
  });
}
