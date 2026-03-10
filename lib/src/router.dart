import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'features/flashing/presentation/flashing_screen.dart';
import 'features/settings/presentation/settings_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/configurator/presentation/device_settings_screen.dart';
import 'features/firmware_manager/presentation/firmware_manager_screen.dart';
import 'features/settings/presentation/legal_notice_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
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
        path: '/device_config',
        builder: (context, state) => const DeviceSettingsScreen(),
      ),
      GoRoute(
        path: '/firmware_manager',
        builder: (context, state) => const FirmwareManagerScreen(),
      ),
      GoRoute(
        path: '/legal',
        builder: (context, state) => const LegalNoticeScreen(),
      ),
    ],
  );
}
