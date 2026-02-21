import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';
import 'package:elrs_mobile/src/features/flashing/data/releases_repository.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ReleasesRepository repository;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    repository = ReleasesRepository(dio);
  });

  test('Repository fetches and filters versions correctly', () async {
    const route = 'https://artifactory.expresslrs.org/ExpressLRS/index.json';
    
    final mockData = {
      'tags': {
        'v3.3.0': 'hash1',
        '3.0.0': 'hash2',
        'v2.5.1': 'hash3',
        'v1.0.0': 'hash4',
      }
    };

    dioAdapter.onGet(
      route,
      (server) => server.reply(200, mockData),
    );

    final versions = await repository.fetchVersions();

    // Should contain v3.3.0 and 3.0.0
    expect(versions, hasLength(2));
    expect(versions[0], equals('v3.3.0'));
    expect(versions[1], equals('3.0.0'));
  });

  test('Repository handles API error', () async {
     const route = 'https://artifactory.expresslrs.org/ExpressLRS/index.json';
     
     dioAdapter.onGet(
      route,
      (server) => server.reply(500, {'message': 'Server Error'}),
    );
    
    expect(() => repository.fetchVersions(), throwsException);
  });
}
