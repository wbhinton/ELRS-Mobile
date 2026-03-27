import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../data/releases_repository.dart';
import '../../../../core/storage/firmware_cache_service.dart';
import '../flashing_controller.dart';

class VersionSelector extends HookConsumerWidget {
  const VersionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final releasesAsync = ref.watch(releasesProvider);
    final selectedVersion = ref.watch(
      flashingControllerProvider.select((s) => s.selectedVersion),
    );
    final selectedTarget = ref.watch(
      flashingControllerProvider.select((s) => s.selectedTarget),
    );
    final controller = ref.read(flashingControllerProvider.notifier);

    // Auto-select latest on data load if nothing selected
    final cachedVersions = useState<List<String>>([]);

    Future<void> refreshCache() async {
      final cacheService = ref.read(firmwareCacheServiceProvider);
      cachedVersions.value = await cacheService.getCachedVersions();
    }

    useEffect(() {
      refreshCache();

      if (releasesAsync.hasValue &&
          selectedVersion == null &&
          releasesAsync.value!.isNotEmpty) {
        // Defer update to avoid build cycle
        Future.microtask(
          () => controller.selectVersion(releasesAsync.value!.first),
        );
      }
      return null;
    }, [releasesAsync.hasValue]);

    if (cachedVersions.value.isEmpty && !releasesAsync.isLoading) {
      return OutlinedButton.icon(
        onPressed: () async {
          await context.push('/firmware_manager');
          await refreshCache();
        },
        icon: const Icon(Icons.download),
        label: const Text('No firmware downloaded. Go to Firmware Manager'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          foregroundColor: Colors.orange,
          side: const BorderSide(color: Colors.orange),
        ),
      );
    }

    return releasesAsync.when(
      data: (allVersions) {
        // Filter out versions that don't meet the target's min requirement
        // AND handle STM32 specific version caps (no v4+)
        final supportedVersions = cachedVersions.value.where((version) {
          final isStm32 = selectedTarget?.platform == 'stm32';
          if (isStm32 && version.startsWith('4.')) {
            return false;
          }
          return _isVersionSupported(version, selectedTarget?.minVersion);
        }).toList();

        // Sort versions (usually alphabetical/lexicographical works for SemVer if they have same length components)
        // ELRS versions are typically X.Y.Z
        supportedVersions.sort((a, b) => b.compareTo(a));

        if (supportedVersions.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.withAlpha(128)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Hardware requires v${selectedTarget?.minVersion} or newer.',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    await context.push('/firmware_manager');
                    await refreshCache();
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Download Compatible Firmware'),
                ),
              ],
            ),
          );
        }

        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Firmware Version',
            border: OutlineInputBorder(),
            helperText: 'Select the ELRS version to flash (>= 3.0.0)',
          ),
          value: supportedVersions.contains(selectedVersion)
              ? selectedVersion
              : null,
          items: supportedVersions.map((version) {
            return DropdownMenuItem(
              value: version,
              child: Row(
                children: [
                  Text(version),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.offline_pin,
                    size: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '(Cached)',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.selectVersion(value);
            }
          },
        );
      },
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (err, stack) => Text(
        'Error loading versions: $err',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

bool _isVersionSupported(String version, String? minVersion) {
  if (minVersion == null || minVersion.isEmpty) return true;
  // Strip 'v' prefixes if present
  final v1 = version.startsWith('v') ? version.substring(1) : version;
  final v2 = minVersion.startsWith('v') ? minVersion.substring(1) : minVersion;

  // Simple lexicographical compare works for ELRS standard versioning (e.g. 3.4.0 >= 3.3.0)
  return v1.compareTo(v2) >= 0;
}
