// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import '../domain/runtime_config_model.dart';

class DeviceConfigService {
  final Dio _dio;
  static final _log = Logger('DeviceConfigService');

  DeviceConfigService(this._dio);

  /// Probes the device with a lightweight GET request for hardware metadata to securely verify heartbeat.
  ///
  /// `/hardware.json` only exists on unified-target firmware (3.2.x+ with
  /// unified build flags, unconditional from ~4.x on). Pre-3.1.0 firmware
  /// (e.g. 3.0.1) never serves it, so falls back to [probeDevice], which
  /// hits `/` — present on every ExpressLRS firmware version.
  Future<bool> probeDeviceHead(String ip, {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(
        'http://$ip/hardware.json',
        cancelToken: cancelToken,
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
      );
      if (response.statusCode == 200) return true;
    } catch (e) {
      // Fall through to the universal probe below.
    }
    return probeDevice(ip, cancelToken: cancelToken);
  }

  /// Probes the device to see if it's alive and responding.
  /// Uses a short timeout (2s) as requested.
  Future<bool> probeDevice(String ip, {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(
        'http://$ip/',
        cancelToken: cancelToken,
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Fetches the current configuration from the device.
  /// Performs a GET request to `http://<ip>/config`.
  ///
  /// `/config` was only added in firmware 3.1.0. On 3.0.x it 404s, so this
  /// falls back to [_fetchLegacyConfig], which reconstructs an equivalent
  /// config from `/target` (and best-effort `/mode.json`) — the endpoints
  /// 3.0.x firmware actually serves.
  Future<RuntimeConfig> fetchConfig(String ip, {CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(
        'http://$ip/config',
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        _log.info('Raw Device Config JSON: $data');

        if (data is Map<String, dynamic>) {
          _normalizeV3Config(data);
          _normalizeConfigDomains(data);

          // Normalize vbind to prevent TypeError on older firmware
          if (data.containsKey('config') && data['config'] is Map) {
            final configMap = data['config'] as Map<String, dynamic>;
            if (configMap.containsKey('vbind')) {
              final vbindVal = configMap['vbind'];
              if (vbindVal is bool) {
                configMap['vbind'] = vbindVal ? 1 : 0;
              } else if (vbindVal is String) {
                if (vbindVal.toLowerCase() == 'true') configMap['vbind'] = 1;
                if (vbindVal.toLowerCase() == 'false') configMap['vbind'] = 0;
              }
            }
          }

          return RuntimeConfig.fromJson(data);
        } else {
          throw Exception('Invalid data format received from $ip');
        }
      } else {
        throw Exception('Failed to fetch config. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        _log.info('$ip has no /config endpoint — trying legacy fallback (pre-3.1.0 firmware).');
        return _fetchLegacyConfig(ip, cancelToken: cancelToken);
      }
      throw Exception('Failed to reach device at $ip: $e');
    } catch (e) {
      throw Exception('Failed to reach device at $ip: $e');
    }
  }

  /// Reconstructs a [RuntimeConfig] for firmware older than 3.1.0, which
  /// predates the unified `/config` endpoint.
  ///
  /// `/target` (present in every version through at least 3.2.1) reports
  /// `product_name`, `version`, `target`, and `reg_domain` — enough to
  /// populate [RuntimeConfigX.effectiveProductName] with the device's real
  /// product name so the Target Mismatch Guard compares against actual data
  /// instead of leaving the device stuck "disconnected". `/mode.json`
  /// (removed once `/config` landed, ~3.2.x) is merged in best-effort for
  /// `modelid`/`uid` where still available.
  Future<RuntimeConfig> _fetchLegacyConfig(String ip, {CancelToken? cancelToken}) async {
    final targetResponse = await _dio.get(
      'http://$ip/target',
      cancelToken: cancelToken,
    );
    final targetData = targetResponse.data;
    if (targetData is! Map<String, dynamic>) {
      throw Exception('Invalid /target response from $ip');
    }

    final data = <String, dynamic>{
      'product_name': targetData['product_name'],
      'version': targetData['version'],
      'target': targetData['target'],
      'settings': {
        'product_name': targetData['product_name'],
        'target': targetData['target'],
        'reg_domain': targetData['reg_domain'],
      },
    };

    try {
      final modeResponse = await _dio.get(
        'http://$ip/mode.json',
        cancelToken: cancelToken,
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
      );
      final modeData = modeResponse.data;
      if (modeData is Map<String, dynamic>) {
        data['config'] = {
          if (modeData['modelid'] != null) 'modelid': modeData['modelid'],
          if (modeData['forcetlm'] != null) 'force-tlm': modeData['forcetlm'],
        };
        if (modeData['uid'] is List) {
          data['options'] = {'uid': modeData['uid']};
        }
      }
    } catch (_) {
      // /mode.json is gone by ~3.2.x — /target alone is enough to unblock flashing.
    }

    _normalizeConfigDomains(data);
    return RuntimeConfig.fromJson(data);
  }

  /// Normalizes V3 firmware JSON payloads to match the V4 structure.
  ///
  /// V3 stores `product_name`, `lua_name`, `version`, `target`, `module-type`,
  /// `uidtype`, and `reg_domain` inside the `config` block.
  /// V4 moved these into a dedicated `settings` block.
  ///
  /// This method hoists those fields into a synthetic `settings` map so the
  /// Freezed model sees a consistent shape regardless of firmware version.
  void _normalizeV3Config(Map<String, dynamic> data) {
    // If settings already exists (V4+), nothing to do
    if (data.containsKey('settings') && data['settings'] is Map) return;

    final config = data['config'];
    if (config is! Map<String, dynamic>) return;

    // Keys that belong in settings, not config
    const metadataKeys = [
      'product_name',
      'lua_name',
      'version',
      'target',
      'module-type',
      'uidtype',
      'reg_domain',
      'radio-type',
      'has-highpower',
      'has_serial_pins',
      'device_id',
    ];

    final settings = <String, dynamic>{};
    for (final key in metadataKeys) {
      if (config.containsKey(key)) {
        if (key == 'reg_domain') {
          final val = config[key];
          settings['reg_domain'] = val;
          final parsed = int.tryParse(val.toString());
          if (parsed != null) {
            settings['domain'] = parsed;
          }
        } else {
          settings[key] = config[key];
        }
      }
    }

    if (settings.isNotEmpty) {
      data['settings'] = settings;
      _log.info('V3 normalization: hoisted ${settings.keys.toList()} into settings block');
    }
  }

  /// Normalizes reg_domain to domain across config, settings, and options sub-maps for both V3 and V4.
  void _normalizeConfigDomains(Map<String, dynamic> data) {
    if (data['options'] is Map<String, dynamic>) {
      final options = data['options'] as Map<String, dynamic>;
      if (options.containsKey('reg_domain')) {
        final val = options['reg_domain'];
        final parsed = int.tryParse(val?.toString() ?? '');
        if (parsed != null) {
          options['domain'] = parsed;
        }
      }
    }
    if (data['settings'] is Map<String, dynamic>) {
      final settings = data['settings'] as Map<String, dynamic>;
      if (settings.containsKey('reg_domain')) {
        final val = settings['reg_domain'];
        final parsed = int.tryParse(val?.toString() ?? '');
        if (parsed != null) {
          settings['domain'] = parsed;
        }
      }
    }
    if (data['config'] is Map<String, dynamic>) {
      final config = data['config'] as Map<String, dynamic>;
      if (config.containsKey('reg_domain')) {
        final val = config['reg_domain'];
        final parsed = int.tryParse(val?.toString() ?? '');
        if (parsed != null) {
          config['domain'] = parsed;
        }
      }
    }
  }
}
