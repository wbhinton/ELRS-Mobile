import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flashing_provider.g.dart';

@Riverpod(keepAlive: true)
class IsFlashing extends _$IsFlashing {
  static final _log = Logger('IsFlashing');

  @override
  bool build() => false;

  void setFlashing(bool value) {
    if (state != value) {
      state = value;
      _log.info('${value ? 'Started' : 'Finished'} (Heartbeat silenced: $value)');
    }
  }
}
