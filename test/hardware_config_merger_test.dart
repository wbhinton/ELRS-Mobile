
import 'package:elrs_mobile/src/features/flashing/utils/hardware_config_merger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HardwareConfigMerger', () {
    test('Merges overlay into base layout correctly', () {
      final base = {
        'serial_rx': 1,
        'serial_tx': 2,
        'led_rgb': 3,
        'pwm_outputs': [1, 2, 3],
      };
      
      final overlay = {
        'serial_tx': 10, // Override
        'led_rgb': 20,   // Override
        'vbat': 5,       // New
      };

      final merged = HardwareConfigMerger.mergeOverlay(base, overlay);

      expect(merged['serial_rx'], equals(1)); // Unchanged
      expect(merged['serial_tx'], equals(10)); // Overridden
      expect(merged['led_rgb'], equals(20)); // Overridden
      expect(merged['vbat'], equals(5)); // Added
      expect(merged['pwm_outputs'], equals([1, 2, 3])); // Unchanged
    });

    test('Handles null or empty overlay', () {
      final base = {'key': 'value'};
      
      final result1 = HardwareConfigMerger.mergeOverlay(base, null);
      expect(result1, equals(base));
      expect(identical(result1, base), isFalse); // Should be data copy/new map

      final result2 = HardwareConfigMerger.mergeOverlay(base, {});
      expect(result2, equals(base));
    });

    test('Does not mutate base layout', () {
      final base = {'key': 'value'};
      final overlay = {'key': 'newValue'};

      final merged = HardwareConfigMerger.mergeOverlay(base, overlay);
      
      expect(merged['key'], equals('newValue'));
      expect(base['key'], equals('value')); // Base preserved
    });
  });
}
