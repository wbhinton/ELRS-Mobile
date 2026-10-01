// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

/// What went wrong during a flash or firmware download.
///
/// The controller reports *which* error occurred; the screen turns it into
/// localised text. Text that comes from the device or the network is carried
/// verbatim in [detail] and shown untranslated, since it's what a user would
/// paste into a bug report.
sealed class FlashError {
  const FlashError();

  /// Stable identifier for analytics, independent of display language.
  String get code;

  /// Untranslated device/network message, when there is one.
  String? get detail => null;
}

final class NoTargetSelected extends FlashError {
  const NoTargetSelected();
  @override
  String get code => 'no_target';
}

final class NoVersionSelected extends FlashError {
  const NoVersionSelected();
  @override
  String get code => 'no_version';
}

final class NoDeviceConnected extends FlashError {
  const NoDeviceConnected();
  @override
  String get code => 'no_device';
}

/// Prompts the user to confirm flashing without a binding phrase.
final class NoBindPhrase extends FlashError {
  const NoBindPhrase();
  @override
  String get code => 'no_bind_phrase';
}

/// The selected firmware is built for a different chip than the device.
final class ChipMismatch extends FlashError {
  const ChipMismatch({required this.deviceChip, required this.targetChip});
  final String deviceChip;
  final String targetChip;
  @override
  String get code => 'chip_mismatch';
}

/// Firmware files are missing from the cache and couldn't be fetched,
/// usually because the phone is on the device's hotspot.
final class OfflineMissingFiles extends FlashError {
  const OfflineMissingFiles({required this.duringFlash});

  /// True when this happened while flashing rather than saving a binary;
  /// the advice differs slightly.
  final bool duringFlash;
  @override
  String get code => 'offline_missing_files';
}

final class FlashFailed extends FlashError {
  const FlashFailed(this.detail);
  @override
  final String detail;
  @override
  String get code => 'flash_failed';
}

/// The device dropped the connection after receiving the image but before
/// replying, so whether the flash took is unknown.
final class FlashUnconfirmed extends FlashError {
  const FlashUnconfirmed(this.detail);
  @override
  final String detail;
  @override
  String get code => 'flash_unconfirmed';
}

final class DownloadFailed extends FlashError {
  const DownloadFailed(this.detail);
  @override
  final String detail;
  @override
  String get code => 'download_failed';
}

/// Strips the nested `Exception: ` prefixes that wrapping adds, leaving the
/// underlying message readable.
String describeFailure(Object error) =>
    error.toString().replaceAll('Exception: ', '');
