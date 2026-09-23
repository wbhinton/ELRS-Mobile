import 'package:elrs_mobile/src/features/flashing/utils/chip_family.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chipFamilyOf', () {
    test('reads the chip from unified device target names', () {
      expect(chipFamilyOf('UNIFIED_ESP8285_2400_RX'), 'esp8285');
      expect(chipFamilyOf('Unified_ESP32_2400_TX'), 'esp32');
      expect(chipFamilyOf('UNIFIED_ESP32C3_LR1121_RX'), 'esp32-c3');
      expect(chipFamilyOf('Unified_ESP32S3_900_TX'), 'esp32-s3');
    });

    test('normalises targets.json platform values to themselves', () {
      for (final p in ['esp8285', 'esp32', 'esp32-c3', 'esp32-s3', 'stm32']) {
        expect(chipFamilyOf(p), p);
      }
    });

    test('treats ESP8266 as the ESP8285 family', () {
      expect(chipFamilyOf('UNIFIED_ESP8266_2400_TX'), 'esp8285');
    });

    test('keeps unknown ESP32 variants distinct from plain ESP32', () {
      expect(chipFamilyOf('UNIFIED_ESP32C6_2400_RX'), 'esp32-c6');
    });

    test('returns null when no chip is named', () {
      expect(chipFamilyOf(null), isNull);
      expect(chipFamilyOf('HappyModel_EP_2400_RX'), isNull);
      expect(chipFamilyOf('Legacy Target'), isNull);
    });
  });
}
