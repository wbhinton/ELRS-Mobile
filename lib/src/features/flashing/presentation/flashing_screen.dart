import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'widgets/target_selection_card.dart';
import 'widgets/options_card.dart';
import 'package:go_router/go_router.dart';
import 'flashing_controller.dart';
import 'flash_error_text.dart';
import '../../settings/presentation/settings_controller.dart';
import '../../config/presentation/config_view_model.dart';
import '../../config/domain/runtime_config_model.dart';

class FlashingScreen extends HookConsumerWidget {
  const FlashingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // Lock orientation to prevent autoDispose teardowns during flash
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      
      Future.microtask(() {
        ref.read(flashingControllerProvider.notifier).loadSavedOptions();
        ref.read(flashingControllerProvider.notifier).autoSelectFromConnectedDevice();
      });
      
      return () {
        // Restore standard rotation when leaving the screen
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      };
    }, []);

    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(flashingControllerProvider);
    final settings = ref.watch(settingsControllerProvider);
    final configAsync = ref.watch(configViewModelProvider);
    final isConnected = configAsync.hasValue && configAsync.value != null;

    ref.listen<AsyncValue<RuntimeConfig?>>(
      configViewModelProvider,
      (previous, next) {
        if (next.hasValue && next.value != null) {
          ref
              .read(flashingControllerProvider.notifier)
              .autoSelectFromConnectedDevice();
        }
      },
    );

    // Listen for flashing state events
    ref.listen<FlashingState>(
      flashingControllerProvider,
      (previous, next) {
        if (next.status == FlashingStatus.mismatch &&
            previous?.status != FlashingStatus.mismatch) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => AlertDialog(
              title: Text(
                l10n.targetMismatchTitle,
                style: const TextStyle(color: Colors.orange),
              ),
              content: Text(l10n.targetMismatchMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    ref.read(flashingControllerProvider.notifier).resetStatus();
                  },
                  child: Text(l10n.cancelLabel.toUpperCase()),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    ref.read(flashingControllerProvider.notifier).forceUpdate();
                  },
                  child: Text(l10n.forceFlashLabel.toUpperCase()),
                ),
              ],
            ),
          );
        } else if (next.status == FlashingStatus.error &&
            next.error is NoBindPhrase &&
            previous?.status != FlashingStatus.error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(l10n.noBindPhraseTitle),
              content: Text(l10n.noBindPhraseMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.cancelLabel.toUpperCase()),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref
                        .read(flashingControllerProvider.notifier)
                        .flash(ignoreMissingBindPhrase: true);
                  },
                  child: Text(l10n.proceedLabel.toUpperCase()),
                ),
              ],
            ),
          );
        } else if (next.status == FlashingStatus.success &&
            previous?.status != FlashingStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.flashSuccessSnackbar)),
          );
        } else if (next.status == FlashingStatus.downloadSuccess &&
            previous?.status != FlashingStatus.downloadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.firmwareSavedSnackbar)),
          );
        }
      },
    );

    // Amber when the outcome is unknown rather than a definite failure.
    final errorColor =
        state.error is FlashUnconfirmed ? Colors.orange : Colors.red;

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
              // The bind-phrase prompt is a dialog, not an inline error.
              if (state.error != null &&
                  state.error is! NoBindPhrase &&
                  state.status != FlashingStatus.mismatch)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    children: [
                      Text(
                        state.error!.message(l10n),
                        style: TextStyle(color: errorColor),
                        textAlign: TextAlign.center,
                      ),
                      if (state.error!.detail != null) ...[
                        const SizedBox(height: 4),
                        SelectableText(
                          state.error!.detail!,
                          style: TextStyle(
                            color: errorColor.shade200,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),

              if (state.status == FlashingStatus.success)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    l10n.flashSuccessMessage,
                    style: const TextStyle(
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
                      // Finalizing has no progress signal from the device —
                      // show an indeterminate bar instead of a stalled 100%.
                      value: state.status == FlashingStatus.finalizing
                          ? null
                          : state.progress,
                      minHeight: 6, // Slightly thicker for better outdoor visibility
                      color: const Color(0xFF00E5FF), // Bright Cyan
                      backgroundColor: Colors.grey.withValues(alpha: 0.3), // Neutral dark track
                      borderRadius: BorderRadius.circular(4), // Rounded edges
                    ),
                    const SizedBox(height: 8),
                    Text(_flashingStatusLabel(context, state.status)),
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
                              l10n.stm32OtaWarning,
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
                    child: Text(l10n.downloadBinaryLabel.toUpperCase()),
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
                  (!isConnected
                          ? l10n.waitingForDeviceLabel
                          : isStm32
                          ? l10n.otaUnavailableLabel
                          : state.status == FlashingStatus.success
                          ? l10n.doneLabel
                          : l10n.flashingButtonLabel)
                      .toUpperCase(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _flashingStatusLabel(BuildContext context, FlashingStatus status) {
  final l10n = AppLocalizations.of(context)!;
  switch (status) {
    case FlashingStatus.locating:
      return l10n.flashingStatusLocating.toUpperCase();
    case FlashingStatus.unpacking:
      return l10n.flashingStatusUnpacking.toUpperCase();
    case FlashingStatus.downloading:
      return l10n.flashingStatusDownloading.toUpperCase();
    case FlashingStatus.building:
      return l10n.flashingStatusBuilding.toUpperCase();
    case FlashingStatus.uploading:
      return l10n.flashingStatusUploading.toUpperCase();
    case FlashingStatus.finalizing:
      return l10n.flashingStatusFinalizing.toUpperCase();
    case FlashingStatus.downloadSuccess:
      return l10n.flashingStatusSaved.toUpperCase();
    case FlashingStatus.idle:
    case FlashingStatus.success:
    case FlashingStatus.error:
    case FlashingStatus.mismatch:
      return status.name.toUpperCase();
  }
}
