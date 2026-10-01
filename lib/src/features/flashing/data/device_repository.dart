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
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/device_dio.dart';
import '../../../core/networking/expected_reboot_drop.dart';
import '../utils/firmware_assembler.dart';

part 'device_repository.g.dart';

/// The whole image was sent but the device dropped the connection without
/// replying. ExpressLRS replies `"ok"` and only then reboots (200 ms later),
/// so this usually means it lost power or crashed while writing — though a
/// reply can occasionally be lost on a weak link after a real success.
/// Either way the outcome is unknown and must not be reported as success.
class FlashUnconfirmedException implements Exception {
  const FlashUnconfirmedException(this.cause);
  final String cause;

  @override
  String toString() => cause;
}

@riverpod
DeviceRepository deviceRepository(Ref ref) {
  final dio = ref.watch(localDioProvider);
  return DeviceRepository(dio);
}

class DeviceRepository {
  final Dio _dio;
  static final _log = Logger('DeviceRepository');

  DeviceRepository(this._dio);

  /// Flashes the firmware to the device.
  /// Endpoint: POST /update
  ///
  /// [firmwareData] is the binary data of the firmware file.
  /// [onSendProgress] is an optional callback for upload progress.
  ///
  /// Optional parameters for Unified Firmware Building (ESP only):
  /// [productName], [luaName], [uid], [hardwareLayout], [wifiSsid], [wifiPassword].
  /// If [hardwareLayout] is provided, the firmware will be built using [FirmwareAssembler].
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
    int? wifiOnInterval,
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
        wifiOnInterval: wifiOnInterval,
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

    // Targeted Compression Logic
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
    int? wifiOnInterval,
    bool isTx = false,
    bool force = false,
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
        wifiOnInterval: wifiOnInterval,
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
      var uploadComplete = false;

      try {
        final response = await _dio.post(
          '/update',
          data: formData,
          // The `force` arg makes the device skip its target-name check and
          // commit the image in this same request (supported since 2.x).
          queryParameters: force ? {'force': '1'} : null,
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
            if (total > 0 && sent >= total) uploadComplete = true;
            onSendProgress?.call(sent, total);
          },
        );

        _log.info('Device response: ${response.data}');
        final status = _responseStatus(response.data);
        if (status == 'mismatch') {
          // Let the upper layer handle mismatch via confirmForceUpdate
          throw Exception('mismatch');
        } else if (status != null && status != 'ok') {
          throw Exception('Flashing failed: ${_responseMessage(response.data)}');
        }
        _log.info('Flash successful!');
      } on DioException catch (e) {
        // A drop mid-upload is a plain failure; one after the last byte left
        // the phone is ambiguous (see [FlashUnconfirmedException]).
        if (uploadComplete && isExpectedRebootSocketDrop(e)) {
          _log.warning('Device dropped the connection without replying: $e');
          throw FlashUnconfirmedException(e.message ?? e.toString());
        }
        rethrow;
      }
    } on FlashUnconfirmedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to flash firmware: $e');
    }
  }

  /// Confirms a forced update after a target mismatch using Dio.
  Future<void> confirmForceUpdate() async {
    try {
      _log.info('Sending manual action=confirm to /forceupdate...');
      final formData = FormData.fromMap({'action': 'confirm'});

      final response = await _dio.post('/forceupdate', data: formData);

      // The device answers HTTP 200 even when the commit fails (e.g. nothing
      // is in its OTA buffer), so the status field is the real result.
      _log.info('Force confirm response: ${response.data}');
      final status = _responseStatus(response.data);
      if (status != null && status != 'ok') {
        throw Exception(_responseMessage(response.data));
      }
    } on DioException catch (e) {
      // The device replies before rebooting, so a drop here is ambiguous too.
      if (isExpectedRebootSocketDrop(e)) {
        _log.warning('Device dropped the connection during force confirm: $e');
        throw FlashUnconfirmedException(e.message ?? e.toString());
      }
      throw Exception('Force update rejected: $e');
    } catch (e) {
      throw Exception('Force update rejected: $e');
    }
  }

  /// Extracts the `status` field from a device JSON reply. Dio only decodes
  /// bodies whose content type it recognises, so string bodies are decoded
  /// here too. Returns null for replies that aren't status JSON (very old
  /// firmware), which callers treat as success as before.
  static String? _responseStatus(Object? data) =>
      _decodeResponse(data)?['status']?.toString();

  static String _responseMessage(Object? data) =>
      _decodeResponse(data)?['msg']?.toString() ?? '$data';

  static Map<String, dynamic>? _decodeResponse(Object? data) {
    if (data is Map<String, dynamic>) return data;
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) return decoded;
      } on FormatException {
        return null;
      }
    }
    return null;
  }
}
