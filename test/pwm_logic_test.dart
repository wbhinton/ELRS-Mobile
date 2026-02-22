import 'package:flutter_test/flutter_test.dart';
import 'package:checks/checks.dart';
import 'package:binary/binary.dart';
import 'package:elrs_mobile/src/features/config/domain/pwm_config.dart';

void main() {
  // STRICT DEVELOPMENT-TIME SAFETY
  // Enforce zero-cost abstraction checking
  debugCheckFixedWithInRange = true;

  group('PWMConfig Binary Logic', () {
    test('Wrapped Addition Overflow', () {
      // Simulate hardware rollover: adding to Uint16.max
      final maxVal = Uint16.max;
      final overflowVal = maxVal.wrappedAdd(Uint16(1));
      
      check(overflowVal).equals(Uint16.zero);
    });

    test('Clamped Addition Ceiling', () {
      // Ensure UI inputs cannot exceed maximum possible hardware value
      final maxVal = Uint16.max;
      final clampedVal = maxVal.clampedAdd(Uint16(50));
      
      check(clampedVal).equals(Uint16.max);
    });

    test('Bit Consistency against ELRS Protocol Expected Pattern', () {
      // Create a test integer. 
      // E.g., Frequency chunk (0-9): 341 -> binary: 0101010101
      // Duty chunk (10-15): 42 -> binary: 101010
      // Combined 16-bit: 101010 0101010101 (42 << 10 | 341) => 43349
      
      final configVal = (42 << 10) | 341;
      final config = PWMConfig(configVal);

      // Verify the extension type successfully parsed the raw integer
      final uint16 = Uint16(config.rawValue);

      // Verify the expected 16-bit pattern matching protocol documentation
      check(uint16.toBinaryString()).equals('1010100101010101');
    });

    test('Input Validation with checkRange', () {
      // If user enters a frequency beyond Uint16.max (65535), 
      // the checkRange method should throw a RangeError, preventing corrupted data.
      
      final int invalidInput = 70000;
      
      // Attempt to fit the value safely into a 16-bit space
      check(() => Uint16.checkRange(invalidInput)).throws<RangeError>();
    });
  });
}
