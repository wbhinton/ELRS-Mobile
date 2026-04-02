import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/connection_repository.dart';
import '../../../core/networking/device_dio.dart';
import '../../../core/networking/discovery_service.dart';
import '../../../core/storage/persistence_service.dart';
import '../../flashing/state/flashing_provider.dart';
import '../domain/runtime_config_model.dart';
import '../services/device_config_service.dart';

part 'config_view_model.g.dart';

@riverpod
DeviceConfigService deviceConfigService(Ref ref) {
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
  bool _isHeartbeating = false;
  CancelToken? _heartbeatCancelToken;
  static const int _maxMissedHeartbeats = 3;
  static final _log = Logger('ConfigViewModel');

  @override
  FutureOr<RuntimeConfig?> build() async {
    ref.onDispose(() {
      _heartbeatTimer?.cancel();
      _discoverySub?.cancel();
    });

    // Load manual IP
    final storage = await ref.read(persistenceServiceProvider.future);
    _manualIp = storage.loadManualIp();

    // Start discovery scan if not started
    final discoveryService = ref.read(discoveryServiceProvider);
    discoveryService.startScan();

    _discoverySub = discoveryService.targetIpStream.listen((ip) {
      if (ip != null) {
        _lastDiscoveredIp = ip;
        _performHeartbeat();
      }
    });

    // Listen for flashing status to cancel heartbeats immediately
    ref.listen(isFlashingProvider, (previous, next) {
      if (next == true) {
        _log.info('Flashing started. Cancelling in-flight heartbeats...');
        _heartbeatCancelToken?.cancel('Flashing started');
        _heartbeatCancelToken = null;
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
    final storage = await ref.read(persistenceServiceProvider.future);
    if (!ref.mounted) return;
    await storage.saveManualIp(ip);

    // Explicitly transition to loading
    if (!ref.mounted) return;
    state = const AsyncValue.loading();
    try {
      await fetchConfig(ip);
    } catch (e) {
      // Allow it to remain in error/disconnected state
    }
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _performHeartbeat(),
    );
  }

  Future<void> _performHeartbeat() async {
    if (_isHeartbeating) return;
    
    // Silence UI during Flash to prevent network contention
    final isFlashing = ref.read(isFlashingProvider);
    if (isFlashing) return;

    _isHeartbeating = true;
    _heartbeatCancelToken = CancelToken();
    try {
      final service = ref.read(deviceConfigServiceProvider);

      // Priority: 1. Manual IP (if set), 2. Discovery targets (AP, Hostnames, Discovered mDNS)
      final ips = [
        '10.0.0.1',
        'elrs_rx.local',
        'elrs_tx.local',
        ...[_manualIp, _lastDiscoveredIp].nonNulls.where((s) => s.isNotEmpty),
      ];

      final uniqueIps = ips.toSet().toList();
      if (uniqueIps.isEmpty) return;

      try {
        final successfulIp = await Future.any(
          uniqueIps.map((ip) async {
            _probeIp = ip;
            // Pulse probe (HEAD request, 1s timeout)
            final alive = await service.probeDeviceHead(
              ip,
              cancelToken: _heartbeatCancelToken,
            );
            if (alive) return ip;

            throw Exception('Probe failed for $ip');
          }),
        );

        if (!ref.mounted) return;

        // A device was successfully found concurrently
        _probeIp = successfulIp;
        _missedHeartbeats = 0; // Reset on any success
        
        // Only fetch the heavy JSON configuration if we aren't already loaded!
        // Pulling the full configuration payload every 3 seconds causes ESP heap exhaustion.
        if (state.value == null) {
          await _refreshConfig(successfulIp, cancelToken: _heartbeatCancelToken);
        }
      } catch (e) {
        if (!ref.mounted) return;

        // If we reach here, no device was found on any priority IP
        _missedHeartbeats++;

        if (_missedHeartbeats >= _maxMissedHeartbeats) {
          if (state.value != null || state.isLoading) {
            state = const AsyncValue.data(null);
          }
        } else {
          // Log missed heartbeat but preserve state
          _log.info(
            'Heartbeat missed ($_missedHeartbeats/$_maxMissedHeartbeats). Preserving last good state.',
          );
        }
      }
    } finally {
      _isHeartbeating = false;
    }
  }

  Future<void> _refreshConfig(String ip, {CancelToken? cancelToken}) async {
    final service = ref.read(deviceConfigServiceProvider);
    try {
      final config = await service.fetchConfig(ip, cancelToken: cancelToken);
      if (!ref.mounted) return;

      // Sync centralized IP with Dashboard
      ref.read(targetIpProvider.notifier).updateIp(ip);
      state = AsyncValue.data(config.copyWith(activeIp: ip));
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> fetchConfig(String ip) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final service = ref.read(deviceConfigServiceProvider);
      final config = await service.fetchConfig(ip);
      ref.read(targetIpProvider.notifier).updateIp(ip);
      return config.copyWith(activeIp: ip);
    });
    if (ref.mounted) {
      state = result;
    }
  }

  Future<void> updateWifiSsid(String ip, String ssid) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final json = currentConfig.options.toJson();
    json['wifi-ssid'] = ssid;
    final updatedOptions = ElrsOptions.fromJson(json);

    await _saveOptions(ip, json);
    if (!ref.mounted) return;

    state = AsyncValue.data(currentConfig.copyWith(options: updatedOptions));
  }

  Future<void> updateWifiPassword(String ip, String password) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final json = currentConfig.options.toJson();
    json['wifi-password'] = password;
    final updatedOptions = ElrsOptions.fromJson(json);

    await _saveOptions(ip, json);
    if (!ref.mounted) return;

    state = AsyncValue.data(currentConfig.copyWith(options: updatedOptions));
  }

  Future<void> updateOption(String ip, String key, dynamic value) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    final json = currentConfig.options.toJson();
    json[key] = value;
    final updatedOptions = ElrsOptions.fromJson(json);

    await _saveOptions(ip, json);
    if (!ref.mounted) return;

    state = AsyncValue.data(currentConfig.copyWith(options: updatedOptions));
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
