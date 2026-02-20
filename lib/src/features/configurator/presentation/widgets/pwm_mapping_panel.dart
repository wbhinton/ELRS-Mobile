import 'package:flutter/material.dart';
import '../../../config/domain/elrs_mappings.dart';

/// A widget that renders a list of ExpansionTiles for each PWM pin.
/// It dynamically hides or disables specific fields (like failsafe/invert)
/// if the pin mode is set to a Serial protocol.
class PwmMappingPanel extends StatelessWidget {
  final List<dynamic> pwmArray;
  final Function(int index, Map<String, dynamic> updatedPin) onPinUpdated;

  const PwmMappingPanel({
    super.key,
    required this.pwmArray,
    required this.onPinUpdated,
  });

  @override
  Widget build(BuildContext context) {
    if (pwmArray.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PWM / Output Mapping',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...List.generate(pwmArray.length, (index) {
          final pinConfig = pwmArray[index] as Map<String, dynamic>;
          return _PwmPinTile(
            pinIndex: index,
            pinConfig: pinConfig,
            onChanged: (updatedPin) => onPinUpdated(index, updatedPin),
          );
        }),
      ],
    );
  }
}

class _PwmPinTile extends StatelessWidget {
  final int pinIndex;
  final Map<String, dynamic> pinConfig;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const _PwmPinTile({
    required this.pinIndex,
    required this.pinConfig,
    required this.onChanged,
  });

  bool get _isSerialMode {
    final mode = pinConfig['mode'] as int?;
    // 8: Serial TX, 9: Serial RX
    return mode == 8 || mode == 9;
  }

  void _updateField(String key, dynamic value) {
    if (value == null) return;
    
    final updated = Map<String, dynamic>.from(pinConfig);
    updated[key] = value;
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    // ELRS Input Channels are generally mapped 0-15 physically representing CH1-CH16
    final inputChannel = pinConfig['input'] as int? ?? 0;
    final mode = pinConfig['mode'] as int? ?? 0;
    final failsafe = pinConfig['failsafe'] as int? ?? 1500;
    final invert = pinConfig['invert'] as bool? ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      color: const Color(0xFF1E1E1E),
      child: ExpansionTile(
        title: Text('Pin ${pinIndex + 1}'),
        subtitle: Text(
          'CH${inputChannel + 1} • ${ElrsMappings.getMapping(ElrsMappings.pwmModes, mode, fallback: 'Unknown')}',
          style: const TextStyle(color: Colors.grey),
        ),
        childrenPadding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Input Channel',
                    border: OutlineInputBorder(),
                  ),
                  value: inputChannel,
                  items: List.generate(16, (i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Text('CH${i + 1}'),
                    );
                  }),
                  onChanged: (val) => _updateField('input', val),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Output Mode',
                    border: OutlineInputBorder(),
                  ),
                  value: ElrsMappings.pwmModes.containsKey(mode) ? mode : null,
                  items: ElrsMappings.pwmModes.entries.map((e) {
                    return DropdownMenuItem(
                      value: e.key,
                      child: Text(e.value),
                    );
                  }).toList(),
                  onChanged: (val) => _updateField('mode', val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Conditionally render Failsafe and Invert depending on Serial Mode
          if (!_isSerialMode) ...[
            TextFormField(
              initialValue: failsafe.toString(),
              decoration: const InputDecoration(
                labelText: 'Failsafe Position (us)',
                border: OutlineInputBorder(),
                helperText: 'Usually 988 to 2012',
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                final intVal = int.tryParse(val);
                if (intVal != null) {
                  _updateField('failsafe', intVal);
                }
              },
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Invert Signal'),
              value: invert,
              onChanged: (val) => _updateField('invert', val),
              contentPadding: EdgeInsets.zero,
            ),
          ] else ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Failsafe and Invert are disabled for Serial modes.',
                style: TextStyle(color: Colors.orange, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
