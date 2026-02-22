import 'package:binary/binary.dart';

/// A service to track and toggle the state of PWM pins.
/// 
/// Uses a [BitList] for zero-allocation, high-density bit toggle tracking.
class PwmPinService {
  /// The underlying bitfield representing pin toggle states.
  /// 
  /// Represents up to 8 pins (0-7), where '1' is active and '0' is inactive.
  BitList _activePins;

  PwmPinService({int initialActiveMask = 0}) 
      : _activePins = BitList.fromInt(initialActiveMask, length: 8);

  /// Returns the internal integer representation of the active pins mask.
  int get activePinsMask {
    int mask = 0;
    for (int i = 0; i < 8; i++) {
      if (_activePins[i]) {
        mask |= (1 << i);
      }
    }
    return mask;
  }

  /// Toggles the activation state of the pin at [index].
  /// 
  /// Throws a [RangeError] if the index is outside the 8-bit limit (0-7).
  void togglePin(int index) {
    // Immediate validation using the 8-bit constraint method.
    Uint8.checkRange(index);
    
    // Additional domain check because we are tracking an 8-bit mask.
    if (index >= 8) {
        throw RangeError.range(index, 0, 7, 'index', 'Index exceeds max supported pins (8)');
    }

    // Toggle the specific bit and create a new BitList (since BitList is immutable).
    int currentMask = activePinsMask;
    currentMask ^= (1 << index);
    _activePins = BitList.fromInt(currentMask, length: 8);
  }

  /// Checks if a pin is currently active.
  bool isPinActive(int index) {
    if (index < 0 || index >= 8) return false;
    return _activePins[index];
  }
}
