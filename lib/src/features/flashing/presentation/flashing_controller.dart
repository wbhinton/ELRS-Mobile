import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:typed_data';
import '../application/firmware_patcher.dart';
import '../domain/patch_configuration.dart';
import '../data/firmware_repository.dart';
import '../data/device_repository.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../core/storage/firmware_cache_service.dart';
import '../domain/target_definition.dart';
import '../utils/target_resolver.dart';
import '../utils/firmware_assembler.dart';
import 'package:archive/archive.dart';
import '../../../core/storage/persistence_service.dart';
import 'package:file_saver/file_saver.dart';
import 'package:permission_handler/permission_handler.dart';

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
    String? autosavingField,
  }) = _FlashingState;
}

@riverpod
class FlashingController extends _$FlashingController {
  @override
  FlashingState build() {
    // Watch settings to react to changes, or just read once?
    // If user changes default in settings, we probably want to update current if it matches old default?
    // Or just use it for initial value. 
    // "pre-filling the Options form".
    // Let's watch it so if they change it in settings, it updates here if not overridden?
    // But `regulatoryDomain` is part of state. 
    // Let's just load it initially.
    
    // Actually, `build` is called when providers change if we watch.
    // We want to initialize with the default.
    final settings = ref.watch(settingsControllerProvider);
    
    return FlashingState(
      regulatoryDomain: settings.defaultRegulatoryDomain,
    );
  }


  Future<void> loadSavedOptions() async {
    // Try to load from PersistenceService first
    final persistence = await ref.read(persistenceServiceProvider.future);
    final bindPhrase = persistence.getBindPhrase();
    final wifiSsid = persistence.getWifiSsid();
    final wifiPassword = persistence.getWifiPassword();

    if (bindPhrase.isNotEmpty || wifiSsid.isNotEmpty || wifiPassword.isNotEmpty) {
      state = state.copyWith(
        bindPhrase: bindPhrase,
        wifiSsid: wifiSsid,
        wifiPassword: wifiPassword,
      );
      return;
    }

    // Fallback to legacy SecureStorageService if persistence is empty
    final storage = ref.read(secureStorageServiceProvider);
    final options = await storage.loadOptions();
    state = state.copyWith(
      bindPhrase: options['bindPhrase'] as String,
      wifiSsid: options['wifiSsid'] as String,
      wifiPassword: options['wifiPassword'] as String,
      regulatoryDomain: options['regulatoryDomain'] as int,
    );
  }

  void selectVendor(String? vendor) {
    // Reset target when vendor changes
    state = state.copyWith(
      selectedVendor: vendor,
      selectedTarget: null,
    );
  }

  void selectTarget(TargetDefinition? target) {
    state = state.copyWith(selectedTarget: target);
  }

  void selectVersion(String? version) {
    state = state.copyWith(selectedVersion: version);
  }

  Future<void> setBindPhrase(String value) async {
    state = state.copyWith(bindPhrase: value);
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setBindPhrase(value);
    _triggerAutosaveFeedback('bindPhrase');
    _saveOptionsLegacy();
  }

  Future<void> setWifiSsid(String value) async {
    state = state.copyWith(wifiSsid: value);
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setWifiSsid(value);
    _triggerAutosaveFeedback('wifiSsid');
    _saveOptionsLegacy();
  }

  Future<void> setWifiPassword(String value) async {
    state = state.copyWith(wifiPassword: value);
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setWifiPassword(value);
    _triggerAutosaveFeedback('wifiPassword');
    _saveOptionsLegacy();
  }
  
  void setRegulatoryDomain(int value) {
    state = state.copyWith(regulatoryDomain: value);
    _saveOptionsLegacy();
  }

  void _triggerAutosaveFeedback(String field) {
    state = state.copyWith(autosavingField: field);
    Future.delayed(const Duration(seconds: 1), () {
      if (state.autosavingField == field) {
        state = state.copyWith(autosavingField: null);
      }
    });
  }

  Future<void> _saveOptionsLegacy() async {
    final storage = ref.read(secureStorageServiceProvider);
    // Debounce behavior could be added here, but for now simple save on change
    // Using a microtask or small delay might be better to avoid hammering storage 
    // on every keystroke, but usually secure storage is fast enough for input fields.
    // Ideally we save on focus lost or periodic, but direct save is simplest for now.
    await storage.saveOptions(
      bindPhrase: state.bindPhrase,
      wifiSsid: state.wifiSsid,
      wifiPassword: state.wifiPassword,
      regulatoryDomain: state.regulatoryDomain,
    );
  }

