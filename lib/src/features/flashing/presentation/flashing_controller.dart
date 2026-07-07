import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logging/logging.dart';

import '../application/firmware_patcher.dart';
import '../domain/patch_configuration.dart';
import '../data/firmware_repository.dart';
import '../data/device_repository.dart';
import '../domain/flashing_profile.dart';

import '../../../core/storage/firmware_cache_service.dart';
import '../domain/target_definition.dart';
import '../utils/target_resolver.dart';
import '../../../core/utils/binding_phrase_utils.dart';
import 'package:archive/archive.dart';
import '../../../core/storage/persistence_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../settings/presentation/settings_controller.dart';
import '../../../core/utils/validation_utils.dart';

import '../state/flashing_provider.dart';
import '../../../core/networking/connectivity_service.dart';
import '../../../core/analytics/analytics_service.dart';
import '../../config/presentation/config_view_model.dart';
import '../../config/domain/runtime_config_model.dart';
import '../data/targets_provider.dart';

part 'flashing_controller.freezed.dart';
part 'flashing_controller.g.dart';

enum FlashingStatus {
  idle,
  downloading,
  patching,
  uploading,
  success,
  downloadSuccess,
  error,
  mismatch,
}

@freezed
abstract class FlashingState with _$FlashingState {
  const factory FlashingState({
    String? selectedDeviceType,
    String? selectedVendor,
    String? selectedFrequency,
    TargetDefinition? selectedTarget,
    String? selectedVersion,
    @Default(FlashingStatus.idle) FlashingStatus status,
    @Default(0.0) double progress,
    String? errorMessage,
    @Default('') String bindPhrase,
    @Default('') String wifiSsid,
    @Default('') String wifiPassword,
    @Default(0) int regulatoryDomain,
    @Default(60) int wifiOnInterval,
    String? autosavingField,
    String? bindPhraseError,
    String? wifiSsidError,
    String? wifiPasswordError,
    Uint8List? cachedPayload, // NEW: Retain binary across lifecycles
  }) = _FlashingState;
}

@Riverpod(keepAlive: true)
class FlashingController extends _$FlashingController {
  static final _log = Logger('FlashingController');

  @override
  FlashingState build() {
    ref.listen(settingsControllerProvider, (previous, next) {
      final prevActive = previous?.profiles.firstWhere(
        (p) => p.id == previous.activeProfileId,
        orElse: () => const FlashingProfile(id: '', name: ''),
      );
      final nextActive = next.profiles.firstWhere(
        (p) => p.id == next.activeProfileId,
        orElse: () => const FlashingProfile(id: '', name: ''),
      );

      if (prevActive != nextActive) {
        final is2G4 = state.selectedTarget?.is2400Mhz ?? true;
        final regDomain = is2G4
            ? nextActive.defaultDomain2400
            : nextActive.defaultDomain900;

        state = state.copyWith(
          bindPhrase: nextActive.bindPhrase,
          wifiSsid: nextActive.wifiSsid,
          wifiPassword: nextActive.wifiPassword,
          regulatoryDomain: regDomain,
          wifiOnInterval: nextActive.wifiOnInterval == 0
              ? 60
              : nextActive.wifiOnInterval,
        );
      }

      // Still listen to global wifiOnInterval
      if (previous?.wifiOnInterval != next.wifiOnInterval) {
        state = state.copyWith(wifiOnInterval: next.wifiOnInterval);
      }
    });

    // Initialize with current settings values
    final settings = ref.read(settingsControllerProvider);
    final activeProfile = settings.profiles.firstWhere(
      (p) => p.id == settings.activeProfileId,
      orElse: () =>
          const FlashingProfile(id: 'default', name: 'Default Profile'),
    );
    final initialRegDomain = activeProfile.defaultDomain2400;

    return FlashingState(
      bindPhrase: activeProfile.bindPhrase,
      wifiSsid: activeProfile.wifiSsid,
      wifiPassword: activeProfile.wifiPassword,
      regulatoryDomain: initialRegDomain,
      wifiOnInterval: activeProfile.wifiOnInterval == 0
          ? 60
          : activeProfile.wifiOnInterval,
    );
  }

