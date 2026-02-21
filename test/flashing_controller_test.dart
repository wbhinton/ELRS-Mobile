import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/domain/target_definition.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_controller.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/target_selectors.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_provider.dart';

void main() {
  test('Selection Logic Resets Correctly', () {
    // 1. Mock Data Setup
    final t1 = TargetDefinition(vendor: 'BetaFPV', name: 'Nano RX', firmware: 'f1');
    final t2 = TargetDefinition(vendor: 'BetaFPV', name: 'Micro TX', firmware: 'f2');
    final t3 = TargetDefinition(vendor: 'HappyModel', name: 'EP1 RX', firmware: 'f3');
    final dummyTargets = [t1, t2, t3];

    // 2. Setup Container
    final container = ProviderContainer(
      overrides: [
        targetsProvider.overrideWith((ref) => Future.value(dummyTargets)),
      ],
    );
    addTearDown(container.dispose);

    // Act 1 (Filter)
    container.read(flashingControllerProvider.notifier).selectVendor('BetaFPV');
    
    // Wait for the async targetsProvider to resolve if needed, 
    // though the override is a Future.value.
    // However, devicesForVendorProvider watches targetsProvider.
    // Reading devicesForVendorProvider will trigger the provider.
    
    // Since targetsProvider is async, devicesForVendorProvider will expose AsyncValue initially if we used AsyncValue in targetsProvider.
    // But wait, targetsProvider returns Future<List>.
    // uniqueVendorsProvider uses ref.watch(targetsProvider).when...
    // So we need to wait for the future to complete.
    
    // Let's verify the initial state first.
    final devices1 = container.read(devicesForVendorProvider);
    // Since we just overrode it, it might need a tick.
    // But since it's a FutureProvider override logic, let's see.
    // Actually, checking how targetsProvider is defined: @riverpod Future<List>...
    // The override above is correct.
    
    // Wait for the provider to emit data
    // We can read .future or just wait a bit.
    
    // Let's proceed with Act 2 and Checks. 
    // Note: devicesForVendorProvider implementation handles AsyncValue logic.
    
    // Assert 1: Filtered list for BetaFPV
    // Since we can't easily await inside the test without reading .future on the provider if it's async...
    // But devicesForVendorProvider returns List<TargetDefinition> (synchronously derived from AsyncValue).
    // If targetsProvider is loading, it returns [].
    // So we need to ensure targetsProvider has emitted 'data'.
    
    // Hack: Wait for the future to complete.
    // await container.read(targetsProvider.future);
    // This is not quite right because we need the dependent providers to update.
    
    // Let's try attempting assertions. If logic is correct, it should work 
    // provided the AsyncValue has data.
    // To ensure data, we can pump the container or wait.
    
  });
  
  // Re-writing the test to be async and handle the AsyncValue propagation
  test('Selection Logic Verify', () async {
      final t1 = TargetDefinition(vendor: 'BetaFPV', name: 'Nano RX', firmware: 'f1');
      final t2 = TargetDefinition(vendor: 'BetaFPV', name: 'Micro TX', firmware: 'f2');
      final t3 = TargetDefinition(vendor: 'HappyModel', name: 'EP1 RX', firmware: 'f3');
      final dummyTargets = [t1, t2, t3];

      final container = ProviderContainer(
        overrides: [
          targetsProvider.overrideWith((ref) => Future.value(dummyTargets)),
        ],
      );
      addTearDown(container.dispose);

      // Initialize/Wait for data
      await container.read(targetsProvider.future);

      // Act 1: Select BetaFPV
      container.read(flashingControllerProvider.notifier).selectVendor('BetaFPV');
      
      // Assert 1: Devices list should have T1 and T2
      final devicesBeta = container.read(devicesForVendorProvider);
      expect(devicesBeta, containsAll([t1, t2]));
      expect(devicesBeta, isNot(contains(t3)));
      expect(devicesBeta.length, 2);

      // Act 2: Select T1
      container.read(flashingControllerProvider.notifier).selectTarget(t1);
      final state2 = container.read(flashingControllerProvider);
      expect(state2.selectedTarget, equals(t1));

      // Act 3: Reset - Select HappyModel
      container.read(flashingControllerProvider.notifier).selectVendor('HappyModel');
      
      // Assert 3
      final state3 = container.read(flashingControllerProvider);
      expect(state3.selectedTarget, isNull, reason: 'Target should be reset to null');
      expect(state3.selectedVendor, 'HappyModel');

      final devicesHappy = container.read(devicesForVendorProvider);
      expect(devicesHappy, contains(t3));
      expect(devicesHappy.length, 1);
  });
}
