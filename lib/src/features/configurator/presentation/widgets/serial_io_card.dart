import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/domain/elrs_mappings.dart';
import '../../../config/domain/runtime_config_model.dart';
import '../../../config/presentation/device_editor_view_model.dart';

/// A card rendering Serial IO configuration fields.
///
/// Visibility: only shown when [ElrsSettings.moduleType] is 'TX' or 'RX'.
///
/// WebUI logic mirrored:
/// - Enabling AirPort Mode forces `serial-protocol` → 0 (CRSF) and sets
///   `is-airport` → true simultaneously.
/// - SBUS Failsafe is only surfaced when either serial protocol is SBUS
///   (index 1 in [ElrsMappings.serialProtocols]).
class SerialIOCard extends ConsumerWidget {
  const SerialIOCard({super.key});

  static const int _sbusProtocolIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runtimeConfig = ref.watch(deviceEditorProvider);
    if (runtimeConfig == null) return const SizedBox.shrink();

    final settings = runtimeConfig.settings;

    final isRx = settings.moduleType == 'RX' || (runtimeConfig.target?.toUpperCase().contains('RX') == true);
    final isTx = settings.moduleType == 'TX' || (runtimeConfig.target?.toUpperCase().contains('TX') == true);

    // Only render for recognised module types.
    if (!isRx && !isTx) return const SizedBox.shrink();

    final config = runtimeConfig.config;
    final options = runtimeConfig.options;
    final notifier = ref.read(deviceEditorProvider.notifier);

    final isAirport = options.isAirport ?? false;
    final serialProtocol = config.serialProtocol ?? 0;
    final serial1Protocol = config.serial1Protocol;

    // Show SBUS Failsafe only when at least one active protocol is SBUS.
    final showSbusFailsafe = serialProtocol == _sbusProtocolIndex ||
        serial1Protocol == _sbusProtocolIndex;

    final theme = Theme.of(context);
    const fieldSpacing = SizedBox(height: 14);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serial IO',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ── AirPort Mode (All) ───────────────────────────────────────
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('AirPort Mode'),
              subtitle: const Text('Enables long-range AirPort protocol'),
              value: isAirport,
              onChanged: (val) {
                notifier.updateOption('is-airport', val);
                if (val) {
                  // WebUI logic: enabling AirPort resets serial-protocol to
                  // CRSF (0) so the device uses the AirPort transport layer
                  // rather than a conflicting serial output protocol.
                  notifier.updateConfigValue('serial-protocol', 0);
                }
              },
            ),

            // ── AirPort UART Baud (TX only, visible when AirPort is on) ──
            if (isTx && isAirport) ...[
              fieldSpacing,
              TextFormField(
                key: ValueKey('airport_baud_${options.airportUartBaud}'),
                initialValue: options.airportUartBaud?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'AirPort UART Baud',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    notifier.updateOption('airport-uart-baud', parsed);
                  }
                },
              ),
            ],

            // ── Receiver Baud (RX Only) ──────────────────────────────────
            if (isRx) ...[
              fieldSpacing,
              TextFormField(
                key: ValueKey('rcvr_baud_${options.rcvrUartBaud}'),
                initialValue: options.rcvrUartBaud?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'Receiver Baud',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null) {
                    notifier.updateOption('rcvr-uart-baud', parsed);
                  }
                },
              ),
              fieldSpacing,

              // ── Primary Serial Protocol (RX Only) ─────────────────────
              DropdownButtonFormField<int>(
                value: ElrsMappings.serialProtocols.containsKey(serialProtocol)
                    ? serialProtocol
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Primary Serial Protocol',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: ElrsMappings.serialProtocols.entries
                    .map((e) =>
                        DropdownMenuItem(value: e.key, child: Text(e.value)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    notifier.updateConfigValue('serial-protocol', val);
                  }
                },
              ),
              fieldSpacing,

              // ── Secondary Serial Protocol (RX Only, if field is present) ─
              if (serial1Protocol != null) ...[
                DropdownButtonFormField<int>(
                  value:
                      ElrsMappings.serial1Protocols.containsKey(serial1Protocol)
                          ? serial1Protocol
                          : null,
                  decoration: const InputDecoration(
                    labelText: 'Secondary Serial Protocol',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: ElrsMappings.serial1Protocols.entries
                      .map((e) =>
                          DropdownMenuItem(value: e.key, child: Text(e.value)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      notifier.updateConfigValue('serial1-protocol', val);
                    }
                  },
                ),
                fieldSpacing,
              ],

              // ── SBUS Failsafe (RX Only, visible when SBUS is selected) ─
              if (showSbusFailsafe) ...[
                DropdownButtonFormField<int>(
                  value: ElrsMappings.sbusFailsafe.containsKey(config.sbusFailsafe)
                      ? config.sbusFailsafe
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'SBUS Failsafe',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: ElrsMappings.sbusFailsafe.entries
                      .map((e) =>
                          DropdownMenuItem(value: e.key, child: Text(e.value)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      notifier.updateConfigValue('sbus-failsafe', val);
                    }
                  },
                ),
                fieldSpacing,
              ],

              // ── DJI Permanently Armed (RX Only) ───────────────────────
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('DJI Permanently Armed'),
                subtitle: const Text('Keeps DJI goggles armed at all times'),
                value: options.djiPermanentlyArmed ?? false,
                onChanged: (val) =>
                    notifier.updateOption('dji-permanently-armed', val),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
