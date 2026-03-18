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
        // ONLY display versions present in cachedVersions.value
        final versions = allVersions
            .where((v) => cachedVersions.value.contains(v))
            .toList();

        if (versions.isEmpty) {
          // Fallback if the intersection is empty (should be caught by check above, but for safety)
          return OutlinedButton.icon(
            onPressed: () async {
              await context.push('/firmware_manager');
              await refreshCache();
            },
            icon: const Icon(Icons.download),
            label: const Text('No compatible firmware cached. Go to Manager'),
          );
        }

        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Firmware Version',
            border: OutlineInputBorder(),
            helperText: 'Select the ELRS version to flash (>= 3.0.0)',
          ),
          value: selectedVersion,
          items: versions.map((version) {
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
