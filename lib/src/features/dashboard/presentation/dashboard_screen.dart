import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/presentation/responsive_layout.dart';
import '../../settings/presentation/settings_controller.dart';
import '../../settings/presentation/disclaimer_dialog.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/hardware_status_card.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final disclaimerAccepted = settingsState.disclaimerAccepted;
    final isLoaded = settingsState.isLoaded;
    final isTablet = ResponsiveLayout.isTablet(context);

    // Show disclaimer once on first launch, after the settings have loaded.
    useEffect(() {
      if (isLoaded && !disclaimerAccepted) {
        Future.microtask(() {
          if (context.mounted) {
            showDisclaimerDialog(context, ref);
          }
        });
      }
      return null;
    }, [isLoaded, disclaimerAccepted]);

    return Scaffold(
      appBar: AppBar(title: const Text('ELRS Mobile')),
      body: ResponsiveLayout(
        child: Stack(
          children: [
            // Blurred background logo
            Positioned(
              bottom: -70,
              right: -70,
              child: Opacity(
                opacity: 0.2,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 4.0,
                    sigmaY: 4.0,
                    tileMode: TileMode.decal,
                  ),
                  child: SvgPicture.asset(
                    'icons/elrs_mobile_foreground.svg',
                    width: isTablet ? 500 : 350,
                    // ignore: deprecated_member_use
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            // Main Content
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                HardwareStatusCard(),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: isTablet ? 3 : 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: [
                    DashboardCard(
                      title: 'Flash Device',
                      icon: Icons.system_update,
                      color: Colors.teal,
                      onTap: () => context.push('/flashing'),
                    ),
                    DashboardCard(
                      title: 'Device Config',
                      icon: Icons.build,
                      color: Colors.blue,
                      onTap: () => context.push('/device_config'),
                    ),
                    DashboardCard(
                      title: 'Firmware Manager',
                      icon: Icons.folder_special,
                      color: Colors.orange,
                      onTap: () => context.push('/firmware_manager'),
                    ),
                    DashboardCard(
                      title: 'Settings',
                      icon: Icons.settings,
                      color: Colors.grey,
                      onTap: () => context.push('/settings'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
