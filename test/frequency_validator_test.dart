import 'package:flutter_test/flutter_test.dart';
import 'package:elrs_mobile/src/features/config/utils/frequency_validator.dart';
import 'package:elrs_mobile/src/features/config/domain/runtime_config_model.dart';

void main() {
  group('FrequencyValidator', () {
    test('getValidatedFrequency allows valid 900MHz frequency for non-2G4 hardware', () {
      // modelId = 0 (no bit 7)
      final freq = FrequencyValidator.getValidatedFrequency(900, 0);
      expect(freq.toInt(), 900);
    });

    test('getValidatedFrequency allows valid 2.4GHz frequency for 2G4 hardware', () {
      // modelId = 128 (bit 7 set: 1000 0000)
      final freq = FrequencyValidator.getValidatedFrequency(2400, 128);
      expect(freq.toInt(), 2400);
    });

    test('getValidatedFrequency throws on sub-GHz frequency for 2G4 hardware', () {
      // modelId = 128 (bit 7 set), freq = 900
      expect(
        () => FrequencyValidator.getValidatedFrequency(900, 128),
        throwsA(predicate((e) => e is Exception && e.toString().contains('Hardware Safety Violation'))),
      );
    });
  });

  group('RuntimeConfig frequencyBand extension', () {
    test('frequencyBand returns 900 for freqIndex 0 on standard hardware', () {
      const config = RuntimeConfig(
        options: ElrsOptions(freqIndex: 0),
        config: ElrsConfig(modelId: 0),
      );
      expect(config.frequencyBand, 900);
    });

    test('frequencyBand returns 2400 for freqIndex 1 on 2.4GHz hardware', () {
      const config = RuntimeConfig(
        options: ElrsOptions(freqIndex: 1),
        config: ElrsConfig(modelId: 128), // bit 7 set
      );
      expect(config.frequencyBand, 2400);
    });

    test('frequencyBand returns 2400 for 2.4GHz hardware regardless of freqIndex', () {
      // freqIndex=0 is the default domain-list index, NOT a 900MHz indicator.
      // Band is determined by modelId bit 7 (hardware capability flag).
      // Real device: modelId=255 (all bits set), freqIndex absent → defaults 0.
      const config = RuntimeConfig(
        options: ElrsOptions(freqIndex: 0),
        config: ElrsConfig(modelId: 128), // bit 7 set → 2.4GHz
      );
      expect(config.frequencyBand, 2400);
    });
  });
}