  Future<void> downloadFirmware() async {
    if (state.selectedTarget == null || state.selectedVersion == null) {
      state = state.copyWith(errorMessage: 'Please select a target and version.');
      return;
    }

    // 1. Check Permissions
    if (await Permission.storage.request().isDenied) {
      state = state.copyWith(errorMessage: 'Storage permission denied.');
      return;
    }

    state = state.copyWith(
      status: FlashingStatus.downloading,
      progress: 0.0,
      errorMessage: null,
    );

    try {
      // 1. Unbind process to permit mobile data for Artifactory download
      final connectivity = ref.read(connectivityServiceProvider.notifier);
      await connectivity.unbind();

      final firmware = await _prepareFirmware();
      
      state = state.copyWith(status: FlashingStatus.patching, progress: 0.5);

      final targetName = state.selectedTarget!.name.replaceAll(' ', '_');
      final downloadName = 'ELRS_${targetName}_Firmware';

      await FileSaver.instance.saveFile(
        name: downloadName,
        bytes: firmware.bytes,
        ext: 'bin',
        mimeType: MimeType.other,
      );

      state = state.copyWith(status: FlashingStatus.success, progress: 1.0);
    } catch (e) {
      state = state.copyWith(
        status: FlashingStatus.error,
        errorMessage: e.toString(),
        progress: 0.0,
      );
    } finally {
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
      
      firmwareData = await ref.read(firmwareRepositoryProvider).extractFirmwareFromZip(
        zipBytes, 
        state.selectedTarget!.firmware ?? state.selectedTarget!.productCode ?? 'unknown',
        regulatoryDomain: state.regulatoryDomain,
      );
    } else {
       // Download from Artifactory
       firmwareData = await ref.read(firmwareRepositoryProvider).downloadFirmware(
        state.selectedTarget!.firmware ?? state.selectedTarget!.productCode ?? 'unknown',
        state.selectedVersion!,
        onReceiveProgress: (received, total) {
          if (total != -1) {
             final progress = (received / total);
             final overallProgress = (progress * 0.4);
             state = state.copyWith(progress: overallProgress, status: FlashingStatus.downloading);
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

  Future<void> flash({bool force = false, bool ignoreMissingBindPhrase = false}) async {
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
    
    // Silence UI heartbeat
    ref.read(isFlashingProvider.notifier).setFlashing(true);

    try {
      final connectivity = ref.read(connectivityServiceProvider.notifier);

      // 1. Unbind process to allow firmware download via mobile data if needed
      await connectivity.unbind();
      
      final firmware = await _prepareFirmware();
      final finalBytes = firmware.bytes;
      final filename = firmware.filename;
      
      state = state.copyWith(status: FlashingStatus.uploading, progress: 0.66);

      // 2. RE-BIND to WiFi interface to ensure the upload reaches 10.0.0.1
      await connectivity.bindToWiFi();

      // 3. Upload
      final deviceRepo = ref.read(deviceRepositoryProvider);
      
      // Prepare Unified Builder parameters if applicable
      String? productName;
      String? luaName;
      List<int>? uid;
      Map<String, dynamic>? mergedHardwareLayout;
      
      final targetConfig = state.selectedTarget!.config;
      final isUnified = targetConfig.containsKey('layout_file');
      
      if (isUnified) {
         print('Preparing Target-Aware Build...');
         try {
           final cacheService = ref.read(firmwareCacheServiceProvider);
           // 1. Get Hardware Zip
           final zipFile = await cacheService.getHardwareZipFile(state.selectedVersion!);
           if (zipFile == null) throw Exception('Hardware zip not found');
           
           final zipBytes = await zipFile.readAsBytes();
           final archive = ZipDecoder().decodeBytes(zipBytes);

           // 2. Resolve Layout
           mergedHardwareLayout = TargetResolver.resolveLayout(
             targetConfig,
             archive,
           );
           
           productName = targetConfig['product_name'] as String? ?? state.selectedTarget!.name;
           luaName = targetConfig['lua_name'] as String? ?? 'ELRS';
           
           if (state.bindPhrase.isNotEmpty) {
              uid = FirmwareAssembler.generateUid(state.bindPhrase);
           } else {
              uid = FirmwareAssembler.generateUid(''); 
           }
         } catch (e) {
           print('Warning: Failed to prepare unified build data: $e');
           throw Exception('Failed to prepare Unified Firmware: $e');
         }
      }

      await deviceRepo.flashFirmware(
        finalBytes, 
        filename,
        productName: productName,
        luaName: luaName,
        uid: uid,
        hardwareLayout: mergedHardwareLayout,
        wifiSsid: state.wifiSsid,
        wifiPassword: state.wifiPassword,
        platform: state.selectedTarget!.platform,
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
          errorMessage: 'Target mismatch detected. Forced update was attempted.',
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
       // Restore connectivity binding
       await ref.read(connectivityServiceProvider.notifier).autoBindIfWiFi();
    }
  }



  void resetStatus() {
    state = state.copyWith(status: FlashingStatus.idle, errorMessage: null, progress: 0.0);
  }
}
