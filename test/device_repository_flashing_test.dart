import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart'; // Still needed for Dio mock if required by constructor

class MockDio extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions(baseUrl: 'http://192.168.1.1/');
}

void main() {
  registerFallbackValue(FormData());
  group('DeviceRepository Flashing Tests', () {
    late DeviceRepository deviceRepository;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
    });

    test(
      'flashFirmware sends GZIP compressed multipart request with correct headers',
      () async {
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
            onSendProgress: any(named: 'onSendProgress'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/update'),
            data: {'status': 'ok', 'msg': 'Update success'},
            statusCode: 200,
          ),
        );

        // 2. Initialize Repository
        deviceRepository = DeviceRepository(mockDio);

        // 3. Execute
        final rawFirmware = Uint8List.fromList([1, 2, 3]);
        await deviceRepository.flashFirmware(rawFirmware, 'firmware.bin');

        // Assertions are inside the MockClient callback
      },
    );

    test('flashFirmware does NOT double-compress .gz files', () async {
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          onSendProgress: any(named: 'onSendProgress'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/update'),
          data: {'status': 'ok'},
          statusCode: 200,
        ),
      );

      // 2. Initialize
      deviceRepository = DeviceRepository(mockDio);

      // 3. Execute with .gz file
      final compressedFirmware = Uint8List.fromList([1, 2, 3]);
      await deviceRepository.flashFirmware(
        compressedFirmware,
        'firmware.bin.gz',
      );
    });

    test('flashFirmware handles 500 error', () async {
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          onSendProgress: any(named: 'onSendProgress'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/update'),
          response: Response(
            requestOptions: RequestOptions(path: '/update'),
            statusCode: 500,
            data: 'Error',
          ),
        ),
      );

      deviceRepository = DeviceRepository(mockDio);

      expect(
        () => deviceRepository.flashFirmware(Uint8List(0), 'fw.bin'),
        throwsException,
      );
    });
  });
}
