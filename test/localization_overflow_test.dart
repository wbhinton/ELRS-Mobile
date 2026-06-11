import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/widgets/options_card.dart';
import 'package:elrs_mobile/src/features/dashboard/presentation/widgets/hardware_status_card.dart';

import 'dart:async';
import 'package:elrs_mobile/src/features/config/domain/runtime_config_model.dart';
import 'package:elrs_mobile/src/core/storage/firmware_cache_service.dart';
import 'package:elrs_mobile/src/features/config/presentation/config_view_model.dart';

void main() {
  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('Test localization layout does not overflow in locale: $locale', (WidgetTester tester) async {
      // Set a small test screen size (e.g. 320x568 - iPhone SE/older phones) to be very sensitive to overflows
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;

      await tester.runAsync(() async {
        // Pump OptionsCard
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              configViewModelProvider.overrideWith(() => MockConfigViewModel()),
              firmwareCacheServiceProvider.overrideWith((ref) => MockFirmwareCacheService()),
            ],
            child: MaterialApp(
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const Scaffold(
                body: SingleChildScrollView(
                  child: OptionsCard(),
                ),
              ),
            ),
          ),
        );
        
        await tester.pump();
        
        // Pump HardwareStatusCard
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              configViewModelProvider.overrideWith(() => MockConfigViewModel()),
              firmwareCacheServiceProvider.overrideWith((ref) => MockFirmwareCacheService()),
            ],
            child: MaterialApp(
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const Scaffold(
                body: SingleChildScrollView(
                  child: HardwareStatusCard(),
                ),
              ),
            ),
          ),
        );

        await tester.pump();
      });
      
      // Reset view configurations
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }
}

class MockConfigViewModel extends ConfigViewModel {
  @override
  FutureOr<RuntimeConfig?> build() {
    return null;
  }
}

class MockFirmwareCacheService extends FirmwareCacheService {
  @override
  Future<List<String>> getCachedVersions() async {
    return ['3.3.0', '3.4.0'];
  }
}
