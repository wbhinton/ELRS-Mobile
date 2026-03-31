import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/domain/elrs_mappings.dart';
import '../../../config/domain/runtime_config_model.dart';
import '../../../config/presentation/device_editor_view_model.dart';

/// A card rendering General Options and Binding configuration fields.
///
/// Watches [deviceEditorProvider] for the current draft [RuntimeConfig] and
/// dispatches mutations back through the notifier.  Field visibility is
/// controlled by [ElrsSettings.moduleType] ('TX' or 'RX') and the device's
/// frequency band (900 MHz vs 2.4 GHz).
class GeneralOptionsCard extends ConsumerStatefulWidget {
  const GeneralOptionsCard({super.key});

  @override
  ConsumerState<GeneralOptionsCard> createState() =>
      _GeneralOptionsCardState();
}

class _GeneralOptionsCardState extends ConsumerState<GeneralOptionsCard> {
  final _modelIdController = TextEditingController();

  // Last value we pushed into the controller from state, so user typing
  // doesn't get overwritten on every rebuild.
  int? _controllerSyncedValue;

  @override
  void dispose() {
    _modelIdController.dispose();
    super.dispose();
  }

  /// Schedules a controller text update for AFTER the current frame so we
  /// never mutate a TextEditingController during build (which fires
  /// notifyListeners → setState on the TextField → red-screen assertion).
  void _scheduleControllerSync(int modelId) {
    if (_controllerSyncedValue == modelId) return;
    _controllerSyncedValue = modelId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _modelIdController.text != modelId.toString()) {
        _modelIdController.text = modelId.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final runtimeConfig = ref.watch(deviceEditorProvider);

    if (runtimeConfig == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final config = runtimeConfig.config;
    final options = runtimeConfig.options;
    final settings = runtimeConfig.settings;
    final notifier = ref.read(deviceEditorProvider.notifier);

    final isRx = settings.moduleType == 'RX' || (runtimeConfig.target?.toUpperCase().contains('RX') == true);
    final isTx = settings.moduleType == 'TX' || (runtimeConfig.target?.toUpperCase().contains('TX') == true);

    // Regulatory domain list depends on the device's frequency band.
    final domainMap = runtimeConfig.frequencyBand == 2400
        ? ElrsMappings.domains2400
        : ElrsMappings.domains;
    final currentDomain = options.domain;

    // Model Match: modelId == 255 means "disabled / all models".
    final rawModelId = config.modelId ?? 255;
    final modelMatchEnabled = rawModelId != 255;
    // Safe sync: scheduled post-frame to avoid setState-during-build.
    if (modelMatchEnabled) _scheduleControllerSync(rawModelId);

    final theme = Theme.of(context);
    const fieldSpacing = SizedBox(height: 14);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Options',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ── Regulatory Domain (All) ──────────────────────────────────
            DropdownButtonFormField<int>(
              value: domainMap.containsKey(currentDomain) ? currentDomain : null,
              decoration: const InputDecoration(
                labelText: 'Regulatory Domain',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              items: domainMap.entries
                  .map((e) =>
                      DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (val) {
                if (val != null) notifier.updateOption('domain', val);
              },
            ),
            fieldSpacing,

            // ── Binding Storage (All) ────────────────────────────────────
            DropdownButtonFormField<int>(
              initialValue: ElrsMappings.vbind.containsKey(config.vbind)
                  ? config.vbind
                  : null,
              decoration: const InputDecoration(
                labelText: 'Binding Storage',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              items: ElrsMappings.vbind.entries
                  .map((e) =>
                      DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (val) {
                if (val != null) notifier.updateConfigValue('vbind', val);
              },
            ),
            fieldSpacing,

            // ── Model Match (All) ────────────────────────────────────────
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Model Match'),
              subtitle: Text(
                modelMatchEnabled
                    ? 'Model ID: $rawModelId'
                    : 'Disabled — links to all models',
              ),
              value: modelMatchEnabled,
              onChanged: (val) {
                if (val) {
                  // Enable — reset to model 0 and show the number field.
                  // This runs in a user-gesture callback (not during build),
                  // so direct controller mutation is safe here.
                  _controllerSyncedValue = 0;
                  _modelIdController.text = '0';
                  notifier.updateConfigValue('modelid', 0);
                } else {
                  // Disable — sentinel value 255.
                  _modelIdController.clear();
                  _controllerSyncedValue = null;
                  notifier.updateConfigValue('modelid', 255);
                }
              },
            ),
            if (modelMatchEnabled) ...[
              const SizedBox(height: 4),
              TextFormField(
                controller: _modelIdController,
                decoration: const InputDecoration(
                  labelText: 'Model ID (0–63)',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _MaxValueFormatter(max: 63),
                ],
                onChanged: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    _controllerSyncedValue = parsed;
                    notifier.updateConfigValue('modelid', parsed);
                  }
                },
              ),
              fieldSpacing,
            ],

            // ── Lock on First Connection (RX Only) ───────────────────────
            if (isRx) ...[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Lock on First Connection'),
                subtitle: const Text('Binds permanently to first TX seen'),
                value: options.lockOnFirstConnection ?? false,
                onChanged: (val) =>
                    notifier.updateOption('lock-on-first-connection', val),
              ),

              // ── Force Telemetry Off (RX Only) ──────────────────────────
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Force Telemetry Off'),
                value: config.forceTlm ?? false,
                onChanged: (val) =>
                    notifier.updateConfigValue('force-tlm', val),
              ),
            ],

            // ── TLM Report Interval (TX Only) ────────────────────────────
            if (isTx) ...[
              TextFormField(
                key: ValueKey('tlm_interval_${options.tlmInterval}'),
                initialValue: options.tlmInterval?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'TLM Report Interval',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    notifier.updateOption('tlm-interval', parsed);
                  }
                },
              ),
              fieldSpacing,

              // ── Fan Runtime (TX Only) ──────────────────────────────────
              TextFormField(
                key: ValueKey('fan_runtime_${options.fanRuntime}'),
                initialValue: options.fanRuntime?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'Fan Runtime',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    notifier.updateOption('fan-runtime', parsed);
                  }
                },
              ),
              fieldSpacing,
            ],
          ],
        ),
      ),
    );
  }
}

/// Input formatter that silently rejects values exceeding [max].
class _MaxValueFormatter extends TextInputFormatter {
  const _MaxValueFormatter({required this.max});
  final int max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final val = int.tryParse(newValue.text);
    if (val == null || val > max) return oldValue;
    return newValue;
  }
}
