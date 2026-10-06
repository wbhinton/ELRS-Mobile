import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/persistence_service.dart';
import '../data/app_update_repository.dart';
import '../domain/app_release.dart';

part 'app_update_service.g.dart';

/// True only in the APK built for direct download (cdn.elrsmobile.com and
/// GitHub Releases), via `--dart-define=DISTRIBUTION=direct`.
///
/// Store builds leave it false, and because it is a compile-time constant
/// the update check is stripped from them entirely: Google Play and the
/// App Store handle their own updates.
const kIsDirectDistribution =
    String.fromEnvironment('DISTRIBUTION') == 'direct';

sealed class UpdateCheckResult {
  const UpdateCheckResult();
}

class UpdateAvailable extends UpdateCheckResult {
  const UpdateAvailable(this.release, this.currentVersion);

  final AppRelease release;
  final String currentVersion;
}

class NoUpdate extends UpdateCheckResult {
  const NoUpdate();
}

class UpdateCheckFailed extends UpdateCheckResult {
  const UpdateCheckFailed();
}

class AppUpdateService {
  AppUpdateService({
    required AppUpdateRepository repository,
    required PersistenceService persistence,
    required Future<PackageInfo> Function() packageInfo,
    bool? enabled,
    DateTime Function()? now,
  })  : _repository = repository,
        _persistence = persistence,
        _packageInfo = packageInfo,
        _enabled = enabled ??
            (kIsDirectDistribution &&
                !kIsWeb &&
                defaultTargetPlatform == TargetPlatform.android),
        _now = now ?? DateTime.now;

  final AppUpdateRepository _repository;
  final PersistenceService _persistence;
  final Future<PackageInfo> Function() _packageInfo;
  final bool _enabled;
  final DateTime Function() _now;

  static const checkInterval = Duration(hours: 24);

  /// Checks for a newer direct-download release.
  ///
  /// Automatic checks run at most once per [checkInterval] and ignore a
  /// version the user chose to skip. A [manual] check (from Settings)
  /// bypasses both.
  Future<UpdateCheckResult> checkForUpdate({bool manual = false}) async {
    if (!_enabled) return const NoUpdate();

    if (!manual) {
      final lastCheck = _persistence.getLastUpdateCheck();
      if (lastCheck != null && _now().difference(lastCheck) < checkInterval) {
        return const NoUpdate();
      }
    }

    final release = await _repository.fetchLatestRelease();
    if (release == null) return const UpdateCheckFailed();
    // Only a successful check counts, so an offline launch retries next time.
    await _persistence.setLastUpdateCheck(_now());

    final info = await _packageInfo();
    final currentCode = int.tryParse(info.buildNumber);
    if (currentCode == null || release.versionCode <= currentCode) {
      return const NoUpdate();
    }

    if (!manual &&
        _persistence.getSkippedUpdateVersionCode() == release.versionCode) {
      return const NoUpdate();
    }

    return UpdateAvailable(release, info.version);
  }

  Future<void> skipVersion(AppRelease release) =>
      _persistence.setSkippedUpdateVersionCode(release.versionCode);
}

@riverpod
Future<AppUpdateService> appUpdateService(Ref ref) async {
  final persistence = await ref.watch(persistenceServiceProvider.future);
  return AppUpdateService(
    repository: ref.watch(appUpdateRepositoryProvider),
    persistence: persistence,
    packageInfo: PackageInfo.fromPlatform,
  );
}
