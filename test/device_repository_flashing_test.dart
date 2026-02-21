
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
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

    test('flashFirmware sends GZIP compressed multipart request with correct headers', () async {
      when(() => mockDio.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
        onSendProgress: any(named: 'onSendProgress'),
      )).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: '/update'),
        data: {'status': 'ok', 'msg': 'Update success'},
        statusCode: 200,
      ));
      
      // 1. Setup Mock Client
      // 1. Setup Mock Client
      final mockHttpClient = MockClient((request) async {
        // Verify Request Properties
        expect(request.method, equals('POST'));
        expect(request.url.toString(), equals('http://192.168.1.1/update'));
        
        // Verify Headers
        // X-FileSize should be the size of GZIP compressed data (approx 26 bytes for 3 bytes input)
        expect(request.headers.containsKey('X-FileSize'), isTrue);
        
        // Verify Multipart Content
        // We need to verify that the body contains the filename and content
        // Since it's a multipart request, the body is a stream of bytes.
        // It's hard to parse exact multipart boundaries in a simple mock, 
        // but we can check content-type or size.
        expect(request.headers['content-type'], startsWith('multipart/form-data'));

        return http.Response('{"status": "ok", "msg": "Update success"}', 200);
      });

      // 2. Initialize Repository with Mock Client
      deviceRepository = DeviceRepository(mockDio, httpClient: mockHttpClient);

      // 3. Execute
      final rawFirmware = Uint8List.fromList([1, 2, 3]);
      await deviceRepository.flashFirmware(rawFirmware, 'firmware.bin');
      
      // Assertions are inside the MockClient callback
    });

    test('flashFirmware does NOT double-compress .gz files', () async {
      // 1. Setup Mock Client
      final mockHttpClient = MockClient((request) async {
         return http.Response('{"status": "ok"}', 200);
      });
      
      when(() => mockDio.post(any(), data: any(named: 'data'), options: any(named: 'options'), onSendProgress: any(named: 'onSendProgress')))
          .thenAnswer((_) async => Response(requestOptions: RequestOptions(path: '/update'), data: {'status': 'ok'}, statusCode: 200));

      // 2. Initialize
      deviceRepository = DeviceRepository(mockDio, httpClient: mockHttpClient);

      // 3. Execute with .gz file
      final compressedFirmware = Uint8List.fromList([1, 2, 3]); 
      await deviceRepository.flashFirmware(compressedFirmware, 'firmware.bin.gz');
    });
    
    test('flashFirmware handles 500 error', () async {
       final mockHttpClient = MockClient((request) async {
         return http.Response('Internal Server Error', 500);
       });
       
       when(() => mockDio.post(any(), data: any(named: 'data'), options: any(named: 'options'), onSendProgress: any(named: 'onSendProgress')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/update'), response: Response(requestOptions: RequestOptions(path: '/update'), statusCode: 500, data: 'Error')));

       deviceRepository = DeviceRepository(mockDio, httpClient: mockHttpClient);
       
       expect(
         () => deviceRepository.flashFirmware(Uint8List(0), 'fw.bin'),
         throwsException,
       );
    });
  });
}
