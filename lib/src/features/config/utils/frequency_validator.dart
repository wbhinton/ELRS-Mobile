import 'package:binary/binary.dart';

class FrequencyValidator {
  // Use Uint32 constants to ensure type-safe comparisons
  static final min2G4 = Uint32(2400);
  static final max2G4 = Uint32(2483);

  static Uint32 getValidatedFrequency(int rawFreq, int rawModelId) {
    // Platform-consistent interpretation using binary.dart types
    final freq = Uint32(rawFreq);
    final modelId = Uint16(rawModelId);

    // Differentiator: Validate frequency against hardware capabilities
    // Assume Bit 7 of model_id is the 2.4GHz capability flag (Ground Truth)
    final is2G4Capable = modelId.nthBit(7);

    if (is2G4Capable && freq < min2G4) {
      throw Exception("Hardware Safety Violation: 2.4GHz model reporting sub-GHz frequency.");
    }

    return freq;
  }
}
