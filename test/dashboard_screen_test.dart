import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:elrs_mobile/src/features/config/presentation/config_view_model.dart';
import 'package:elrs_mobile/src/features/dashboard/presentation/widgets/hardware_status_card.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:elrs_mobile/src/features/config/services/device_config_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceConfigService extends Mock implements DeviceConfigService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  testWidgets('Dashboard renders all menu items', (WidgetTester tester) async {
    final mockDeviceConfig = MockDeviceConfigService();
    // Simulate failing connection so the heartbeat gives up immediately and NO timers are left waiting on HTTP requests.
    when(
      () => mockDeviceConfig.probeDeviceHead(any()),
    ).thenAnswer((_) async => false);

    // 1. Pump Widget
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deviceConfigServiceProvider.overrideWithValue(mockDeviceConfig),
        ],
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );

    // 2. Assertions

    // Verify Cards (Title)
    expect(find.text('Flash Device'), findsOneWidget);
    expect(find.text('Device Config'), findsOneWidget);
    expect(find.text('Firmware Manager'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Check specific icons used in dashboard_screen.dart
    expect(find.byIcon(Icons.system_update), findsOneWidget); // Flash Device
    expect(find.byIcon(Icons.build), findsOneWidget); // Device Config
    expect(
      find.byIcon(Icons.folder_special),
      findsOneWidget,
    ); // Firmware Manager
    expect(find.byIcon(Icons.settings), findsWidgets); // Settings

    // Verify HardwareStatusCard
    expect(find.byType(HardwareStatusCard), findsOneWidget);

    // Unmount to dispose ProviderScope and cancel timers
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}
