import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/device_dio.dart';
import '../../configurator/domain/device_config_model.dart';
import '../utils/firmware_assembler.dart';

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
        
        // Conditional compression based on platform
        if (platform == 'esp8285') {
          print('Compressing unified firmware for ESP8285...');
          final compressed = GZipEncoder().encode(dataToUpload);
          if (compressed == null) {
            throw Exception('Failed to compress unified firmware payload.');
          }
          dataToUpload = Uint8List.fromList(compressed);
          filenameToUpload += '.gz';
          print('Compressed Unified Size: ${dataToUpload.length} bytes');
        } else if (platform.startsWith('esp32')) {
          print('Skipping compression for ESP32 platform: $platform');
          // No compression for ESP32
        } else {
          // Default to GZip for other ESP platforms? 
          // The request said: If platform.startsWith('esp32'), do not compress.
          // Otherwise preserve working logic (which was GZip).
          print('Defaulting to GZip compression for platform: $platform');
          final compressed = GZipEncoder().encode(dataToUpload);
          if (compressed != null) {
            dataToUpload = Uint8List.fromList(compressed);
            filenameToUpload += '.gz';
          }
        }

      } else {
        // Standard / Legacy Flow (used when not building Unified, or platform missing)
        // Note: For legacy flow, we still might want to honor the platform-specific compression
        // if platform is provided.
        
        if (platform != null && platform.startsWith('esp32')) {
          print('Legacy Flow: Skipping compression for ESP32 ($platform)');
          dataToUpload = firmwareData;
          filenameToUpload = filename.endsWith('.gz') ? filename.substring(0, filename.length - 3) : filename;
        } else {
          // Check if already compressed to avoid double compression
          if (filename.endsWith('.gz')) {
            print('Firmware already compressed: $filename');
            dataToUpload = firmwareData;
            filenameToUpload = filename;
          } else {
            print('Compressing firmware: $filename');
            final compressed = GZipEncoder().encode(firmwareData);
            if (compressed == null) {
              throw Exception('Failed to compress firmware payload.');
            }
            dataToUpload = Uint8List.fromList(compressed);
            filenameToUpload = '$filename.gz';
            print('Original Size: ${firmwareData.length} bytes');
            print('Compressed Size: ${dataToUpload.length} bytes');
          }
        }
      }

      // Construct URI from Dio's base URL
      final baseUrl = _dio.options.baseUrl;
      final uri = Uri.parse(baseUrl.endsWith('/') ? '${baseUrl}update' : '$baseUrl/update');
      
      final request = http.MultipartRequest('POST', uri);

      // Set headers
      request.headers['X-FileSize'] = dataToUpload.length.toString();
      
      // Attach file
      final multipartFile = http.MultipartFile.fromBytes(
        'upload',
        dataToUpload,
        filename: filenameToUpload,
        contentType: MediaType('application', 'octet-stream'),
      );
      
      request.files.add(multipartFile);

      final targetIpValue = uri.host;
      print('LOG: Attempting OTA Update at URL: http://$targetIpValue/update');
      
      final streamedResponse = await (_httpClient?.send(request) ?? request.send()).timeout(const Duration(seconds: 120));
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        print('LOG: OTA Update Failed! Status: ${response.statusCode}');
        print('LOG: Device Error Response: ${response.body}');
        throw Exception('Flashing failed with status: ${response.statusCode}. Body: ${response.body}');
      }
      
      print('Flash successful! Device response: ${response.body}');
      
      // Verify ELRS specific JSON response if possible (parse body)
      // The response body is usually JSON string.
      if (response.body.contains('"status": "ok"') || response.body.contains('"status":"ok"')) {
         // Success
      } else if (response.body.contains('"msg"')) {
         // Try to extract msg? Or just throw if status not ok?
         // Assuming 200 OK means generic success for now, as parsing string manually is brittle.
      }
      
    } catch (e) {
      throw Exception('Failed to flash firmware: $e');
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
