import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/targets_provider.dart';
import '../domain/target_definition.dart';
import 'flashing_controller.dart';
import '../../settings/presentation/settings_controller.dart';

part 'target_selectors.g.dart';

@riverpod
List<String> availableDeviceTypes(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  final expertMode = ref.watch(settingsControllerProvider.select((s) => s.expertMode));

  return targetsValue.when(
    data: (targets) {
      final types = targets
          .where((t) => expertMode || t.platform != 'stm32')
          .map((t) => t.deviceType)
          .toSet()
          .toList();
      types.sort();
      return types;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
List<String> availableVendors(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  final selectedDeviceType = ref.watch(
    flashingControllerProvider.select((s) => s.selectedDeviceType),
  );
  final expertMode = ref.watch(settingsControllerProvider.select((s) => s.expertMode));

  if (selectedDeviceType == null) return [];

  return targetsValue.when(
    data: (targets) {
      final vendors = targets
          .where((t) => t.deviceType == selectedDeviceType && (expertMode || t.platform != 'stm32'))
          .map((t) => t.vendor)
          .toSet()
          .toList();
      vendors.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      return vendors;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
List<String> availableFrequencies(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  final selectedDeviceType = ref.watch(
    flashingControllerProvider.select((s) => s.selectedDeviceType),
  );
  final selectedVendor = ref.watch(
    flashingControllerProvider.select((s) => s.selectedVendor),
  );
  final expertMode = ref.watch(settingsControllerProvider.select((s) => s.expertMode));

  if (selectedDeviceType == null || selectedVendor == null) return [];

  return targetsValue.when(
    data: (targets) {
      final freqs = targets
          .where(
            (t) =>
                t.deviceType == selectedDeviceType &&
                t.vendor == selectedVendor &&
                (expertMode || t.platform != 'stm32'),
          )
          .map((t) => t.frequencyType)
          .toSet()
          .toList();
      freqs.sort();
      return freqs;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
List<TargetDefinition> availableTargetsList(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  final selectedDeviceType = ref.watch(
    flashingControllerProvider.select((s) => s.selectedDeviceType),
  );
  final selectedVendor = ref.watch(
    flashingControllerProvider.select((s) => s.selectedVendor),
  );
  final selectedFrequency = ref.watch(
    flashingControllerProvider.select((s) => s.selectedFrequency),
  );
  final expertMode = ref.watch(settingsControllerProvider.select((s) => s.expertMode));

  if (selectedDeviceType == null || selectedVendor == null || selectedFrequency == null) {
    return [];
  }

  return targetsValue.when(
    data: (targets) {
      final devices = targets
          .where(
            (t) =>
                t.deviceType == selectedDeviceType &&
                t.vendor == selectedVendor &&
                t.frequencyType == selectedFrequency &&
                (expertMode || t.platform != 'stm32'),
          )
          .toList();

      devices.sort((a, b) => a.name.compareTo(b.name));
      return devices;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
