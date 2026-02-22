import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/bug_report_service.dart';
import 'settings_controller.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(settingsControllerProvider.notifier);
    final state = ref.watch(settingsControllerProvider);

    useEffect(() {
      Future.microtask(() => controller.loadSettings());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Flashing Defaults'),
          ListTile(
            title: const Text('Default Regulatory Domain'),
            subtitle: Text(_getDomainLabel(state.defaultRegulatoryDomain)),
            trailing: DropdownButton<int>(
              value: state.defaultRegulatoryDomain,
              onChanged: (val) {
                if (val != null) controller.setDefaultRegulatoryDomain(val);
              },
              items: const [
                DropdownMenuItem(value: 0, child: Text('FCC (915MHz)')),
                DropdownMenuItem(value: 1, child: Text('EU (868MHz)')),
                DropdownMenuItem(value: 2, child: Text('ISM (2.4GHz)')),
                DropdownMenuItem(value: 3, child: Text('AU (915MHz)')),
              ],
            ),
          ),
          
          ListTile(
            title: const Text('Manage Cached Firmware'),
            subtitle: const Text('Download or delete offline firmware'),
            leading: const Icon(Icons.sd_storage),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.push('/firmware_manager'),
          ),

          ListTile(
            title: const Text('Max Cached Versions'),
            subtitle: Text('${state.maxCachedVersions} versions'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: state.maxCachedVersions > 1 
                      ? () => controller.setMaxCachedVersions(state.maxCachedVersions - 1)
                      : null,
                ),
                Text('${state.maxCachedVersions}', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: state.maxCachedVersions < 10
                      ? () => controller.setMaxCachedVersions(state.maxCachedVersions + 1)
                      : null,
                ),
              ],
            ),
          ),
          
          _buildSectionHeader(context, 'Networking'),
          SwitchListTile(
            title: const Text('Force Mobile Data'),
            subtitle: const Text('Use cellular data for downloads while connected to ELRS WiFi'),
            value: state.forceMobileData,
            onChanged: (val) => controller.setForceMobileData(val),
          ),
          
          _buildSectionHeader(context, 'About'),
          ListTile(
            title: const Text('App Version'),
            subtitle: Text(state.appVersion),
            onTap: () {
              // Easter egg logic could go here
            },
            leading: const Icon(Icons.info_outline),
          ),
          ListTile(
            title: const Text('GitHub Repository'),
            subtitle: const Text('https://github.com/ExpressLRS/ExpressLRS'),
            leading: const Icon(Icons.code),
            onTap: () => _launchUrl('https://github.com/ExpressLRS/ExpressLRS'),
          ),
          ListTile(
            title: const Text('Discord Community'),
            subtitle: const Text('Join the ELRS Discord'),
            leading: const Icon(Icons.chat),
            onTap: () => _launchUrl('https://discord.gg/dS6ReFY'),
          ),
          
          if (state.developerMode) ...[
             _buildSectionHeader(context, 'Developer'),
             const ListTile(title: Text('Developer Mode Enabled')),
          ],

          _buildSectionHeader(context, 'Advanced'),
          SwitchListTile(
            title: const Text('Expert Mode'),
            subtitle: const Text('Enable advanced firmware handling and downloads'),
            value: state.expertMode,
            onChanged: (val) => controller.toggleExpertMode(),
          ),
          
          if (state.expertMode) ...[
            const Divider(),
            ListTile(
              title: const Text('Submit Debug Report to GitHub'),
              subtitle: const Text('Help us fix bugs by sharing anonymous system logs'),
              leading: const Icon(Icons.bug_report, color: Colors.orange),
              trailing: const Icon(Icons.send),
              onTap: () => _showPrivacyGuard(context),
            ),
          ],
        ],
      ),
    );
  }

  void _showPrivacyGuard(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Guard'),
        content: const Text(
          'This will send your device info and app logs to GitHub for debugging. '
          'No personal info like Binding Phrases or WiFi passwords will be included. '
          'Proceed?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              _submitReport(context);
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }

  void _submitReport(BuildContext context) async {
    // Track whether user cancelled so we don't pop an already-popped dialog.
    var _dialogDismissed = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: const Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Expanded(child: Text('Submitting report…')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _dialogDismissed = true;
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    final error = await BugReportService.instance.submitReport(
      'Automated Bug Report',
      'User submitted a debug report from Settings.',
    );

    if (context.mounted && !_dialogDismissed) {
      Navigator.pop(context); // Hide loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error == null
            ? 'Report submitted successfully!'
            : 'Failed: $error'),
          backgroundColor: error == null ? Colors.green : Colors.red,
          duration: const Duration(seconds: 6),
        ),
      );
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getDomainLabel(int value) {
    switch (value) {
      case 0: return 'FCC (915MHz)';
      case 1: return 'EU (868MHz)';
      case 2: return 'ISM (2.4GHz)';
      case 3: return 'AU (915MHz)';
      default: return 'Unknown';
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
