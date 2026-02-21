import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'features/flashing/presentation/flashing_screen.dart';
import 'features/settings/presentation/settings_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/model_match/presentation/model_match_screen.dart';
import 'features/pwm_config/presentation/pwm_screen.dart';
import 'features/backpack/presentation/backpack_screen.dart';
import 'features/configurator/presentation/device_settings_screen.dart';
import 'features/firmware_manager/presentation/firmware_manager_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/flashing',
        builder: (context, state) => const FlashingScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/model_match',
        builder: (context, state) => const ModelMatchScreen(),
      ),
      GoRoute(
        path: '/pwm_config',
        builder: (context, state) => const PwmScreen(),
      ),
      GoRoute(
        path: '/backpack',
        builder: (context, state) => const BackpackScreen(),
      ),
      GoRoute(
        path: '/device_config',
        builder: (context, state) => const DeviceSettingsScreen(),
      ),
      GoRoute(
        path: '/firmware_manager',
        builder: (context, state) => const FirmwareManagerScreen(),
      ),
    ],
  );
}
