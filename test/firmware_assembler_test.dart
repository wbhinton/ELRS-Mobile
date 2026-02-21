
import 'dart:convert';
import 'dart:typed_data';
import 'package:elrs_mobile/src/features/flashing/utils/firmware_assembler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirmwareAssembler', () {
    test('generateUid hashes correctly', () {
      // Known hash for "expresslrs": 41f521e63ae2ce90029b691bbc9109b4
      // First 6 bytes: 0x41, 0xF5, 0x21, 0xE6, 0x3A, 0xE2
      final uid = FirmwareAssembler.generateUid('expresslrs');
      expect(uid, equals([0x41, 0xF5, 0x21, 0xE6, 0x3A, 0xE2]));
    });

    test('assembleEspUnified builds correct structure', () {
      final firmware = Uint8List.fromList([1, 2, 3]);
      final uid = [1, 2, 3, 4, 5, 6];
      const productName = 'Test Product';
      const luaName = 'TESTLUA';

      final result = FirmwareAssembler.assembleEspUnified(
        firmware: firmware,
        productName: productName,
        luaName: luaName,
        uid: uid,
        hardwareLayout: {'key': 'val'},
        platform: 'esp8285',
        wifiSsid: 'ssid',
        wifiPassword: 'pass',
      );

      // Verify Total Size
      // FW(3) + Product(128) + Lua(16) + Options(512) + Layout(2048) = 2707
      expect(result.length, equals(3 + 128 + 16 + 512 + 2048));

      // Verify specific content (e.g. WiFi in options)
      final optionsOffset = 3 + 128 + 16;
      final optionsBytes = result.sublist(optionsOffset, optionsOffset + 512);
      final optionsStr = utf8.decode(optionsBytes.takeWhile((b) => b != 0).toList());
      final options = jsonDecode(optionsStr);
      
      expect(options['wifi-ssid'], equals('ssid'));
    });

    test('assembleEspUnified handles ESP32 platform', () {
       final firmware = Uint8List.fromList([1, 2, 3]);
       final result = FirmwareAssembler.assembleEspUnified(
         firmware: firmware,
         productName: 'PROD',
         luaName: 'LUA',
         uid: [0,0,0,0,0,0],
         hardwareLayout: {},
         platform: 'esp32',
       );
       expect(result.length, equals(3 + 128 + 16 + 512 + 2048));
    });
  });
}
