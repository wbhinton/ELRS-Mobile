import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/device_dio.dart';
import '../../configurator/domain/device_config_model.dart';
import '../utils/firmware_assembler.dart';
import 'package:path_provider/path_provider.dart';

part 'device_repository.g.dart';

@riverpod
DeviceRepository deviceRepository(Ref ref) {
  final dio = ref.watch(deviceDioProvider);
  return DeviceRepository(dio);
}

class DeviceRepository {
  final Dio _dio;
  final http.Client? _httpClient;

  DeviceRepository(this._dio, {http.Client? httpClient}) : _httpClient = httpClient;

  Dio get dio => _dio;

  /// Fetches the current configuration from the device.
  /// Endpoint: GET /config
  Future<DeviceConfig> fetchConfig() async {
    try {
      final response = await _dio.get('/config');
      return DeviceConfig.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch config: $e');
    }
  }

  /// Updates the binding phrase.
  /// Generates the UID and sends it to /config.
  Future<void> updateBindingPhrase(String phrase) async {
    try {
      final uid = FirmwareAssembler.generateUid(phrase);
      await _dio.post(
        '/config',
        data: {'uid': uid},
      );
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
        data: {
          'wifi_ssid': ssid,
          'wifi_password': password,
        },
      );
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
    bool force = false,
  }) async {
    try {
      Uint8List dataToUpload;
      String filenameToUpload;

      // Check if Unified Building is requested/possible
      if (hardwareLayout != null && productName != null && luaName != null && uid != null && platform != null) {
        print('Building Unified Firmware for $productName ($platform)...');
        dataToUpload = FirmwareAssembler.assembleEspUnified(
          firmware: firmwareData,
          productName: productName,
          luaName: luaName,
          uid: uid,
          hardwareLayout: hardwareLayout,
          platform: platform,
          wifiSsid: wifiSsid ?? '',
          wifiPassword: wifiPassword ?? '',
        );
        // Unified firmware is always a .bin before compression
        filenameToUpload = filename.endsWith('.gz') ? filename.substring(0, filename.length - 3) : filename;
        if (!filenameToUpload.endsWith('.bin')) filenameToUpload += '.bin';
        
        print('Unified Firmware Built. Size: ${dataToUpload.length} bytes');
        
        // --- FORENSIC DEBUG: Save to Documents Directory ---
        try {
          final directory = await getApplicationDocumentsDirectory();
          final debugFile = File('${directory.path}/generated_er8.bin');
          await debugFile.writeAsBytes(dataToUpload);
          print('I/flutter: DEBUG: Firmware saved to: ${debugFile.path}');
          print('I/flutter: TIP: Run \'open "${directory.path}"\' in your terminal to see the file.');
        } catch (e) {
          print('Warning: Failed to save debug firmware file: $e');
        }
        // --------------------------------------------------

      } else {
        dataToUpload = firmwareData;
        filenameToUpload = filename;
      }

      // Targeted Compression Logic (Task 3)
      if (platform == 'esp8285') {
        print('Compressing firmware for ESP8285...');
        final compressed = GZipEncoder().encode(dataToUpload);
        if (compressed == null) {
          throw Exception('Failed to compress firmware payload.');
        }
        dataToUpload = Uint8List.fromList(compressed);
        if (!filenameToUpload.endsWith('.gz')) filenameToUpload += '.gz';
      } else if (platform != null && platform.startsWith('esp32')) {
        print('Using raw bytes for ESP32 ($platform)');
        if (filenameToUpload.endsWith('.gz')) {
           filenameToUpload = filenameToUpload.substring(0, filenameToUpload.length - 3);
        }
      } else {
        print('Skipping compression for platform: $platform');
      }

      int trimmingDelta = 0;
      if (platform != null) {
        final trimmedEnd = FirmwareAssembler.findFirmwareEnd(firmwareData, platform);
        trimmingDelta = firmwareData.length - trimmedEnd;
      }
      print('Trimming Delta: $trimmingDelta');
      print('Final Byte Count: ${dataToUpload.length}');

      final formData = FormData.fromMap({
        'upload': MultipartFile.fromBytes(
          dataToUpload,
          filename: filenameToUpload,
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
              'X-FileSize': dataToUpload.length.toString(),
            },
            receiveTimeout: const Duration(seconds: 120),
            sendTimeout: const Duration(seconds: 120),
          ),
          onSendProgress: (sent, total) {
             print('Upload Progress: ${(sent / total * 100).toStringAsFixed(1)}%');
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
        print('LOG: Flash successful!');
      } on DioException catch (e) {
        final errStr = e.toString();
        // The ESP32 physically reboots within 200ms of a successful flash.
        // It often severs the TCP connection before sending the HTTP JSON response back.
        if (errStr.contains('Software caused connection abort') || 
            errStr.contains('Connection closed before full header was received') ||
            errStr.contains('Connection reset by peer')) {
           print('LOG: ESP32 successfully updated and rebooted! Caught expected socket drop.');
           return; // Treat as full success
        }
        rethrow;
      }
      
    } catch (e) {
      throw Exception('Failed to flash firmware: $e');
    }
  }

  /// Confirms a forced update after a target mismatch using Dio.
  Future<void> confirmForceUpdate() async {
    try {
      print('LOG: Sending manual action=confirm to /forceupdate...');
      
      final formData = FormData.fromMap({
        'action': 'confirm',
      });

      final evaluatedLength = formData.length;

      final response = await _dio.post(
        '/forceupdate',
        data: formData,
        options: Options(
          headers: {
            Headers.contentLengthHeader: evaluatedLength,
          },
        ),
      );

      final responseData = response.data;
      if (responseData is Map<String, dynamic> && responseData['status'] != 'ok') {
        throw Exception('Force update failed: ${responseData['msg']}');
      }
      print('LOG: Force update successful!');
    } on DioException catch (e) {
        final errStr = e.toString();
        if (errStr.contains('Software caused connection abort') || 
            errStr.contains('Connection closed before full header was received') ||
            errStr.contains('Connection reset by peer')) {
           print('LOG: ESP32 successfully forced and rebooted! Caught expected socket drop.');
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
        data: {
          'modelId': modelId,
          'modelMatch': enabled,
        },
      );
    } catch (e) {
      throw Exception('Failed to update model match: $e');
    }
  }

  /// Sets the PWM output mapping.
  /// Endpoint: POST /config
  ///
  /// [mapping] maps Output Pin Index (0-based) to Input Channel Index.
  /// The payload sent is {'pwm_outputs': [ch_for_pin0, ch_for_pin1, ...]}
  Future<void> setPwmMapping(Map<int, int> mapping) async {
    try {
      // Convert map to list. Identifying max index to determine list size.
      // Assuming contiguous indices starting from 0.
      if (mapping.isEmpty) return;
      
      final maxIndex = mapping.keys.reduce((a, b) => a > b ? a : b);
      final List<int> pwmOutputs = List.filled(maxIndex + 1, 0);
      
      mapping.forEach((pin, channel) {
        if (pin >= 0 && pin < pwmOutputs.length) {
          pwmOutputs[pin] = channel;
        }
      });

      await _dio.post(
        '/config',
        data: {
          'pwm_outputs': pwmOutputs,
        },
      );
    } catch (e) {
      throw Exception('Failed to set PWM mapping: $e');
    }
  }
}
