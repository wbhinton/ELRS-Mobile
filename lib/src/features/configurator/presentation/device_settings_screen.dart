import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../../core/analytics/analytics_service.dart';
import '../../config/domain/runtime_config_model.dart';
import '../../config/presentation/config_view_model.dart';
import '../../config/presentation/device_editor_view_model.dart';
import '../../flashing/utils/firmware_assembler.dart';
import '../../settings/presentation/settings_controller.dart';
import 'widgets/general_options_card.dart';
import 'widgets/pwm_connections_card.dart';
import 'widgets/serial_io_card.dart';

/// The device configuration screen.
///
/// Default view: native Flutter UI ([_NativeConfigView]) built from
/// [deviceEditorProvider] draft state.
///
/// Expert Mode (toggled in Settings): an icon appears in the AppBar letting
/// the user switch to the legacy WebView ([_LegacyWebConfigView]) that loads
/// the on-device ExpressLRS WebUI directly.
class DeviceSettingsScreen extends ConsumerStatefulWidget {
  const DeviceSettingsScreen({super.key});

  @override
  ConsumerState<DeviceSettingsScreen> createState() =>
      _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends ConsumerState<DeviceSettingsScreen> {
  bool _showWebUi = false;

  @override
  Widget build(BuildContext context) {
    final expertMode =
        ref.watch(settingsControllerProvider.select((s) => s.expertMode));
    final configAsync = ref.watch(configViewModelProvider);

    // Watch draft state to rebuild when changes happen so the FAB can appear.
    ref.watch(deviceEditorProvider);
    final hasChanges = ref.read(deviceEditorProvider.notifier).hasChanges;
    final isSaving = ref.read(deviceEditorProvider.notifier).isSaving;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Configuration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (expertMode)
            IconButton(
              icon: Icon(_showWebUi ? Icons.tune_rounded : Icons.web_rounded),
              tooltip: _showWebUi ? 'Switch to Native UI' : 'Switch to Web UI',
              onPressed: () => setState(() => _showWebUi = !_showWebUi),
            ),
        ],
      ),
      body: configAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF00E5FF)),
        ),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Could not load device config:\n$e',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (config) {
          if (config == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off_rounded, size: 56),
                  SizedBox(height: 16),
                  Text('No device connected', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }

          // Expert mode: show legacy WebView when toggled.
          if (expertMode && _showWebUi) {
            return _LegacyWebConfigView(ip: config.activeIp ?? '10.0.0.1');
          }

          return const _NativeConfigView();
        },
      ),
      floatingActionButton: hasChanges && !_showWebUi && !isSaving
          ? FloatingActionButton.extended(
              onPressed: () async {
                final ip = ref.read(configViewModelProvider.notifier).probeIp ??
                    '10.0.0.1';
                final service = ref.read(deviceConfigServiceProvider);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Saving configuration...')),
                );

                try {
                  await ref.read(deviceEditorProvider.notifier).saveChanges(
                        ip,
                        service.saveOptions,
                        service.saveConfig,
                        service.reboot,
                      );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Saved successfully! Device is rebooting.')),
                    );
                    context.pop(); // Close screen on success
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to save config: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('Save & Reboot'),
            )
          : null,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Native UI — Tabbed Layout
// ─────────────────────────────────────────────────────────────────────────────

class _NativeConfigView extends HookConsumerWidget {
  const _NativeConfigView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(configViewModelProvider);

    // Initialise the draft editor the moment we have a live config.
    // The Future() wrapper is required: flutter_hooks runs useEffect inside
    // HookElement.didBuild(), which Riverpod still considers part of the
    // build phase. Calling notifier.initialize() there triggers Riverpod's
    // "Tried to modify a provider while the widget tree was building" guard.
    // Future() defers execution to the next event-loop iteration — after
    // Riverpod has exited its build window.
    useEffect(() {
      final config = configAsync.value;
      if (config != null && ref.read(deviceEditorProvider) == null) {
        Future(() {
          ref.read(deviceEditorProvider.notifier).initialize(config);
        });
      }
      return null;
    }, [configAsync.value]);

