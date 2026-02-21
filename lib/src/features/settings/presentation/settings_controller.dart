import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_controller.freezed.dart';
part 'settings_controller.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(false) bool developerMode,
    @Default(false) bool forceMobileData,
    @Default(0) int defaultRegulatoryDomain, // 0: FCC, 1: EU, etc.
    @Default(2) int maxCachedVersions,
    @Default(false) bool expertMode,
    @Default('Unknown') String appVersion,
  }) = _SettingsState;
}

@riverpod
class SettingsController extends _$SettingsController {
  @override
  SettingsState build() {
    return const SettingsState();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final info = await PackageInfo.fromPlatform();
    
    state = state.copyWith(
      developerMode: prefs.getBool('developerMode') ?? false,
      forceMobileData: prefs.getBool('forceMobileData') ?? false,
      defaultRegulatoryDomain: prefs.getInt('defaultRegulatoryDomain') ?? 0,
      maxCachedVersions: prefs.getInt('maxCachedVersions') ?? 2,
      expertMode: prefs.getBool('expertMode') ?? false,
      appVersion: info.version,
    );
  }

  Future<void> toggleDeveloperMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.developerMode;
    await prefs.setBool('developerMode', newValue);
    state = state.copyWith(developerMode: newValue);
  }

  Future<void> setForceMobileData(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('forceMobileData', value);
    state = state.copyWith(forceMobileData: value);
  }

  Future<void> setDefaultRegulatoryDomain(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('defaultRegulatoryDomain', value);
    state = state.copyWith(defaultRegulatoryDomain: value);
  }

  Future<void> setMaxCachedVersions(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('maxCachedVersions', value);
    state = state.copyWith(maxCachedVersions: value);
  }

  Future<void> toggleExpertMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.expertMode;
    await prefs.setBool('expertMode', newValue);
    state = state.copyWith(expertMode: newValue);
  }
}
