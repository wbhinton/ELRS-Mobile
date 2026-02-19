import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/connection_repository.dart';
import '../../../core/networking/device_dio.dart';
import '../../../core/networking/discovery_service.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../domain/runtime_config_model.dart';
import '../services/device_config_service.dart';

part 'config_view_model.g.dart';

@riverpod
DeviceConfigService deviceConfigService(Ref ref) {
  final dio = ref.watch(deviceDioProvider);
  return DeviceConfigService(dio);
}

@riverpod
class ConfigViewModel extends _$ConfigViewModel {
  Timer? _heartbeatTimer;
  StreamSubscription? _discoverySub;
  String? _lastDiscoveredIp;
  String? _manualIp;
  String? _probeIp; // The IP we are currently trying or failed on

  @override
  FutureOr<RuntimeConfig?> build() async {
    ref.onDispose(() {
      _heartbeatTimer?.cancel();
      _discoverySub?.cancel();
    });

    // Load manual IP
    final storage = ref.read(secureStorageServiceProvider);
    _manualIp = await storage.loadManualIp();

    // Start discovery scan if not started
    final discoveryService = ref.read(discoveryServiceProvider);
    discoveryService.startScan();

    _discoverySub = discoveryService.targetIpStream.listen((ip) {
      if (ip != null) {
        _lastDiscoveredIp = ip;
        _performHeartbeat();
      }
    });

    _startHeartbeat();
    _performHeartbeat();

    return null;
  }

  String? get manualIp => _manualIp;
  String? get probeIp => _probeIp;

  Future<void> setManualIp(String ip) async {
    _manualIp = ip;
    final storage = ref.read(secureStorageServiceProvider);
    await storage.saveManualIp(ip);
    _performHeartbeat();
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (_) => _performHeartbeat());
  }

  Future<void> _performHeartbeat() async {
    final service = ref.read(deviceConfigServiceProvider);
    
    // Priority: 1. Manual IP, 2. mDNS
    final ips = [
      if (_manualIp != null && _manualIp!.isNotEmpty) _manualIp!,
      if (_lastDiscoveredIp != null) _lastDiscoveredIp!,
    ];

    for (final ip in ips) {
      _probeIp = ip;
      // Pulse probe (HEAD request, 1s timeout)
      final alive = await service.probeDeviceHead(ip);
      if (alive) {
        // Robust check (GET /config, 2s timeout)
        final ok = await service.probeDevice(ip);
        if (ok) {
          await _refreshConfig(ip);
          return;
        }
      }
    }

    // If we reach here, no device was found on any priority IP
    if (state.value != null) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> _refreshConfig(String ip) async {
    final service = ref.read(deviceConfigServiceProvider);
    try {
      final config = await service.fetchConfig(ip);
      // Sync centralized IP with Dashboard
      ref.read(targetIpProvider.notifier).updateIp(ip);
      state = AsyncValue.data(config.copyWith(activeIp: ip));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> fetchConfig(String ip) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(deviceConfigServiceProvider);
      final config = await service.fetchConfig(ip);
      return config.copyWith(activeIp: ip);
    });
  }

  Future<void> updateWifiSsid(String ip, String ssid) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final updatedOptions = Map<String, dynamic>.from(currentConfig.options);
    updatedOptions['wifi-ssid'] = ssid;

    await _saveOptions(ip, updatedOptions);
    
    state = AsyncValue.data(currentConfig.copyWith(
      options: updatedOptions,
    ));
  }

  Future<void> updateWifiPassword(String ip, String password) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final updatedOptions = Map<String, dynamic>.from(currentConfig.options);
    updatedOptions['wifi-password'] = password;

    await _saveOptions(ip, updatedOptions);
    
    state = AsyncValue.data(currentConfig.copyWith(
      options: updatedOptions,
    ));
  }

  Future<void> updateOption(String ip, String key, dynamic value) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final updatedOptions = Map<String, dynamic>.from(currentConfig.options);
    updatedOptions[key] = value;

    await _saveOptions(ip, updatedOptions);
    
    state = AsyncValue.data(currentConfig.copyWith(
      options: updatedOptions,
    ));
  }

  Future<void> _saveOptions(String ip, Map<String, dynamic> options) async {
    final service = ref.read(deviceConfigServiceProvider);
    await service.saveOptions(ip, options);
  }

  Future<void> reboot(String ip) async {
    final service = ref.read(deviceConfigServiceProvider);
    await service.reboot(ip);
  }
}
