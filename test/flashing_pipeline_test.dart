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
import 'package:elrs_mobile/src/core/storage/persistence_service.dart';
import 'package:elrs_mobile/src/core/storage/firmware_cache_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elrs_mobile/src/core/networking/connectivity_service.dart';
import 'package:flutter/services.dart';

// 1. Define Mocks
class MockFirmwareRepository extends Mock implements FirmwareRepository {}

class MockDeviceRepository extends Mock implements DeviceRepository {}

class MockFirmwarePatcher extends Mock implements FirmwarePatcher {}

class MockPersistenceService extends Mock implements PersistenceService {}

class MockFirmwareCacheService extends Mock implements FirmwareCacheService {}

// ConnectivityService extends a Riverpod-generated base class that has an
// internal `_element` getter. mocktail's `implements` pattern doesn't inherit
// that getter, causing Riverpod to crash when wiring the notifier. Using a
// concrete subclass correctly inherits all generated machinery.
class FakeConnectivityService extends ConnectivityService {
  @override
  Stream<List<ConnectivityResult>> build() => const Stream.empty();

  @override
  Future<void> bindToWiFi() async {}

  @override
  Future<void> unbind() async {}

  @override
  Future<void> autoBindIfWiFi() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFirmwareRepository mockFirmwareRepo;
  late MockDeviceRepository mockDeviceRepo;
  late MockFirmwarePatcher mockPatcher;
  late MockPersistenceService mockStorage;
  late MockFirmwareCacheService mockCache;

  setUpAll(() {
    // Register fallback values once for the whole test suite.
    // Putting these in setUp causes mocktail matcher state to accumulate
    // across tests, which can cause the second test to fail.
    registerFallbackValue(
      PatchConfiguration(
        bindPhrase: '',
        wifiSsid: '',
        wifiPassword: '',
        regulatoryDomain: 0,
      ),
    );
    registerFallbackValue(Uint8List(0));

    // Mock wakelock_plus Platform Channel so Tests don't throw MissingPluginException
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler(
          'dev.flutter.pigeon.wakelock_plus_platform_interface.WakelockPlusApi.toggle',
          (ByteData? message) async {
            // Encode a success response matching Pigeon's expected format (a list with a single null value)
            return const StandardMessageCodec().encodeMessage([null]);
          },
        );
  });

  setUp(() {
    mockFirmwareRepo = MockFirmwareRepository();
    mockDeviceRepo = MockDeviceRepository();
    mockPatcher = MockFirmwarePatcher();
    mockStorage = MockPersistenceService();
    mockCache = MockFirmwareCacheService();

    when(() => mockCache.getZipFile(any())).thenAnswer((_) async => null);

    // Default stubs for storage to avoid errors during controller init/save
    when(() => mockStorage.migrateIfNeeded()).thenAnswer((_) async {});
    when(() => mockStorage.getBindPhrase()).thenAnswer((_) async => '');
    when(() => mockStorage.getWifiSsid()).thenAnswer((_) async => '');
    when(() => mockStorage.getWifiPassword()).thenAnswer((_) async => '');

    when(() => mockStorage.setBindPhrase(any())).thenAnswer((_) async {});
    when(() => mockStorage.setWifiSsid(any())).thenAnswer((_) async {});
    when(() => mockStorage.setWifiPassword(any())).thenAnswer((_) async {});
  });

