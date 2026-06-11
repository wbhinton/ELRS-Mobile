import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      icon: const Icon(
        Icons.warning_amber_rounded,
        size: 40,
        color: Colors.amber,
      ),
      title: Text(l10n.disclaimerTitle),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.disclaimerHeader,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.disclaimerLiability,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.disclaimerAgreement,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.disclaimerVerification,
              style: const TextStyle(fontStyle: FontStyle.italic),
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
          child: Text(l10n.disclaimerUnderstand),
        ),
      ],
    );
  }
}
