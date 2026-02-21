
import 'dart:convert';
import 'dart:typed_data';
import 'package:elrs_mobile/src/features/flashing/utils/unified_firmware_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnifiedFirmwareBuilder', () {
    test('Builds correctly structured binary', () {
      // Setup
      final firmware = Uint8List.fromList([1, 2, 3, 0xFF, 0x00, 0xFF]); // Has padding
      const productName = 'Test Product';
      const luaName = 'TESTLUA';
      final uid = [1, 2, 3, 4, 5, 6];
      final layout = {'serial_rx': 1, 'serial_tx': 2};

      // Act
      final result = UnifiedFirmwareBuilder.build(
        firmware: firmware,
        productName: productName,
        luaName: luaName,
        uid: uid,
        hardwareLayout: layout,
      );

      // Assert
      
      // 1. Firmware should be trimmed (3 bytes: 1, 2, 3)
      // Wait, 0xFF and 0x00 suffix should be removed.
      // Expected trimmed length: 3.
      
      const expectedTrimmedLength = 3;
      const expectedProductLength = 128;
      const expectedLuaLength = 16;
      const expectedOptionsLength = 512;
      const expectedLayoutLength = 2048;

      final expectedTotalLength = expectedTrimmedLength + 
          expectedProductLength + 
          expectedLuaLength + 
          expectedOptionsLength + 
          expectedLayoutLength;

      expect(result.length, equals(expectedTotalLength));

      // Verify Offsets via sublist checks
      var offset = 0;

      // Firmware
      expect(result.sublist(0, 3), equals([1, 2, 3]));
      offset += 3;

      // Product Name
      final productBytes = result.sublist(offset, offset + expectedProductLength);
      expect(utf8.decode(productBytes.takeWhile((b) => b != 0).toList()), equals(productName));
      offset += expectedProductLength;

      // Lua Name
      final luaBytes = result.sublist(offset, offset + expectedLuaLength);
      expect(utf8.decode(luaBytes.takeWhile((b) => b != 0).toList()), equals(luaName));
      offset += expectedLuaLength;

      // Options JSON
      final optionsBytes = result.sublist(offset, offset + expectedOptionsLength);
      final optionsStr = utf8.decode(optionsBytes.takeWhile((b) => b != 0).toList());
      final optionsJson = jsonDecode(optionsStr);
      expect(optionsJson['uid'], equals(uid));
      offset += expectedOptionsLength;

      // Layout JSON
      final layoutBytes = result.sublist(offset, offset + expectedLayoutLength);
      final layoutStr = utf8.decode(layoutBytes.takeWhile((b) => b != 0).toList());
      final layoutJson = jsonDecode(layoutStr);
      expect(layoutJson['serial_rx'], equals(1));
    });

    test('Trims firmware correctly', () {
      // Accessing private method via public build? 
      // We can just verify the output size/content.
      final fw = Uint8List.fromList([10, 20, 0, 0, 255, 255, 0]);
      // Should trim to [10, 20]
      
      final result = UnifiedFirmwareBuilder.build(
        firmware: fw,
        productName: '',
        luaName: '',
        uid: [],
        hardwareLayout: {},
      );
      
      expect(result.sublist(0, 2), equals([10, 20]));
      // Next byte should be part of product name (0x00 padding since empty)
      expect(result[2], equals(0));
    });

    test('Includes Wi-Fi credentials in options JSON', () {
      final firmware = Uint8List.fromList([1, 2, 3]);
      final uid = [1, 2, 3, 4, 5, 6];
      const ssid = 'MyWiFi';
      const password = 'Password123';

      final result = UnifiedFirmwareBuilder.build(
        firmware: firmware,
        productName: 'Product',
        luaName: 'LUA',
        uid: uid,
        hardwareLayout: {},
        wifiSsid: ssid,
        wifiPassword: password,
      );

      // Verify Options JSON
      // Lengths: FW(3) + Product(128) + Lua(16) = 147 bytes offset
      const offset = 3 + 128 + 16;
      final optionsBytes = result.sublist(offset, offset + 512);
      final optionsStr = utf8.decode(optionsBytes.takeWhile((b) => b != 0).toList());
      final optionsJson = jsonDecode(optionsStr);

      expect(optionsJson['uid'], equals(uid));
      expect(optionsJson['wifi-ssid'], equals(ssid));
      expect(optionsJson['wifi-password'], equals(password));
    });

    test('Builds correctly with specific BetaFPV strings', () {
      final firmware = Uint8List.fromList([1, 2, 3]);
      final uid = [1, 2, 3, 4, 5, 6];
      const productName = "BETAFPV PWM 2.4GHz RX";
      const luaName = "BFPV PWM 2G4RX";

      final result = UnifiedFirmwareBuilder.build(
        firmware: firmware,
        productName: productName,
        luaName: luaName,
        uid: uid,
        hardwareLayout: {},
      );

      // Verify Product Name
      // Offset: Firmware(3)
      final productBytes = result.sublist(3, 3 + 128);
      final productStr = utf8.decode(productBytes.takeWhile((b) => b != 0).toList());
      expect(productStr, equals(productName));

      // Verify Lua Name
      // Offset: Firmware(3) + Product(128)
      final luaBytes = result.sublist(3 + 128, 3 + 128 + 16);
      final luaStr = utf8.decode(luaBytes.takeWhile((b) => b != 0).toList());
      expect(luaStr, equals(luaName));
    });
  });
}