  Future<void> loadSavedOptions() async {
    final settings = ref.read(settingsControllerProvider);
    final activeProfile = settings.profiles.firstWhere(
      (p) => p.id == settings.activeProfileId,
      orElse: () =>
          const FlashingProfile(id: 'default', name: 'Default Profile'),
    );

    final is2G4 = state.selectedTarget?.is2400Mhz ?? true;
    final regDomain = is2G4
        ? activeProfile.defaultDomain2400
        : activeProfile.defaultDomain900;

    state = state.copyWith(
      bindPhrase: activeProfile.bindPhrase,
      wifiSsid: activeProfile.wifiSsid,
      wifiPassword: activeProfile.wifiPassword,
      regulatoryDomain: regDomain,
      wifiOnInterval: activeProfile.wifiOnInterval == 0
          ? 60
          : activeProfile.wifiOnInterval,
    );
  }

  Future<void> autoSelectFromConnectedDevice() async {
    // Only auto-select if nothing is currently selected in the UI
    if (state.selectedTarget != null) return;

    final configState = ref.read(configViewModelProvider);
    if (!configState.hasValue || configState.value == null) return;
    final config = configState.value!;

    // ELRS V3/V4 uses product_name, fallback to effectiveProductName
    final deviceName = config.effectiveProductName;
    if (deviceName == 'Unknown Device' || deviceName.isEmpty) return;

    try {
      final targets = await ref.read(targetsProvider.future);

      // Find the target where the parsed name matches the connected device
      TargetDefinition? match;
      try {
        match = targets.firstWhere(
          (t) =>
              t.name.toLowerCase() == deviceName.toLowerCase() ||
              (t.productCode != null &&
                  t.productCode!.toLowerCase() == deviceName.toLowerCase()),
        );
      } catch (_) {
        // Catch StateError if no match is found in the iterable
      }

      if (match != null) {
        state = state.copyWith(
          selectedDeviceType: match.deviceType,
          selectedVendor: match.vendor,
          selectedFrequency: match.frequencyType,
          selectedTarget: match,
        );
        _log.info('Auto-selected target: ${match.name}');
      } else {
        _log.warning('No matching target found for device name: $deviceName');
      }
    } catch (e) {
      _log.warning('Could not auto-select target, Error: $e');
    }
  }

  void selectDeviceType(String? type) {
    state = state.copyWith(
      selectedDeviceType: type,
      selectedVendor: null,
      selectedFrequency: null,
      selectedTarget: null,
      status: FlashingStatus.idle,
      errorMessage: null,
    );
  }

  void selectVendor(String? vendor) {
    state = state.copyWith(
      selectedVendor: vendor,
      selectedFrequency: null,
      selectedTarget: null,
      status: FlashingStatus.idle,
      errorMessage: null,
    );
  }

  void selectFrequency(String? freq) {
    state = state.copyWith(
      selectedFrequency: freq,
      selectedTarget: null,
      status: FlashingStatus.idle,
      errorMessage: null,
    );
  }

  void selectTarget(TargetDefinition? target) {
    String? updatedVersion = state.selectedVersion;

    // If switching to an STM32 target, clear the version if it's a 4.x release
    // (STM32 support was dropped in ELRS v4.0.0)
    if (target?.platform == 'stm32' &&
        updatedVersion != null &&
        (updatedVersion.startsWith('4.') || updatedVersion.startsWith('v4.'))) {
      updatedVersion = null;
    }

    final settings = ref.read(settingsControllerProvider);
    final activeProfile = settings.profiles.firstWhere(
      (p) => p.id == settings.activeProfileId,
      orElse: () =>
          const FlashingProfile(id: 'default', name: 'Default Profile'),
    );
    final is2G4 = target?.is2400Mhz ?? true;
    final regDomain = is2G4
        ? activeProfile.defaultDomain2400
        : activeProfile.defaultDomain900;

    state = state.copyWith(
      selectedTarget: target,
      selectedVersion: updatedVersion,
      regulatoryDomain: regDomain,
      status: FlashingStatus.idle,
      errorMessage: null,
    );
  }

  void selectVersion(String? version) {
    state = state.copyWith(selectedVersion: version);
  }

