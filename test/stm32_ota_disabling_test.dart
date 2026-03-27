import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_screen.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_controller.dart';
import 'package:elrs_mobile/src/features/flashing/domain/target_definition.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_provider.dart';
import 'package:elrs_mobile/src/features/flashing/data/releases_repository.dart';
import 'package:elrs_mobile/src/features/config/domain/runtime_config_model.dart';
import 'package:elrs_mobile/src/features/config/presentation/config_view_model.dart';

class MockConfigViewModel extends ConfigViewModel {
  final RuntimeConfig? _mockValue;
  MockConfigViewModel(this._mockValue);

  @override
  FutureOr<RuntimeConfig?> build() => _mockValue;
}

void main() {
  testWidgets('Should disable FLASH button and show warning for STM32 target', (WidgetTester tester) async {
    final stm32Target = TargetDefinition(
      name: 'Test STM32',
      platform: 'stm32',
      vendor: 'TestVendor',
      deviceType: 'TX',
      frequencyType: '2400',
      firmware: 'test_firmware',
      config: {},
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          targetsProvider.overrideWith((ref) => Future.value([stm32Target])),
          releasesProvider.overrideWith((ref) => Future.value([])),
          configViewModelProvider.overrideWith(() => MockConfigViewModel(const RuntimeConfig())),
          flashingControllerProvider.overrideWith(() {
             final notifier = FlashingController();
             // Manually set the state for the test
             Future.microtask(() => notifier.selectTarget(stm32Target));
             return notifier;
          }),
        ],
        child: const MaterialApp(
          home: FlashingScreen(),
        ),
      ),
    );

    // Initial load
    await tester.pump();
    // Wait for the microtask to select the target
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify Warning UI is present
    expect(find.textContaining('STM32 Target Selected'), findsOneWidget);

    // Verify Flash button is disabled or says OTA UNAVAILABLE
    final flashButtonFinder = find.widgetWithText(ElevatedButton, 'OTA UNAVAILABLE');
    expect(flashButtonFinder, findsOneWidget);
    
    final ElevatedButton button = tester.widget(flashButtonFinder);
    expect(button.enabled, isFalse);
  });

  testWidgets('Should allow FLASH button for ESP32 target', (WidgetTester tester) async {
    final esp32Target = TargetDefinition(
      name: 'Test ESP32',
      platform: 'esp32',
      vendor: 'TestVendor',
      deviceType: 'TX',
      frequencyType: '2400',
      firmware: 'test_firmware',
      config: {},
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          targetsProvider.overrideWith((ref) => Future.value([esp32Target])),
          releasesProvider.overrideWith((ref) => Future.value([])),
          configViewModelProvider.overrideWith(() => MockConfigViewModel(const RuntimeConfig())),
          flashingControllerProvider.overrideWith(() {
             final notifier = FlashingController();
             Future.microtask(() => notifier.selectTarget(esp32Target));
             return notifier;
          }),
        ],
        child: const MaterialApp(
          home: FlashingScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify Warning UI is NOT present
    expect(find.textContaining('STM32 Target Selected'), findsNothing);

    // Verify Flash button is enabled and says FLASH
    final flashButtonFinder = find.widgetWithText(ElevatedButton, 'FLASH');
    expect(flashButtonFinder, findsOneWidget);
    
    final ElevatedButton button = tester.widget(flashButtonFinder);
    expect(button.enabled, isTrue);
  });
}
