import 'package:elrs_mobile/src/core/utils/validation_utils.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flash_error_text.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  test('chip mismatch names the target chip first, then the device chip', () {
    const error = ChipMismatch(deviceChip: 'esp8285', targetChip: 'esp32');
    expect(
      error.message(l10n),
      'Incompatible chip: this firmware is built for ESP32, but the connected '
      'device is ESP8285. Select a target for the same chip.',
    );
  });

  test('offline errors give flash- and download-specific advice', () {
    expect(
      const OfflineMissingFiles(duringFlash: true).message(l10n),
      l10n.flashErrorOfflineFlash,
    );
    expect(
      const OfflineMissingFiles(duringFlash: false).message(l10n),
      l10n.flashErrorOfflineDownload,
    );
  });

  test('device detail is kept separate and untranslated', () {
    const error = FlashFailed('Wrong Magic Byte');
    expect(error.message(l10n), l10n.flashErrorFlashFailed);
    expect(error.detail, 'Wrong Magic Byte');
  });

  test('unconfirmed flashes are not reported as failures or successes', () {
    const error = FlashUnconfirmed('Connection reset by peer');
    expect(error.message(l10n), l10n.flashErrorUnconfirmed);
    expect(error.code, 'flash_unconfirmed');
    expect(error.detail, 'Connection reset by peer');
  });

  test('describeFailure strips nested Exception prefixes', () {
    expect(
      describeFailure(
        Exception('Failed to flash firmware: Exception: Flashing failed: x'),
      ),
      'Failed to flash firmware: Flashing failed: x',
    );
  });

  test('validation errors map to localised messages', () {
    expect(
      ValidationUtils.validatePassword('short')?.message(l10n),
      l10n.validationPasswordTooShort,
    );
    expect(ValidationUtils.validateSsid('a' * 33), FieldValidationError.ssidTooLong);
    expect(ValidationUtils.validateSsid(''), isNull);
  });
}
