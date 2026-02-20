import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/presentation/config_view_model.dart';
import '../../../../core/networking/connection_repository.dart';

class ManualIpSection extends ConsumerStatefulWidget {
  const ManualIpSection({super.key});

  @override
  ConsumerState<ManualIpSection> createState() => _ManualIpSectionState();
}

class _ManualIpSectionState extends ConsumerState<ManualIpSection> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final currentIp = ref.read(targetIpProvider) ?? '';
    _controller = TextEditingController(text: currentIp);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to provider updates to keep field synced if mDNS finds something
    ref.listen(targetIpProvider, (prev, next) {
      if (next != null && next != _controller.text) {
        _controller.text = next;
      }
    });

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Target Device IP',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 192.168.1.32',
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    final ip = _controller.text.trim();
                    if (ip.isNotEmpty) {
                      ref.read(configViewModelProvider.notifier).setManualIp(ip);
                      // Also ensure flasher sees it immediately
                      ref.read(targetIpProvider.notifier).updateIp(ip);
                    }
                  },
                  child: const Text('Connect'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
