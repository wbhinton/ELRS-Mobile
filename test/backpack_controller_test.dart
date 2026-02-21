import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/backpack/data/backpack_repository.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:elrs_mobile/src/features/backpack/presentation/backpack_controller.dart';

class MockBackpackRepository extends Mock implements BackpackRepository {}
class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late MockBackpackRepository mockBackpackRepo;
  late MockDeviceRepository mockDeviceRepo;

  setUp(() {
    mockBackpackRepo = MockBackpackRepository();
    mockDeviceRepo = MockDeviceRepository();
  });

  test('Backpack Flash Pipeline succeeds', () async {
    // Stub
    const targetName = 'HDZero VRX4';
    final dummyBytes = Uint8List.fromList([1, 2, 3]);

    when(() => mockBackpackRepo.downloadBackpackFirmware(targetName))
        .thenAnswer((_) async => dummyBytes);
    
    when(() => mockDeviceRepo.flashFirmware(dummyBytes, any(), onSendProgress: any(named: 'onSendProgress')))
        .thenAnswer((_) async {});

    final container = ProviderContainer(
      overrides: [
        backpackRepositoryProvider.overrideWithValue(mockBackpackRepo),
        deviceRepositoryProvider.overrideWithValue(mockDeviceRepo),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(backpackControllerProvider.notifier);

    // Act 1: Select Target
    controller.selectTarget(targetName);
    
    // Check selection state
    expect(container.read(backpackControllerProvider).selectedTarget, targetName);

    // Act 2: Flash
    final future = controller.flash();
    
    // Verify intermediate status (downloading/flashing) - tricky in async test, 
    // but we can check if the methods were called.
    await future;

    // Assert
    verify(() => mockBackpackRepo.downloadBackpackFirmware(targetName)).called(1);
    verify(() => mockDeviceRepo.flashFirmware(
      dummyBytes, 
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
    )).called(1);
    
    final state = container.read(backpackControllerProvider);
    expect(state.status, BackpackStatus.success);
    expect(state.progress, 1.0);
    expect(state.errorMessage, null);
  });
}
