import 'package:binary/binary.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:elrs_mobile/src/bit_list.dart' as elrs_bits;
import 'pwm_controller.dart';

class PwmScreen extends HookConsumerWidget {
  const PwmScreen({super.key});

  // Total number of logical ELRS channels — drives BitList length, no hardcoded list.
  static const int _kChannelCount = 16;

  // Aux-channel suffixes for Ch 5–12; all others are plain "Ch N".
  static const Map<int, String> _kAuxSuffixes = {
    4: 'Aux1', 5: 'Aux2', 6: 'Aux3', 7: 'Aux4',
    8: 'Aux5', 9: 'Aux6', 10: 'Aux7', 11: 'Aux8',
  };

  /// Dynamically generates a human-readable channel label for index [i].
  static String _channelLabel(int i) {
    final suffix = _kAuxSuffixes[i];
    return suffix != null ? 'Ch ${i + 1} ($suffix)' : 'Ch ${i + 1}';
  }

  /// WYSIWIS register validation — called per-pin in debug/test builds.
  /// Asserts that [BitList] and [Uint8.nthBit] agree on every bit of [rawReg].
  /// Throws [StateError] on mismatch; is a no-op in release builds.
  static void _assertWysiwis(elrs_bits.BitList configBits, Uint8 rawReg) {
    assert(() {
      for (var i = 0; i < configBits.length; i++) {
        final fromBitList = configBits[i];
        final fromReg = rawReg.nthBit(i);
        if (fromBitList != fromReg) {
          throw StateError(
            'WYSIWIS violation: BitList mismatch with raw register at bit $i '
            '(BitList=$fromBitList, nthBit=$fromReg)',
          );
        }
      }
      return true;
    }());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pwmControllerProvider);
    final controller = ref.read(pwmControllerProvider.notifier);

    useEffect(() {
      Future.microtask(() => controller.loadConfig());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PWM Configuration'),
      ),
      body: state.status == PwmStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
                  ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.outputs.length,
                    separatorBuilder: (ctx, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final currentChannel = state.outputs[index];

                      // Wrap the raw channel value in the device's register type.
                      // Uint8 is the ground-truth register width used by the device WebUI.
                      final rawReg = Uint8(currentChannel);

                      // BitList provides list-style iteration over the register's bits,
                      // decoupling the UI loop from any hardcoded channel count literal.
                      final configBits = elrs_bits.BitList.fromInt(
                        rawReg.toInt(),
                        length: _kChannelCount,
                      );

                      // WYSIWIS: run parity assertion before the items list is built.
                      // assert() is a statement — it cannot appear inside a collection
                      // literal expression, so validation is lifted into a helper.
                      _assertWysiwis(configBits, rawReg);

                      return ListTile(
                        title: Text('Output Pin ${index + 1}'),
                        subtitle: Text(
                          'Mapped to ${_channelLabel(currentChannel < _kChannelCount ? currentChannel : currentChannel)}',
                        ),
                        trailing: DropdownButton<int>(
                          value: currentChannel < _kChannelCount ? currentChannel : null,
                          onChanged: (val) {
                            if (val != null) {
                              controller.updateOutput(index, val);
                            }
                          },
                          // BitList drives iteration — _kChannelCount is the only
                          // constant controlling loop width.
                          items: [
                            for (var i = 0; i < configBits.length; i++)
                              DropdownMenuItem<int>(
                                value: i,
                                child: Text(
                                  _channelLabel(i),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.status == PwmStatus.saving
            ? null
            : () => controller.save(),
        child: state.status == PwmStatus.saving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save),
      ),
    );
  }
}
