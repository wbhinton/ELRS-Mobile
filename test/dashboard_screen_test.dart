import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:elrs_mobile/src/features/config/presentation/config_view_model.dart';
import 'package:elrs_mobile/src/features/dashboard/presentation/widgets/hardware_status_card.dart';
import 'package:elrs_mobile/src/features/dashboard/presentation/widgets/connection_status_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  
  testWidgets('Dashboard renders all menu items', (WidgetTester tester) async {
    // 1. Pump Widget
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: DashboardScreen(),
        ),
      ),
    );

    // 2. Assertions
    
    // Verify Cards (Title)
    expect(find.text('Flash Device'), findsOneWidget);
    expect(find.text('Device Config'), findsOneWidget);
    expect(find.text('Backpack'), findsOneWidget);
    expect(find.text('Firmware Manager'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    
    // Check specific icons used in dashboard_screen.dart
    expect(find.byIcon(Icons.system_update), findsOneWidget); // Flash Device
    expect(find.byIcon(Icons.build), findsOneWidget);         // Device Config
    expect(find.byIcon(Icons.videocam), findsOneWidget);      // Backpack
    expect(find.byIcon(Icons.folder_special), findsOneWidget); // Firmware Manager
    expect(find.byIcon(Icons.settings), findsWidgets);      // Settings

    // Verify HardwareStatusCard
    expect(find.byType(HardwareStatusCard), findsOneWidget);
  });
}
