
import 'dart:typed_data';
import 'package:elrs_mobile/src/features/flashing/utils/stm32_firmware_patcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stm32FirmwarePatcher', () {
    test('Patches version 0 firmware correctly', () {
      // Magic Header: BE EF BA BE CA FE F0 0D
      final magicHeader = [0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D];
      // Version 0 (uint16 little endian: 00 00)
      // BaseOffset + 0 = Version
      // Write Offset if Version 0 = BaseOffset + 3 (BaseOffset + 2 is skipped?)
      // Actually per instructions: "If version == 0, writeOffset = BaseOffset + 3"
      
      final firmware = Uint8List.fromList([
        ...magicHeader,
        0x00, 0x00, // Version 0
        0xFF,       // Skipped byte?
        0x00, 0x00, // Placeholder for Domain + Flag
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00 // Placeholder for UID
      ]);

      final uid = [10, 20, 30, 40, 50, 60];
      final patched = Stm32FirmwarePatcher.patchStm32(
        firmware: firmware, 
        uid: uid, 
        domain: 1, // LBT
      );

      final offset = magicHeader.length;
      
      // Check Domain at (offset + 3)
      expect(patched[offset + 3], equals(1)); // Domain
      
      // Check UID Flag at (offset + 3 + 1)
      expect(patched[offset + 4], equals(1)); // Flag
      
      // Check UID at (offset + 3 + 2)
      expect(patched.sublist(offset + 5, offset + 5 + 6), equals(uid));
    });

    test('Patches non-zero version firmware correctly', () {
      final magicHeader = [0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D];
      
      final firmware = Uint8List.fromList([
        ...magicHeader,
        0x01, 0x00, // Version 1
        0x00, 0x00, // Placeholder for Domain + Flag at offset + 2
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
      ]);

      final uid = [1, 2, 3, 4, 5, 6];
      final patched = Stm32FirmwarePatcher.patchStm32(
        firmware: firmware, 
        uid: uid, 
        domain: 0, 
      );

      final offset = magicHeader.length;
      
      // Check Domain at (offset + 2)
      expect(patched[offset + 2], equals(0)); // Domain
      
      // Check UID Flag at (offset + 3)
      expect(patched[offset + 3], equals(1)); // Flag
      
      // Check UID at (offset + 4)
      expect(patched.sublist(offset + 4, offset + 4 + 6), equals(uid));
    });

    test('Throws if magic header missing', () {
      final firmware = Uint8List.fromList([1, 2, 3, 4]);
      expect(
        () => Stm32FirmwarePatcher.patchStm32(firmware: firmware, uid: [1,2,3,4,5,6]),
        throwsException,
      );
    });
  });
}
