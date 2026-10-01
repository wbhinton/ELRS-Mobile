import 'package:elrs_mobile/src/localization/app_localizations.dart';

/// What went wrong in the Firmware Manager. The controller reports the
/// kind; the screen renders localised text. Unlike [FlashError] no variant
/// carries its own data, so a kind plus optional untranslated [detail] is
/// enough.
enum FirmwareManagerErrorKind {
  loadFailed,
  onDeviceHotspot,
  cacheFull,
  serverUnreachable,
  downloadInterrupted,
  downloadFailed,
  deleteFailed,
}

class FirmwareManagerError {
  const FirmwareManagerError(this.kind, [this.detail]);

  final FirmwareManagerErrorKind kind;

  /// Untranslated technical message, when there is one.
  final String? detail;

  String message(AppLocalizations l10n) => switch (kind) {
    FirmwareManagerErrorKind.loadFailed => l10n.firmwareErrorLoadFailed,
    FirmwareManagerErrorKind.onDeviceHotspot => l10n.firmwareErrorOnHotspot,
    FirmwareManagerErrorKind.cacheFull => l10n.firmwareErrorCacheFull,
    FirmwareManagerErrorKind.serverUnreachable =>
      l10n.firmwareErrorServerUnreachable,
    FirmwareManagerErrorKind.downloadInterrupted =>
      l10n.firmwareErrorDownloadInterrupted,
    FirmwareManagerErrorKind.downloadFailed =>
      l10n.firmwareErrorDownloadFailed,
    FirmwareManagerErrorKind.deleteFailed => l10n.firmwareErrorDeleteFailed,
  };
}
