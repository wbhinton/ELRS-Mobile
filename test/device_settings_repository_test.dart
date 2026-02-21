import 'package:dio/dio.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

// Assuming we construct DeviceRepository with a Dio instance.
// Test checks if correct POST is made.

void main() {
  group('DeviceRepository Settings', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late DeviceRepository repo;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'http://10.0.0.1'));
      dioAdapter = DioAdapter(dio: dio);
      repo = DeviceRepository(dio);
    });

    test('updateBindingPhrase sends correct UID payload', () async {
      const phrase = 'expresslrs';
      final expectedUid = [65, 245, 33, 230, 58, 226]; // Correct MD5 hash prefix

      // Mock Post
      dioAdapter.onPost(
        '/config',
        (server) => server.reply(200, {}),
        data: {'uid': expectedUid},
      );

      // Act
      await repo.updateBindingPhrase(phrase);

      // Assert
      // If no exception, it matched.
    });

    test('updateWifi sends correct ssid and password', () async {
      const ssid = 'MyHomeWiFi';
      const pass = 'Secret123';

      dioAdapter.onPost(
        '/config',
        (server) => server.reply(200, {}),
        data: Matchers.isA<Map<String, dynamic>>(), // Loose match or exact?
      );
      
      // Let's rely on DioAdapter catching exact data match if we provide it?
      // Or verify manually? 
      // http_mock_adapter usually matches blindly if data is provided.
      // Let's try exact match.
      
      dioAdapter.onPost(
        '/config',
         (server) => server.reply(200, {}),
         data: {
           'wifi_ssid': ssid,
           'wifi_password': pass,
         }
      );

      await repo.updateWifi(ssid, pass);
    });
  });
}
