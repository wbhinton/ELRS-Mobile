import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';

import 'package:elrs_mobile/src/features/flashing/data/firmware_repository.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:elrs_mobile/src/features/flashing/application/firmware_patcher.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_controller.dart';
import 'package:elrs_mobile/src/features/flashing/domain/target_definition.dart';
import 'package:elrs_mobile/src/features/flashing/domain/patch_configuration.dart';
import 'package:elrs_mobile/src/core/storage/secure_storage_service.dart';
import 'package:elrs_mobile/src/core/storage/firmware_cache_service.dart';

// 1. Define Mocks
class MockFirmwareRepository extends Mock implements FirmwareRepository {}
class MockDeviceRepository extends Mock implements DeviceRepository {}
class MockFirmwarePatcher extends Mock implements FirmwarePatcher {}
class MockSecureStorageService extends Mock implements SecureStorageService {}
class MockFirmwareCacheService extends Mock implements FirmwareCacheService {}

void main() {
  late MockFirmwareRepository mockFirmwareRepo;
  late MockDeviceRepository mockDeviceRepo;
  late MockFirmwarePatcher mockPatcher;
  late MockSecureStorageService mockStorage;
  late MockFirmwareCacheService mockCache;

  setUp(() {
    mockFirmwareRepo = MockFirmwareRepository();
    mockDeviceRepo = MockDeviceRepository();
    mockPatcher = MockFirmwarePatcher();
    mockStorage = MockSecureStorageService();
    mockCache = MockFirmwareCacheService();
    
    when(() => mockCache.getZipFile(any())).thenAnswer((_) async => null);
    
    // Default stubs for storage to avoid errors during controller init/save
    when(() => mockStorage.loadOptions()).thenAnswer((_) async => {});
    when(() => mockStorage.saveOptions(
      bindPhrase: any(named: 'bindPhrase'),
      wifiSsid: any(named: 'wifiSsid'),
      wifiPassword: any(named: 'wifiPassword'),
      regulatoryDomain: any(named: 'regulatoryDomain'),
    )).thenAnswer((_) async => {}); // Future<void>

    // Register fallback values if needed for 'any()'
    registerFallbackValue(PatchConfiguration(bindPhrase: '', wifiSsid: '', wifiPassword: '', regulatoryDomain: 0));
    registerFallbackValue(Uint8List(0));
  });

  test('Flash Action completes successfully', () async {
    // 2. Success Scenario
    
    // Stubbing
    when(() => mockFirmwareRepo.downloadFirmware(
      any(), 
      any(), 
      regulatoryDomain: any(named: 'regulatoryDomain'), 
      onReceiveProgress: any(named: 'onReceiveProgress')
    )).thenAnswer((_) async => FirmwareData(bytes: Uint8List.fromList([1, 2, 3]), filename: 'firmware.bin'));
    
    when(() => mockPatcher.patchFirmware(any(), any()))
        .thenAnswer((_) async => Uint8List.fromList([4, 5, 6])); 
    when(() => mockDeviceRepo.flashFirmware(
      any(), 
      any(),
      onSendProgress: any(named: 'onSendProgress'),
      productName: any(named: 'productName'),
      luaName: any(named: 'luaName'),
      uid: any(named: 'uid'),
      hardwareLayout: any(named: 'hardwareLayout'),
      wifiSsid: any(named: 'wifiSsid'),
      wifiPassword: any(named: 'wifiPassword'),
      platform: any(named: 'platform'),
      force: any(named: 'force'),
    )).thenAnswer((_) async => {});

    // Provider Override
    final container = ProviderContainer(
      overrides: [
        firmwareRepositoryProvider.overrideWith((ref) => mockFirmwareRepo),
        deviceRepositoryProvider.overrideWith((ref) => mockDeviceRepo),
        firmwarePatcherProvider.overrideWith((ref) => mockPatcher),
        secureStorageServiceProvider.overrideWith((ref) => mockStorage),
        firmwareCacheServiceProvider.overrideWith((ref) => mockCache),
      ],
    );
    addTearDown(container.dispose);

    // Act: Initialize Controller
    final controller = container.read(flashingControllerProvider.notifier);
    
    // Set preconditions (Target + Bind Phrase)
    controller.selectTarget(const TargetDefinition(
      vendor: 'BetaFPV', 
      name: 'Nano RX', 
      firmware: 'betafpv_nano_rx.bin',
      productCode: 'betafpv_nano_rx', // Add productCode
    ));
    controller.selectVersion('3.3.0');
    controller.setBindPhrase('my_secret_phrase');
    
    // Trigger Flash
    await controller.flash();

    // Assert
    verify(() => mockFirmwareRepo.downloadFirmware(
      any(), // 'betafpv_nano_rx.bin', 
      any(), // '3.3.0',
      regulatoryDomain: any(named: 'regulatoryDomain'),
      onReceiveProgress: any(named: 'onReceiveProgress')
    )).called(1);
    verify(() => mockPatcher.patchFirmware(
      any(that: isA<Uint8List>()), 
      any(that: isA<PatchConfiguration>()) 
    )).called(1);
    verify(() => mockDeviceRepo.flashFirmware(
      any(), 
      'firmware.bin',
      onSendProgress: any(named: 'onSendProgress'),
      productName: any(named: 'productName'),
      luaName: any(named: 'luaName'),
      uid: any(named: 'uid'),
      hardwareLayout: any(named: 'hardwareLayout'),
      wifiSsid: any(named: 'wifiSsid'),
      wifiPassword: any(named: 'wifiPassword'),
      platform: any(named: 'platform'),
      force: any(named: 'force'),
    )).called(1);

    final state = container.read(flashingControllerProvider);
    expect(state.status, equals(FlashingStatus.success));
    expect(state.progress, equals(1.0));
  });

  test('Flash Action handles download error', () async {
    // 3. Error Scenario
    
    // Stubbing
    when(() => mockFirmwareRepo.downloadFirmware(
      any(), 
      any(),
      regulatoryDomain: any(named: 'regulatoryDomain'),
      onReceiveProgress: any(named: 'onReceiveProgress')
    )).thenThrow(Exception('Network Error'));

    // Provider Override
    final container = ProviderContainer(
      overrides: [
        firmwareRepositoryProvider.overrideWith((ref) => mockFirmwareRepo),
        deviceRepositoryProvider.overrideWith((ref) => mockDeviceRepo),
        firmwarePatcherProvider.overrideWith((ref) => mockPatcher),
        secureStorageServiceProvider.overrideWith((ref) => mockStorage),
        firmwareCacheServiceProvider.overrideWith((ref) => mockCache),
      ],
    );
    addTearDown(container.dispose);

    // Act
    final controller = container.read(flashingControllerProvider.notifier);
    controller.selectTarget(const TargetDefinition(vendor: 'V', name: 'N', firmware: 'f.bin', productCode: 'f'));
    controller.selectVersion('3.3.0');
    controller.setBindPhrase('phrase');

    await controller.flash();

    // Assert
    verify(() => mockFirmwareRepo.downloadFirmware(
      any(), 
      any(),
      regulatoryDomain: any(named: 'regulatoryDomain'),
      onReceiveProgress: any(named: 'onReceiveProgress')
    )).called(1);
    verifyNever(() => mockPatcher.patchFirmware(any(), any()));
    verifyNever(() => mockDeviceRepo.flashFirmware(any(), any()));

    final state = container.read(flashingControllerProvider);
    expect(state.status, equals(FlashingStatus.error));
    expect(state.errorMessage, contains('Network Error'));
  });
}
