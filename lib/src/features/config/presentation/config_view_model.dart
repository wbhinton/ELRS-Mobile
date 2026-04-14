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
  // ── Timers ──────────────────────────────────────────────────────────────────
  /// Low-frequency keepalive timer, runs only while a device is connected.
  Timer? _heartbeatTimer;

  /// Aggressive pre-connection poller (3s). Probes static fallback addresses
  /// (10.0.0.1, .local hostnames) until a device is found, then stops.
  Timer? _discoveryPollTimer;

  // ── Subscriptions & state ────────────────────────────────────────────────────
  StreamSubscription? _discoverySub;
  String? _connectedIp; // confirmed live IP we are currently heartbeating
  String? _manualIp;
  String? _probeIp; // IP currently being probed (for UI diagnostics)

  int _missedHeartbeats = 0;
  bool _isHeartbeating = false;

  /// True during the grace window immediately after a successful flash.
  /// Prevents the missed-heartbeat counter from triggering a premature
  /// "disconnected" state while the device is rebooting (~60 seconds).
  bool _inPostFlashGrace = false;

  CancelToken? _heartbeatCancelToken;

  static const int _maxMissedHeartbeats = 3;
  static const Duration _discoveryPollInterval = Duration(seconds: 3);

  /// How long to hold "connecting" state after a flash before giving up.
  /// The ELRS device takes ~60 seconds to re-enter Wi-Fi mode after a flash,
  /// so 75 seconds provides a comfortable buffer.
  static const Duration _postFlashGraceDuration = Duration(seconds: 75);

  static final _log = Logger('ConfigViewModel');

  @override
  FutureOr<RuntimeConfig?> build() async {
    ref.onDispose(() {
      _heartbeatTimer?.cancel();
      _discoveryPollTimer?.cancel();
      _discoverySub?.cancel();
    });

    // Load manual IP override from persistent storage
    final storage = await ref.read(persistenceServiceProvider.future);
    _manualIp = storage.loadManualIp();

    // ── mDNS: event-driven, always running ──────────────────────────────────
    // nsd opens a multicast DNS socket and passively listens. When the ELRS
    // device advertises its _http._tcp record, this fires within 1–3 seconds
    // with no timer required on our end.
    final discoveryService = ref.read(discoveryServiceProvider);
    discoveryService.startScan();

    _discoverySub = discoveryService.targetIpStream.listen((ip) {
      if (ip != null) {
        _onDeviceFound(ip); // fast path — no poll timer delay
      }
    });

    // ── Flash state transitions ───────────────────────────────────────────────
    ref.listen(isFlashingProvider, (previous, next) {
      if (next == true) {
        // Silence all probing while the binary is uploading to prevent
        // socket contention on the device's Wi-Fi stack.
        _log.info(
          'Flashing started — silencing heartbeat and discovery timers.',
        );
        _heartbeatCancelToken?.cancel('Flashing started');
        _heartbeatCancelToken = null;
        _heartbeatTimer?.cancel();
        _discoveryPollTimer?.cancel();
      } else if (previous == true && next == false) {
        // Flash succeeded — device will now reboot and be unreachable for
        // ~60 seconds. Clear stale config immediately, enter grace period,
        // and start aggressive discovery so we reconnect the instant the
        // device comes back online.
        _log.info(
          'Flash complete — clearing config and entering '
          '${_postFlashGraceDuration.inSeconds}s post-flash grace period.',
        );
        _inPostFlashGrace = true;
        state = const AsyncValue.data(null);
        _connectedIp = null;
        ref.read(discoveryServiceProvider).resetFoundState();
        _startDiscoveryPoller();

        // Auto-expire the grace period if the device never comes back.
        Future.delayed(_postFlashGraceDuration, () {
          if (_inPostFlashGrace) {
            _inPostFlashGrace = false;
            _log.info(
              'Post-flash grace period expired — device did not reconnect.',
            );
          }
        });
      }
    });

    // ── Startup: begin pre-connection discovery ───────────────────────────────
    _startDiscoveryPoller();

    return null;
  }

  String? get manualIp => _manualIp;
  String? get probeIp => _probeIp;

  Future<void> setManualIp(String ip) async {
    _manualIp = ip;
    final storage = await ref.read(persistenceServiceProvider.future);
    if (!ref.mounted) return;
    await storage.saveManualIp(ip);

    if (!ref.mounted) return;
    state = const AsyncValue.loading();
    try {
      await fetchConfig(ip);
    } catch (e) {
      // Allow it to remain in error/disconnected state
    }
  }

  // ── Discovery: pre-connection phase ─────────────────────────────────────────

  /// Starts the aggressive pre-connection discovery poller (3-second interval).
  ///
  /// Probes static fallback addresses in parallel via [_probeFallbackAddresses].
  /// Also fires immediately on start so first contact happens within milliseconds,
  /// not after the first 3-second tick.
  ///
  /// The poller cancels itself once [state.value] is non-null (connected), and
  /// is restarted when the device disconnects or the app re-enters the
  /// pre-connection phase after a flash.
  void _startDiscoveryPoller() {
    _discoveryPollTimer?.cancel();
    _probeFallbackAddresses(); // probe immediately, don't wait for first tick
    _discoveryPollTimer = Timer.periodic(_discoveryPollInterval, (_) {
      if (ref.read(isFlashingProvider)) return;
      if (state.value != null) {
        // Already connected — poller's job is done.
        _discoveryPollTimer?.cancel();
        return;
      }
      _probeFallbackAddresses();
    });
  }

  /// Probes [elrs_rx.local], [elrs_tx.local], [10.0.0.1], and [_manualIp]
  /// (if set) in parallel. The first address to respond triggers [_onDeviceFound].
  ///
  /// Uses [Future.any] on a fixed, known set of addresses — racing is safe here
  /// because all candidates are static targets we control. mDNS-discovered IPs
  /// are handled by the stream listener, not this method.
  Future<void> _probeFallbackAddresses() async {
    if (_isHeartbeating) return;
    if (ref.read(isFlashingProvider)) return;
    _isHeartbeating = true;
    _heartbeatCancelToken = CancelToken();

    final candidates = <String>{
      'elrs_rx.local',
      'elrs_tx.local',
      '10.0.0.1',
      if (_manualIp != null && _manualIp!.isNotEmpty) _manualIp!,
    };

    try {
      final service = ref.read(deviceConfigServiceProvider);
      final ip = await Future.any(
        candidates.map((candidate) async {
          _probeIp = candidate;
          final alive = await service.probeDeviceHead(
            candidate,
            cancelToken: _heartbeatCancelToken,
          );
          if (alive) return candidate;
          throw Exception('No response from $candidate');
        }),
      );
      if (!ref.mounted) return;
      await _onDeviceFound(ip);
    } catch (_) {
      // No device found on this tick — poller will retry in 3 seconds.
    } finally {
      _isHeartbeating = false;
    }
  }

  /// Shared success handler invoked by both the mDNS stream listener and the
  /// fallback discovery poller whenever a live device is confirmed.
  ///
  /// Transitions from pre-connection → post-connection:
  /// - cancels the discovery poller
  /// - fetches full device config (if not already loaded)
  /// - starts the low-frequency keepalive heartbeat
  Future<void> _onDeviceFound(String ip) async {
    if (!ref.mounted) return;
    _log.info('Device found at $ip — fetching config.');
    _connectedIp = ip;
    _probeIp = ip;
    _missedHeartbeats = 0;
    _inPostFlashGrace = false; // exit grace period on successful reconnect
    _discoveryPollTimer?.cancel();

    if (state.value == null) {
      await _refreshConfig(ip, cancelToken: _heartbeatCancelToken);
    }
    _startHeartbeat();
  }

  // ── Heartbeat: post-connection phase ─────────────────────────────────────────

  /// Starts the low-frequency post-connection keepalive (10-second interval).
  ///
  /// Only called after [_onDeviceFound] confirms a connection. Probes the
  /// known-good IP plus redundant fallback addresses for DHCP resilience.
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _performHeartbeat(),
    );
  }

  /// Post-connection keepalive heartbeat.
  ///
  /// Probes [_connectedIp] (the confirmed live IP), [elrs_rx.local],
  /// [elrs_tx.local], and [10.0.0.1] in parallel for DHCP resilience.
  /// On 3 consecutive misses, declares the device lost and restarts the
  /// pre-connection discovery poller.
  ///
  /// During [_inPostFlashGrace], missed probes are silently swallowed — the
  /// device is rebooting and will re-advertise via mDNS when ready.
  Future<void> _performHeartbeat() async {
    if (ref.read(isFlashingProvider)) return;
    if (_isHeartbeating) return;
    _isHeartbeating = true;
    _heartbeatCancelToken = CancelToken();

    try {
      final service = ref.read(deviceConfigServiceProvider);
      final candidates = <String>{
        ?_connectedIp,
        'elrs_rx.local',
        'elrs_tx.local',
        '10.0.0.1',
        if (_manualIp != null && _manualIp!.isNotEmpty) _manualIp!,
      };

      final ip = await Future.any(
        candidates.map((candidate) async {
          final alive = await service.probeDeviceHead(
            candidate,
            cancelToken: _heartbeatCancelToken,
          );
          if (alive) return candidate;
          throw Exception('No response from $candidate');
        }),
      );

      if (!ref.mounted) return;
      _missedHeartbeats = 0;
      _connectedIp = ip; // update in case DHCP reassigned the address
    } catch (_) {
      if (!ref.mounted) return;

      // During the post-flash grace period the device is rebooting — don't
      // count misses or drop state. The mDNS listener will call _onDeviceFound
      // automatically when the device comes back online.
      if (_inPostFlashGrace) {
        _log.info(
          'Post-flash grace: device rebooting — suppressing miss count.',
        );
        return;
      }

      _missedHeartbeats++;
      if (_missedHeartbeats >= _maxMissedHeartbeats) {
        _log.info(
          'Device lost after $_maxMissedHeartbeats missed heartbeats. '
          'Returning to discovery.',
        );
        if (state.value != null || state.isLoading) {
          state = const AsyncValue.data(null);
        }
        _connectedIp = null;
        _heartbeatTimer?.cancel();
        ref.read(discoveryServiceProvider).resetFoundState();
        _startDiscoveryPoller(); // back to pre-connection phase
      } else {
        _log.info(
          'Heartbeat missed ($_missedHeartbeats/$_maxMissedHeartbeats). '
          'Preserving last good state.',
        );
      }
    } finally {
      _isHeartbeating = false;
    }
  }

  // ── Config operations ────────────────────────────────────────────────────────

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
