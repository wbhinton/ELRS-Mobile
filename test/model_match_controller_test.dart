import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elrs_mobile/src/features/config/domain/runtime_config_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:elrs_mobile/src/features/model_match/presentation/model_match_controller.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late MockDeviceRepository mockRepo;

  setUp(() {
    mockRepo = MockDeviceRepository();
  });

  test('ModelMatchController loads Model ID from config', () async {
    // Stub
    when(() => mockRepo.fetchConfig()).thenAnswer((_) async => const RuntimeConfig(
      productName: 'Test',
      version: '1.0',
      config: ElrsConfig(modelId: 5),
    ));

    final container = ProviderContainer(
      overrides: [
        deviceRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(modelMatchControllerProvider.notifier);

    // Act
    await controller.loadConfig();

    // Assert
    final state = container.read(modelMatchControllerProvider);
    expect(state.modelId, 5);
    expect(state.isEnabled, true);
    expect(state.status, ModelMatchStatus.success);
  });

  test('ModelMatchController saves new Model ID', () async {
    // Stub
    when(() => mockRepo.updateModelMatch(any(), any())).thenAnswer((_) async {});

    final container = ProviderContainer(
      overrides: [
        deviceRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(modelMatchControllerProvider.notifier);

    // Act
    await controller.save(10, true);

    // Assert
    verify(() => mockRepo.updateModelMatch(10, true)).called(1);
    
    final state = container.read(modelMatchControllerProvider);
    expect(state.modelId, 10);
    expect(state.isEnabled, true);
    expect(state.status, ModelMatchStatus.success);
  });
}