  Future<void> setBindPhrase(String value) async {
    final error = ValidationUtils.validateBindPhrase(value);
    state = state.copyWith(bindPhrase: value, bindPhraseError: error);
    if (error == null) {
      final settings = ref.read(settingsControllerProvider);
      final activeProfile = settings.profiles.firstWhere(
        (p) => p.id == settings.activeProfileId,
        orElse: () =>
            const FlashingProfile(id: 'default', name: 'Default Profile'),
      );
      final updatedProfile = activeProfile.copyWith(bindPhrase: value);
      await ref
          .read(settingsControllerProvider.notifier)
          .updateActiveProfile(updatedProfile);
      _triggerAutosaveFeedback('bindPhrase');
    }
  }

  Future<void> setWifiSsid(String value) async {
    final error = ValidationUtils.validateSsid(value);
    state = state.copyWith(wifiSsid: value, wifiSsidError: error);
    if (error == null) {
      final settings = ref.read(settingsControllerProvider);
      final activeProfile = settings.profiles.firstWhere(
        (p) => p.id == settings.activeProfileId,
        orElse: () =>
            const FlashingProfile(id: 'default', name: 'Default Profile'),
      );
      final updatedProfile = activeProfile.copyWith(wifiSsid: value);
      await ref
          .read(settingsControllerProvider.notifier)
          .updateActiveProfile(updatedProfile);
      _triggerAutosaveFeedback('wifiSsid');
    }
  }

  Future<void> setWifiPassword(String value) async {
    final error = ValidationUtils.validatePassword(value);
    state = state.copyWith(wifiPassword: value, wifiPasswordError: error);
    if (error == null || value.isEmpty) {
      final settings = ref.read(settingsControllerProvider);
      final activeProfile = settings.profiles.firstWhere(
        (p) => p.id == settings.activeProfileId,
        orElse: () =>
            const FlashingProfile(id: 'default', name: 'Default Profile'),
      );
      final updatedProfile = activeProfile.copyWith(wifiPassword: value);
      await ref
          .read(settingsControllerProvider.notifier)
          .updateActiveProfile(updatedProfile);
      _triggerAutosaveFeedback('wifiPassword');
      if (value.isEmpty) {
        state = state.copyWith(wifiPasswordError: null);
      }
    }
  }

  Future<void> setRegulatoryDomain(int id) async {
    state = state.copyWith(regulatoryDomain: id);
    final is2G4 = state.selectedTarget?.is2400Mhz ?? true;
    final settings = ref.read(settingsControllerProvider);
    final activeProfile = settings.profiles.firstWhere(
      (p) => p.id == settings.activeProfileId,
      orElse: () =>
          const FlashingProfile(id: 'default', name: 'Default Profile'),
    );
    final updatedProfile = is2G4
        ? activeProfile.copyWith(defaultDomain2400: id)
        : activeProfile.copyWith(defaultDomain900: id);
    await ref
        .read(settingsControllerProvider.notifier)
        .updateActiveProfile(updatedProfile);
  }

  Future<void> setWifiOnInterval(int value) async {
    state = state.copyWith(wifiOnInterval: value);
    final settings = ref.read(settingsControllerProvider);
    final activeProfile = settings.profiles.firstWhere(
      (p) => p.id == settings.activeProfileId,
      orElse: () =>
          const FlashingProfile(id: 'default', name: 'Default Profile'),
    );
    final updatedProfile = activeProfile.copyWith(wifiOnInterval: value);
    await ref
        .read(settingsControllerProvider.notifier)
        .updateActiveProfile(updatedProfile);
    _triggerAutosaveFeedback('wifiOnInterval');
  }

  void _triggerAutosaveFeedback(String field) {
    state = state.copyWith(autosavingField: field);
    Future.delayed(const Duration(seconds: 1), () {
      if (state.autosavingField == field) {
        state = state.copyWith(autosavingField: null);
      }
    });
  }