  test('Flash Action completes successfully', () async {
    // 2. Success Scenario

    // Stubbing
    when(
      () => mockFirmwareRepo.downloadFirmware(
        any(),
        any(),
        isLbt: any(named: 'isLbt'),
        onReceiveProgress: any(named: 'onReceiveProgress'),
      ),
    ).thenAnswer(
      (_) async => FirmwareData(
        bytes: Uint8List.fromList([1, 2, 3]),
        filename: 'firmware.bin',
      ),
    );

    when(
      () => mockCache.getHardwareZipFile(any()),
    ).thenAnswer((_) async => null);

    // Stub buildFirmwarePayload to return a mock payload
    when(
      () => mockDeviceRepo.buildFirmwarePayload(
        any(),
        any(),
        productName: any(named: 'productName'),
        luaName: any(named: 'luaName'),
        uid: any(named: 'uid'),
        hardwareLayout: any(named: 'hardwareLayout'),
        wifiSsid: any(named: 'wifiSsid'),
        wifiPassword: any(named: 'wifiPassword'),
        platform: any(named: 'platform'),
        domain: any(named: 'domain'),
        isTx: any(named: 'isTx'),
      ),
    ).thenAnswer(
      (_) async =>
          (bytes: Uint8List.fromList([4, 5, 6]), filename: 'firmware.bin'),
    );

    when(
      () => mockPatcher.patchFirmware(any(), any()),
    ).thenAnswer((_) async => Uint8List.fromList([4, 5, 6]));

    when(
      () => mockDeviceRepo.flashFirmware(
        any(),
        any(),
        force: any(named: 'force'),
        isTx: any(named: 'isTx'),
      ),
    ).thenAnswer((_) async {});

    // Provider Override
    final container = ProviderContainer(
      overrides: [
        firmwareRepositoryProvider.overrideWith((ref) => mockFirmwareRepo),
        deviceRepositoryProvider.overrideWith((ref) => mockDeviceRepo),
        firmwarePatcherProvider.overrideWith((ref) => mockPatcher),
        persistenceServiceProvider.overrideWith(
          (ref) => Future.value(mockStorage),
        ),
        firmwareCacheServiceProvider.overrideWith((ref) => mockCache),
        connectivityServiceProvider.overrideWith(FakeConnectivityService.new),
      ],
    );
    addTearDown(container.dispose);

    // Act: Initialize Controller
    final subscription = container.listen(
      flashingControllerProvider,
      (_, _) {},
    );
    final controller = container.read(flashingControllerProvider.notifier);

    // Set preconditions (Target + Bind Phrase)
    controller.selectTarget(
      const TargetDefinition(
        vendor: 'BetaFPV',
        name: 'Nano RX',
        firmware: 'betafpv_nano_rx.bin',
        productCode: 'betafpv_nano_rx', // Add productCode
      ),
    );
    controller.selectVersion('3.3.0');
    await controller.setBindPhrase('my_secret_phrase');

    // Trigger Flash
    await controller.flash();

    // Assert
    verify(
      () => mockFirmwareRepo.downloadFirmware(
        any(), // 'betafpv_nano_rx.bin',
        any(), // '3.3.0',
        isLbt: any(named: 'isLbt'),
        onReceiveProgress: any(named: 'onReceiveProgress'),
      ),
    ).called(1);
    verify(
      () => mockPatcher.patchFirmware(
        any(that: isA<Uint8List>()),
        any(that: isA<PatchConfiguration>()),
      ),
    ).called(1);
    verify(
      () => mockDeviceRepo.flashFirmware(
        any(),
        'firmware.bin',
        force: any(named: 'force'),
        isTx: any(named: 'isTx'),
      ),
    ).called(1);

    final state = container.read(flashingControllerProvider);
    expect(state.status, equals(FlashingStatus.success));
    expect(state.progress, equals(1.0));
  });

  test('Flash Action handles download error', () async {
    // 3. Error Scenario

    // Stubbing
    when(
      () => mockFirmwareRepo.downloadFirmware(
        any(),
        any(),
        isLbt: any(named: 'isLbt'),
        onReceiveProgress: any(named: 'onReceiveProgress'),
      ),
    ).thenThrow(Exception('Network Error'));

    // Provider Override
    final container = ProviderContainer(
      overrides: [
        firmwareRepositoryProvider.overrideWith((ref) => mockFirmwareRepo),
        deviceRepositoryProvider.overrideWith((ref) => mockDeviceRepo),
        firmwarePatcherProvider.overrideWith((ref) => mockPatcher),
        persistenceServiceProvider.overrideWith(
          (ref) => Future.value(mockStorage),
        ),
        firmwareCacheServiceProvider.overrideWith((ref) => mockCache),
        connectivityServiceProvider.overrideWith(FakeConnectivityService.new),
      ],
    );
    addTearDown(container.dispose);

    // Act
    await pumpEventQueue();
    final controller = container.read(flashingControllerProvider.notifier);
    controller.selectTarget(
      const TargetDefinition(
        vendor: 'V',
        name: 'N',
        firmware: 'f.bin',
        productCode: 'f',
      ),
    );
    controller.selectVersion('3.3.0');
    await controller.setBindPhrase('phrase');

    await controller.flash();

    // Assert
    verify(
      () => mockFirmwareRepo.downloadFirmware(
        any(),
        any(),
        isLbt: any(named: 'isLbt'),
        onReceiveProgress: any(named: 'onReceiveProgress'),
      ),
    ).called(1);
    verifyNever(() => mockPatcher.patchFirmware(any(), any()));
    verifyNever(() => mockDeviceRepo.flashFirmware(any(), any()));

    final state = container.read(flashingControllerProvider);
    expect(state.status, equals(FlashingStatus.error));
    expect(state.errorMessage, contains('Network Error'));
  });
}
