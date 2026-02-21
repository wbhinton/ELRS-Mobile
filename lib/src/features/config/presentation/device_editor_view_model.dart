import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/domain/runtime_config_model.dart';

/// A notifier that manages the draft state of a device's configuration.
/// It holds the original config and a mutable draft, exposing whether
/// changes have been made.
class DeviceEditorViewModel extends Notifier<RuntimeConfig?> {
  RuntimeConfig? _originalConfig;
  bool _isSaving = false;

  @override
  RuntimeConfig? build() {
    return null;
  }

  /// Initializes the editor with a fresh config from the device.
  void initialize(RuntimeConfig config) {
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
  void updatePwmPin(int index, Map<String, dynamic> pinConfig) {
    if (state == null) return;

    final List<dynamic> oldPwmList = state!.config.pwm;
    
    // Create a new list to ensure immutability is respected
    final List<dynamic> newPwmList = List<dynamic>.from(oldPwmList);
    
    // Ensure the index is within bounds before updating
    if (index >= 0 && index < newPwmList.length) {
      newPwmList[index] = pinConfig;
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
      if (_originalConfig!.config != state!.config ||
          _originalConfig!.settings != state!.settings) {
        
        // The /config endpoint expects 'settings', 'config', and other core fields
        final payload = <String, dynamic>{
          'settings': state!.settings.toJson(),
          'config': state!.config.toJson(),
        };
        await saveConfig(targetIp, payload);
      }

      // 3. Trigger Reboot
      await reboot(targetIp);

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
