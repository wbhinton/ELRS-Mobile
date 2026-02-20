import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/config/domain/runtime_config_model.dart';
import 'package:elrs_mobile/src/features/config/presentation/device_editor_view_model.dart';

void main() {
  group('DeviceEditorViewModel Tests', () {
    late ProviderContainer container;
    late DeviceEditorViewModel viewModel;
    late RuntimeConfig baseConfig;

    setUp(() {
      container = ProviderContainer();
      viewModel = container.read(deviceEditorProvider.notifier);
      baseConfig = const RuntimeConfig(
        productName: 'Test RX',
        version: '4.0.0',
        settings: {'domain': 0, 'serialProtocol': 0},
        options: {'wifi-ssid': 'HomeNet', 'wifi-password': 'secret_password'},
        config: {'hardware': {'type': 'rx', 'has_pwm': false}},
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state has no changes', () {
      viewModel.initialize(baseConfig);
      expect(viewModel.hasChanges, isFalse);
    });

    test('Updating a setting flags hasChanges as true', () {
      viewModel.initialize(baseConfig);
      viewModel.updateSetting('domain', 1);
      
      expect(viewModel.hasChanges, isTrue);
      // Access state through the container for safety, or via the exposed state property if synced
      expect(container.read(deviceEditorProvider)?.settings['domain'], 1);
    });

    test('Updating an option flags hasChanges as true', () {
      viewModel.initialize(baseConfig);
      viewModel.updateOption('wifi-ssid', 'NewNet');
      
      expect(viewModel.hasChanges, isTrue);
      expect(container.read(deviceEditorProvider)?.options['wifi-ssid'], 'NewNet');
    });

    test('saveChanges correctly orchestrates saving logic depending on whats changed', () async {
      viewModel.initialize(baseConfig);
      
      // We'll track what methods were called.
      bool savedOptions = false;
      bool savedConfig = false;
      bool rebooted = false;

      Future<void> mockSaveOptions(String ip, Map<String, dynamic> opts) async => savedOptions = true;
      Future<void> mockSaveConfig(String ip, Map<String, dynamic> cfg) async => savedConfig = true;
      Future<void> mockReboot(String ip) async => rebooted = true;

      // Update ONLY an option.
      viewModel.updateOption('wifi-ssid', 'NewNet');

      final success = await viewModel.saveChanges('10.0.0.1', mockSaveOptions, mockSaveConfig, mockReboot);

      expect(success, isTrue);
      expect(savedOptions, isTrue);
      expect(savedConfig, isFalse); // Settings/Config were untouched!
      expect(rebooted, isTrue);
    });

    test('saveChanges triggers both endpoints if both are changed', () async {
      viewModel.initialize(baseConfig);
      
      bool savedOptions = false;
      bool savedConfig = false;

      Future<void> mockSaveOptions(String ip, Map<String, dynamic> opts) async => savedOptions = true;
      Future<void> mockSaveConfig(String ip, Map<String, dynamic> cfg) async => savedConfig = true;
      Future<void> mockReboot(String ip) async {};

      viewModel.updateOption('wifi-ssid', 'NewNet');
      viewModel.updateSetting('serialProtocol', 1);

      await viewModel.saveChanges('10.0.0.1', mockSaveOptions, mockSaveConfig, mockReboot);

      expect(savedOptions, isTrue);
      expect(savedConfig, isTrue);
    });
  });
}
