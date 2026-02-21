import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:elrs_mobile/src/features/firmware_manager/presentation/firmware_manager_controller.dart';
import 'package:elrs_mobile/src/core/storage/firmware_cache_service.dart';
import 'package:elrs_mobile/src/features/settings/presentation/settings_controller.dart';
import 'package:elrs_mobile/src/features/flashing/data/firmware_repository.dart';
import 'package:elrs_mobile/src/features/flashing/data/releases_repository.dart';

class MockFirmwareCacheService extends Mock implements FirmwareCacheService {}
class MockFirmwareRepository extends Mock implements FirmwareRepository {}
class MockReleasesRepository extends Mock implements ReleasesRepository {}
class MockFile extends Mock implements File {}

// For Notifier mocking
class MockSettingsController extends SettingsController with Mock {
  @override
  SettingsState build() => const SettingsState(maxCachedVersions: 2);
}

void main() {
  late MockFirmwareCacheService mockCacheService;
  late MockFirmwareRepository mockFirmwareRepository;
  late MockReleasesRepository mockReleasesRepository;
  late ProviderContainer container;

  setUp(() {
    mockCacheService = MockFirmwareCacheService();
    mockFirmwareRepository = MockFirmwareRepository();
    mockReleasesRepository = MockReleasesRepository();
    
    // Defaults
    when(() => mockCacheService.getCacheSizeMb()).thenAnswer((_) async => 10.0);
    when(() => mockReleasesRepository.fetchVersions()).thenAnswer((_) async => ['3.3.1', '3.3.0', '3.2.1']);
    
    // New Mocks for downloadVersion
    when(() => mockFirmwareRepository.fetchHashForVersion(any())).thenAnswer((_) async => 'commit_hash_123');
    
    // Suggest generic stub for downloadArtifact
    when(() => mockFirmwareRepository.downloadArtifact(any(), any(), onReceiveProgress: any(named: 'onReceiveProgress')))
        .thenAnswer((_) async => [0, 1, 2, 3]); 

    // Stub for downloadHardwareZip
    when(() => mockFirmwareRepository.downloadHardwareZip(onReceiveProgress: any(named: 'onReceiveProgress')))
        .thenAnswer((_) async => [4, 5, 6]); 

    when(() => mockCacheService.saveZip(any(), any())).thenAnswer((_) async => MockFile());
    when(() => mockCacheService.saveHardwareZip(any(), any())).thenAnswer((_) async => MockFile());
  });

  ProviderContainer makeContainer({required List<String> cachedVersions}) {
    when(() => mockCacheService.getCachedVersions()).thenAnswer((_) async => cachedVersions);

    return ProviderContainer(
      overrides: [
        firmwareCacheServiceProvider.overrideWithValue(mockCacheService),
        firmwareRepositoryProvider.overrideWithValue(mockFirmwareRepository),
        releasesRepositoryProvider.overrideWithValue(mockReleasesRepository),
        settingsControllerProvider.overrideWith(() => MockSettingsController()),
      ],
    );
  }

  test('Download is rejected when cache limit is reached', () async {
    // Setup: Cache is full (2 versions)
    container = makeContainer(cachedVersions: ['3.2.1', '3.3.0']);
    
    // Initialize controller
    final controller = container.read(firmwareManagerControllerProvider.notifier);
    
    // Initialize state
    await controller.load();
    
    // Act: Download a new version
    await controller.downloadVersion('3.3.1');
    
    // Assert
    final state = container.read(firmwareManagerControllerProvider);
    expect(state.errorMessage, contains('Cache limit reached'));
    verifyNever(() => mockCacheService.saveZip(any(), any()));
  });

  test('Download succeeds when under cache limit', () async {
    // Setup: Cache has space (1 version)
    container = makeContainer(cachedVersions: ['3.3.0']);
    
    // Initialize
    final controller = container.read(firmwareManagerControllerProvider.notifier);
    await controller.load();
    
    // Act
    await controller.downloadVersion('3.3.1');
    
    // Assert
    final state = container.read(firmwareManagerControllerProvider);
    expect(state.errorMessage, isNull);
    verify(() => mockCacheService.saveZip('3.3.1', any())).called(1);
    verify(() => mockCacheService.saveHardwareZip('3.3.1', any())).called(1);
  });
}
