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

import 'dart:typed_data';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/device_dio.dart';
import '../../config/domain/runtime_config_model.dart';
import '../utils/firmware_assembler.dart';
import '../../../core/analytics/analytics_service.dart';

part 'device_repository.g.dart';

@riverpod
DeviceRepository deviceRepository(Ref ref) {
  final dio = ref.watch(localDioProvider);
  return DeviceRepository(dio, ref);
}

class DeviceRepository {
  final Dio _dio;
  final Ref? _ref;
  static final _log = Logger('DeviceRepository');

  DeviceRepository(this._dio, [this._ref]);

  Dio get dio => _dio;

  /// Fetches the current configuration from the device.
  /// Endpoint: GET /config
  Future<RuntimeConfig> fetchConfig() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await _dio.get('/config');
      stopwatch.stop();
      Sentry.metrics.distribution(
        'config_fetch_latency',
        stopwatch.elapsedMilliseconds.toDouble(),
        unit: SentryMetricUnit.millisecond,
      );
      _ref?.read(analyticsServiceProvider).trackEvent('Device Connected');
      return RuntimeConfig.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      _ref?.read(analyticsServiceProvider).trackEvent('Device Connection Failed', {
        'error': e.toString(),
      });
      throw Exception('Failed to fetch config: $e');
    }
  }

  /// Updates the binding phrase.
  /// Generates the UID and sends it to /config.
  Future<void> updateBindingPhrase(String phrase) async {
    try {
      final uid = FirmwareAssembler.generateUid(phrase);
      await _dio.post('/config', data: {'uid': uid});
      _ref?.read(analyticsServiceProvider).trackEvent('Settings Changed', {'setting': 'Bind Phrase'});
    } catch (e) {
      throw Exception('Failed to update binding phrase: $e');
    }
  }

  /// Updates the Home WiFi credentials.
  /// Endpoint: POST /config
  Future<void> updateWifi(String ssid, String password) async {
    try {
      await _dio.post(
        '/config',
        data: {'wifi-ssid': ssid, 'wifi-password': password},
      );
      _ref?.read(analyticsServiceProvider).trackEvent('Settings Changed', {'setting': 'WiFi'});
    } catch (e) {
      throw Exception('Failed to update WiFi: $e');
    }
  }

  /// Fetches the hardware definition from the device.
  /// Endpoint: GET /hardware.json
  Future<Map<String, dynamic>> fetchHardware() async {
    try {
      final response = await _dio.get('/hardware.json');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch hardware info: $e');
    }
  }

  /// Flashes the firmware to the device.
  /// Endpoint: POST /update
  ///
  /// [firmwareData] is the binary data of the firmware file.
  /// [onSendProgress] is an optional callback for upload progress.
  ///
  /// Optional parameters for Unified Firmware Building (ESP only):
  /// [productName], [luaName], [uid], [hardwareLayout], [wifiSsid], [wifiPassword].
  /// If [hardwareLayout] is provided, the firmware will be built using UnifiedFirmwareBuilder.
  Future<({Uint8List bytes, String filename})> buildFirmwarePayload(
    Uint8List firmwareData,
    String filename, {
    String? productName,
    String? luaName,
    List<int>? uid,
    Map<String, dynamic>? hardwareLayout,
    String? wifiSsid,
    String? wifiPassword,
    String? platform,
    int? domain,
    bool isTx = false,
  }) async {
    Uint8List dataToUpload;
    String filenameToUpload;

    // Check if Unified Building is requested/possible
    if (hardwareLayout != null &&
        productName != null &&
        luaName != null &&
        uid != null &&
        platform != null) {
      _log.info('Building Unified Firmware for $productName ($platform)...');

      Uint8List baseFirmware = firmwareData;
      if (filename.endsWith('.gz')) {
        final decompressed = GZipDecoder().decodeBytes(firmwareData);
        baseFirmware = Uint8List.fromList(decompressed);
      }

      dataToUpload = FirmwareAssembler.assembleEspUnified(
        firmware: baseFirmware,
        productName: productName,
        luaName: luaName,
        uid: uid,
        hardwareLayout: hardwareLayout,
        platform: platform,
        wifiSsid: wifiSsid ?? '',
        wifiPassword: wifiPassword ?? '',
        domain: domain,
        isTx: isTx,
      );
      // Unified firmware is always a .bin before compression
      filenameToUpload = filename.endsWith('.gz')
          ? filename.substring(0, filename.length - 3)
          : filename;
      if (!filenameToUpload.endsWith('.bin')) filenameToUpload += '.bin';

      _log.info('Unified Firmware Built. Size: ${dataToUpload.length} bytes');
    } else {
      dataToUpload = firmwareData;
      filenameToUpload = filename;
    }

    // Targeted Compression Logic (Task 3)
    if (platform == 'esp8285') {
      _log.info('Compressing firmware for ESP8285...');
      final compressed = GZipEncoder().encode(dataToUpload);
      if (compressed == null) {
        throw Exception('Failed to compress firmware payload.');
      }
      dataToUpload = Uint8List.fromList(compressed);
      if (!filenameToUpload.endsWith('.gz')) filenameToUpload += '.gz';
    } else if (platform != null && platform.startsWith('esp32')) {
      _log.info('Using raw bytes for ESP32 ($platform)');
      if (filenameToUpload.endsWith('.gz')) {
        filenameToUpload = filenameToUpload.substring(
          0,
          filenameToUpload.length - 3,
        );
      }
    } else {
      _log.info('Skipping compression for platform: $platform');
    }

    int trimmingDelta = 0;
    if (platform != null) {
      final trimmedEnd = FirmwareAssembler.findFirmwareEnd(
        firmwareData,
        platform,
      );
      trimmingDelta = firmwareData.length - trimmedEnd;
    }
    _log.info('Trimming Delta: $trimmingDelta');
    _log.info('Final Byte Count: ${dataToUpload.length}');

    return (bytes: dataToUpload, filename: filenameToUpload);
  }

  Future<void> flashFirmware(
    Uint8List firmwareData,
    String filename, {
    void Function(int, int)? onSendProgress,
    // Unified Builder Params
    String? productName,
    String? luaName,
    List<int>? uid,
    Map<String, dynamic>? hardwareLayout,
    String? wifiSsid,
    String? wifiPassword,
    String? platform,
    int? domain,
    bool force = false,
    bool isTx = false,
  }) async {
    try {
      final payload = await buildFirmwarePayload(
        firmwareData,
        filename,
        productName: productName,
        luaName: luaName,
        uid: uid,
        hardwareLayout: hardwareLayout,
        wifiSsid: wifiSsid,
        wifiPassword: wifiPassword,
        platform: platform,
        domain: domain,
        isTx: isTx,
      );

      final formData = FormData.fromMap({
        'upload': MultipartFile.fromBytes(
          payload.bytes,
          filename: payload.filename,
        ),
      });

      // Bypassing chunked encoding by explicitly evaluating payload size
      final evaluatedLength = formData.length;

      try {
        final response = await _dio.post(
          '/update',
          data: formData,
          options: Options(
            headers: {
              Headers.contentLengthHeader: evaluatedLength,
              'X-FileSize': payload.bytes.length.toString(),
            },
            receiveTimeout: const Duration(seconds: 120),
            sendTimeout: const Duration(seconds: 120),
          ),
          onSendProgress: (sent, total) {
            _log.info(
              'Upload Progress: ${(sent / total * 100).toStringAsFixed(1)}%',
            );
          },
        );

        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          if (responseData['status'] == 'mismatch') {
            // Let the upper layer handle mismatch via confirmForceUpdate
            throw Exception('mismatch');
          } else if (responseData['status'] != 'ok') {
            throw Exception('Flashing failed: ${responseData['msg']}');
          }
        }
        _log.info('Flash successful!');
      } on DioException catch (e) {
        if (_isExpectedRebootSocketDrop(e)) {
          _log.info(
            'Device successfully updated and rebooted! Caught expected socket drop.',
          );
          return; // Treat as full success
        }
        rethrow;
      }
    } catch (e) {
      throw Exception('Failed to flash firmware: $e');
    }
  }

  bool _isExpectedRebootSocketDrop(DioException e) {
    final errStr = e.toString().toLowerCase();
    return errStr.contains('software caused connection abort') ||
        errStr.contains('connection closed before full header was received') ||
        errStr.contains('connection reset by peer') ||
        errStr.contains('broken pipe');
  }

  /// Confirms a forced update after a target mismatch using Dio.
  Future<void> confirmForceUpdate() async {
    try {
      _log.info('Sending manual action=confirm to /forceupdate...');

      final formData = FormData.fromMap({'action': 'confirm'});

      final evaluatedLength = formData.length;

      final response = await _dio.post(
        '/forceupdate',
        data: formData,
        options: Options(
          headers: {Headers.contentLengthHeader: evaluatedLength},
        ),
      );

      final responseData = response.data;
      if (responseData is Map<String, dynamic> &&
          responseData['status'] != 'ok') {
        throw Exception('Force update failed: ${responseData['msg']}');
      }
      _log.info('Force update successful!');
    } on DioException catch (e) {
      final errStr = e.toString();
      if (errStr.contains('Software caused connection abort') ||
          errStr.contains(
            'Connection closed before full header was received',
          ) ||
          errStr.contains('Connection reset by peer')) {
        _log.info(
          'ESP32 successfully forced and rebooted! Caught expected socket drop.',
        );
        return;
      }
      throw Exception('Failed to force update: $e');
    } catch (e) {
      throw Exception('Failed to force update: $e');
    }
  }

  /// Updates the Model Match configuration.
  /// Endpoint: POST /config
  ///
  /// [modelId] is the ID (0-63). 255 usually means off in ELRS context,
  /// but we'll stick to the user request.
  /// [enabled] determines if model match is active.
  Future<void> updateModelMatch(int modelId, bool enabled) async {
    try {
      // Structure based on ELRS config API.
      // For MVP, sending flat JSON keys as requested.
      // Real ELRS uses a more complex structure, but this is the requested contract.
      await _dio.post(
        '/config',
        data: {'modelid': modelId, 'modelMatch': enabled},
      );
    } catch (e) {
      throw Exception('Failed to update model match: $e');
    }
  }

  /// Sets the PWM output mapping.
  /// Endpoint: POST /config
  ///
  /// [mapping] maps Output Pin Index (0-based) to Input Channel Index.
  /// The payload sent is {'pwm': [ch_for_pin0, ch_for_pin1, ...]}
  Future<void> setPwmMapping(Map<int, int> mapping) async {
    try {
      if (mapping.isEmpty) return;

      final maxIndex = mapping.keys.reduce((a, b) => a > b ? a : b);
      final List<int> pwm = List.filled(maxIndex + 1, 0);

      mapping.forEach((pin, channel) {
        if (pin >= 0 && pin < pwm.length) {
          pwm[pin] = channel;
        }
      });

      await _dio.post('/config', data: {'pwm': pwm});
    } catch (e) {
      throw Exception('Failed to set PWM mapping: $e');
    }
  }
}
