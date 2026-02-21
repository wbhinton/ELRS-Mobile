import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/domain/runtime_config_model.dart';
import '../../config/presentation/config_view_model.dart';
import '../../config/presentation/device_editor_view_model.dart';
import '../../config/domain/elrs_mappings.dart';
import 'widgets/pwm_mapping_panel.dart';

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
        body: Container(
        child: () {
          // If we have data (even if currently loading/error), show the content
          if (configAsync.hasValue) {
            final baseConfig = configAsync.value;
            
            if (baseConfig == null) {
              return const Center(child: Text('Device Offline or Disconnected.'));
            }
            
            if (draftState == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                Column(
                  children: [
                    if (configAsync.isRefreshing || configAsync.isLoading)
                      const LinearProgressIndicator(
                        minHeight: 2,
                        backgroundColor: Colors.transparent,
                      ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _InfoTab(config: draftState),
                          _GeneralTab(draft: draftState, editor: editor),
                        ],
                      ),
                    ),
                  ],
                ),
                if (configAsync.isRefreshing || configAsync.isLoading)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white70),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Reconnecting...',
                            style: TextStyle(color: Colors.white70, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }

          // Fallback for initial load or absolute disconnection
          return configAsync.when(
            data: (_) => const Center(child: Text('Device Offline.')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          );
        }(),
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
    // Determine the product name from settings or root
    final productName = config.settings.productName ?? config.productName ?? 'Unknown';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoTile('Product Name', productName),
        _buildInfoTile('Firmware Version', config.version),
        if (config.target != null)
          _buildInfoTile('Target', config.target),
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
    final options = draft.options;
    final config = draft.config;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Hardware Setup', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        // Regulatory Domain
        if (options.domain != null)
          _buildDropdown(
            title: 'Regulatory Domain',
            value: options.domain!,
            options: ElrsMappings.domains,
            onChanged: (val) => editor.updateOption('domain', val),
          ),

        // Binding Mode
        if (config.vbind != null)
          _buildDropdown(
            title: 'Binding Mode (vbind)',
            value: config.vbind!,
            options: ElrsMappings.vbind,
            onChanged: (val) => editor.updateConfigValue('vbind', val),
          ),

        // Serial Protocol
        if (config.serialProtocol != null)
          _buildDropdown(
            title: 'Serial Protocol',
            value: config.serialProtocol!,
            options: ElrsMappings.serialProtocols,
            onChanged: (val) => editor.updateConfigValue('serial-protocol', val),
          ),

        // Model ID
        if (config.modelId != null)
          _buildTextInput(
            title: 'Model ID',
            value: config.modelId.toString(),
            onChanged: (val) => editor.updateConfigValue('modelid', int.tryParse(val) ?? config.modelId),
            isNumber: true,
          ),

        // Receiver UART Baud Rate
        if (options.rcvrUartBaud != null)
          _buildTextInput(
            title: 'UART Baud Rate',
            value: options.rcvrUartBaud.toString(),
            onChanged: (val) => editor.updateOption('rcvr-uart-baud', int.tryParse(val) ?? options.rcvrUartBaud),
            isNumber: true,
          ),

        const Divider(height: 32),
        const Text('Wi-Fi Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        if (options.wifiSsid != null)
          _buildTextInput(
            title: 'Home WiFi SSID',
            value: options.wifiSsid!,
            onChanged: (val) => editor.updateOption('wifi-ssid', val),
          ),

        if (options.wifiPassword != null)
          _buildTextInput(
            title: 'Home WiFi Password',
            value: options.wifiPassword!,
            onChanged: (val) => editor.updateOption('wifi-password', val),
            obscure: true,
          ),
          
        if (config.pwm.isNotEmpty) ...[
          const Divider(height: 32),
          PwmMappingPanel(
            pwmArray: config.pwm,
            onPinUpdated: editor.updatePwmPin,
          ),
        ],
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
