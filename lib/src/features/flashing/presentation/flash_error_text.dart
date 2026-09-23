import 'package:elrs_mobile/src/localization/app_localizations.dart';

import '../domain/flash_error.dart';

export '../domain/flash_error.dart';

extension FlashErrorText on FlashError {
  /// Localised headline for this error. Any [FlashError.detail] is shown
  /// separately, untranslated.
  String message(AppLocalizations l10n) => switch (this) {
    NoTargetSelected() => l10n.flashErrorNoTarget,
    NoVersionSelected() => l10n.flashErrorNoVersion,
    NoDeviceConnected() => l10n.flashErrorNoDevice,
    NoBindPhrase() => l10n.noBindPhraseMessage,
    ChipMismatch(:final deviceChip, :final targetChip) =>
      l10n.flashErrorChipMismatch(
        targetChip.toUpperCase(),
        deviceChip.toUpperCase(),
      ),
    OfflineMissingFiles(duringFlash: true) => l10n.flashErrorOfflineFlash,
    OfflineMissingFiles(duringFlash: false) => l10n.flashErrorOfflineDownload,
    FlashFailed() => l10n.flashErrorFlashFailed,
    FlashUnconfirmed() => l10n.flashErrorUnconfirmed,
    DownloadFailed() => l10n.flashErrorDownloadFailed,
  };
}
