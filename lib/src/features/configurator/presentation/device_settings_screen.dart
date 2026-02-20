import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/domain/runtime_config_model.dart';
import '../../config/presentation/config_view_model.dart';
import '../../config/presentation/device_editor_view_model.dart';
import '../../config/domain/elrs_mappings.dart';

class DeviceSettingsScreen extends ConsumerStatefulWidget {
  const DeviceSettingsScreen({super.key});

  @override
  ConsumerState<DeviceSettingsScreen> createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends ConsumerState<DeviceSettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the editor with current config data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final configAsync = ref.read(configViewModelProvider);
      if (configAsync.hasValue && configAsync.value != null) {
        ref.read(deviceEditorProvider.notifier).initialize(configAsync.value!);
      }
    });
  }

  void _handleSave(BuildContext context, String ip) async {
    final editor = ref.read(deviceEditorProvider.notifier);
    final service = ref.read(deviceConfigServiceProvider);

    try {
      final success = await editor.saveChanges(
        ip,
        service.saveOptions,
        service.saveConfig,
        service.reboot,
      );

      if (success && mounted) {
        _showReconnectingOverlay(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save config: $e')),
        );
      }
    }
  }

  void _showReconnectingOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _ReconnectingOverlay(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(configViewModelProvider);
    final draftState = ref.watch(deviceEditorProvider);
    final editor = ref.watch(deviceEditorProvider.notifier);
    final isSaving = editor.isSaving;
    final hasChanges = editor.hasChanges;
    final ip = ref.read(configViewModelProvider.notifier).probeIp ?? '10.0.0.1';

    return DefaultTabController(
      length: 2, // Info, General
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Device Configuration'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'General'),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: isSaving
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : ElevatedButton.icon(
                      onPressed: hasChanges ? () => _handleSave(context, ip) : null,
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasChanges ? const Color(0xFF00E5FF) : Colors.grey,
                        foregroundColor: hasChanges ? Colors.black : Colors.white54,
                      ),
                    ),
            ),
          ],
        ),
        body: configAsync.when(
          data: (baseConfig) {
            if (baseConfig == null) {
              return const Center(child: Text('Device Offline or Disconnected.'));
            }
            if (draftState == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              children: [
                _InfoTab(config: draftState),
                _GeneralTab(draft: draftState, editor: editor),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  final RuntimeConfig config;
  const _InfoTab({required this.config});

  @override
  Widget build(BuildContext context) {
    // Determine the product name from hardware or root
    final productName = config.productName ?? config.config['hardware']?['name'] ?? 'Unknown';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoTile('Product Name', productName),
        _buildInfoTile('Firmware Version', config.version),
      ],
    );
  }

  Widget _buildInfoTile(String title, dynamic subtitle) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle.toString()),
    );
  }
}

class _GeneralTab extends StatelessWidget {
  final RuntimeConfig draft;
  final DeviceEditorViewModel editor;

  const _GeneralTab({required this.draft, required this.editor});

  @override
  Widget build(BuildContext context) {
    final settings = draft.settings;
    final options = draft.options;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Hardware Setup', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        // Regulatory Domain
        if (settings.containsKey('domain'))
          _buildDropdown(
            title: 'Regulatory Domain',
            value: settings['domain'],
            options: ElrsMappings.domains,
            onChanged: (val) => editor.updateSetting('domain', val),
          ),

        // UID Binding (Volatile, Persistent, etc)
        if (settings.containsKey('vbind'))
          _buildDropdown(
            title: 'Binding Mode (vbind)',
            value: settings['vbind'],
            options: ElrsMappings.vbind,
            onChanged: (val) => editor.updateSetting('vbind', val),
          ),

        // Serial Protocol
        if (settings.containsKey('serialProtocol'))
          _buildDropdown(
            title: 'Serial Protocol',
            value: settings['serialProtocol'],
            options: ElrsMappings.serialProtocols,
            onChanged: (val) => editor.updateSetting('serialProtocol', val),
          ),

        // TX/RX specific options
        if (settings.containsKey('uartBaud'))
          _buildTextInput(
            title: 'UART Baud Rate',
            value: settings['uartBaud'].toString(),
            onChanged: (val) => editor.updateSetting('uartBaud', int.tryParse(val) ?? settings['uartBaud']),
            isNumber: true,
          ),

        const Divider(height: 32),
        const Text('Wi-Fi Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        if (options.containsKey('wifi-ssid'))
          _buildTextInput(
            title: 'Home WiFi SSID',
            value: options['wifi-ssid'],
            onChanged: (val) => editor.updateOption('wifi-ssid', val),
          ),

        if (options.containsKey('wifi-password'))
          _buildTextInput(
            title: 'Home WiFi Password',
            value: options['wifi-password'],
            onChanged: (val) => editor.updateOption('wifi-password', val),
            obscure: true,
          ),
      ],
    );
  }

  Widget _buildDropdown({
    required String title,
    required int value,
    required Map<int, String> options,
    required ValueChanged<int?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
        value: options.containsKey(value) ? value : null,
        items: options.entries.map((entry) {
          return DropdownMenuItem<int>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextInput({
    required String title,
    required String value,
    required ValueChanged<String> onChanged,
    bool obscure = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
        obscureText: obscure,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        onChanged: onChanged,
      ),
    );
  }
}

class _ReconnectingOverlay extends StatefulWidget {
  const _ReconnectingOverlay();

  @override
  State<_ReconnectingOverlay> createState() => _ReconnectingOverlayState();
}

class _ReconnectingOverlayState extends State<_ReconnectingOverlay> {
  int _countdown = 10;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() async {
    while (_countdown > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _countdown--);
      }
    }
    if (mounted) {
      // Return to Dashboard or force a network refresh
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Color(0xFF00E5FF)),
            const SizedBox(height: 24),
            Text(
              'Saving & Rebooting',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Reconnecting in $_countdown...',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
