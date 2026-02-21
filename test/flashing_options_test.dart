import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:elrs_mobile/src/core/storage/secure_storage_service.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_controller.dart';
import 'package:mockito/mockito.dart';

// 1. Mock Service
class MockSecureStorageService implements SecureStorageService {
  final Map<String, String> _storage = {};

  // We don't need the real FlutterSecureStorage for the mock, 
  // but the class structure might require it if we were extending.
  // Since we implement, we must satisfy the interface.
  // The original class has `final FlutterSecureStorage _storage;` which is private, 
  // so implementation is fine regarding fields (they are not part of interface).
  
  // However, the original class constructor requires FlutterSecureStorage.
  // Implementation doesn't inherit constructor.
  
  @override
  Future<void> saveOptions({
    required String bindPhrase,
    required String wifiSsid,
    required String wifiPassword,
    required int regulatoryDomain,
  }) async {
    _storage['bindPhrase'] = bindPhrase;
    _storage['wifiSsid'] = wifiSsid;
    _storage['wifiPassword'] = wifiPassword;
    _storage['regulatoryDomain'] = regulatoryDomain.toString();
  }

  @override
  Future<Map<String, dynamic>> loadOptions() async {
    return {
      'bindPhrase': _storage['bindPhrase'] ?? '',
      'wifiSsid': _storage['wifiSsid'] ?? '',
      'wifiPassword': _storage['wifiPassword'] ?? '',
      'regulatoryDomain': int.parse(_storage['regulatoryDomain'] ?? '0'),
    };
  }

  @override
  Future<String?> loadManualIp() async => _storage['manualIp'];

  @override
  Future<void> saveManualIp(String ip) async {
    _storage['manualIp'] = ip;
  }
}

void main() {
  test('Controller loads saved options on init', () async {
    // 2. Setup
    final mockStorage = MockSecureStorageService();
    // Preload mock data
    await mockStorage.saveOptions(
      bindPhrase: 'test_phrase',
      wifiSsid: 'My_WiFi',
      wifiPassword: 'secret_password',
      regulatoryDomain: 1,
    );

    final container = ProviderContainer(
      overrides: [
        secureStorageServiceProvider.overrideWith((ref) => mockStorage),
      ],
    );
    addTearDown(container.dispose);

    // Act
    await container.read(flashingControllerProvider.notifier).loadSavedOptions();
    final state = container.read(flashingControllerProvider);

    // Assert
    expect(state.bindPhrase, equals('test_phrase'));
    expect(state.wifiSsid, equals('My_WiFi'));
    // Optionally check others
    expect(state.wifiPassword, equals('secret_password'));
    expect(state.regulatoryDomain, equals(1));
  });

  test('Controller updates state when user types and persists', () async {
    // 3. Setup
    final mockStorage = MockSecureStorageService();
    final container = ProviderContainer(
      overrides: [
        secureStorageServiceProvider.overrideWith((ref) => mockStorage),
      ],
    );
    addTearDown(container.dispose);

    // Act
    container.read(flashingControllerProvider.notifier).setBindPhrase('new_secret');
    
    // Assert State
    final state = container.read(flashingControllerProvider);
    expect(state.bindPhrase, equals('new_secret'));

    // Assert Persistence (wait slightly for async save if needed, but the mock is synchronous-ish inside Future)
    // The controller calls _saveOptions which calls await storage.saveOptions.
    // Since we didn't await the setBindPhrase (it's void), we might race.
    // But typically un-awaited Futures in tests might need pumping or simple delay.
    // However, MockSecureStorageService methods are async? Yes, Future<void>.
    // So `setBindPhrase` starts a future "fire and forget".
    
    // To properly verify async side-effects that are fire-and-forget, we need to ensure the event loop processes it.
    await Future.delayed(Duration.zero);
    
    final loaded = await mockStorage.loadOptions();
    expect(loaded['bindPhrase'], equals('new_secret'));
  });
}
