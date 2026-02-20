import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flashing_provider.g.dart';

@Riverpod(keepAlive: true)
class IsFlashing extends _$IsFlashing {
  @override
  bool build() => false;

  void setFlashing(bool value) {
    if (state != value) {
      state = value;
      print('FLASHING: ${value ? 'Started' : 'Finished'} (Heartbeat silenced: $value)');
    }
  }
}
