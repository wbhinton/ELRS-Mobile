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

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:binary/binary.dart';
import '../domain/runtime_config_model.dart';

class DeviceConfigService {
  final Dio _dio;
  static final _log = Logger('DeviceConfigService');

  DeviceConfigService(this._dio);

  /// Probes the device with a very fast (1s) HEAD request to check if IP is alive.
  Future<bool> probeDeviceHead(String ip) async {
    try {
      final response = await _dio.head(
        'http://$ip/',
        options: Options(
          sendTimeout: const Duration(seconds: 1),
          receiveTimeout: const Duration(seconds: 1),
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Probes the device to see if it's alive and responding.
  /// Uses a short timeout (2s) as requested.
  Future<bool> probeDevice(String ip) async {
    try {
      final response = await _dio.get(
        'http://$ip/',
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
  Future<RuntimeConfig> fetchConfig(String ip) async {
    try {
      final response = await _dio.get('http://$ip/config');
      if (response.statusCode == 200) {
        final data = response.data;
        _log.info('Raw Device Config JSON: $data');

        RuntimeConfig config;
        if (data is Map<String, dynamic>) {
          if (data.containsKey('settings')) {
            _log.info('V4 Path: "settings" key detected.');
            config = RuntimeConfig.fromJson(data);
          } else {
            _log.info(
                'V3 Path: "settings" key missing. Executing local normalization.');
            config = _normalizeV3Config(data);
          }
        } else {
          throw Exception('Invalid data format received from $ip');
        }

        // 5. Version Scrape Fallback: If version is still unknown, try scraping root HTML.
        if (config.settings.version == 'unknown' ||
            config.settings.version == null) {
          _log.info('Version is unknown. Attempting HTML scrape fallback...');
          final scrapedVersion = await _scrapeVersionFromHtml(ip);
          if (scrapedVersion != null) {
            _log.info('Recovered version from HTML: $scrapedVersion');
            config = config.copyWith(
              settings: config.settings.copyWith(version: scrapedVersion),
            );
          }
        }

        return config;
      } else {
        throw Exception(
            'Failed to fetch config. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to reach device at $ip: $e');
    }
  }

  /// Normalizes a legacy V3 or "hybrid" JSON payload into the structural V4 format.
  RuntimeConfig _normalizeV3Config(Map<String, dynamic> v3Json) {
    final configNode = v3Json['config'] as Map<String, dynamic>? ?? {};
    final optionsNode = v3Json['options'] as Map<String, dynamic>? ?? {};

    // 1. Recover Metadata (Multi-path lookup for hybrid V3/V4 layouts).
    final productName = v3Json['product_name'] as String? ??
        configNode['product_name'] as String? ??
        v3Json['product-name'] as String? ??
        configNode['product-name'] as String?;

    final target = v3Json['target'] as String? ??
        configNode['target'] as String? ??
        configNode['lua_name'] as String?;

    final version = v3Json['version'] as String? ??
        configNode['version'] as String? ??
        'unknown';

    final deviceId = v3Json['device_id'] as int? ??
        configNode['device_id'] as int? ??
        v3Json['device-id'] as int? ??
        configNode['device-id'] as int? ??
        optionsNode['device_id'] as int? ??
        optionsNode['device-id'] as int?;

    final domain = v3Json['domain'] as int? ??
        optionsNode['domain'] as int? ??
        configNode['domain'] as int? ??
        v3Json['reg_domain_index'] as int?;

    _log.info('Recovered Metadata -> Name: $productName, Target: $target, Domain: $domain');

    // 2. Identify Serial Support (Official WebUI 3-Step Logic).
    final pwmData = configNode['pwm'];
    bool hasSerialPins = false;
    if (pwmData == null || (pwmData is List && pwmData.isEmpty)) {
      hasSerialPins = true;
    } else if (pwmData is List) {
      hasSerialPins = pwmData.any((p) {
        if (p is! Map) return false;
        final config = p['config'] as int? ?? 0;
        final mode = (config >> 16) & 15;
        return mode == 8 || mode == 9;
      });
    }

    if (!hasSerialPins) {
      hasSerialPins = v3Json['settings']?['has_serial_pins'] == true;
    }

    // 3. Determine Module Type (Target-first, then Product Name scanning).
    String? moduleType;
    final searchStr = '${target ?? ''} ${productName ?? ''}'.toUpperCase();
    if (searchStr.contains('TX')) {
      moduleType = 'TX';
    } else if (searchStr.contains('RX')) {
      moduleType = 'RX';
    }

    // 4. Apply bit-precision to numeric attributes using Uint8 wrapping.
    final settingsNode = ElrsSettings(
      productName: productName,
      version: version,
      target: target,
      deviceId: deviceId != null ? Uint8(deviceId).toInt() : null,
      domain: domain != null ? Uint8(domain).toInt() : null,
      hasSerialPins: hasSerialPins,
      moduleType: moduleType,
    );

    // 5. Return the modern structure, preserving existing nodes.
    return RuntimeConfig.fromJson({
      ...v3Json, // Preserve all original root keys
      'settings': settingsNode.toJson(),
    });
  }

  /// Scrapes the firmware version from the root HTML page using exact elrsState RegExp.
  Future<String?> _scrapeVersionFromHtml(String ip) async {
    try {
      final response = await _dio.get(
        'http://$ip/',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        final html = response.data.toString();
        // Exact RegExp requested: var elrsState = ({.*?});
        final regExp = RegExp(
          r'var\s+elrsState\s+=\s+(\{.*?\});',
          multiLine: true,
          dotAll: true,
        );

        final match = regExp.firstMatch(html);
        if (match != null) {
          final jsonStr = match.group(1);
          if (jsonStr != null) {
            final Map<String, dynamic> state = json.decode(jsonStr);
            return state['version'] as String? ??
                state['version-name'] as String? ??
                state['version_name'] as String?;
          }
        }
      }
      return null;
    } catch (e) {
      _log.warning('Failed to scrape version from HTML at $ip: $e');
      return null;
    }
  }

  /// Saves the updated options to the device.
  /// Performs a POST request to `http://<ip>/options.json`.
  /// Adds 'customised': true to the payload.
  Future<void> saveOptions(String ip, Map<String, dynamic> options) async {
    try {
      final payload = Map<String, dynamic>.from(options);
      payload['customised'] = true;

      _log.info('Saving Options to http://$ip/options.json: $payload');
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
      _log.info('Saving Config to http://$ip/config: $config');
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
    } on DioException catch (e) {
      if (_isExpectedRebootSocketDrop(e)) {
        _log.info('Caught expected socket drop during reboot to $ip');
        return;
      }
      throw Exception('Failed to reboot device at $ip: $e');
    } catch (e) {
      throw Exception('Failed to reboot device at $ip: $e');
    }
  }

  bool _isExpectedRebootSocketDrop(DioException e) {
    final errStr = e.toString().toLowerCase();
    return errStr.contains('software caused connection abort') ||
        errStr.contains('connection closed before full header was received') ||
        errStr.contains('connection reset by peer') ||
        errStr.contains('broken pipe') ||
        errStr.contains('connection refused');
  }
}
