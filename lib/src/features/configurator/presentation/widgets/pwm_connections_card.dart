import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/domain/elrs_mappings.dart';
import '../../../config/presentation/device_editor_view_model.dart';

/// A card that renders a collapsible row of controls for each PWM pin.
///
/// Only shown when [ElrsConfig.pwm] is non-empty.
///
/// Each pin's configuration is stored as a single packed [int] which this card
/// decodes for display and re-encodes on every user change.
class PwmConnectionsCard extends ConsumerWidget {
  const PwmConnectionsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runtimeConfig = ref.watch(deviceEditorProvider);
    if (runtimeConfig == null) return const SizedBox.shrink();

    final pwmList = runtimeConfig.config.pwm;
    if (pwmList.isEmpty) return const SizedBox.shrink();

    final notifier = ref.read(deviceEditorProvider.notifier);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PWM Connections',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            ...pwmList.asMap().entries.map((entry) {
              final index = entry.key;
              final rawItem = entry.value;

              if (rawItem is int) {
                return _V3PwmRow(
                  index: index,
                  channel: rawItem,
                  onChanged: (updated) => notifier.updatePwmPin(index, updated),
                );
              }

              if (rawItem is Map) {
                final pinData = Map<String, dynamic>.from(rawItem);
                return _V4PwmRow(
                  index: index,
                  pinData: pinData,
                  onChanged: (updated) => notifier.updatePwmPin(index, updated),
                );
              }

              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// V3 PWM Row (Standard Channel Mapping)
// ─────────────────────────────────────────────────────────────────────────────

class _V3PwmRow extends StatelessWidget {
  const _V3PwmRow({
    required this.index,
    required this.channel,
    required this.onChanged,
  });

  final int index;
  final int channel;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index > 0) const Divider(height: 1, thickness: 0.5),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          leading: _PinChip(pin: index),
          title: DropdownButtonFormField<int>(
            value: channel >= 0 && channel < 16 ? channel : null,
            decoration: InputDecoration(
              labelText: 'Output Pin ${index + 1}',
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            items: List.generate(
              16,
              (i) => DropdownMenuItem(value: i, child: Text('CH${i + 1}')),
            ),
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// V4 PWM Row (Bit-packed Configuration)
// ─────────────────────────────────────────────────────────────────────────────

class _V4PwmRow extends StatefulWidget {
  const _V4PwmRow({
    required this.index,
    required this.pinData,
    required this.onChanged,
  });

  final int index;
  final Map<String, dynamic> pinData;
  final void Function(Map<String, dynamic>) onChanged;

  @override
  State<_V4PwmRow> createState() => _V4PwmRowState();
}

class _V4PwmRowState extends State<_V4PwmRow> {
  late final TextEditingController _failsafeController;

  // ── Bitwise helpers ────────────────────────────────────────────────────────

  static _PwmDecoded _decode(int packed) => _PwmDecoded(
        failsafe: (packed & 2047) + 476,
        channel: (packed >> 11) & 15,
        inverted: (packed >> 15) & 1,
        mode: (packed >> 16) & 15,
      );

  static int _encode({
    required int mode,
    required int inverted,
    required int channel,
    required int failsafe,
  }) =>
      (mode << 16) | (inverted << 15) | (channel << 11) | (failsafe - 476);

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    final packed = widget.pinData['config'] as int? ?? 0;
    _failsafeController = TextEditingController(
      text: _decode(packed).failsafe.toString(),
    );
  }

  @override
  void dispose() {
    _failsafeController.dispose();
    super.dispose();
  }

  // ── Save ───────────────────────────────────────────────────────────────────

  void _save(_PwmDecoded current,
      {int? mode, int? inverted, int? channel, int? failsafe}) {
    final newPacked = _encode(
      mode: mode ?? current.mode,
      inverted: inverted ?? current.inverted,
      channel: channel ?? current.channel,
      failsafe: failsafe ?? current.failsafe,
    );
    widget.onChanged({
      'config': newPacked,
      'pin': widget.pinData['pin'] ?? widget.index,
      'features': widget.pinData['features'] ?? 0,
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final packed = widget.pinData['config'] as int? ?? 0;
    final pin = widget.pinData['pin'] as int? ?? widget.index;
    final decoded = _decode(packed);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.index > 0) const Divider(height: 1, thickness: 0.5),

        ExpansionTile(
          // Give horizontal room so the leading chip and text aren't
          // flush against the card edge.
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          // Top padding (8 pt) stops the floating label on the first field
          // from being clipped against the expansion seam.
          childrenPadding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          leading: _PinChip(pin: pin),
          title: Text(
            ElrsMappings.pwmModes[decoded.mode] ?? 'Unknown',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          subtitle: Text(
            'Ch ${decoded.channel + 1}'
            '${decoded.inverted == 1 ? '  ·  Inverted' : ''}',
            style: theme.textTheme.bodySmall,
          ),
          children: [
            // ── Row 1: Mode + Channel ──────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: ElrsMappings.pwmModes.containsKey(decoded.mode)
                        ? decoded.mode
                        : null,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Mode',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: ElrsMappings.pwmModes.entries
                        .map((e) => DropdownMenuItem(
                            value: e.key, child: Text(e.value)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) _save(decoded, mode: val);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: decoded.channel,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Channel',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: List.generate(
                      16,
                      (i) => DropdownMenuItem(
                          value: i, child: Text('Ch ${i + 1}')),
                    ),
                    onChanged: (val) {
                      if (val != null) _save(decoded, channel: val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Row 2: Failsafe + Inverted toggle ─────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _failsafeController,
                    decoration: const InputDecoration(
                      labelText: 'Failsafe (µs)',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      helperText: '476 – 2523',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (val) {
                      final parsed = int.tryParse(val);
                      if (parsed != null &&
                          parsed >= 476 &&
                          parsed <= 2523) {
                        _save(decoded, failsafe: parsed);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Switch(
                      value: decoded.inverted == 1,
                      onChanged: (val) =>
                          _save(decoded, inverted: val ? 1 : 0),
                    ),
                    Text('Inverted', style: theme.textTheme.labelSmall),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pin number badge used in the ExpansionTile leading slot
// ─────────────────────────────────────────────────────────────────────────────

class _PinChip extends StatelessWidget {
  const _PinChip({required this.pin});

  final int pin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        '$pin',
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Decoded PWM value object
// ─────────────────────────────────────────────────────────────────────────────

class _PwmDecoded {
  const _PwmDecoded({
    required this.failsafe,
    required this.channel,
    required this.inverted,
    required this.mode,
  });

  final int failsafe;
  final int channel;
  final int inverted;
  final int mode;
}
