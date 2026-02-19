import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/presentation/config_view_model.dart';
import '../../../flashing/presentation/flashing_controller.dart';

class HardwareStatusCard extends ConsumerWidget {
  const HardwareStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(configViewModelProvider);
    final flashingState = ref.watch(flashingControllerProvider);
    final selectedTarget = flashingState.selectedTarget;

    final viewModel = ref.watch(configViewModelProvider.notifier);
    final probeIp = viewModel.probeIp;
    final manualIp = viewModel.manualIp;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: configAsync.when(
          data: (config) {
            if (config == null) {
              return Center(
                child: Column(
                  children: [
                    if (probeIp != null) ...[
                      const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Device Offline',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ] else ...[
                      const CircularProgressIndicator.adaptive(),
                      const SizedBox(height: 16),
                      const Text(
                        'Searching for ELRS Device...',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                    const SizedBox(height: 16),
                    _IpDisplayRow(
                      ip: probeIp ?? '10.0.0.1',
                      onEdit: () => _showIpDialog(context, ref, manualIp),
                    ),
                  ],
                ),
              );
            }

            // Refined mismatch logic: Only trigger if both are known and different.
            final deviceTarget = config.target;
            final isMatched = selectedTarget != null &&
                deviceTarget != null &&
                deviceTarget != 'Unknown' &&
                selectedTarget.name == deviceTarget;

            final showMismatch = selectedTarget != null &&
                deviceTarget != null &&
                deviceTarget != 'Unknown' &&
                selectedTarget.name != deviceTarget;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        config.productName ?? 'Unknown Device',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => ref
                          .read(configViewModelProvider.notifier)
                          .fetchConfig(config.activeIp ?? '10.0.0.1'),
                    ),
                  ],
                ),
                _IpDisplayRow(
                  ip: config.activeIp ?? 'Unknown IP',
                  onEdit: () => _showIpDialog(context, ref, manualIp),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _InfoChip(
                      label: config.version,
                      icon: Icons.code,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(width: 8),
                    _InfoChip(
                      label: config.target ?? 'Unknown Target',
                      icon: Icons.track_changes,
                      color: Colors.indigo,
                    ),
                    const Spacer(),
                    if (showMismatch)
                      const _MatchStatusIndicator(isMatched: false)
                    else if (isMatched)
                      const _MatchStatusIndicator(isMatched: true),
                  ],
                ),
              ],
            );
          },
          loading: () => const _LoadingState(),
          error: (err, stack) => _ErrorState(
            error: err.toString(),
            onRetry: () => ref
                .read(configViewModelProvider.notifier)
                .fetchConfig(probeIp ?? '10.0.0.1'),
          ),
        ),
      ),
    );
  }

  void _showIpDialog(BuildContext context, WidgetRef ref, String? currentIp) {
    final controller = TextEditingController(text: currentIp ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manual IP Override'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'e.g. 192.168.1.50',
            labelText: 'Device IP Address',
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(configViewModelProvider.notifier).setManualIp(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}

class _IpDisplayRow extends StatelessWidget {
  final String ip;
  final VoidCallback onEdit;

  const _IpDisplayRow({required this.ip, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lan, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          'IP: $ip',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: onEdit,
          child: Icon(Icons.edit, size: 14, color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _InfoChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchStatusIndicator extends StatelessWidget {
  final bool isMatched;

  const _MatchStatusIndicator({required this.isMatched});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isMatched ? Icons.check_circle : Icons.warning_amber_rounded,
          color: isMatched ? Colors.green : Colors.orange,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          isMatched ? 'Matched' : 'Mismatch',
          style: TextStyle(
            color: isMatched ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              height: 24,
              color: Colors.grey.withOpacity(0.3),
            ),
            const Icon(Icons.refresh, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(width: 80, height: 24, color: Colors.grey.withOpacity(0.3)),
            const SizedBox(width: 8),
            Container(width: 120, height: 24, color: Colors.grey.withOpacity(0.3)),
          ],
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorState({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.red),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
