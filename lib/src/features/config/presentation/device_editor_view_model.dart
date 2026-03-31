import 'package:binary/binary.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/domain/runtime_config_model.dart';

/// A notifier that manages the draft state of a device's configuration.
/// It holds the original config and a mutable draft, exposing whether
/// changes have been made.
class DeviceEditorViewModel extends Notifier<RuntimeConfig?> {
  RuntimeConfig? _originalConfig;
  bool _isSaving = false;
  static final _log = Logger('DeviceEditorViewModel');

  @override
  RuntimeConfig? build() {
    return null;
  }

  /// Initializes the editor with a fresh config from the device.
  void initialize(RuntimeConfig config) {
    _log.info('Initializing editor stage. PWM count: ${config.config.pwm.length}');
    // Polymorphic State: We no longer force-normalize to Map.
    // V3 stays List<int>, V4 stays List<Map>.
    _originalConfig = config;
    state = config;
  }

  /// Checks if the current draft differs from the original configuration.
  bool get hasChanges {
    if (_originalConfig == null || state == null) return false;
    return _originalConfig != state;
  }

  bool get isSaving => _isSaving;

  /// Updates a specific setting in the 'settings' map.
  void updateSetting(String key, dynamic value) {
    if (state == null) return;
    
    final json = state!.settings.toJson();
    json[key] = value;
    
    state = state!.copyWith(settings: ElrsSettings.fromJson(json));
  }

  /// Updates a specific option in the 'options' map.
  void updateOption(String key, dynamic value) {
    if (state == null) return;
    
    final json = state!.options.toJson();
    json[key] = value;
    
    state = state!.copyWith(options: ElrsOptions.fromJson(json));
  }

  /// Updates a specific config value in the 'config' map.
  void updateConfigValue(String key, dynamic value) {
    if (state == null) return;
    
    final json = state!.config.toJson();
    json[key] = value;
    
    state = state!.copyWith(config: ElrsConfig.fromJson(json));
  }

  /// Updates a specific PWM pin's configuration.
  /// Handles both Map (V4) and int (V3) types.
  void updatePwmPin(int index, dynamic newPinConfig) {
    if (state == null) return;

    final List<dynamic> oldPwmList = state!.config.pwm;
    final List<dynamic> newPwmList = List<dynamic>.from(oldPwmList);

    if (index >= 0 && index < newPwmList.length) {
      // Bit-integrity: If the existing value is an int (V3), wrap the new one.
      if (oldPwmList[index] is int && newPinConfig is int) {
        newPwmList[index] = Uint8(newPinConfig).toInt();
      } else {
        newPwmList[index] = newPinConfig;
      }

      state = state!.copyWith(
        config: state!.config.copyWith(pwm: newPwmList),
      );
    }
  }

  /// Saves the current draft to the device.
  /// Sequential POST to /options.json and /config as needed, followed by /reboot.
  Future<bool> saveChanges(
    String targetIp,
    Future<void> Function(String ip, Map<String, dynamic> options) saveOptions,
    Future<void> Function(String ip, Map<String, dynamic> config) saveConfig,
    Future<void> Function(String ip) reboot,
  ) async {
    if (!hasChanges || state == null || _originalConfig == null) return false;

    _isSaving = true;
    ref.notifyListeners();

    try {
      // 1. Save Options if changed
      if (_originalConfig!.options != state!.options) {
        await saveOptions(targetIp, state!.options.toJson());
      }

      // 2. Save Config if changed
      if (_originalConfig!.config != state!.config) {
        // Outbound Flattening: V4 returns Maps but expects Ints on save.
        final List<int> pwmToSave = state!.config.pwm.map((item) {
          if (item is Map) return item['config'] as int? ?? 0;
          return item as int; // V3 channel mapping
        }).toList();

        _log.info('Flattened PWM for save: $pwmToSave');

        // Create a flat payload starting with the config fields.
        // We do NO nesting: most ELRS versions expect fields at the root of /config.
        final Map<String, dynamic> payload = state!.config.toJson();
        payload['pwm'] = pwmToSave;

        // Metadata Scrubbing: Remove read-only hardware definitions.
        // Sending null or root-level hardware strings back can cause some ESP
        // firmware to reject the configuration update.
        payload.remove('product_name');
        payload.remove('lua_name');
        payload.remove('target');
        payload.remove('reg_domain');
        payload.remove('version');
        payload.remove('has_serial_pins');
        payload.remove('has-highpower');
        payload.remove('uidtype');
        payload.remove('hardware'); // Already bit-packed into 'config'

        _log.info('Flat & Scrubbed Config POST payload: $payload');
        await saveConfig(targetIp, payload);
      }

      // 3. Trigger Reboot
      await reboot(targetIp);

      _originalConfig = state;
      _isSaving = false;
      ref.notifyListeners();
      return true;
    } catch (e) {
      _isSaving = false;
      ref.notifyListeners();
      rethrow;
    }
  }

  /// Sets the saving state for UI feedback.
  void setSaving(bool saving) {
    _isSaving = saving;
    ref.notifyListeners();
  }
}

final deviceEditorProvider = NotifierProvider<DeviceEditorViewModel, RuntimeConfig?>(
  DeviceEditorViewModel.new,
);
