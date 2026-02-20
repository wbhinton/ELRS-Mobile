import 'package:dio/dio.dart';
import '../domain/runtime_config_model.dart';

class DeviceConfigService {
  final Dio _dio;

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
  /// Performs a GET request to http://<ip>/config.
  Future<RuntimeConfig> fetchConfig(String ip) async {
    try {
      final response = await _dio.get('http://$ip/config');
      if (response.statusCode == 200) {
        final data = response.data;
        print('Raw Device Config JSON: $data');
        
        if (data is Map<String, dynamic>) {
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
  /// Performs a POST request to http://<ip>/options.json.
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

  /// Reboots the device.
  /// Performs a POST request to http://<ip>/reboot.
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
}