    final draft = ref.watch(deviceEditorProvider);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'General'),
              Tab(text: 'Hardware'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _GeneralTab(draft: draft),
                const _HardwareTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// General Tab
// ─────────────────────────────────────────────────────────────────────────────

class _GeneralTab extends ConsumerWidget {
  const _GeneralTab({required this.draft});

  final RuntimeConfig? draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (draft == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final settings = draft!.settings;
    final options = draft!.options;
    final notifier = ref.read(deviceEditorProvider.notifier);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Device Information (read-only) ───────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device Information',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    label: 'Product Name',
                    value: settings.productName ?? draft!.productName ?? 'Unknown Device',
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    label: 'Firmware Version',
                    value: settings.version ?? draft!.version,
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    label: 'Target',
                    value: settings.target ?? draft!.target ?? 'Unknown Target',
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    label: 'Module Type',
                    value: settings.moduleType ?? 
                           ((settings.target ?? draft!.target ?? '').toUpperCase().contains('TX') ? 'TX' : 
                           ((settings.target ?? draft!.target ?? '').toUpperCase().contains('RX') ? 'RX' : 'Unknown Type')),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Network & Binding ────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Network & Binding',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // WiFi SSID
                  TextFormField(
                    key: ValueKey('wifi_ssid_${options.wifiSsid}'),
                    initialValue: options.wifiSsid ?? '',
                    decoration: const InputDecoration(
                      labelText: 'WiFi SSID',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    onChanged: (value) =>
                        notifier.updateOption('wifi-ssid', value),
                  ),
                  const SizedBox(height: 14),

                  // WiFi Password
                  TextFormField(
                    key: ValueKey('wifi_pw_${options.wifiPassword}'),
                    initialValue: options.wifiPassword ?? '',
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'WiFi Password',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    onChanged: (value) =>
                        notifier.updateOption('wifi-password', value),
                  ),
                  const SizedBox(height: 14),

                  // Binding Phrase — converted to UID array on-change
                  _BindingPhraseField(
                    currentUid: options.uid,
                    notifier: notifier,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Configuration Cards ──────────────────────────────────────
          const GeneralOptionsCard(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// A read-only label + value pair used in the Device Information card.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

/// Binding phrase text field.
///
/// The ELRS device stores the binding phrase as a 6-byte UID array.
/// [FirmwareAssembler.generateUid] converts the human-readable string to that
/// array before dispatching the change to the editor draft.
class _BindingPhraseField extends StatefulWidget {
  const _BindingPhraseField({
    required this.currentUid,
    required this.notifier,
  });

  final List<int>? currentUid;
  final DeviceEditorViewModel notifier;

  @override
  State<_BindingPhraseField> createState() => _BindingPhraseFieldState();
}

class _BindingPhraseFieldState extends State<_BindingPhraseField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Formats a 6-byte UID list as uppercase colon-separated hex.
  /// Returns null when the UID is absent or all-zero (open binding).
  static String? _formatUid(List<int>? uid) {
    if (uid == null || uid.every((b) => b == 0)) return null;
    return uid
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uidHex = _formatUid(widget.currentUid);
    final isBound = uidHex != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Binding Phrase',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          onChanged: (value) {
            final uid = FirmwareAssembler.generateUid(value);
            widget.notifier.updateOption('uid', uid);
          },
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              isBound ? Icons.link_rounded : Icons.link_off_rounded,
              size: 14,
              color: isBound
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                isBound
                    ? 'Device UID: $uidHex'
                    : 'Open binding — no phrase set',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isBound
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  fontFamily: isBound ? 'monospace' : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Hardware Tab
// ─────────────────────────────────────────────────────────────────────────────

class _HardwareTab extends StatelessWidget {
  const _HardwareTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SerialIOCard(),
          SizedBox(height: 12),
          PwmConnectionsCard(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Legacy WebView
// ─────────────────────────────────────────────────────────────────────────────

class _LegacyWebConfigView extends ConsumerStatefulWidget {
  const _LegacyWebConfigView({required this.ip});

  final String ip;

  @override
  ConsumerState<_LegacyWebConfigView> createState() =>
      _LegacyWebConfigViewState();
}

class _LegacyWebConfigViewState extends ConsumerState<_LegacyWebConfigView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    ref.read(analyticsServiceProvider).trackEvent('Config Webview Opened', {
      'connection_type':
          widget.ip == '10.0.0.1' ? 'Access Point' : 'Home WiFi',
    });

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF121212))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.parse(request.url);
            if (uri.host == widget.ip) {
              return NavigationDecision.navigate;
            }
            debugPrint(
              'Blocked external navigation in Config WebView: ${request.url}',
            );
            return NavigationDecision.prevent;
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse('http://${widget.ip}/'));
  }

  Widget _buildWebView() {
    if (Platform.isAndroid) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: _controller.platform,
          displayWithHybridComposition: false,
        ),
      );
    }
    return WebViewWidget(controller: _controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildWebView(),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(color: Color(0xFF00E5FF)),
          ),
      ],
    );
  }
}
