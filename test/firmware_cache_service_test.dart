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
    'evictOldestVersions should remove oldest version when limit exceeded',
    () async {
      // 1. Create dummy files with different modification dates
      final v1Dir = Directory(p.join(tempDir.path, 'firmware_cache'));
      await v1Dir.create(recursive: true);

      final f1 = File(p.join(v1Dir.path, 'expresslrs_v1.0.0.zip'));
      await f1.writeAsString('v1');
      // Manual modification time setting is tricky in Dart, but we can rely on sequential creation
      await Future.delayed(const Duration(milliseconds: 100));

      final f2 = File(p.join(v1Dir.path, 'expresslrs_v2.0.0.zip'));
      await f2.writeAsString('v2');
      await Future.delayed(const Duration(milliseconds: 100));

      final f3 = File(p.join(v1Dir.path, 'expresslrs_v3.0.0.zip'));
      await f3.writeAsString('v3');

      // Verify all exist
      expect(
        await service.getCachedVersions(),
        containsAll(['1.0.0', '2.0.0', '3.0.0']),
      );

      // 2. Perform eviction with limit 2
      await service.evictOldestVersions(2);

      // 3. Verify v1.0.0 is gone (it's the oldest)
      final remaining = await service.getCachedVersions();
      expect(remaining.length, 2);
      expect(remaining, isNot(contains('1.0.0')));
      expect(remaining, containsAll(['2.0.0', '3.0.0']));
    },
  );

  test('clearCache should remove everything', () async {
    final v1Dir = Directory(p.join(tempDir.path, 'firmware_cache'));
    await v1Dir.create(recursive: true);
    await File(
      p.join(v1Dir.path, 'expresslrs_v1.0.0.zip'),
    ).writeAsString('test');

    expect((await service.getCachedVersions()).length, 1);

    await service.clearCache();

    expect((await service.getCachedVersions()).length, 0);
  });
}
