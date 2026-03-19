class ValidationUtils {
  /// Validates WiFi SSID according to IEEE 802.11 (1-32 octets).
  static String? validateSsid(String? value) {
    if (value == null || value.isEmpty) {
      return 'SSID cannot be empty';
    }
    if (value.length > 32) {
      return 'SSID must be 32 characters or less';
    }
    return null;
  }

  /// Validates WiFi Password.
  /// ELRS supports open networks (empty) or WPA2 (8-63 chars).
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Open network
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (value.length > 63) {
      return 'Password must be 63 characters or less';
    }
    return null;
  }

  /// Validates ExpressLRS Binding Phrase.
  static String? validateBindPhrase(String? value) {
    if (value == null || value.isEmpty) {
      return 'Binding Phrase cannot be empty';
    }
    if (value.isEmpty) {
      return 'Binding Phrase is too short';
    }
    return null;
  }
}
