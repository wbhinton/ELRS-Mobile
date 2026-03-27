import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/widgets/version_selector.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/target_selectors.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_controller.dart';
import 'package:elrs_mobile/src/features/flashing/domain/target_definition.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_provider.dart';
import 'package:elrs_mobile/src/features/flashing/data/releases_repository.dart';
import 'package:elrs_mobile/src/core/storage/firmware_cache_service.dart';
import 'package:elrs_mobile/src/features/settings/presentation/settings_controller.dart';

class MockFirmwareCacheService extends FirmwareCacheService {
  final List<String> _mockVersions;
  MockFirmwareCacheService(this._mockVersions);

  @override
  Future<List<String>> getCachedVersions() async => _mockVersions;
}

class MockSettingsController extends SettingsController {
  final SettingsState _initialState;
  MockSettingsController(this._initialState);
  @override
  SettingsState build() => _initialState;
}

class MockFlashingController extends FlashingController {
  final FlashingState _initialState;
  MockFlashingController(this._initialState);
  @override
  FlashingState build() => _initialState;
}

void main() {
  final stm32Target = TargetDefinition(
    name: 'Test STM32',
    platform: 'stm32',
    vendor: 'TestVendor',
    deviceType: 'TX',
    frequencyType: '2400',
    firmware: 'test_firmware',
    config: {},
  );

  final esp32Target = TargetDefinition(
    name: 'Test ESP32',
    platform: 'esp32',
    vendor: 'TestVendor',
    deviceType: 'TX',
    frequencyType: '2400',
    firmware: 'test_firmware',
    config: {},
  );

  testWidgets('STM32 targets should be visible in expert mode even if v4 is selected', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          targetsProvider.overrideWith((ref) => Future.value([stm32Target, esp32Target])),
          settingsControllerProvider.overrideWith(() => MockSettingsController(const SettingsState(expertMode: true))),
          flashingControllerProvider.overrideWith(() => MockFlashingController(const FlashingState(
            selectedVersion: '4.0.0',
            selectedDeviceType: 'TX',
            selectedVendor: 'TestVendor',
            selectedFrequency: '2400',
          ))),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, child) {
                final targets = ref.watch(availableTargetsListProvider);
                return ListView(
                  children: targets.map((t) => Text(t.name)).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.pump(); // No need for pumpAndSettle if there's no async work in build
    
    // Now visible because we moved from hiding to resetting on selection
    expect(find.text('Test STM32'), findsOneWidget);
    expect(find.text('Test ESP32'), findsOneWidget);
  });

  testWidgets('Selecting an STM32 target while v4 is selected should clear the version', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        settingsControllerProvider.overrideWith(() => MockSettingsController(const SettingsState(expertMode: true))),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(flashingControllerProvider.notifier);
    
    // 1. Select v4
    controller.selectVersion('4.0.0');
    expect(container.read(flashingControllerProvider).selectedVersion, '4.0.0');

    // 2. Select STM32 target
    controller.selectTarget(stm32Target);

    // 3. Version should be cleared
    expect(container.read(flashingControllerProvider).selectedTarget, stm32Target);
    expect(container.read(flashingControllerProvider).selectedVersion, isNull);
  });

  testWidgets('Should hide v4.0.0 from VersionSelector if STM32 target is already selected', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          releasesProvider.overrideWith((ref) => Future.value(['4.0.0', '3.3.0'])),
          firmwareCacheServiceProvider.overrideWith((ref) => MockFirmwareCacheService(['4.0.0', '3.3.0'])),
          flashingControllerProvider.overrideWith(() => MockFlashingController(FlashingState(selectedTarget: stm32Target))),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: VersionSelector(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Open dropdown
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    
    expect(find.text('4.0.0'), findsNothing);
    expect(find.text('3.3.0'), findsOneWidget);
  });
}
