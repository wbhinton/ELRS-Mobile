import 'package:elrs_mobile/src/elrs_mappings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Domain Mapping Tests', () {
    test('getDomainLabel returns correct labels for 900MHz', () {
      expect(getDomainLabel(0, FrequencyCategory.freq900MHz), 'FCC');
      expect(getDomainLabel(1, FrequencyCategory.freq900MHz), 'EU');
      expect(getDomainLabel(2, FrequencyCategory.freq900MHz), 'AU');
    });

    test('getDomainLabel returns correct labels for 2400MHz', () {
      expect(getDomainLabel(0, FrequencyCategory.freq2400MHz), 'ISM');
      expect(getDomainLabel(1, FrequencyCategory.freq2400MHz), 'EU_LBT');
    });

    test('getDomainLabel returns Unknown for out of bounds indices', () {
      expect(getDomainLabel(-1, FrequencyCategory.freq900MHz), 'Unknown');
      expect(getDomainLabel(3, FrequencyCategory.freq900MHz), 'Unknown');
      expect(getDomainLabel(100, FrequencyCategory.freq2400MHz), 'Unknown');
    });

    test('FrequencyCategory enum contains expected values', () {
      expect(FrequencyCategory.values, contains(FrequencyCategory.freq900MHz));
      expect(FrequencyCategory.values, contains(FrequencyCategory.freq2400MHz));
    });
  });
}
