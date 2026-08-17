import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/storage/persistence_service.dart';
import '../../../core/utils/validation_utils.dart';
import '../../../core/storage/firmware_cache_service.dart';
import '../../flashing/domain/flashing_profile.dart';

part 'settings_controller.freezed.dart';
part 'settings_controller.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
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
    @Default(true) bool shareAnalytics,
    @Default(false) bool isLoaded,
    @Default(60) int wifiOnInterval,
    String? appLocale,
    String? bindPhraseError,
    String? wifiSsidError,
    String? wifiPasswordError,
    @Default([]) List<FlashingProfile> profiles,
    String? activeProfileId,
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

    final profiles = await persistence.getProfiles();
    final activeProfileId = await persistence.getActiveProfileId();
    String? effectiveActiveId = activeProfileId;

    if (effectiveActiveId == null && profiles.isNotEmpty) {
      effectiveActiveId = profiles.first.id;
      await persistence.setActiveProfileId(effectiveActiveId);
    }

    final activeProfile = profiles.firstWhere(
      (p) => p.id == effectiveActiveId,
      orElse: () => const FlashingProfile(id: 'default', name: 'Default Profile'),
    );

    state = state.copyWith(
      forceMobileData: prefs.getBool('forceMobileData') ?? false,
      defaultDomain2400: prefs.getInt('defaultDomain2400') ?? 0,
      defaultDomain900: prefs.getInt('defaultDomain900') ?? 1,
      globalBindPhrase: activeProfile.bindPhrase,
      homeWifiSsid: activeProfile.wifiSsid,
      homeWifiPassword: activeProfile.wifiPassword,
      maxCachedVersions: prefs.getInt('maxCachedVersions') ?? 2,
      expertMode: prefs.getBool('expertMode') ?? false,
      appVersion: '${info.version}+${info.buildNumber}',
      disclaimerAccepted: persistence.hasAcceptedDisclaimer(),
      shareAnalytics: prefs.getBool('shareAnalytics') ?? true,
      appLocale: prefs.getString('appLocale'),
      wifiOnInterval: activeProfile.wifiOnInterval == 0 ? 60 : activeProfile.wifiOnInterval,
      profiles: profiles,
      activeProfileId: effectiveActiveId,
      isLoaded: true,
    );
  }

  Future<void> createProfile(String name) async {
    final newProfile = FlashingProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      defaultDomain2400: state.defaultDomain2400,
      defaultDomain900: state.defaultDomain900,
      wifiOnInterval: state.wifiOnInterval,
    );

    final updatedProfiles = [...state.profiles, newProfile];
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.saveProfiles(updatedProfiles);
    await persistence.setActiveProfileId(newProfile.id);

    state = state.copyWith(
      profiles: updatedProfiles,
      activeProfileId: newProfile.id,
      globalBindPhrase: newProfile.bindPhrase,
      homeWifiSsid: newProfile.wifiSsid,
      homeWifiPassword: newProfile.wifiPassword,
      wifiOnInterval: newProfile.wifiOnInterval == 0 ? 60 : newProfile.wifiOnInterval,
    );
  }

  Future<void> updateActiveProfile(FlashingProfile profile) async {
    final updatedProfiles = state.profiles.map((p) {
      return p.id == profile.id ? profile : p;
    }).toList();

    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.saveProfiles(updatedProfiles);

    state = state.copyWith(
      profiles: updatedProfiles,
      globalBindPhrase: profile.bindPhrase,
      homeWifiSsid: profile.wifiSsid,
      homeWifiPassword: profile.wifiPassword,
      wifiOnInterval: profile.wifiOnInterval == 0 ? 60 : profile.wifiOnInterval,
    );
  }

  Future<void> deleteProfile(String id) async {
    if (state.profiles.length <= 1) return;

    final updatedProfiles = state.profiles.where((p) => p.id != id).toList();
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.saveProfiles(updatedProfiles);

    String? nextActiveId = state.activeProfileId;
    if (state.activeProfileId == id) {
      nextActiveId = updatedProfiles.first.id;
      await persistence.setActiveProfileId(nextActiveId);
    }

    final activeProfile = updatedProfiles.firstWhere(
      (p) => p.id == nextActiveId,
      orElse: () => const FlashingProfile(id: 'default', name: 'Default Profile'),
    );

    state = state.copyWith(
      profiles: updatedProfiles,
      activeProfileId: nextActiveId,
      globalBindPhrase: activeProfile.bindPhrase,
      homeWifiSsid: activeProfile.wifiSsid,
      homeWifiPassword: activeProfile.wifiPassword,
      wifiOnInterval: activeProfile.wifiOnInterval == 0 ? 60 : activeProfile.wifiOnInterval,
    );
  }

  Future<void> setActiveProfile(String id) async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setActiveProfileId(id);

    final activeProfile = state.profiles.firstWhere(
      (p) => p.id == id,
      orElse: () => const FlashingProfile(id: 'default', name: 'Default Profile'),
    );

    state = state.copyWith(
      activeProfileId: id,
      globalBindPhrase: activeProfile.bindPhrase,
      homeWifiSsid: activeProfile.wifiSsid,
      homeWifiPassword: activeProfile.wifiPassword,
      wifiOnInterval: activeProfile.wifiOnInterval == 0 ? 60 : activeProfile.wifiOnInterval,
    );
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
      final activeProfile = state.profiles.firstWhere(
        (p) => p.id == state.activeProfileId,
        orElse: () => const FlashingProfile(id: 'default', name: 'Default Profile'),
      );
      final updatedProfile = activeProfile.copyWith(bindPhrase: value);
      await updateActiveProfile(updatedProfile);
    }
  }

  Future<void> setHomeWifiSsid(String value) async {
    final error = ValidationUtils.validateSsid(value);
    state = state.copyWith(homeWifiSsid: value, wifiSsidError: error);
    if (error == null) {
      final activeProfile = state.profiles.firstWhere(
        (p) => p.id == state.activeProfileId,
        orElse: () => const FlashingProfile(id: 'default', name: 'Default Profile'),
      );
      final updatedProfile = activeProfile.copyWith(wifiSsid: value);
      await updateActiveProfile(updatedProfile);
    }
  }

  Future<void> setHomeWifiPassword(String value) async {
    final error = ValidationUtils.validatePassword(value);
    state = state.copyWith(homeWifiPassword: value, wifiPasswordError: error);
    if (error == null || value.isEmpty) {
      final activeProfile = state.profiles.firstWhere(
        (p) => p.id == state.activeProfileId,
        orElse: () => const FlashingProfile(id: 'default', name: 'Default Profile'),
      );
      final updatedProfile = activeProfile.copyWith(wifiPassword: value);
      await updateActiveProfile(updatedProfile);
      if (value.isEmpty) {
        state = state.copyWith(wifiPasswordError: null);
      }
    }
  }

  Future<void> setMaxCachedVersions(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('maxCachedVersions', value);
    state = state.copyWith(maxCachedVersions: value);

    // Trigger immediate eviction
    final cacheService = ref.read(firmwareCacheServiceProvider);
    await cacheService.evictOldestVersions(value);
  }

  Future<void> clearCache() async {
    final cacheService = ref.read(firmwareCacheServiceProvider);
    await cacheService.clearCache();
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

  Future<void> setShareAnalytics(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('shareAnalytics', value);
    state = state.copyWith(shareAnalytics: value);
  }

  Future<void> setAppLocale(String? localeCode) async {
    final prefs = await SharedPreferences.getInstance();
    if (localeCode == null) {
      await prefs.remove('appLocale');
    } else {
      await prefs.setString('appLocale', localeCode);
    }
    state = state.copyWith(appLocale: localeCode);
  }

  Future<void> setWifiOnInterval(int value) async {
    final persistence = await ref.read(persistenceServiceProvider.future);
    await persistence.setWifiOnInterval(value);
    state = state.copyWith(wifiOnInterval: value);
    final activeProfile = state.profiles.firstWhere(
      (p) => p.id == state.activeProfileId,
      orElse: () => const FlashingProfile(id: 'default', name: 'Default Profile'),
    );
    final updatedProfile = activeProfile.copyWith(wifiOnInterval: value);
    await updateActiveProfile(updatedProfile);
  }

  void clearErrors() {
    state = state.copyWith(
      bindPhraseError: null,
      wifiSsidError: null,
      wifiPasswordError: null,
    );
  }
}
