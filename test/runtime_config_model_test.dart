import 'package:elrs_mobile/src/features/config/domain/runtime_config_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RuntimeConfig Model', () {
    test('Parses valid /config JSON with nested structure correctly', () {
      // Setup
      final json = <String, dynamic>{
        "product_name": "BetaFPV Nano RX",
        "version": "3.3.0",
        "settings": <String, dynamic>{
          "has_serial_pins": true,
          "module-type": "RX"
        },
        "options": <String, dynamic>{
          "domain": 2,
          "uid": [37, 16, 128, 230, 252, 116],
          "wifi-ssid": "HomeWiFi",
          "wifi-password": "pass"
        },
        "config": <String, dynamic>{
          "modelid": 5,
          "pwm": [0, 1, 2, 3]
        }
      };

      // Act
      final model = RuntimeConfig.fromJson(json);

      // Assert
      expect(model.productName, 'BetaFPV Nano RX');
      expect(model.options.domain, 2);
      expect(model.settings.hasSerialPins, true);
      expect(model.settings.moduleType, "RX");
      
      expect(model.options.wifiSsid, 'HomeWiFi');
      expect(model.options.uid, equals([37, 16, 128, 230, 252, 116]));
      
      expect(model.config.modelId, 5);
      expect(model.config.pwm, equals([0, 1, 2, 3]));
    });

    test('Handles missing nested fields with defaults', () {
      final json = <String, dynamic>{
        "version": "1.0",
      };

      final model = RuntimeConfig.fromJson(json);

      expect(model.productName, null);
      expect(model.version, '1.0');
      expect(model.options.domain, null);
      expect(model.options.uid, null);
      expect(model.config.modelId, null);
    });
  });
}
