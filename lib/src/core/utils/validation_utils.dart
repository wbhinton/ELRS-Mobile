class ValidationUtils {
  /// Validates WiFi SSID according to IEEE 802.11. Allows empty for Hotspot mode.
  static String? validateSsid(String? value) {
    if (value == null || value.isEmpty) return null; 
    if (value.length > 32) {
      return 'SSID must be 32 characters or less';
    }
    return null;
  }

  /// Validates WiFi Password.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return null; // Open network
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (value.length > 63) {
      return 'Password must be 63 characters or less';
    }
    return null;
  }

  /// Validates ExpressLRS Binding Phrase. Allows empty for traditional binding.
  static String? validateBindPhrase(String? value) {
    return null; 
  }
}
