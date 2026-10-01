import '../../localization/app_localizations.dart';

/// Why a user-entered field was rejected. Turned into display text with
/// [FieldValidationErrorText.message] so the wording can be localised.
enum FieldValidationError { ssidTooLong, passwordTooShort, passwordTooLong }

extension FieldValidationErrorText on FieldValidationError {
  String message(AppLocalizations l10n) => switch (this) {
    FieldValidationError.ssidTooLong => l10n.validationSsidTooLong,
    FieldValidationError.passwordTooShort => l10n.validationPasswordTooShort,
    FieldValidationError.passwordTooLong => l10n.validationPasswordTooLong,
  };
}

class ValidationUtils {
  /// Validates WiFi SSID according to IEEE 802.11. Allows empty for Hotspot mode.
  static FieldValidationError? validateSsid(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length > 32) return FieldValidationError.ssidTooLong;
    return null;
  }

  /// Validates WiFi Password.
  static FieldValidationError? validatePassword(String? value) {
    if (value == null || value.isEmpty) return null; // Open network
    if (value.length < 8) return FieldValidationError.passwordTooShort;
    if (value.length > 63) return FieldValidationError.passwordTooLong;
    return null;
  }

  /// Validates ExpressLRS Binding Phrase. Allows empty for traditional binding.
  static FieldValidationError? validateBindPhrase(String? value) {
    return null;
  }
}
