import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
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
  late TextEditingController _wifiOnIntervalController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(flashingControllerProvider);
    _bindPhraseController = TextEditingController(text: state.bindPhrase);
    _wifiSsidController = TextEditingController(text: state.wifiSsid);
    _wifiPasswordController = TextEditingController(text: state.wifiPassword);
    _wifiOnIntervalController = TextEditingController(text: state.wifiOnInterval.toString());
  }

  bool _obscureBindPhrase = true;
  bool _obscureWifiPassword = true;

  @override
  void dispose() {
    _bindPhraseController.dispose();
    _wifiSsidController.dispose();
    _wifiPasswordController.dispose();
    _wifiOnIntervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
      if (previous?.wifiOnInterval != next.wifiOnInterval &&
          _wifiOnIntervalController.text != next.wifiOnInterval.toString()) {
        _wifiOnIntervalController.text = next.wifiOnInterval.toString();
      }
    });

    final autosavingField = ref.watch(
      flashingControllerProvider.select((s) => s.autosavingField),
    );
    final regulatoryDomain = ref.watch(
      flashingControllerProvider.select((s) => s.regulatoryDomain),
    );
    final target = ref.watch(
      flashingControllerProvider.select((s) => s.selectedTarget),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrientationBuilder(
          builder: (context, orientation) {
            final headerContent = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.settings),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.optionsTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.optionsSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            );

            final formContent = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Firmware Version
                const VersionSelector(),
                const SizedBox(height: 16),

                // Bind Phrase
                TextFormField(
                  controller: _bindPhraseController,
                  decoration: InputDecoration(
                    labelText: l10n.bindingPhraseLabel,
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
                    labelText: l10n.networkSsidLabel,
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
                    labelText: l10n.wifiPasswordLabel,
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
 
                // Wifi On Interval
                TextFormField(
                  controller: _wifiOnIntervalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.wifiOnIntervalLabel,
                    suffixIcon: autosavingField == 'wifiOnInterval'
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    final parsed = int.tryParse(value) ?? 60;
                    ref
                        .read(flashingControllerProvider.notifier)
                        .setWifiOnInterval(parsed);
                  },
                ),
                const SizedBox(height: 16),

                // Regulatory Domain
                Builder(
                  builder: (context) {
                    final is2G4Only =
                        target != null && target.is2400Mhz && !target.isDualBand;
                    int currentDomainId = regulatoryDomain;

                    if (is2G4Only && currentDomainId > 1) {
                      currentDomainId = 0;
                    }

                    final List<DropdownMenuItem<int>> domainItems = is2G4Only
                        ? [
                            DropdownMenuItem(value: 0, child: Text(l10n.regDomainIsm)),
                            DropdownMenuItem(
                              value: 1,
                              child: Text(l10n.regDomainEuLbt),
                            ),
                          ]
                        : [
                            DropdownMenuItem(value: 0, child: Text(l10n.regDomainAu915)),
                            DropdownMenuItem(value: 1, child: Text(l10n.regDomainFcc915)),
                            DropdownMenuItem(value: 2, child: Text(l10n.regDomainEu868)),
                            DropdownMenuItem(value: 3, child: Text(l10n.regDomainIn866)),
                            DropdownMenuItem(value: 4, child: Text(l10n.regDomainAu433)),
                            DropdownMenuItem(value: 5, child: Text(l10n.regDomainEu433)),
                            DropdownMenuItem(value: 6, child: Text(l10n.regDomainUs433)),
                          ];

                    return DropdownButtonFormField<int>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: l10n.regulatoryDomainLabel,
                      ),
                      initialValue: currentDomainId,
                      items: domainItems,
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(flashingControllerProvider.notifier)
                              .setRegulatoryDomain(value);
                        }
                      },
                    );
                  },
                ),
              ],
            );

            // LANDSCAPE SPLIT-SCREEN LAYOUT
            if (orientation == Orientation.landscape) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: headerContent),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: formContent,
                    ),
                  ),
                ],
              );
            }

            // STANDARD PORTRAIT LAYOUT
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                headerContent,
                const SizedBox(height: 16),
                formContent,
              ],
            );
          },
        ),
      ),
    );
  }
}
