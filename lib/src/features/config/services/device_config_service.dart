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
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
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
          return RuntimeConfig.fromJson(data);
        } else {
          throw Exception('Invalid data format received from $ip');
        }
      } else {
        throw Exception('Failed to fetch config. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to reach device at $ip: $e');
    }
  }

  /// Saves the updated options to the device.
  /// Performs a POST request to `http://<ip>/options.json`.
  /// Adds 'customised': true to the payload.
  Future<void> saveOptions(String ip, Map<String, dynamic> options) async {
    try {
      final payload = Map<String, dynamic>.from(options);
      payload['customised'] = true;

      final response = await _dio.post(
        'http://$ip/options.json',
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to save options. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to save options to $ip: $e');
    }
  }

  /// Saves the updated config to the device.
  /// Performs a POST request to `http://<ip>/config`.
  Future<void> saveConfig(String ip, Map<String, dynamic> config) async {
    try {
      final response = await _dio.post(
        'http://$ip/config',
        data: config,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to save config. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to save config to $ip: $e');
    }
  }

  /// Reboots the device.
  /// Performs a POST request to `http://<ip>/reboot`.
  Future<void> reboot(String ip) async {
    try {
      final response = await _dio.post('http://$ip/reboot');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to reboot device. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to reboot device at $ip: $e');
    }
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
        settings[key] = config[key];
      }
    }

    if (settings.isNotEmpty) {
      data['settings'] = settings;
      _log.info('V3 normalization: hoisted ${settings.keys.toList()} into settings block');
    }
  }
}
