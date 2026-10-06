import 'package:flutter/material.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../application/app_update_service.dart';

/// Offers a direct-download update. "Download" opens the APK link in the
/// browser and Android's sideload flow installs it over this app.
Future<void> showUpdateDialog(
  BuildContext context,
  AppUpdateService service,
  UpdateAvailable update,
) {
  return showDialog<void>(
    context: context,
    builder: (ctx) {
      final l10n = AppLocalizations.of(ctx)!;
      return AlertDialog(
        icon: const Icon(Icons.system_update, size: 40),
        title: Text(l10n.updateAvailableTitle),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.updateAvailableMessage(
                  update.release.version,
                  update.currentVersion,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.updateInstallHint,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await service.skipVersion(update.release);
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: Text(l10n.updateSkipVersionButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.updateLaterButton),
          ),
          ElevatedButton(
            onPressed: () async {
              await launchUrl(
                update.release.downloadUrl,
                mode: LaunchMode.externalApplication,
              );
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: Text(l10n.updateDownloadButton),
          ),
        ],
      );
    },
  );
}
