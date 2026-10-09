import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../features/flashing/domain/flashing_profile.dart';

part 'persistence_service.g.dart';

class PersistenceService {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secure;

  PersistenceService(this._prefs, this._secure);

  static const _keyBindPhrase = 'flashing_bind_phrase';
  static const _keyWifiSsid = 'flashing_wifi_ssid';
  static const _keyWifiPassword = 'flashing_wifi_password';
  static const _keyManualIp = 'manual_ip';
  static const _keyDisclaimerAccepted = 'disclaimer_accepted';
  static const _keyMigrationDone = 'security_migration_v1_done';
  static const _keyWifiOnInterval = 'flashing_wifi_on_interval';
  static const _keyProfiles = 'flashing_profiles';
  static const _keyActiveProfileId = 'active_profile_id';
  static const _keyAppUpdateLastCheck = 'app_update_last_check';
  static const _keyAppUpdateSkippedVersionCode = 'app_update_skipped_version_code';
  static const _keySecureDataLost = 'secure_storage_data_lost';

  /// Records whether flutter_secure_storage v11 found data it can no longer
  /// decrypt: an install that went straight from a v9 build (before 1.0.44)
  /// to this one, skipping the v10 build that migrates the cipher. That data
  /// (bind phrase, Wi-Fi credentials, profiles) is discarded on first access,
  /// so this must run before anything reads or writes secure storage.
  Future<void> checkSecureStorageUpgrade() async {
    try {
      final status = await _secure.checkUpgradeStatus();
      if (!status.hasDataLoss) return;
      await _prefs.setBool(_keySecureDataLost, true);
      await Sentry.captureMessage(
        'Secure storage data lost on upgrade: $status',
        level: SentryLevel.warning,
      );
    } catch (e, st) {
      // Never block startup on a diagnostic check.
      await Sentry.captureException(e, stackTrace: st);
    }
  }

  /// True until the user has been told their saved settings were lost.
  bool get secureDataLostOnUpgrade => _prefs.getBool(_keySecureDataLost) ?? false;

  Future<void> clearSecureDataLostNotice() async {
    await _prefs.remove(_keySecureDataLost);
  }

  /// Migrates sensitive data from SharedPreferences to SecureStorage once.
  Future<void> migrateIfNeeded() async {
    if (!(_prefs.getBool(_keyMigrationDone) ?? false)) {
      final oldPhrase = _prefs.getString(_keyBindPhrase);
      final oldSsid = _prefs.getString(_keyWifiSsid);
      final oldPass = _prefs.getString(_keyWifiPassword);

      if (oldPhrase != null) {
        await _secure.write(key: _keyBindPhrase, value: oldPhrase);
      }
      if (oldSsid != null) {
        await _secure.write(key: _keyWifiSsid, value: oldSsid);
      }
      if (oldPass != null) {
        await _secure.write(key: _keyWifiPassword, value: oldPass);
      }

      // Clean up old plain-text data
      await _prefs.remove(_keyBindPhrase);
      await _prefs.remove(_keyWifiSsid);
      await _prefs.remove(_keyWifiPassword);

      await _prefs.setBool(_keyMigrationDone, true);
    }

    final existingProfiles = await getProfiles();
    if (existingProfiles.isEmpty) {
      final legacyPhrase = await _secure.read(key: _keyBindPhrase) ?? '';
      final legacySsid = await _secure.read(key: _keyWifiSsid) ?? '';
      final legacyPass = await _secure.read(key: _keyWifiPassword) ?? '';

      final defaultProfile = FlashingProfile(
        id: 'default',
        name: 'Default Profile',
        bindPhrase: legacyPhrase,
        wifiSsid: legacySsid,
        wifiPassword: legacyPass,
        defaultDomain2400: _prefs.getInt('defaultDomain2400') ?? 0,
        defaultDomain900: _prefs.getInt('defaultDomain900') ?? 1,
        wifiOnInterval: _prefs.getInt(_keyWifiOnInterval) ?? 60,
      );

      await saveProfiles([defaultProfile]);
      await setActiveProfileId('default');
    }
  }

  Future<void> saveProfiles(List<FlashingProfile> profiles) async {
    final jsonList = profiles.map((p) => p.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await _secure.write(key: _keyProfiles, value: jsonString);
  }

  Future<List<FlashingProfile>> getProfiles() async {
    final jsonString = await _secure.read(key: _keyProfiles);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((j) => FlashingProfile.fromJson(j as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> setActiveProfileId(String id) async {
    await _secure.write(key: _keyActiveProfileId, value: id);
  }

  Future<String?> getActiveProfileId() async {
    return await _secure.read(key: _keyActiveProfileId);
  }

  Future<void> saveManualIp(String ip) async {
    await _prefs.setString(_keyManualIp, ip);
  }

  String? loadManualIp() {
    return _prefs.getString(_keyManualIp);
  }

  Future<void> setBindPhrase(String value) async {
    await _secure.write(key: _keyBindPhrase, value: value);
  }

  Future<String> getBindPhrase() async {
    return await _secure.read(key: _keyBindPhrase) ?? '';
  }

  Future<void> setWifiSsid(String value) async {
    await _secure.write(key: _keyWifiSsid, value: value);
  }

  Future<void> setWifiPassword(String value) async {
    await _secure.write(key: _keyWifiPassword, value: value);
  }

  bool hasAcceptedDisclaimer() {
    return _prefs.getBool(_keyDisclaimerAccepted) ?? false;
  }

  Future<void> setDisclaimerAccepted() async {
    await _prefs.setBool(_keyDisclaimerAccepted, true);
  }

  Future<void> setWifiOnInterval(int value) async {
    await _prefs.setInt(_keyWifiOnInterval, value);
  }

  DateTime? getLastUpdateCheck() {
    final millis = _prefs.getInt(_keyAppUpdateLastCheck);
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  Future<void> setLastUpdateCheck(DateTime value) async {
    await _prefs.setInt(_keyAppUpdateLastCheck, value.millisecondsSinceEpoch);
  }

  int? getSkippedUpdateVersionCode() {
    return _prefs.getInt(_keyAppUpdateSkippedVersionCode);
  }

  Future<void> setSkippedUpdateVersionCode(int value) async {
    await _prefs.setInt(_keyAppUpdateSkippedVersionCode, value);
  }
}

// Kept alive: every caller reads it without listening, and startup checks
// and migrations must run once per launch, before any other storage access.
@Riverpod(keepAlive: true)
Future<PersistenceService> persistenceService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  const secure = FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );
  final service = PersistenceService(prefs, secure);
  await service.checkSecureStorageUpgrade();
  await service.migrateIfNeeded();
  return service;
}

