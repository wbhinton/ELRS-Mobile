import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  static const _keyBindPhrase = 'bind_phrase';
  static const _keyWifiSsid = 'wifi_ssid';
  static const _keyWifiPassword = 'wifi_password';
  static const _keyRegulatoryDomain = 'regulatory_domain';
  static const _keyManualIp = 'manual_ip';

  Future<void> saveManualIp(String ip) async {
    await _storage.write(key: _keyManualIp, value: ip);
  }

  Future<String?> loadManualIp() async {
    return await _storage.read(key: _keyManualIp);
  }

  Future<void> saveOptions({
    required String bindPhrase,
    required String wifiSsid,
    required String wifiPassword,
    required int regulatoryDomain,
  }) async {
    await _storage.write(key: _keyBindPhrase, value: bindPhrase);
    await _storage.write(key: _keyWifiSsid, value: wifiSsid);
    await _storage.write(key: _keyWifiPassword, value: wifiPassword);
    await _storage.write(key: _keyRegulatoryDomain, value: regulatoryDomain.toString());
  }

  Future<Map<String, dynamic>> loadOptions() async {
    final bindPhrase = await _storage.read(key: _keyBindPhrase) ?? '';
    final wifiSsid = await _storage.read(key: _keyWifiSsid) ?? '';
    final wifiPassword = await _storage.read(key: _keyWifiPassword) ?? '';
    final regulatoryDomainStr = await _storage.read(key: _keyRegulatoryDomain) ?? '0';
    final regulatoryDomain = int.tryParse(regulatoryDomainStr) ?? 0;

    return {
      'bindPhrase': bindPhrase,
      'wifiSsid': wifiSsid,
      'wifiPassword': wifiPassword,
      'regulatoryDomain': regulatoryDomain,
    };
  }
}

@riverpod
SecureStorageService secureStorageService(Ref ref) {
  return SecureStorageService(const FlutterSecureStorage());
}
