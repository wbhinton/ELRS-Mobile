import 'package:dio/dio.dart';
import 'package:elrs_manager/src/features/config/domain/runtime_config_model.dart';
import 'package:elrs_manager/src/features/config/services/device_config_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('DeviceConfigService', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late DeviceConfigService service;
    const String ip = '192.168.1.1';

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      service = DeviceConfigService(dio);
    });

    test('fetchConfig returns RuntimeConfig on success', () async {
      final mockResponse = {
        'settings': {'field1': 'val1'},
        'options': {'wifi-ssid': 'mikes-wifi'},
        'config': {'hardware': 'lite'},
      };

      dioAdapter.onGet(
        'http://$ip/config',
        (server) => server.reply(200, mockResponse),
      );

      final result = await service.fetchConfig(ip);

      expect(result.settings['field1'], equals('val1'));
      expect(result.options['wifi-ssid'], equals('mikes-wifi'));
      expect(result.config['hardware'], equals('lite'));
    });

    test('saveOptions sends correct payload and headers', () async {
      final options = {'wifi-ssid': 'new-wifi'};
      
      dioAdapter.onPost(
        'http://$ip/options.json',
        (server) => server.reply(200, {}),
        data: {
          'wifi-ssid': 'new-wifi',
          'customised': true,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );

      await service.saveOptions(ip, options);
      // No exception means success
    });

    test('reboot sends POST request to /reboot', () async {
      dioAdapter.onPost(
        'http://$ip/reboot',
        (server) => server.reply(200, {}),
      );

      await service.reboot(ip);
      // No exception means success
    });

    test('fetchConfig throws exception on error', () async {
      dioAdapter.onGet(
        'http://$ip/config',
        (server) => server.reply(404, 'Not Found'),
      );

      expect(
        () async => await service.fetchConfig(ip),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('RuntimeConfig model', () {
    test('fromJson and toJson work correctly', () {
      final json = {
        'settings': {'s': 1},
        'options': {'o': 2},
        'config': {'c': 3},
      };

      final config = RuntimeConfig.fromJson(json);
      expect(config.settings['s'], 1);
      expect(config.toJson(), json);
    });
  });
}
