import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';

void main() {
  group('DeviceRepository', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late DeviceRepository deviceRepository;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'http://10.0.0.1'));
      dioAdapter = DioAdapter(dio: dio);
      deviceRepository = DeviceRepository(dio);
    });

    test('fetchConfig returns configuration map on success', () async {
      final mockData = {
        'product_name': 'Test RX',
        'options': {'uid': [1, 2, 3]},
      };
      
      dioAdapter.onGet(
        '/config',
        (server) => server.reply(200, mockData),
      );

      final result = await deviceRepository.fetchConfig();
      
      expect(result.productName, equals('Test RX'));
      expect(result.options.uid, equals([1, 2, 3]));
    });

    test('fetchHardware returns hardware map on success', () async {
      final mockData = {'mapping': {'serial_rx': 1, 'serial_tx': 3}};

      dioAdapter.onGet(
        '/hardware.json',
        (server) => server.reply(200, mockData),
      );

      final result = await deviceRepository.fetchHardware();

      expect(result, equals(mockData));
    });

    test('flashFirmware throws exception on error', () async {
      final firmwareData = Uint8List.fromList([1, 2, 3]);

      dioAdapter.onPost(
        '/update',
        (server) => server.throws(
          0, 
          DioException(
            requestOptions: RequestOptions(path: '/update'),
            error: 'Timeout',
          ),
        ),
        data: Matchers.any,
      );

      expect(
        () async => await deviceRepository.flashFirmware(firmwareData, 'firmware.bin'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
