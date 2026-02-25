import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:binary/binary.dart';

import '../application/firmware_patcher.dart';
import '../domain/patch_configuration.dart';
import '../data/firmware_repository.dart';
import '../data/device_repository.dart';

import '../../../core/storage/firmware_cache_service.dart';
import '../domain/target_definition.dart';
import '../utils/target_resolver.dart';
import '../utils/firmware_assembler.dart';
import 'package:archive/archive.dart';
import '../../../core/storage/persistence_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../settings/presentation/settings_controller.dart';

import '../state/flashing_provider.dart';
import '../../../core/networking/connectivity_service.dart';

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
    String? selectedVendor,
    TargetDefinition? selectedTarget,
    String? selectedVersion,
    @Default(FlashingStatus.idle) FlashingStatus status,
    @Default(0.0) double progress,
    String? errorMessage,
    @Default('') String bindPhrase,
    @Default('') String wifiSsid,
    @Default('') String wifiPassword,
    @Default(0) int regulatoryDomain,
    @Default(false) bool dualBandEnabled,
    String? autosavingField,
  }) = _FlashingState;
}

@Riverpod(keepAlive: true)
class FlashingController extends _$FlashingController {
  @override
  FlashingState build() {
    // Listen for global settings changes and sync them to local state
    ref.listen(settingsControllerProvider, (previous, next) {
      if (previous?.globalBindPhrase != next.globalBindPhrase) {
        state = state.copyWith(bindPhrase: next.globalBindPhrase);
      }
      if (previous?.homeWifiSsid != next.homeWifiSsid) {
        state = state.copyWith(wifiSsid: next.homeWifiSsid);
      }
      if (previous?.homeWifiPassword != next.homeWifiPassword) {
        state = state.copyWith(wifiPassword: next.homeWifiPassword);
      }
      if (previous?.defaultRegulatoryDomain != next.defaultRegulatoryDomain) {
        state = state.copyWith(regulatoryDomain: next.defaultRegulatoryDomain);
      }
    });

    // Initialize with current settings values
    final settings = ref.read(settingsControllerProvider);

    return FlashingState(
      bindPhrase: settings.globalBindPhrase,
      wifiSsid: settings.homeWifiSsid,
      wifiPassword: settings.homeWifiPassword,
      regulatoryDomain: settings.defaultRegulatoryDomain,
    );
  }

  Future<void> loadSavedOptions() async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    final bindPhrase = persistence.getBindPhrase();
    final wifiSsid = persistence.getWifiSsid();
    final wifiPassword = persistence.getWifiPassword();
    final regulatoryDomain = persistence.getRegulatoryDomain();

