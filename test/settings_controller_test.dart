import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/settings/presentation/settings_controller.dart';

void main() {
  setUp(() {
    // 1. Setup: Mock the OS (Empty SharedPreferences)
    SharedPreferences.setMockInitialValues({});
    
    // Mock PackageInfo
    PackageInfo.setMockInitialValues(
      appName: 'ELRS Configurator',
      packageName: 'com.elrs.elrs_mobile',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
      installerStore: null,
    );
  });

  test('Settings load with correct defaults', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(settingsControllerProvider.notifier);
    
    // Act: Load settings
    await controller.loadSettings();

    // Assert: Check defaults
    final state = container.read(settingsControllerProvider);
    expect(state.developerMode, false);
    expect(state.forceMobileData, false);
    expect(state.appVersion, '1.0.0');
    expect(state.defaultRegulatoryDomain, 0); // Default is 0 per state definition
  });

  test('Toggling Developer Mode saves to disk', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(settingsControllerProvider.notifier);
    await controller.loadSettings(); // Initialize

    // Act: Toggle
    await controller.toggleDeveloperMode();

    // Assert (State)
    final state = container.read(settingsControllerProvider);
    expect(state.developerMode, true);

    // Assert (Disk)
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('developerMode'), true);
  });

  test('Setting Regulatory Domain updates state', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(settingsControllerProvider.notifier);
    await controller.loadSettings();

    // Act
    await controller.setDefaultRegulatoryDomain(1); // Set to EU

    // Assert
    final state = container.read(settingsControllerProvider);
    expect(state.defaultRegulatoryDomain, 1);
    
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('defaultRegulatoryDomain'), 1);
  });
}
