import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/target_definition.dart';
import '../flashing_controller.dart';
import '../target_selectors.dart';

class TargetSelectionCard extends ConsumerWidget {
  const TargetSelectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceTypes = ref.watch(availableDeviceTypesProvider);
    final vendors = ref.watch(availableVendorsProvider);
    final frequencies = ref.watch(availableFrequenciesProvider);
    final devices = ref.watch(availableTargetsListProvider);

    final selectedDeviceType = ref.watch(
      flashingControllerProvider.select((s) => s.selectedDeviceType),
    );
    final selectedVendor = ref.watch(
      flashingControllerProvider.select((s) => s.selectedVendor),
    );
    final selectedFrequency = ref.watch(
      flashingControllerProvider.select((s) => s.selectedFrequency),
    );
    final selectedTarget = ref.watch(
      flashingControllerProvider.select((s) => s.selectedTarget),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.developer_board),
                SizedBox(width: 8),
                Text(
                  'Target Selection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 1. Device Type Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Device Type'),
              initialValue: selectedDeviceType,
              items: deviceTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                ref
                    .read(flashingControllerProvider.notifier)
                    .selectDeviceType(value);
              },
            ),
            const SizedBox(height: 16),

            // 2. Vendor Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Device Vendor'),
              initialValue: selectedVendor,
              items: vendors.map((vendor) {
                return DropdownMenuItem(value: vendor, child: Text(vendor));
              }).toList(),
              onChanged: selectedDeviceType == null
                  ? null
                  : (value) {
                      ref
                          .read(flashingControllerProvider.notifier)
                          .selectVendor(value);
                    },
            ),
            const SizedBox(height: 16),

            // 3. Frequency Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Regulatory & Frequency',
              ),
              initialValue: selectedFrequency,
              items: frequencies.map((freq) {
                return DropdownMenuItem(value: freq, child: Text(freq));
              }).toList(),
              onChanged: selectedVendor == null
                  ? null
                  : (value) {
                      ref
                          .read(flashingControllerProvider.notifier)
                          .selectFrequency(value);
                    },
            ),
            const SizedBox(height: 16),

            // 4. Device Target Dropdown
            DropdownButtonFormField<TargetDefinition>(
              decoration: const InputDecoration(labelText: 'Device Target'),
              initialValue: selectedTarget,
              items: selectedFrequency == null
                  ? []
                  : devices.map((device) {
                      return DropdownMenuItem(
                        value: device,
                        child: Text(
                          '${device.name} ${device.productCode != null ? "(${device.productCode})" : ""}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
              onChanged: selectedFrequency == null
                  ? null
                  : (value) {
                      ref
                          .read(flashingControllerProvider.notifier)
                          .selectTarget(value);
                    },
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }
}
