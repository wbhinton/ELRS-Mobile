import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_provider.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_repository.dart';
import 'package:elrs_mobile/src/features/flashing/domain/target_definition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

class MockTargetsRepository extends Mock implements TargetsRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  
  test('Targets Provider fetches data successfully', () async {
    final mockRepo = MockTargetsRepository();
    
    when(() => mockRepo.fetchTargets()).thenAnswer((_) async => [
      const TargetDefinition(name: 'Test Target', vendor: 'Test Vendor'),
    ]);

    final container = ProviderContainer(
      overrides: [
        targetsRepositoryProvider.overrideWith((ref) => mockRepo),
      ],
    );
    addTearDown(container.dispose);

    final targets = await container.read(targetsProvider.future);

    expect(targets, isNotEmpty);
    expect(targets.first.name, equals('Test Target'));
  });
}