  Future<void> downloadFirmware() async {
    if (state.selectedTarget == null || state.selectedVersion == null) {
      state = state.copyWith(
        errorMessage: 'Please select a target and version.',
      );
      return;
    }

    state = state.copyWith(
      status: FlashingStatus.downloading,
      progress: 0.0,
      errorMessage: null,
    );

    File? tempFile;
    try {
      final version = state.selectedVersion!;
      final cacheService = ref.read(firmwareCacheServiceProvider);
      final firmwareRepo = ref.read(firmwareRepositoryProvider);

      final cachedZip = await cacheService.getZipFile(version);
      final cachedHardwareZip = await cacheService.getHardwareZipFile(version);

      if (cachedZip == null || cachedHardwareZip == null) {
        // Cache missing or incomplete. Fallback to network download.
        // 1. Unbind process to permit mobile data for Artifactory download
        final connectivity = ref.read(connectivityServiceProvider.notifier);
        await connectivity.unbind();

        // Download both zips concurrently
        final results = await Future.wait([
          firmwareRepo.downloadFirmwareZip(version),
          firmwareRepo.downloadHardwareZip(),
        ]);

        // Save to local storage (results[0] is firmware, results[1] is hardware)
        await cacheService.saveZip(version, results[0]);
        await cacheService.saveHardwareZip(version, results[1]);
      } else {
        _log.info('Using locally cached zip files for offline download');
      }

      final payload = await _buildFinalPayload();

      state = state.copyWith(status: FlashingStatus.patching, progress: 0.5);

      final settingsState = ref.read(settingsControllerProvider);
      final activeProfile = settingsState.profiles.firstWhere(
        (p) => p.id == settingsState.activeProfileId,
        orElse: () => const FlashingProfile(id: '', name: ''),
      );

      final profilePart = activeProfile.name.trim().isNotEmpty
          ? '_${activeProfile.name.trim().replaceAll(' ', '_').replaceAll('/', '_').replaceAll('\\', '_')}'
          : '';

      final targetName = state.selectedTarget!.name
          .replaceAll(' ', '_')
          .replaceAll('/', '_') // Sanitize slashes (e.g. 2.4/900)
          .replaceAll('\\', '_');
      final extension = payload.filename.endsWith('.gz') ? '.gz' : '.bin';
      final downloadName = 'ELRS_$targetName${profilePart}_Firmware$extension';

      // Step A (Temp Storage): Save to app's temporary directory
      final tempDir = await getTemporaryDirectory();
      tempFile = File('${tempDir.path}/$downloadName');
      await tempFile.writeAsBytes(payload.bytes);

      // Step B (System Picker): Trigger native 'Save As' dialog
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Firmware Binary',
        fileName: downloadName,
        bytes: payload.bytes,
      );

      // Give native presentation controllers time to settle down
      await Future.delayed(const Duration(milliseconds: 300));

      if (result != null) {
        state = state.copyWith(
          status: FlashingStatus.downloadSuccess,
          progress: 1.0,
        );
        ref.read(analyticsServiceProvider).trackEvent('Firmware Downloaded', {
          'target': state.selectedTarget?.name ?? 'Unknown',
          'version': state.selectedVersion ?? 'Unknown',
        });
        debugPrint('Firmware saved successfully to $result');
      } else {
        // User cancelled
        state = state.copyWith(status: FlashingStatus.idle, progress: 0.0);
      }
    } catch (e) {
      String msg = 'Failed to download firmware: $e';
      final errStr = e.toString().toLowerCase();

      if (errStr.contains('connection error') ||
          errStr.contains('connection refused') ||
          errStr.contains('failed host lookup')) {
        msg =
            'No internet access. You cannot download firmware while connected to the ELRS device hotspot. Please disconnect, download this version via the Firmware Manager, and try again.';
      }

      state = state.copyWith(
        status: FlashingStatus.error,
        errorMessage: msg,
        progress: 0.0,
      );
      ref.read(analyticsServiceProvider).trackEvent('Firmware Download Error', {
        'error': msg,
      });
    } finally {
      // Step C (Cleanup): Delete temporary file
      if (tempFile != null && await tempFile.exists()) {
        try {
          await tempFile.delete();
        } catch (e) {
          debugPrint('Warning: Failed to cleanup temp file: $e');
        }
      }
      // 2. Re-bind to WiFi to restore local connectivity state
      try {
        await ref.read(connectivityServiceProvider.notifier).ensureBound();
      } catch (e) {
        debugPrint('Warning: Failed to re-bind connectivity: $e');
      }
    }
  }

  Future<({Uint8List bytes, String filename})> _prepareFirmware() async {
    final version = state.selectedVersion!;
    final cacheService = ref.read(firmwareCacheServiceProvider);
    final firmwareRepo = ref.read(firmwareRepositoryProvider);

    final cachedZip = await cacheService.getZipFile(version);
    final cachedHardwareZip = await cacheService.getHardwareZipFile(version);

    FirmwareData firmwareData;

    final target = state.selectedTarget;
    final domainId = state.regulatoryDomain & 0x0F;
    bool isLbt = false;

    if (target != null) {
      if (target.is2400Mhz && !target.isDualBand) {
        isLbt = (domainId == 1); // 1 = EU LBT in 2.4GHz dropdown
      } else if (target.isDualBand) {
        isLbt =
            (domainId == 2 ||
            domainId == 5); // EU868 or EU433 in Sub-GHz dropdown
      }
    }

    if (cachedZip != null && cachedHardwareZip != null) {
      _log.info('Building firmware from local cache for version $version');
      state = state.copyWith(status: FlashingStatus.downloading, progress: 0.1);
      final zipBytes = await cachedZip.readAsBytes();

      firmwareData = await ref
          .read(firmwareRepositoryProvider)
          .extractFirmwareFromZip(
            zipBytes,
            state.selectedTarget!.firmware ??
                state.selectedTarget!.productCode ??
                'unknown',
            isLbt: isLbt,
          );
    } else {
      _log.info(
        'Cache missing or incomplete. Self-healing / downloading from Artifactory...',
      );
      state = state.copyWith(status: FlashingStatus.downloading);
      // Self-heal incomplete legacy caches
      final hasHardware = cachedHardwareZip != null;
      if (!hasHardware) {
        final hardwareBytes = await firmwareRepo.downloadHardwareZip();
        await cacheService.saveHardwareZip(version, hardwareBytes);
      }

      // Download from Artifactory
      firmwareData = await ref
          .read(firmwareRepositoryProvider)
          .downloadFirmware(
            state.selectedTarget!.firmware ??
                state.selectedTarget!.productCode ??
                'unknown',
            state.selectedVersion!,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                final progress = (received / total);
                final overallProgress = (progress * 0.4);
                state = state.copyWith(
                  progress: overallProgress,
                  status: FlashingStatus.downloading,
                );
              }
            },
            isLbt: isLbt,
          );
    }

    state = state.copyWith(status: FlashingStatus.patching, progress: 0.33);

    Uint8List finalBytes;

    final targetConfig = state.selectedTarget!.config;
    final isUnified = targetConfig.containsKey('layout_file');

    if (firmwareData.filename.endsWith('.gz')) {
      finalBytes = firmwareData.bytes;
    } else if (isUnified) {
      finalBytes = firmwareData.bytes;
    } else {
      final config = PatchConfiguration(
        bindPhrase: state.bindPhrase,
        wifiSsid: state.wifiSsid,
        wifiPassword: state.wifiPassword,
        regulatoryDomain: state.regulatoryDomain,
        wifiOnInterval: state.wifiOnInterval,
      );

      final patcher = ref.read(firmwarePatcherProvider);
      finalBytes = await patcher.patchFirmware(
        firmwareData.bytes,
        config,
        platform: state.selectedTarget?.platform,
      );
    }

    return (bytes: finalBytes, filename: firmwareData.filename);
  }

  Future<({Uint8List bytes, String filename})> _buildFinalPayload() async {
    // Return cached bytes immediately if already compiled to prevent duplicates
    if (state.cachedPayload != null) {
      return (bytes: state.cachedPayload!, filename: 'firmware.gz');
    }

    final firmware = await _prepareFirmware();
    final finalBytes = firmware.bytes;
    final filename = firmware.filename;

    String? productName;
    String? luaName;
    List<int>? uid;
    Map<String, dynamic>? mergedHardwareLayout;

    final targetConfig = state.selectedTarget!.config;
    final isUnified = targetConfig.containsKey('layout_file');

    if (isUnified) {
      debugPrint('Preparing Target-Aware Build...');
      try {
        final cacheService = ref.read(firmwareCacheServiceProvider);
        final zipFile = await cacheService.getHardwareZipFile(
          state.selectedVersion!,
        );
        if (zipFile == null) throw Exception('Hardware zip not found');

        final zipBytes = await zipFile.readAsBytes();
        final archive = ZipDecoder().decodeBytes(zipBytes);

        mergedHardwareLayout = TargetResolver.resolveLayout(
          targetConfig,
          archive,
        );

        productName =
            targetConfig['product_name'] as String? ??
            state.selectedTarget!.name;
        luaName = targetConfig['lua_name'] as String? ?? 'ELRS';

        if (state.bindPhrase.isNotEmpty) {
          uid = BindingPhraseUtils.generateUid(state.bindPhrase);
        } else {
          uid = BindingPhraseUtils.generateUid('');
        }
      } catch (e) {
        debugPrint('Warning: Failed to prepare unified build data: $e');
        throw Exception('Failed to prepare Unified Firmware: $e');
      }
    }

    // Determine if we should send a domain (Sub-GHz or Dual-Band)
    int? finalDomain;
    final target = state.selectedTarget;

    final isSubGhzOrDual =
        (target != null && (target.is900Mhz || target.isDualBand)) ||
        (productName != null &&
            (productName.contains('900') ||
                productName.contains('433') ||
                productName.toLowerCase().contains('dual')));

    if (isSubGhzOrDual) {
      finalDomain = state.regulatoryDomain;
    }

    final deviceRepo = ref.read(deviceRepositoryProvider);
    final isTx = state.selectedTarget?.deviceType == 'TX';
    final payload = await deviceRepo.buildFirmwarePayload(
      finalBytes,
      filename,
      productName: productName,
      luaName: luaName,
      uid: uid,
      hardwareLayout: mergedHardwareLayout,
      wifiSsid: state.wifiSsid,
      wifiPassword: state.wifiPassword,
      platform: state.selectedTarget!.platform,
      domain: finalDomain,
      wifiOnInterval: state.wifiOnInterval,
      isTx: isTx,
    );

    // Save to persistent state before returning
    state = state.copyWith(cachedPayload: payload.bytes);
    return payload;
  }

  Future<void> flash({
    bool force = false,
    bool ignoreMissingBindPhrase = false,
  }) async {
    if (state.selectedTarget == null) {
      state = state.copyWith(errorMessage: 'Please select a target device.');
      return;
    }
    if (state.selectedVersion == null) {
      state = state.copyWith(errorMessage: 'Please select a firmware version.');
      return;
    }

    final configState = ref.read(configViewModelProvider);
    if (!configState.hasValue || configState.value == null) {
      state = state.copyWith(
        errorMessage: 'Cannot flash: No ELRS device connected.',
      );
      return;
    }

    // Flash Guard: Check binding phrase
    if (state.bindPhrase.isEmpty && !ignoreMissingBindPhrase) {
      final persistence = await ref.read(persistenceServiceProvider.future);
      final savedBindPhrase = await persistence.getBindPhrase();

      if (savedBindPhrase.isEmpty) {
        state = state.copyWith(
          status: FlashingStatus.error,
          errorMessage: 'NO_BIND_PHRASE',
        );
        return;
      } else {
        // Recover from persistence if state was somehow empty but storage has it
        state = state.copyWith(bindPhrase: savedBindPhrase);
      }
    }

    // Pre-flight Target Mismatch Guard
    // Compares at the PRODUCT level, not the platform level.
    // Multiple products share the same unified target (e.g. UNIFIED_ESP8285_2400_RX)
    // so we must compare product_name to catch cross-product mismatches.
    if (!force) {
      final deviceConfig = configState.value!;
      final deviceProductName = deviceConfig.effectiveProductName;
      final selectedProductName =
          state.selectedTarget!.config['product_name'] as String? ??
          state.selectedTarget!.name;

      // Normalize for comparison
      final normalizedDevice = deviceProductName.toLowerCase().trim();
      final normalizedSelected = selectedProductName.toLowerCase().trim();

      final isMismatch =
          normalizedDevice != normalizedSelected &&
          normalizedDevice !=
              'elrs device'; // Skip check if device didn't report a name

      if (isMismatch) {
        state = state.copyWith(
          status: FlashingStatus.mismatch,
        );
        return;
      }
    }

    state = state.copyWith(
      status: FlashingStatus.downloading,
      progress: 0.0,
      errorMessage: null,
    );

    // Keep the screen on while flashing — released unconditionally in finally.
    await WakelockPlus.enable();

    // Silence UI heartbeat
    ref.read(isFlashingProvider.notifier).setFlashing(true);

    // Give heartbeats a chance to cancel and the ESP to settle
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final connectivity = ref.read(connectivityServiceProvider.notifier);

      // 1. Unbind process to allow firmware download via mobile data if needed
      await connectivity.unbind();

      final payload = await _buildFinalPayload();

      state = state.copyWith(status: FlashingStatus.uploading, progress: 0.66);

      // 2. RE-BIND to WiFi interface to ensure the upload reaches 10.0.0.1
      await connectivity.bindToWiFi();

      // 3. Upload
      final deviceRepo = ref.read(deviceRepositoryProvider);
      final isTx = state.selectedTarget?.deviceType == 'TX';

      await deviceRepo.flashFirmware(
        payload.bytes,
        payload.filename,
        force: force,
        isTx: isTx,
      );

      ref.read(isFlashingProvider.notifier).setFlashing(false);
      state = state.copyWith(status: FlashingStatus.success, progress: 1.0);
      Sentry.metrics.count(
        'firmware_flash_success',
        1,
        attributes: {
          'target': SentryAttribute.string(
            state.selectedTarget?.name ?? 'unknown',
          ),
        },
      );
      ref.read(analyticsServiceProvider).trackEvent('Firmware Flashed', {
        'target': state.selectedTarget?.name ?? 'Unknown',
        'version': state.selectedVersion ?? 'Unknown',
      });
    } catch (e) {
      var errorMsg = e.toString();
      final errStr = errorMsg.toLowerCase();

      // Keep the flashing lock active on mismatch to block background polling from clearing the upload
      if (!errStr.contains('mismatch')) {
        ref.read(isFlashingProvider.notifier).setFlashing(false);
      }

      if (errStr.contains('connection error') ||
          errStr.contains('connection refused') ||
          errStr.contains('failed host lookup')) {
        errorMsg =
            'No internet access to fetch missing files. Please disconnect from the ELRS device, download this firmware via the Firmware Manager to complete your cache, and try again.';
      }

      if (errorMsg.contains('mismatch')) {
        state = state.copyWith(
          status: FlashingStatus.mismatch,
          errorMessage:
              'Target mismatch detected. Forced update was attempted.',
          progress: 0.0,
        );
      } else {
        state = state.copyWith(
          status: FlashingStatus.error,
          errorMessage: errorMsg,
          progress: 0.0,
        );
      }
      Sentry.metrics.count(
        'firmware_flash_failure',
        1,
        attributes: {'error': SentryAttribute.string(state.status.toString())},
      );
      ref.read(analyticsServiceProvider).trackEvent('Firmware Flash Error', {
        'errorType': state.status.toString(),
        'error': errorMsg,
      });
    } finally {
      // Restore connectivity binding and release wake lock.
      await ref.read(connectivityServiceProvider.notifier).ensureBound();
      await WakelockPlus.disable();
    }
  }

  void resetStatus() {
    ref.read(isFlashingProvider.notifier).setFlashing(false);
    state = state.copyWith(
      status: FlashingStatus.idle,
      errorMessage: null,
      progress: 0.0,
      cachedPayload: null,
    );
  }

  Future<void> forceUpdate() async {
    try {
      state = state.copyWith(status: FlashingStatus.uploading);
      final repo = ref.read(deviceRepositoryProvider);
      final payload = await _buildFinalPayload();

      // 1. Re-fill the ESP's OTA buffer!
      // Because the user took time to read the warning dialog, the ESP's
      // 10-second idle timer expired and cleared the firmware from RAM.
      try {
        await repo.flashFirmware(
          payload.bytes,
          payload.filename,
          onSendProgress: (sent, total) {
            if (total > 0) {
              state = state.copyWith(progress: sent / total);
            }
          },
        );
      } catch (e) {
        // We EXPECT it to throw a mismatch exception here because we just
        // re-uploaded the mismatched file. We swallow it and proceed!
        if (e.toString().contains('mismatch')) {
          _log.info(
            'Caught expected mismatch during buffer refill. Proceeding to force commit...',
          );
        } else {
          rethrow; // If it's a different network error, abort.
        }
      }

      // 2. The buffer is now full and fresh. Immediately confirm the force update!
      await repo.confirmForceUpdate();

      state = state.copyWith(status: FlashingStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: FlashingStatus.error,
        errorMessage: 'Force update failed: $e',
      );
    } finally {
      ref.read(isFlashingProvider.notifier).setFlashing(false);
    }
  }
}
