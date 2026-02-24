import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/storage/persistence_service.dart';

part 'settings_controller.freezed.dart';
part 'settings_controller.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(false) bool developerMode,
    @Default(false) bool forceMobileData,
    @Default(0) int defaultRegulatoryDomain,
    @Default('') String globalBindPhrase,
    @Default('') String homeWifiSsid,
    @Default('') String homeWifiPassword,
    @Default(2) int maxCachedVersions,
    @Default(false) bool expertMode,
    @Default('Unknown') String appVersion,
    @Default(false) bool disclaimerAccepted,
    @Default(false) bool isLoaded,
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
      defaultRegulatoryDomain: persistence.getRegulatoryDomain(),
      globalBindPhrase: persistence.getBindPhrase(),
      homeWifiSsid: persistence.getWifiSsid(),
      homeWifiPassword: persistence.getWifiPassword(),
      maxCachedVersions: prefs.getInt('maxCachedVersions') ?? 2,
      expertMode: prefs.getBool('expertMode') ?? false,
      appVersion: info.version,
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

  Future<void> setDefaultRegulatoryDomain(int value) async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setRegulatoryDomain(value);
    state = state.copyWith(defaultRegulatoryDomain: value);
  }

  Future<void> setGlobalBindPhrase(String value) async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setBindPhrase(value);
    state = state.copyWith(globalBindPhrase: value);
  }

  Future<void> setHomeWifiSsid(String value) async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setWifiSsid(value);
    state = state.copyWith(homeWifiSsid: value);
  }

  Future<void> setHomeWifiPassword(String value) async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setWifiPassword(value);
    state = state.copyWith(homeWifiPassword: value);
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
