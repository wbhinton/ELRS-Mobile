import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../presentation/settings_controller.dart';

/// Shows the disclaimer dialog. Pass [onAccepted] to be notified when the
/// user taps "I Understand". If [barrierDismissible] is false (the default
/// for first-run), the user must explicitly acknowledge.
Future<void> showDisclaimerDialog(
  BuildContext context,
  WidgetRef ref, {
  bool barrierDismissible = false,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (ctx) => _DisclaimerDialog(ref: ref),
  );
}

class _DisclaimerDialog extends ConsumerWidget {
  const _DisclaimerDialog({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning_amber_rounded,
        size: 40,
        color: Colors.amber,
      ),
      title: const Text('Use at Your Own Risk'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ELRS Mobile is provided as-is, without warranty of any kind.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'The developers are not responsible for any damage, data loss, or '
              'non-functional hardware resulting from the use of this application, '
              'including but not limited to bricked receivers, transmitters, or '
              'flight controllers.',
            ),
            SizedBox(height: 12),
            Text(
              'By using this app you confirm that you understand the risks of '
              'flashing custom firmware and accept full responsibility for your '
              'hardware.',
            ),
            SizedBox(height: 12),
            Text(
              'Always verify the target and firmware version before flashing. '
              'Keep a record of your original firmware if possible.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await widgetRef
                .read(settingsControllerProvider.notifier)
                .acceptDisclaimer();
            if (context.mounted) Navigator.of(context).pop();
          },
          child: const Text('I Understand'),
        ),
      ],
    );
  }
}