    state = state.copyWith(
      bindPhrase: bindPhrase,
      wifiSsid: wifiSsid,
      wifiPassword: wifiPassword,
      regulatoryDomain: regulatoryDomain,
    );
  }

  void selectVendor(String? vendor) {
    // Reset target when vendor changes
    state = state.copyWith(selectedVendor: vendor, selectedTarget: null);
  }

  void selectTarget(TargetDefinition? target) {
    state = state.copyWith(selectedTarget: target);
  }

  void selectVersion(String? version) {
    state = state.copyWith(selectedVersion: version);
  }

  /// Corrects the regulatory mapping for dual-band hardware.
  Uint16 updateRegulatoryMapping({
    required int currentRegInteger,
    required int newDomainId,
    required bool dualBandEnabled,
  }) {
    // Wrap existing data in Uint16 to preserve higher-order configuration bits.
    final currentVal = Uint16(currentRegInteger);

    // 1. Modify: Replace the domain ID (bits 0-3).
    var updatedVal = currentVal.replace(0, 3, newDomainId);

    // 2. Modify: Inject the Dual-Band toggle flag at bit 7.
    // This ensures no 'clobbering' of bits 4-6 or 8-15.
    updatedVal = updatedVal.replace(7, 7, dualBandEnabled ? 1 : 0);

    return updatedVal;
  }

  Future<void> setBindPhrase(String value) async {
    state = state.copyWith(bindPhrase: value);
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setBindPhrase(value);
    _triggerAutosaveFeedback('bindPhrase');
  }

  Future<void> setWifiSsid(String value) async {
    state = state.copyWith(wifiSsid: value);
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setWifiSsid(value);
    _triggerAutosaveFeedback('wifiSsid');
  }

  Future<void> setWifiPassword(String value) async {
    state = state.copyWith(wifiPassword: value);
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setWifiPassword(value);
    _triggerAutosaveFeedback('wifiPassword');
  }

  Future<void> setRegulatoryDomain(int id) async {
    final updatedMapping = updateRegulatoryMapping(
      currentRegInteger: state.regulatoryDomain,
      newDomainId: id,
      dualBandEnabled: state.dualBandEnabled,
    );
    state = state.copyWith(regulatoryDomain: updatedMapping.toInt());
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setRegulatoryDomain(state.regulatoryDomain);
  }

  Future<void> setDualBandEnabled(bool enabled) async {
    final updatedMapping = updateRegulatoryMapping(
      currentRegInteger: state.regulatoryDomain,
      newDomainId: state.regulatoryDomain & 0xF, // Extract bits 0-3
      dualBandEnabled: enabled,
    );
    state = state.copyWith(
      dualBandEnabled: enabled,
      regulatoryDomain: updatedMapping.toInt(),
    );
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setRegulatoryDomain(state.regulatoryDomain);
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
      // 1. Unbind process to permit mobile data for Artifactory download
      final connectivity = ref.read(connectivityServiceProvider.notifier);
      await connectivity.unbind();

      final payload = await _buildFinalPayload();

      state = state.copyWith(status: FlashingStatus.patching, progress: 0.5);

      final targetName = state.selectedTarget!.name.replaceAll(' ', '_');
      final extension = payload.filename.endsWith('.gz') ? '.gz' : '.bin';
      final downloadName = 'ELRS_${targetName}_Firmware$extension';

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

      if (result != null) {
        state = state.copyWith(
          status: FlashingStatus.downloadSuccess,
          progress: 1.0,
        );
        debugPrint('Firmware saved successfully to $result');
      } else {
        // User cancelled
        state = state.copyWith(status: FlashingStatus.idle, progress: 0.0);
      }
    } catch (e) {
      state = state.copyWith(
        status: FlashingStatus.error,
        errorMessage: e.toString(),
        progress: 0.0,
      );
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
      await ref.read(connectivityServiceProvider.notifier).autoBindIfWiFi();
    }
  }

  Future<({Uint8List bytes, String filename})> _prepareFirmware() async {
    FirmwareData firmwareData;

    // Check for cached version
    final cacheService = ref.read(firmwareCacheServiceProvider);
    final cachedZip = await cacheService.getZipFile(state.selectedVersion!);

    if (cachedZip != null) {
      state = state.copyWith(status: FlashingStatus.downloading, progress: 0.1);
      final zipBytes = await cachedZip.readAsBytes();

      firmwareData = await ref
          .read(firmwareRepositoryProvider)
          .extractFirmwareFromZip(
            zipBytes,
            state.selectedTarget!.firmware ??
                state.selectedTarget!.productCode ??
                'unknown',
            regulatoryDomain: state.regulatoryDomain,
          );
    } else {
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
            regulatoryDomain: state.regulatoryDomain,
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
      );

      final patcher = ref.read(firmwarePatcherProvider);
      finalBytes = await patcher.patchFirmware(firmwareData.bytes, config);
    }

    return (bytes: finalBytes, filename: firmwareData.filename);
  }

  Future<({Uint8List bytes, String filename})> _buildFinalPayload() async {
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
          uid = FirmwareAssembler.generateUid(state.bindPhrase);
        } else {
          uid = FirmwareAssembler.generateUid('');
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
      // Extract ONLY the domain ID (bits 0-3) by masking with 0x0F
      finalDomain = state.regulatoryDomain & 0x0F;
    }

    final deviceRepo = ref.read(deviceRepositoryProvider);
    return await deviceRepo.buildFirmwarePayload(
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
    );
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

    // Flash Guard: Check binding phrase
    if (state.bindPhrase.isEmpty && !ignoreMissingBindPhrase) {
      final persistence = await ref.read(persistenceServiceProvider.future);
      final savedBindPhrase = persistence.getBindPhrase();

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

    state = state.copyWith(
      status: FlashingStatus.downloading,
      progress: 0.0,
      errorMessage: null,
    );

    // Keep the screen on while flashing — released unconditionally in finally.
    await WakelockPlus.enable();

    // Silence UI heartbeat
    ref.read(isFlashingProvider.notifier).setFlashing(true);

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

      await deviceRepo.flashFirmware(
        payload.bytes,
        payload.filename,
        force: force,
      );

      ref.read(isFlashingProvider.notifier).setFlashing(false);
      state = state.copyWith(status: FlashingStatus.success, progress: 1.0);
    } catch (e) {
      ref.read(isFlashingProvider.notifier).setFlashing(false);
      final errorMsg = e.toString();

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
    } finally {
      // Restore connectivity binding and release wake lock.
      await ref.read(connectivityServiceProvider.notifier).autoBindIfWiFi();
      await WakelockPlus.disable();
    }
  }

  void resetStatus() {
    state = state.copyWith(
      status: FlashingStatus.idle,
      errorMessage: null,
      progress: 0.0,
    );
  }
}
