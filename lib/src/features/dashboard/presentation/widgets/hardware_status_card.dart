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
    final manualIp = viewModel.manualIp;

    final isConnected = configAsync.hasValue && configAsync.value != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isConnected ? 8 : 2,
      shadowColor: isConnected ? Colors.teal.withOpacity(0.5) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isConnected ? const BorderSide(color: Colors.teal, width: 1) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildStateContent(context, ref, configAsync, selectedTarget),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => _showIpDialog(context, ref, manualIp),
                  tooltip: 'Manual Connection',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateContent(
    BuildContext context, 
    WidgetRef ref, 
    AsyncValue configAsync,
    dynamic selectedTarget,
  ) {
    if (configAsync.isLoading) {
      return Row(
        key: const ValueKey('searching'),
        children: [
          _PulsingWifiIcon(),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Searching for ELRS Device...',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
        ],
      );
    }

    if (configAsync.hasValue && configAsync.value != null) {
      final config = configAsync.value!;
      
      final deviceTarget = config.target;
      final isMatched = selectedTarget != null &&
          deviceTarget != null &&
          deviceTarget != 'Unknown' &&
          selectedTarget.name == deviceTarget;

      final showMismatch = selectedTarget != null &&
          deviceTarget != null &&
          deviceTarget != 'Unknown' &&
          selectedTarget.name != deviceTarget;

      return Row(
        key: const ValueKey('connected'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, size: 32, color: Colors.teal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.productName ?? 'Unknown Device',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Connected: ${config.activeIp ?? 'Unknown IP'}',
                  style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _InfoChip(
                      label: config.version,
                      icon: Icons.code,
                      color: Colors.blueGrey,
                    ),
                    _InfoChip(
                      label: config.target ?? 'Unknown Target',
                      icon: Icons.track_changes,
                      color: Colors.indigo,
                    ),
                    if (showMismatch)
                      const _MatchStatusIndicator(isMatched: false)
                    else if (isMatched)
                      const _MatchStatusIndicator(isMatched: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Disconnected / Failed state
    return Row(
      key: const ValueKey('disconnected'),
      children: [
        const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No Device Found',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton.icon(
                onPressed: () {
                  ref.read(configViewModelProvider.notifier).fetchConfig('10.0.0.1'); 
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _showIpDialog(BuildContext context, WidgetRef ref, String? currentIp) {
    showDialog(
      context: context,
      builder: (context) => _ManualIpDialog(initialIp: currentIp, ref: ref),
    );
  }
}

class _PulsingWifiIcon extends StatefulWidget {
  @override
  _PulsingWifiIconState createState() => _PulsingWifiIconState();
}

class _PulsingWifiIconState extends State<_PulsingWifiIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: const Icon(Icons.wifi, size: 48, color: Colors.teal),
    );
  }
}

class _ManualIpDialog extends StatefulWidget {
  final String? initialIp;
  final WidgetRef ref;

  const _ManualIpDialog({this.initialIp, required this.ref});

  @override
  _ManualIpDialogState createState() => _ManualIpDialogState();
}

class _ManualIpDialogState extends State<_ManualIpDialog> {
  late TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialIp ?? '');
    _validate(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate(String value) {
    final regex = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$');
    setState(() {
      _isValid = regex.hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Manual IP Override'),
      content: TextField(
        controller: _controller,
        onChanged: _validate,
        decoration: InputDecoration(
          hintText: 'e.g. 10.0.0.1',
          labelText: 'Device IP Address',
          errorText: _controller.text.isNotEmpty && !_isValid ? 'Invalid IPv4 address' : null,
        ),
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isValid
              ? () {
                  widget.ref.read(configViewModelProvider.notifier).setManualIp(_controller.text);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Connect'),
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
