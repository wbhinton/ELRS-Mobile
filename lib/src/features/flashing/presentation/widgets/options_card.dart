import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binary/binary.dart';
import '../flashing_controller.dart';
import 'version_selector.dart';

class OptionsCard extends ConsumerStatefulWidget {
  const OptionsCard({super.key});

  @override
  ConsumerState<OptionsCard> createState() => _OptionsCardState();
}

class _OptionsCardState extends ConsumerState<OptionsCard> {
  late TextEditingController _bindPhraseController;
  late TextEditingController _wifiSsidController;
  late TextEditingController _wifiPasswordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(flashingControllerProvider);
    _bindPhraseController = TextEditingController(text: state.bindPhrase);
    _wifiSsidController = TextEditingController(text: state.wifiSsid);
    _wifiPasswordController = TextEditingController(text: state.wifiPassword);
  }

  bool _obscureBindPhrase = true;
  bool _obscureWifiPassword = true;

  @override
  void dispose() {
    _bindPhraseController.dispose();
    _wifiSsidController.dispose();
    _wifiPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to state changes to update controllers when data loads
    ref.listen(flashingControllerProvider, (previous, next) {
      if (previous?.bindPhrase != next.bindPhrase &&
          _bindPhraseController.text != next.bindPhrase) {
        _bindPhraseController.text = next.bindPhrase;
      }
      if (previous?.wifiSsid != next.wifiSsid &&
          _wifiSsidController.text != next.wifiSsid) {
        _wifiSsidController.text = next.wifiSsid;
      }
      if (previous?.wifiPassword != next.wifiPassword &&
          _wifiPasswordController.text != next.wifiPassword) {
        _wifiPasswordController.text = next.wifiPassword;
      }
    });

    final autosavingField = ref.watch(
      flashingControllerProvider.select((s) => s.autosavingField),
    );
    final regulatoryDomain = ref.watch(
      flashingControllerProvider.select((s) => s.regulatoryDomain),
    );
    final dualBandEnabled = ref.watch(
      flashingControllerProvider.select((s) => s.dualBandEnabled),
    );
    final target = ref.watch(
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
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text(
                  'Device Options',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Firmware Version
            const VersionSelector(),
            const SizedBox(height: 16),

            // Bind Phrase
            TextFormField(
              controller: _bindPhraseController,
              decoration: InputDecoration(
                labelText: 'Binding Phrase',
                helperText: 'Your unique binding phrase',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (autosavingField == 'bindPhrase')
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    IconButton(
                      icon: Icon(
                        _obscureBindPhrase
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureBindPhrase = !_obscureBindPhrase;
                        });
                      },
                    ),
                  ],
                ),
              ),
              onChanged: (value) => ref
                  .read(flashingControllerProvider.notifier)
                  .setBindPhrase(value),
              obscureText: _obscureBindPhrase,
            ),
            const SizedBox(height: 16),

            // Wifi SSID
            TextFormField(
              controller: _wifiSsidController,
              decoration: InputDecoration(
                labelText: 'WiFi SSID',
                suffixIcon: autosavingField == 'wifiSsid'
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      )
                    : null,
              ),
              onChanged: (value) => ref
                  .read(flashingControllerProvider.notifier)
                  .setWifiSsid(value),
            ),
            const SizedBox(height: 16),

            // Wifi Password
            TextFormField(
              controller: _wifiPasswordController,
              decoration: InputDecoration(
                labelText: 'WiFi Password',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (autosavingField == 'wifiPassword')
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    IconButton(
                      icon: Icon(
                        _obscureWifiPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureWifiPassword = !_obscureWifiPassword;
                        });
                      },
                    ),
                  ],
                ),
              ),
              onChanged: (value) => ref
                  .read(flashingControllerProvider.notifier)
                  .setWifiPassword(value),
              obscureText: _obscureWifiPassword,
            ),
            const SizedBox(height: 16),

            // Dual-Band Toggle (Only for dual-band capable devices)
            if (target?.isDualBand ?? false) ...[
              SwitchListTile(
                title: const Text('Dual-Band Mode'),
                subtitle: const Text(
                  'Enable concurrent 900MHz and 2.4GHz operation',
                ),
                value: dualBandEnabled,
                onChanged: (value) {
                  ref
                      .read(flashingControllerProvider.notifier)
                      .setDualBandEnabled(value);
                },
              ),
              const SizedBox(height: 16),
            ],

            // Regulatory Domain
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Regulatory Domain'),
              // Map composite bitfield to Domain ID (bits 0-3) using package:binary
              initialValue: Uint16(regulatoryDomain).slice(0, 3).toInt(),
              items: const [
                DropdownMenuItem(value: 0, child: Text('AU (915MHz)')),
                DropdownMenuItem(value: 1, child: Text('FCC (915MHz)')),
                DropdownMenuItem(value: 2, child: Text('EU (868MHz)')),
                DropdownMenuItem(value: 3, child: Text('IN (866MHz)')),
                DropdownMenuItem(value: 4, child: Text('AU (433MHz)')),
                DropdownMenuItem(value: 5, child: Text('EU (433MHz)')),
                DropdownMenuItem(value: 6, child: Text('US (433MHz)')),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref
                      .read(flashingControllerProvider.notifier)
                      .setRegulatoryDomain(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
