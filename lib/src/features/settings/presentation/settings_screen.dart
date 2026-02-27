import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'disclaimer_dialog.dart';
import 'settings_controller.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(settingsControllerProvider.notifier);
    final state = ref.watch(settingsControllerProvider);
    final showBindPhrase = useState(false);
    final showWifiPassword = useState(false);

    useEffect(() {
      Future.microtask(() => controller.loadSettings());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Flashing Defaults'),
          ListTile(
            title: const Text('Default 2.4GHz Domain'),
            subtitle: Text(_getDomainLabel2400(state.defaultDomain2400)),
            trailing: DropdownButton<int>(
              value: state.defaultDomain2400,
              onChanged: (val) {
                if (val != null) controller.setDefaultDomain2400(val);
              },
              items: const [
                DropdownMenuItem(value: 0, child: Text('ISM')),
                DropdownMenuItem(value: 1, child: Text('EU CE LBT')),
              ],
            ),
          ),
          ListTile(
            title: const Text('Default Sub-GHz Domain'),
            subtitle: Text(_getDomainLabel900(state.defaultDomain900)),
            trailing: DropdownButton<int>(
              value: state.defaultDomain900,
              onChanged: (val) {
                if (val != null) controller.setDefaultDomain900(val);
              },
              items: const [
                DropdownMenuItem(value: 0, child: Text('AU915')),
                DropdownMenuItem(value: 1, child: Text('FCC915')),
                DropdownMenuItem(value: 2, child: Text('EU868')),
                DropdownMenuItem(value: 3, child: Text('IN866')),
                DropdownMenuItem(value: 4, child: Text('AU433')),
                DropdownMenuItem(value: 5, child: Text('EU433')),
                DropdownMenuItem(value: 6, child: Text('US433')),
              ],
            ),
          ),

          _buildEditDialogTile(
            context,
            title: 'Global Binding Phrase',
            subtitle: state.globalBindPhrase.isEmpty
                ? 'Not set'
                : (showBindPhrase.value ? state.globalBindPhrase : '••••••••'),
            currentValue: state.globalBindPhrase,
            onSaved: (val) => controller.setGlobalBindPhrase(val),
            isSecret: true,
            isVisibleNotifier: showBindPhrase,
          ),
          _buildEditDialogTile(
            context,
            title: 'Home WiFi SSID',
            subtitle: state.homeWifiSsid.isEmpty
                ? 'Not set'
                : state.homeWifiSsid,
            currentValue: state.homeWifiSsid,
            onSaved: (val) => controller.setHomeWifiSsid(val),
          ),
          _buildEditDialogTile(
            context,
            title: 'Home WiFi Password',
            subtitle: state.homeWifiPassword.isEmpty
                ? 'Not set'
                : (showWifiPassword.value
                      ? state.homeWifiPassword
                      : '••••••••'),
            currentValue: state.homeWifiPassword,
            onSaved: (val) => controller.setHomeWifiPassword(val),
            isSecret: true,
            isVisibleNotifier: showWifiPassword,
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
                      ? () => controller.setMaxCachedVersions(
                          state.maxCachedVersions - 1,
                        )
                      : null,
                ),
                Text(
                  '${state.maxCachedVersions}',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: state.maxCachedVersions < 10
                      ? () => controller.setMaxCachedVersions(
                          state.maxCachedVersions + 1,
                        )
                      : null,
                ),
              ],
            ),
          ),

          _buildSectionHeader(context, 'About'),
          ListTile(
            title: const Text('App Version'),
            subtitle: Text(state.appVersion),
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
          ExpansionTile(
            leading: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.amber,
            ),
            title: const Text('Disclaimer & Liability'),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              const Text(
                'ELRS Mobile is provided as-is, without warranty of any kind. '
                'The developers are not responsible for any damage, data loss, or '
                'non-functional hardware resulting from the use of this application, '
                'including but not limited to bricked receivers, transmitters, or '
                'flight controllers.\n\n'
                'By using this app you accept full responsibility for your hardware.',
                style: TextStyle(height: 1.5),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('View Full Disclaimer'),
                  onPressed: () => showDisclaimerDialog(
                    context,
                    ref,
                    barrierDismissible: true,
                  ),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(
              Icons.build_circle_outlined,
              color: Colors.orange,
            ),
            title: const Text('Flash Recovery Instructions'),
            subtitle: const Text('What to do if a flash fails'),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              const Text(
                'If your device appears unresponsive after a failed flash:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const _RecoveryStep(
                number: '1',
                text:
                    'Hold the BOOT button while plugging in via USB to enter bootloader mode.',
              ),
              const _RecoveryStep(
                number: '2',
                text:
                    'Use the ELRS Web Flasher at expresslrs.org/flasher to re-flash over USB/UART.',
              ),
              const _RecoveryStep(
                number: '3',
                text:
                    'For WiFi-capable devices, hold BOOT for 60 s to trigger WiFi Hotspot recovery mode.',
              ),
              const _RecoveryStep(
                number: '4',
                text:
                    'Join #help on the ELRS Discord — the community can usually recover any device.',
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('Web Flasher'),
                    onPressed: () =>
                        _launchUrl('https://expresslrs.github.io/web-flasher/'),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.chat, size: 16),
                    label: const Text('Discord'),
                    onPressed: () => _launchUrl('https://discord.gg/dS6ReFY'),
                  ),
                ],
              ),
            ],
          ),

          if (state.developerMode) ...[
            _buildSectionHeader(context, 'Developer'),
            const ListTile(title: Text('Developer Mode Enabled')),
            ListTile(
              title: const Text('Test Sentry Error Capture'),
              subtitle: const Text(
                'Sends a test exception to Sentry — check the dashboard',
              ),
              leading: const Icon(Icons.science, color: Colors.deepPurple),
              trailing: const Icon(Icons.send),
              onTap: () async {
                final id = await Sentry.captureException(
                  Exception('Sentry test exception — ignore'),
                  stackTrace: StackTrace.current,
                  withScope: (scope) => scope.setTag('test', 'true'),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Sent! Event ID: ${id.toString().substring(0, 8)}…',
                      ),
                      backgroundColor: Colors.deepPurple,
                      duration: const Duration(seconds: 6),
                    ),
                  );
                }
              },
            ),
          ],

          _buildSectionHeader(context, 'Advanced'),
          SwitchListTile(
            title: const Text('Expert Mode'),
            subtitle: const Text(
              'Enable advanced firmware handling and downloads',
            ),
            value: state.expertMode,
            onChanged: (val) => controller.toggleExpertMode(),
          ),

          if (state.expertMode) ...[
            const Divider(),
            ListTile(
              title: const Text('Submit Debug Report to Sentry'),
              subtitle: const Text(
                'Help us fix bugs by sharing anonymous system logs',
              ),
              leading: const Icon(Icons.bug_report, color: Colors.orange),
              trailing: const Icon(Icons.send),
              onTap: () => _showPrivacyGuard(context, state),
            ),
          ],
        ],
      ),
    );
  }

  void _showPrivacyGuard(BuildContext context, SettingsState state) {
    final descController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Debug Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This will send your device info and app logs to Sentry for debugging. '
              'No personal info like Binding Phrases or WiFi passwords will be included.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Describe what happened (optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final desc = descController.text.trim();
              Navigator.pop(context);
              _submitReport(context, state, desc);
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }

  void _submitReport(
    BuildContext context,
    SettingsState state,
    String description,
  ) async {
    // Track whether user cancelled so we don't pop an already-popped dialog.
    var dialogDismissed = false;

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
              dialogDismissed = true;
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    try {
      final id = await Sentry.captureMessage(
        description.isNotEmpty
            ? description
            : 'User Feedback: Manual Debug Report',
        level: SentryLevel.info,
        withScope: (scope) {
          scope.setTag('user-report', 'manual');
          scope.setTag('app.version', state.appVersion);
          scope.setTag('app.expert_mode', state.expertMode.toString());
          scope.setTag('app.developer_mode', state.developerMode.toString());
          scope.setTag('app.domain_2400', state.defaultDomain2400.toString());
          scope.setTag('app.domain_900', state.defaultDomain900.toString());
          scope.setTag(
            'app.max_cached_versions',
            state.maxCachedVersions.toString(),
          );
          scope.setTag(
            'has_bind_phrase',
            state.globalBindPhrase.isNotEmpty.toString(),
          );
          scope.setTag(
            'has_wifi_ssid',
            state.homeWifiSsid.isNotEmpty.toString(),
          );
        },
      );

      if (context.mounted && !dialogDismissed) {
        Navigator.pop(context); // Hide loading dialog

        final msg = id != SentryId.empty()
            ? 'Submitted! Event ID: ${id.toString().substring(0, 8)}…'
            : 'Report submitted successfully!';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    } catch (e) {
      if (context.mounted && !dialogDismissed) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 6),
          ),
        );
      }
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

  String _getDomainLabel2400(int value) {
    switch (value) {
      case 0:
        return 'ISM';
      case 1:
        return 'EU CE LBT';
      default:
        return 'Unknown';
    }
  }

  String _getDomainLabel900(int value) {
    switch (value) {
      case 0:
        return 'AU915';
      case 1:
        return 'FCC915';
      case 2:
        return 'EU868';
      case 3:
        return 'IN866';
      case 4:
        return 'AU433';
      case 5:
        return 'EU433';
      case 6:
        return 'US433';
      default:
        return 'Unknown';
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildEditDialogTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String currentValue,
    required Function(String) onSaved,
    bool isSecret = false,
    ValueNotifier<bool>? isVisibleNotifier,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSecret && isVisibleNotifier != null)
            IconButton(
              icon: Icon(
                isVisibleNotifier.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                size: 20,
              ),
              onPressed: () =>
                  isVisibleNotifier.value = !isVisibleNotifier.value,
            ),
          const Icon(Icons.edit, size: 20),
        ],
      ),
      onTap: () {
        final textController = TextEditingController(text: currentValue);
        bool obscureText = isSecret && !(isVisibleNotifier?.value ?? false);

        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Text('Edit $title'),
              content: TextField(
                controller: textController,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: 'Enter $title',
                  suffixIcon: isSecret
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      : null,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onSaved(textController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RecoveryStep extends StatelessWidget {
  const _RecoveryStep({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(height: 1.4))),
        ],
      ),
    );
  }
}
