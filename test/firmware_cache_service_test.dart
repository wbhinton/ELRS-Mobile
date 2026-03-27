import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;
import 'package:elrs_mobile/src/core/storage/firmware_cache_service.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {}

void main() {
  late FirmwareCacheService service;
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('elrs_cache_test');
    final mockPathProvider = MockPathProviderPlatform();
    PathProviderPlatform.instance = mockPathProvider;

    when(
      () => mockPathProvider.getApplicationDocumentsPath(),
    ).thenAnswer((_) async => tempDir.path);

    service = FirmwareCacheService();
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test(
    'evictOldestVersions should remove oldest version based on modification time',
    () async {
      final cacheDir = Directory(p.join(tempDir.path, 'firmware_cache'));
      await cacheDir.create(recursive: true);

      // Helper to create both zips for a version with a specific modification time
      Future<void> createVersion(String version, DateTime modified) async {
        final f1 = File(p.join(cacheDir.path, 'expresslrs_v$version.zip'));
        await f1.writeAsString('fw');
        await f1.setLastModified(modified);
        
        final f2 = File(p.join(cacheDir.path, 'expresslrs_hardware_v$version.zip'));
        await f2.writeAsString('hw');
        await f2.setLastModified(modified);
      }

      final now = DateTime.now();
      // v1 is oldest, v3 is newest
      await createVersion('1.0.0', now.subtract(const Duration(hours: 3)));
      await createVersion('2.0.0', now.subtract(const Duration(hours: 2)));
      await createVersion('3.0.0', now.subtract(const Duration(hours: 1)));

      // Verify all exist
      final versionsBefore = await service.getCachedVersions();
      expect(versionsBefore, containsAll(['1.0.0', '2.0.0', '3.0.0']));

      // Perform eviction with limit 2
      await service.evictOldestVersions(2);

      // Verify v1.0.0 is gone (it's the oldest)
      final remaining = await service.getCachedVersions();
      expect(remaining.length, 2);
      expect(remaining, isNot(contains('1.0.0')));
      expect(remaining, containsAll(['2.0.0', '3.0.0']));
    },
  );

  test('clearCache should remove everything', () async {
    final cacheDir = Directory(p.join(tempDir.path, 'firmware_cache'));
    await cacheDir.create(recursive: true);
    await File(p.join(cacheDir.path, 'expresslrs_v1.0.0.zip')).writeAsString('fw');
    await File(p.join(cacheDir.path, 'expresslrs_hardware_v1.0.0.zip')).writeAsString('hw');

    expect((await service.getCachedVersions()).length, 1);

    await service.clearCache();

    expect((await service.getCachedVersions()).length, 0);
  });

  test('getCachedVersions should ignore versions with missing hardware zip', () async {
    final cacheDir = Directory(p.join(tempDir.path, 'firmware_cache'));
    await cacheDir.create(recursive: true);
    
    // Complete version
    await File(p.join(cacheDir.path, 'expresslrs_v3.3.0.zip')).writeAsString('fw');
    await File(p.join(cacheDir.path, 'expresslrs_hardware_v3.3.0.zip')).writeAsString('hw');
    
    // Incomplete version (missing hardware)
    await File(p.join(cacheDir.path, 'expresslrs_v3.2.1.zip')).writeAsString('fw');

    final versions = await service.getCachedVersions();
    expect(versions, equals(['3.3.0']));
  });
}
