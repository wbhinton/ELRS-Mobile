import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/connection_repository.dart';
import '../../../core/networking/device_dio.dart';
import '../../../core/networking/discovery_service.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../flashing/state/flashing_provider.dart';
import '../domain/runtime_config_model.dart';
import '../services/device_config_service.dart';

part 'config_view_model.g.dart';

@riverpod
DeviceConfigService deviceConfigService(DeviceConfigServiceRef ref) {
  final dio = ref.watch(localDioProvider);
  return DeviceConfigService(dio);
}

@riverpod
class ConfigViewModel extends _$ConfigViewModel {
  Timer? _heartbeatTimer;
  StreamSubscription? _discoverySub;
  String? _lastDiscoveredIp;
  String? _manualIp;
  String? _probeIp; // The IP we are currently trying or failed on
  int _missedHeartbeats = 0;
  static const int _maxMissedHeartbeats = 3;

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
    
    // Explicitly transition to loading
    state = const AsyncValue.loading();
    try {
      await fetchConfig(ip);
    } catch (e) {
      // Allow it to remain in error/disconnected state
    }
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (_) => _performHeartbeat());
  }

  Future<void> _performHeartbeat() async {
    // Silence UI during Flash to prevent network contention
    final isFlashing = ref.read(isFlashingProvider);
    if (isFlashing) return;

    final service = ref.read(deviceConfigServiceProvider);
    
    // Priority: 1. Manual IP (if set), 2. Discovery targets (AP, Hostnames, Discovered mDNS)
    final ips = [
      if (_manualIp != null && _manualIp!.isNotEmpty) _manualIp!,
      '10.0.0.1', 
      'elrs_rx.local',
      'elrs_tx.local',
      if (_lastDiscoveredIp != null) _lastDiscoveredIp!,
    ];

    final uniqueIps = ips.toSet().toList();
    if (uniqueIps.isEmpty) return;

    try {
      final successfulIp = await Future.any(uniqueIps.map((ip) async {
        _probeIp = ip;
        // Pulse probe (HEAD request, 1s timeout)
        final alive = await service.probeDeviceHead(ip);
        if (alive) {
          // Robust check (GET /config, 2s timeout)
          final ok = await service.probeDevice(ip);
          if (ok) return ip;
        }
        throw Exception('Probe failed for $ip');
      }));

      // A device was successfully found concurrently
      _probeIp = successfulIp;
      _missedHeartbeats = 0; // Reset on any success
      await _refreshConfig(successfulIp);
    } catch (e) {
      // If we reach here, no device was found on any priority IP
      _missedHeartbeats++;
      
      if (_missedHeartbeats >= _maxMissedHeartbeats) {
        if (state.value != null || state.isLoading) {
          state = const AsyncValue.data(null);
        }
      } else {
        // Log missed heartbeat but preserve state
        print('CONNECTION: Heartbeat missed ($_missedHeartbeats/$_maxMissedHeartbeats). Preserving last good state.');
      }
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
      // Synchronize centralized IP state with Dashboard
      ref.read(targetIpProvider.notifier).updateIp(ip);
      return config.copyWith(activeIp: ip);
    });
  }

  Future<void> updateWifiSsid(String ip, String ssid) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final json = currentConfig.options.toJson();
    json['wifi-ssid'] = ssid;
    final updatedOptions = ElrsOptions.fromJson(json);

    await _saveOptions(ip, json);
    
    state = AsyncValue.data(currentConfig.copyWith(
      options: updatedOptions,
    ));
  }

  Future<void> updateWifiPassword(String ip, String password) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final json = currentConfig.options.toJson();
    json['wifi-password'] = password;
    final updatedOptions = ElrsOptions.fromJson(json);

    await _saveOptions(ip, json);
    
    state = AsyncValue.data(currentConfig.copyWith(
      options: updatedOptions,
    ));
  }

  Future<void> updateOption(String ip, String key, dynamic value) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final json = currentConfig.options.toJson();
    json[key] = value;
    final updatedOptions = ElrsOptions.fromJson(json);

    await _saveOptions(ip, json);
    
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
