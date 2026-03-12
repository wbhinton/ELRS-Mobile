import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/storage/persistence_service.dart';
import '../../../core/utils/validation_utils.dart';

part 'settings_controller.freezed.dart';
part 'settings_controller.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(false) bool developerMode,
    @Default(false) bool forceMobileData,
    @Default(0) int defaultDomain2400,
    @Default(1) int defaultDomain900,
    @Default('') String globalBindPhrase,
    @Default('') String homeWifiSsid,
    @Default('') String homeWifiPassword,
    @Default(2) int maxCachedVersions,
    @Default(false) bool expertMode,
    @Default('Unknown') String appVersion,
    @Default(false) bool disclaimerAccepted,
    @Default(false) bool isLoaded,
    String? bindPhraseError,
    String? wifiSsidError,
    String? wifiPasswordError,
  }) = _SettingsState;
}

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  SettingsState build() {
    return const SettingsState();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final info = await PackageInfo.fromPlatform();
    final persistence = await ref.read(persistenceServiceProvider.future);

    state = state.copyWith(
      developerMode: prefs.getBool('developerMode') ?? false,
      forceMobileData: prefs.getBool('forceMobileData') ?? false,
      defaultDomain2400: prefs.getInt('defaultDomain2400') ?? 0,
      defaultDomain900: prefs.getInt('defaultDomain900') ?? 1,
      globalBindPhrase: await persistence.getBindPhrase(),
      homeWifiSsid: await persistence.getWifiSsid(),
      homeWifiPassword: await persistence.getWifiPassword(),
      maxCachedVersions: prefs.getInt('maxCachedVersions') ?? 2,
      expertMode: prefs.getBool('expertMode') ?? false,
      appVersion: '${info.version}+${info.buildNumber}',
      disclaimerAccepted: persistence.hasAcceptedDisclaimer(),
      isLoaded: true,
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

  Future<void> setDefaultDomain2400(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('defaultDomain2400', value);
    state = state.copyWith(defaultDomain2400: value);
  }

  Future<void> setDefaultDomain900(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('defaultDomain900', value);
    state = state.copyWith(defaultDomain900: value);
  }

  Future<void> setGlobalBindPhrase(String value) async {
    final error = ValidationUtils.validateBindPhrase(value);
    state = state.copyWith(globalBindPhrase: value, bindPhraseError: error);
    if (error == null) {
      final persistence = await ref.read(persistenceServiceProvider.future);
      await persistence.setBindPhrase(value);
    }
  }

  Future<void> setHomeWifiSsid(String value) async {
    final error = ValidationUtils.validateSsid(value);
    state = state.copyWith(homeWifiSsid: value, wifiSsidError: error);
    if (error == null) {
      final persistence = await ref.read(persistenceServiceProvider.future);
      await persistence.setWifiSsid(value);
    }
  }

  Future<void> setHomeWifiPassword(String value) async {
    final error = ValidationUtils.validatePassword(value);
    state = state.copyWith(homeWifiPassword: value, wifiPasswordError: error);
    if (error == null || value.isEmpty) {
      // Allow persisting empty (open network)
      final persistence = await ref.read(persistenceServiceProvider.future);
      await persistence.setWifiPassword(value);
      if (value.isEmpty) {
        state = state.copyWith(wifiPasswordError: null);
      }
    }
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

  Future<void> acceptDisclaimer() async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setDisclaimerAccepted();
    state = state.copyWith(disclaimerAccepted: true);
  }
}
