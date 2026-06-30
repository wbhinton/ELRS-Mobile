import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'widgets/target_selection_card.dart';
import 'widgets/options_card.dart';
import 'package:go_router/go_router.dart';
import 'flashing_controller.dart';
import '../../settings/presentation/settings_controller.dart';
import '../../config/presentation/config_view_model.dart';

class FlashingScreen extends HookConsumerWidget {
  const FlashingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // Lock orientation to prevent autoDispose teardowns during flash
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      
      Future.microtask(
        () => ref.read(flashingControllerProvider.notifier).loadSavedOptions(),
      );
      
      return () {
        // Restore standard rotation when leaving the screen
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      };
    }, []);

    final state = ref.watch(flashingControllerProvider);
    final settings = ref.watch(settingsControllerProvider);
    final configAsync = ref.watch(configViewModelProvider);
    final isConnected = configAsync.hasValue && configAsync.value != null;

    // Listen for flashing state events
    ref.listen<FlashingState>(
      flashingControllerProvider,
      (previous, next) {
        if (next.status == FlashingStatus.mismatch &&
            previous?.status != FlashingStatus.mismatch) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Target Mismatch'),
              content: const Text(
                  'The firmware target you selected does not match the hardware '
                  'target currently installed on this device. Are you sure you want to force this update?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref.read(flashingControllerProvider.notifier).resetStatus();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref.read(flashingControllerProvider.notifier).forceUpdate();
                  },
                  child: const Text('Flash Anyway', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        } else if (next.status == FlashingStatus.error &&
            next.errorMessage == 'NO_BIND_PHRASE' &&
            previous?.status != FlashingStatus.error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('No Binding Phrase'),
              content: const Text(
                'No Binding Phrase set. Proceed with default (empty)?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref
                        .read(flashingControllerProvider.notifier)
                        .flash(ignoreMissingBindPhrase: true);
                  },
                  child: const Text('PROCEED'),
                ),
              ],
            ),
          );
        } else if (next.status == FlashingStatus.success &&
            previous?.status != FlashingStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Flashing completed successfully!')),
          );
        } else if (next.status == FlashingStatus.downloadSuccess &&
            previous?.status != FlashingStatus.downloadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Firmware saved successfully!')),
          );
        }
      },
    );

    final selectedTarget = state.selectedTarget;
    final isStm32 = selectedTarget?.platform == 'stm32';

    return Scaffold(
      appBar: AppBar(
        title: const Text('ELRS Mobile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Target Selection Card
              const TargetSelectionCard(),
              const SizedBox(height: 16),

              // 2. Options Card
              const OptionsCard(),
              const SizedBox(height: 24),

              // 3. Action Button & Progress
              if (state.errorMessage != null &&
                  state.status != FlashingStatus.mismatch)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              if (state.status == FlashingStatus.success)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Flashing Successful! Device is rebooting.',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              if (state.status != FlashingStatus.idle &&
                  state.status != FlashingStatus.error &&
                  state.status != FlashingStatus.success &&
                  state.status != FlashingStatus.mismatch)
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: state.progress,
                      minHeight: 6, // Slightly thicker for better outdoor visibility
                      color: const Color(0xFF00E5FF), // Bright Cyan
                      backgroundColor: Colors.grey.withValues(alpha: 0.3), // Neutral dark track
                      borderRadius: BorderRadius.circular(4), // Rounded edges
                    ),
                    const SizedBox(height: 8),
                    Text(state.status.name.toUpperCase()),
                    const SizedBox(height: 16),
                  ],
                ),

              if (isStm32)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Card(
                    color: Colors.amber.withValues(alpha: 0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.amber.withValues(alpha: 0.4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: Colors.amber.shade400),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'STM32 Target Selected: OTA flashing is not supported for this hardware. You can build and save this firmware locally to flash manually via STLink or Betaflight Passthrough.',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: Colors.amber.shade100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              if (settings.expertMode)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: OutlinedButton(
                    onPressed:
                        (state.status == FlashingStatus.idle ||
                            state.status == FlashingStatus.error ||
                            state.status == FlashingStatus.success ||
                            state.status == FlashingStatus.downloadSuccess ||
                            state.status == FlashingStatus.mismatch)
                        ? () => ref
                              .read(flashingControllerProvider.notifier)
                              .downloadFirmware()
                        : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('DOWNLOAD BINARY'),
                  ),
                ),

              ElevatedButton(
                onPressed: (isConnected &&
                        !isStm32 &&
                        (state.status == FlashingStatus.idle ||
                            state.status == FlashingStatus.error ||
                            state.status == FlashingStatus.success ||
                            state.status == FlashingStatus.downloadSuccess ||
                            state.status == FlashingStatus.mismatch))
                    ? () {
                        if (state.status == FlashingStatus.success) {
                          ref
                              .read(flashingControllerProvider.notifier)
                              .resetStatus();
                        } else if (state.status == FlashingStatus.mismatch) {
                          // Re-trigger mismatch dialog if they click the button again
                          ref
                              .read(flashingControllerProvider.notifier)
                              .resetStatus();
                          Future.microtask(
                            () => ref
                                .read(flashingControllerProvider.notifier)
                                .flash(),
                          );
                        } else {
                          ref.read(flashingControllerProvider.notifier).flash();
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: state.status == FlashingStatus.success
                      ? Colors.green
                      : null,
                ),
                child: Text(
                  !isConnected
                      ? 'WAITING FOR DEVICE...'
                      : isStm32
                          ? 'OTA UNAVAILABLE'
                          : state.status == FlashingStatus.success
                              ? 'DONE'
                              : AppLocalizations.of(context)!.flashingButtonLabel.toUpperCase(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
