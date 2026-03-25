import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../../flashing/data/releases_repository.dart';
import '../../settings/presentation/settings_controller.dart';
import '../../../core/storage/firmware_cache_service.dart';
import '../../flashing/data/firmware_repository.dart';
import '../../../core/networking/connection_repository.dart';

part 'firmware_manager_controller.freezed.dart';
part 'firmware_manager_controller.g.dart';

@freezed
abstract class FirmwareManagerState with _$FirmwareManagerState {
  const factory FirmwareManagerState({
    @Default([]) List<String> availableVersions,
    @Default([]) List<String> cachedVersions,
    @Default(false) bool isLoading,
    @Default({}) Map<String, double> downloadProgress,
    @Default(0.0) double cacheSizeMb,
    String? errorMessage,
  }) = _FirmwareManagerState;
}

@Riverpod(keepAlive: true)
class FirmwareManagerController extends _$FirmwareManagerController {
  static final _log = Logger('FirmwareManagerController');
  @override
  FirmwareManagerState build() {
    return const FirmwareManagerState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final cacheService = ref.read(firmwareCacheServiceProvider);
      final releasesRepo = ref.read(releasesRepositoryProvider);

      // Fetch available versions (online)
      // Note: This might fail if offline. We should handle that gracefully.
      List<String> available = [];
      try {
        available = await releasesRepo.fetchVersions();
      } catch (e) {
        _log.warning('Failed to fetch available versions: $e');
        // If offline, maybe we only show cached?
      }

      final cached = await cacheService.getCachedVersions();
      final size = await cacheService.getCacheSizeMb();

      state = state.copyWith(
        isLoading: false,
        availableVersions: available,
        cachedVersions: cached,
        cacheSizeMb: size,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading: $e',
      );
    }
  }

  Future<void> downloadVersion(String version) async {
    // Safeguard: Prevent downloads ONLY if connected directly to the ELRS device hotspot
    final targetIp = ref.read(targetIpProvider);
    if (targetIp == '10.0.0.1') {
      state = state.copyWith(
        errorMessage: 'Cannot download firmware while connected directly to the receiver\'s Wi-Fi hotspot. Please disconnect or use a home network.',
      );
      return;
    }

    final settings = ref.read(settingsControllerProvider);
    final cacheService = ref.read(firmwareCacheServiceProvider);
    final firmwareRepo = ref.read(firmwareRepositoryProvider);

    // Safeguard: Cache limit
    final cached = await cacheService.getCachedVersions();
    if (cached.length >= settings.maxCachedVersions && !cached.contains(version)) {
      state = state.copyWith(
        errorMessage: 'Cache limit reached. Please delete an old version.',
      );
      return;
    }

    state = state.copyWith(
      downloadProgress: {...state.downloadProgress, version: 0.0},
      errorMessage: null,
    );

    try {
      // 1. Fetch Hash
      final hash = await firmwareRepo.fetchHashForVersion(version);

      // 2. Download Firmware Zip
      final firmwareBytes = await firmwareRepo.downloadArtifact(
        hash,
        'firmware.zip',
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // 50% progress allocated to firmware zip
            final progress = (received / total) * 0.5;
            state = state.copyWith(
              downloadProgress: {...state.downloadProgress, version: progress},
            );
          }
        },
      );

      // 3. Download Hardware Zip (from fixed URL)
      final hardwareBytes = await firmwareRepo.downloadHardwareZip(
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // 50% to 100% progress allocated to hardware zip
            final progress = 0.5 + ((received / total) * 0.5);
            state = state.copyWith(
              downloadProgress: {...state.downloadProgress, version: progress},
            );
          }
        },
      );

      // 4. Save both to cache
      await cacheService.saveZip(version, firmwareBytes);
      await cacheService.saveHardwareZip(version, hardwareBytes);

      Sentry.metrics.count(
        'firmware_download_completed',
        1,
        attributes: {'version': SentryAttribute.string(version)},
      );

      // Perform eviction to maintain limit
      await cacheService.evictOldestVersions(settings.maxCachedVersions);

      // Refresh cache list
      final cached = await cacheService.getCachedVersions();
      final size = await cacheService.getCacheSizeMb();

      state = state.copyWith(
        cachedVersions: cached,
        cacheSizeMb: size,
        downloadProgress: {...state.downloadProgress}..remove(version),
      );
    } on DioException catch (e) {
      _log.warning('Network error during firmware download', e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Network error: Unable to reach the firmware server. Please check your internet connection.',
        downloadProgress: {...state.downloadProgress}..remove(version),
      );
    } catch (e) {
      // Cleanup on failure
      await cacheService.deleteCachedZip(version);

      state = state.copyWith(
        errorMessage: 'Download failed: $e',
        downloadProgress: {...state.downloadProgress}..remove(version),
      );
    }
  }

  Future<void> deleteVersion(String version) async {
    try {
      final cacheService = ref.read(firmwareCacheServiceProvider);
      await cacheService.deleteCachedZip(version);

      final cached = await cacheService.getCachedVersions();
      final size = await cacheService.getCacheSizeMb();

      state = state.copyWith(cachedVersions: cached, cacheSizeMb: size);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Delete failed: $e');
    }
  }
}
