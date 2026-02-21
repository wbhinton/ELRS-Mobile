
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_repository.dart';
import 'package:elrs_mobile/src/core/storage/firmware_cache_service.dart';
import 'package:elrs_mobile/src/features/flashing/domain/target_definition.dart';

class MockDio extends Mock implements Dio {}
class MockFirmwareCacheService extends Mock implements FirmwareCacheService {}
class MockResponse extends Mock implements Response {}

void main() {
  late MockDio mockDio;
  late MockFirmwareCacheService mockCache;
  late TargetsRepository repository;

  setUp(() {
    mockDio = MockDio();
    mockCache = MockFirmwareCacheService();
    repository = TargetsRepository(mockDio, mockCache);
    
    registerFallbackValue(Options());
  });

  final sampleJson = '''
  {
    "Vendor A": {
      "name": "Vendor A",
      "devices": {
        "device1": {
          "product_name": "Device 1",
          "product_code": "dev1"
        }
      }
    }
  }
  ''';

  test('fetchTargets returns data from network and caches it', () async {
    // Arrange
    final response = MockResponse();
    when(() => response.data).thenReturn(sampleJson);
    when(() => mockDio.get(any(), options: any(named: 'options')))
        .thenAnswer((_) async => response);
    when(() => mockCache.saveTargetJson(any(), any())).thenAnswer((_) async {});

    // Act
    final result = await repository.fetchTargets();

    // Assert
    expect(result, isNotEmpty);
    expect(result.first.vendor, 'Vendor A');
    verify(() => mockCache.saveTargetJson('master', sampleJson)).called(1);
  });

  test('fetchTargets returns data from cache when network fails', () async {
    // Arrange
    when(() => mockDio.get(any(), options: any(named: 'options')))
        .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
    when(() => mockCache.getCachedTargetJson(any()))
        .thenAnswer((_) async => sampleJson);

    // Act
    final result = await repository.fetchTargets();

    // Assert
    expect(result, isNotEmpty);
    expect(result.first.vendor, 'Vendor A');
    verify(() => mockCache.getCachedTargetJson('master')).called(1);
  });

  test('fetchTargets throws when network fails and cache is empty', () async {
    // Arrange
    when(() => mockDio.get(any(), options: any(named: 'options')))
        .thenThrow(Exception('Network error'));
    when(() => mockCache.getCachedTargetJson(any()))
        .thenAnswer((_) async => null);

    // Act & Assert
    expect(() => repository.fetchTargets(), throwsException);
  });
}
