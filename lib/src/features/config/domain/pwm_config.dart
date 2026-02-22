import 'package:binary/binary.dart';

/// A zero-cost abstraction over a 16-bit integer representing a PWM configuration.
/// 
/// Uses `package:binary` to provide safe, declarative access to the bitfield
/// chunks as defined by the ELRS protocol, avoiding manual bitwise shifting.
extension type const PWMConfig._(Uint16 _value) {
  /// Creates a new [PWMConfig] from a raw integer.
  /// 
  /// The integer will be truncated to 16 bits safely.
  factory PWMConfig(int value) => PWMConfig._(Uint16(value));

  /// Internal raw value access.
  int get rawValue => _value.toInt();

  /// Gets the Frequency chunk (Bits 0-9).
  /// 
  /// Returns a valid unsigned integer representing the 10-bit frequency value.
  int get frequency => _value.slice(0, 9).toInt();

  /// Updates the Duty Cycle / Resolution chunk (Bits 10-15).
  /// 
  /// Returns a new immutable [PWMConfig] with the targeted bit chunk replaced
  /// by the provided value [v].
  PWMConfig updateDutyCycle(int v) {
    return PWMConfig._(_value.replace(10, 15, v));
  }
}
