import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'firmware_manager_controller.dart';
import '../../settings/presentation/settings_controller.dart';

class FirmwareManagerScreen extends HookConsumerWidget {
  const FirmwareManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(firmwareManagerControllerProvider);
    final controller = ref.read(firmwareManagerControllerProvider.notifier);
    final settings = ref.watch(settingsControllerProvider);

    useEffect(() {
      Future.microtask(() => controller.load());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firmware Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.load(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStorageHeader(context, state, settings.maxCachedVersions),
          if (state.errorMessage != null)
            Container(
              color: Colors.red.withValues(alpha: 0.1),
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: state.availableVersions.length,
                    itemBuilder: (context, index) {
                      final version = state.availableVersions[index];
                      final isCached = state.cachedVersions.contains(version);
                      final progress = state.downloadProgress[version];

                      return ListTile(
                        title: Text('Version $version'),
                        subtitle: isCached
                            ? const Text('Ready for offline use')
                            : null,
                        leading: Icon(
                          Icons.dns,
                          color: isCached ? Colors.green : Colors.grey,
                        ),
                        trailing: _buildTrailingAction(
                          context,
                          version,
                          isCached,
                          progress,
                          controller,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageHeader(
    BuildContext context,
    FirmwareManagerState state,
    int limit,
  ) {
    final usagePercent = (state.cachedVersions.length / limit).clamp(0.0, 1.0);
    Color barColor = Colors.blue;
    if (usagePercent >= 1.0) {
      barColor = Colors.red;
    } else if (usagePercent > 0.8) {
      barColor = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Storage Used: ${state.cacheSizeMb.toStringAsFixed(1)} MB',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${state.cachedVersions.length} / $limit Versions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: state.cachedVersions.length >= limit
                      ? Colors.red
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: usagePercent,
            color: barColor,
            backgroundColor: Colors.grey.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingAction(
    BuildContext context,
    String version,
    bool isCached,
    double? progress,
    FirmwareManagerController controller,
  ) {
    if (progress != null) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          value: progress > 0 ? progress : null,
          strokeWidth: 2,
        ),
      );
    }

    if (isCached) {
      return IconButton(
        icon: const Icon(Icons.delete, color: Colors.grey),
        onPressed: () => controller.deleteVersion(version),
      );
    }

    return IconButton(
      icon: const Icon(Icons.cloud_download, color: Colors.blue),
      onPressed: () => controller.downloadVersion(version),
    );
  }
}
