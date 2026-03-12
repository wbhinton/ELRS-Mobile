import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  /// Migrates sensitive data from SharedPreferences to SecureStorage once.
  Future<void> migrateIfNeeded() async {
    if (_prefs.getBool(_keyMigrationDone) ?? false) return;

    final oldPhrase = _prefs.getString(_keyBindPhrase);
    final oldSsid = _prefs.getString(_keyWifiSsid);
    final oldPass = _prefs.getString(_keyWifiPassword);

    if (oldPhrase != null)
      await _secure.write(key: _keyBindPhrase, value: oldPhrase);
    if (oldSsid != null) await _secure.write(key: _keyWifiSsid, value: oldSsid);
    if (oldPass != null)
      await _secure.write(key: _keyWifiPassword, value: oldPass);

    // Clean up old plain-text data
    await _prefs.remove(_keyBindPhrase);
    await _prefs.remove(_keyWifiSsid);
    await _prefs.remove(_keyWifiPassword);

    await _prefs.setBool(_keyMigrationDone, true);
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

  Future<String> getWifiSsid() async {
    return await _secure.read(key: _keyWifiSsid) ?? '';
  }

  Future<void> setWifiPassword(String value) async {
    await _secure.write(key: _keyWifiPassword, value: value);
  }

  Future<String> getWifiPassword() async {
    return await _secure.read(key: _keyWifiPassword) ?? '';
  }

  bool hasAcceptedDisclaimer() {
    return _prefs.getBool(_keyDisclaimerAccepted) ?? false;
  }

  Future<void> setDisclaimerAccepted() async {
    await _prefs.setBool(_keyDisclaimerAccepted, true);
  }
}

@riverpod
Future<PersistenceService> persistenceService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  const secure = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  final service = PersistenceService(prefs, secure);
  await service.migrateIfNeeded();
  return service;
}
