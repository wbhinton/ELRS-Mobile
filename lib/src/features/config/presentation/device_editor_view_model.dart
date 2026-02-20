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
    
    // Create a deep copy of the maps to avoid mutating the original
    state = config.copyWith(
      settings: Map<String, dynamic>.from(config.settings),
      options: Map<String, dynamic>.from(config.options),
      config: Map<String, dynamic>.from(config.config),
    );
  }

  /// Checks if the current draft differs from the original configuration.
  bool get hasChanges {
    if (_originalConfig == null || state == null) return false;

    return !_mapsEqual(_originalConfig!.settings, state!.settings) ||
           !_mapsEqual(_originalConfig!.options, state!.options) ||
           !_mapsEqual(_originalConfig!.config, state!.config);
  }

  bool get isSaving => _isSaving;

  /// Updates a specific setting in the 'settings' map.
  void updateSetting(String key, dynamic value) {
    if (state == null) return;
    
    final newSettings = Map<String, dynamic>.from(state!.settings);
    newSettings[key] = value;
    
    state = state!.copyWith(settings: newSettings);
  }

  /// Updates a specific option in the 'options' map.
  void updateOption(String key, dynamic value) {
    if (state == null) return;
    
    final newOptions = Map<String, dynamic>.from(state!.options);
    newOptions[key] = value;
    
    state = state!.copyWith(options: newOptions);
  }

  /// Updates a specific config value in the 'config' map.
  void updateConfigValue(String key, dynamic value) {
    if (state == null) return;
    
    final newConfig = Map<String, dynamic>.from(state!.config);
    newConfig[key] = value;
    
    state = state!.copyWith(config: newConfig);
  }

  /// Updates a specific PWM pin's configuration.
  void updatePwmPin(int index, Map<String, dynamic> pinConfig) {
    if (state == null || !state!.config.containsKey('pwm')) return;

    final newConfig = Map<String, dynamic>.from(state!.config);
    final List<dynamic> oldPwmList = newConfig['pwm'];
    
    // Create a new list to ensure immutability is respected
    final List<dynamic> newPwmList = List<dynamic>.from(oldPwmList);
    
    // Ensure the index is within bounds before updating
    if (index >= 0 && index < newPwmList.length) {
      newPwmList[index] = pinConfig;
      newConfig['pwm'] = newPwmList;
      state = state!.copyWith(config: newConfig);
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

    setSaving(true);
    try {
      // 1. Save Options if changed
      if (!_mapsEqual(_originalConfig!.options, state!.options)) {
        await saveOptions(targetIp, state!.options);
      }

      // 2. Save Config if changed
      if (!_mapsEqual(_originalConfig!.config, state!.config) ||
          !_mapsEqual(_originalConfig!.settings, state!.settings)) {
        
        // The /config endpoint expects 'settings', 'config', and 'modelId'
        // Construct the payload based on the device's expected format.
        final payload = <String, dynamic>{
          'settings': state!.settings,
          'config': state!.config,
        };
        await saveConfig(targetIp, payload);
      }

      // 3. Trigger Reboot
      await reboot(targetIp);

      // Successfully sent commands. The caller (UI) should handle the reconnect overlay.
      return true;
    } catch (e) {
      setSaving(false);
      rethrow;
    }
  }

  /// Sets the saving state for UI feedback.
  void setSaving(bool saving) {
    _isSaving = saving;
    ref.notifyListeners();
  }

  // Helper method to compare two maps for equality (including nested lists).
  bool _mapsEqual(Map<String, dynamic> a, Map<String, dynamic> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      
      final valA = a[key];
      final valB = b[key];

      if (valA is List && valB is List) {
        if (!_listsEqual(valA, valB)) return false;
      } else if (valA is Map<String, dynamic> && valB is Map<String, dynamic>) {
        if (!_mapsEqual(valA, valB)) return false;
      } else if (valA != valB) {
        return false;
      }
    }
    return true;
  }

  bool _listsEqual(List<dynamic> a, List<dynamic> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      final valA = a[i];
      final valB = b[i];

      if (valA is Map<String, dynamic> && valB is Map<String, dynamic>) {
        if (!_mapsEqual(valA, valB)) return false;
      } else if (valA is List && valB is List) {
        if (!_listsEqual(valA, valB)) return false;
      } else if (valA != valB) {
        return false;
      }
    }
    return true;
  }
}

final deviceEditorProvider = NotifierProvider<DeviceEditorViewModel, RuntimeConfig?>(
  DeviceEditorViewModel.new,
);
