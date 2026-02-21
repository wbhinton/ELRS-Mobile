import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elrs_mobile/src/features/config/domain/runtime_config_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:elrs_mobile/src/features/pwm_config/presentation/pwm_controller.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late MockDeviceRepository mockRepo;

  setUp(() {
    mockRepo = MockDeviceRepository();
  });

  test('PwmController parses output array', () async {
    // Stub
    when(() => mockRepo.fetchConfig()).thenAnswer((_) async => const RuntimeConfig(
      productName: 'Test',
      version: '1.0',
      config: ElrsConfig(pwm: [0, 1, 2, 3]),
    ));

    final container = ProviderContainer(
      overrides: [
        deviceRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(pwmControllerProvider.notifier);

    // Act
    await controller.loadConfig();

    // Assert
    final state = container.read(pwmControllerProvider);
    expect(state.outputs.length, 4);
    expect(state.outputs, [0, 1, 2, 3]);
    expect(state.status, PwmStatus.idle);
  });

  test('PwmController updates specific pin and saves', () async {
    // Stub
    when(() => mockRepo.fetchConfig()).thenAnswer((_) async => const RuntimeConfig(
      productName: 'Test',
      version: '1.0',
      config: ElrsConfig(pwm: [0, 1, 2, 3]),
    ));
    when(() => mockRepo.setPwmMapping(any())).thenAnswer((_) async {});

    final container = ProviderContainer(
      overrides: [
        deviceRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(pwmControllerProvider.notifier);
    await controller.loadConfig(); // Init state

    // Act: Update Pin 1 (index 0) to Channel 6 (index 5)
    controller.updateOutput(0, 5);

    // Assert State update
    var state = container.read(pwmControllerProvider);
    expect(state.outputs[0], 5);
    expect(state.outputs[1], 1); // Verify others unchanged
    expect(state.outputs[2], 2);
    expect(state.outputs[3], 3);

    // Act: Save
    await controller.save();

    // Assert Repo call
    // The controller converts list [5, 1, 2, 3] to Map {0: 5, 1: 1, 2: 2, 3: 3}
    final expectedMap = {0: 5, 1: 1, 2: 2, 3: 3};
    verify(() => mockRepo.setPwmMapping(expectedMap)).called(1);
    
    state = container.read(pwmControllerProvider);
    expect(state.status, PwmStatus.success);
  });
}
