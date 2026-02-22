import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'widgets/target_selection_card.dart';
import 'widgets/options_card.dart';
import 'package:go_router/go_router.dart';
import 'flashing_controller.dart';
import '../../settings/presentation/settings_controller.dart';

class FlashingScreen extends HookConsumerWidget {
  const FlashingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // Load saved options on mount
      Future.microtask(() => ref.read(flashingControllerProvider.notifier).loadSavedOptions());
      return null;
    }, []);

    final state = ref.watch(flashingControllerProvider);
    final settings = ref.watch(settingsControllerProvider);

    // Listen for mismatch state to show dialog
    ref.listen<FlashingStatus>(
      flashingControllerProvider.select((s) => s.status),
      (previous, next) {
        if (next == FlashingStatus.mismatch) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Target Mismatch'),
              content: Text(state.errorMessage ?? 'The selected firmware does not match this device.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.read(flashingControllerProvider.notifier).resetStatus();
                  },
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.read(flashingControllerProvider.notifier).flash();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('RETRY FLASH'),
                ),
              ],
            ),
          );
        } else if (next == FlashingStatus.error && state.errorMessage == 'NO_BIND_PHRASE') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('No Binding Phrase'),
              content: const Text('No Binding Phrase set. Proceed with default (empty)?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.read(flashingControllerProvider.notifier).flash(ignoreMissingBindPhrase: true);
                  },
                  child: const Text('PROCEED'),
                ),
              ],
            ),
          );
        } else if (next == FlashingStatus.success) {
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Flashing completed successfully!')),
           );
        } else if (next == FlashingStatus.downloadSuccess) {
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Firmware saved successfully!')),
           );
        }
      },
    );

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
      body: SingleChildScrollView(
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
            if (state.errorMessage != null && state.status != FlashingStatus.mismatch)
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
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

            if (state.status != FlashingStatus.idle && 
                state.status != FlashingStatus.error && 
                state.status != FlashingStatus.success &&
                state.status != FlashingStatus.mismatch)
              Column(
                children: [
                   LinearProgressIndicator(value: state.progress),
                   const SizedBox(height: 8),
                   Text(state.status.name.toUpperCase()),
                   const SizedBox(height: 16),
                ],
              ),

            if (settings.expertMode)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: OutlinedButton(
                  onPressed: (state.status == FlashingStatus.idle || 
                              state.status == FlashingStatus.error || 
                              state.status == FlashingStatus.success ||
                              state.status == FlashingStatus.downloadSuccess ||
                              state.status == FlashingStatus.mismatch)
                       ? () => ref.read(flashingControllerProvider.notifier).downloadFirmware()
                      : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('DOWNLOAD BINARY'),
                ),
              ),

            ElevatedButton(
              onPressed: (state.status == FlashingStatus.idle || 
                          state.status == FlashingStatus.error || 
                          state.status == FlashingStatus.success ||
                          state.status == FlashingStatus.downloadSuccess ||
                          state.status == FlashingStatus.mismatch)
                  ? () {
                      if (state.status == FlashingStatus.success) {
                        ref.read(flashingControllerProvider.notifier).resetStatus();
                      } else if (state.status == FlashingStatus.mismatch) {
                        // Re-trigger mismatch dialog if they click the button again
                        ref.read(flashingControllerProvider.notifier).resetStatus();
                        Future.microtask(() => ref.read(flashingControllerProvider.notifier).flash());
                      } else {
                        ref.read(flashingControllerProvider.notifier).flash();
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: state.status == FlashingStatus.success ? Colors.green : null,
              ),
              child: Text(state.status == FlashingStatus.success ? 'DONE' : 'FLASH'),
            ),
          ],
        ),
      ),
    );
  }
}
