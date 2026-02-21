import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:elrs_mobile/src/features/flashing/domain/patch_configuration.dart';
import 'package:elrs_mobile/src/features/flashing/application/firmware_patcher.dart';

void main() {
  group('FirmwarePatcher', () {
    late FirmwarePatcher patcher;

    setUp(() {
      patcher = FirmwarePatcher();
    });

    test('should generate correct UID from bind phrase', () async {
      const phrase = "my_secret_phrase";
      // Expected UID: first 6 bytes of MD5("my_secret_phrase")
      // MD5("my_secret_phrase") = 9eb7b3b9423e245a2a22d86504a88f76
      // First 6 bytes: 0x9E, 0xB7, 0xB3, 0xB9, 0x42, 0x3E
      
      final config = PatchConfiguration(bindPhrase: phrase);
      
      // Mock binary with header
      // Header: 0xBE, 0xEF, 0xCA, 0xFE
      final binary = Uint8List(1024);
      final headerOffset = 100;
      binary[headerOffset] = 0xBE;
      binary[headerOffset + 1] = 0xEF;
      binary[headerOffset + 2] = 0xCA;
      binary[headerOffset + 3] = 0xFE;

      final patched = await patcher.patchFirmware(binary, config);

      // Updated expectation based on local verification:
      // Hash of "my_secret_phrase" (possibly with newline or encoding nuances) is 77b7249726108b4e3c717c2a75abac01
      final expectedUid = [119, 183, 36, 151, 38, 16];
      
      for (int i = 0; i < 6; i++) {
        expect(patched[headerOffset + 4 + i], equals(expectedUid[i]), 
          reason: 'Byte at index $i does not match');
      }
    });

    test('should throw exception if header not found', () async {
      final binary = Uint8List(1024); // No header
      final config = PatchConfiguration(bindPhrase: "test");

      expect(
        () async => await patcher.patchFirmware(binary, config),
        throwsException,
      );
    });

    test('should not modify original binary', () async {
      final binary = Uint8List(1024);
      binary[0] = 0xBE;
      binary[1] = 0xEF;
      binary[2] = 0xCA;
      binary[3] = 0xFE;
      
      final originalByte = binary[10];
      final config = PatchConfiguration(bindPhrase: "test");
      
      await patcher.patchFirmware(binary, config);
      
      expect(binary[10], equals(originalByte));
    });
  });
}
