import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_repository.g.dart';

@Riverpod(keepAlive: true)
class TargetIp extends _$TargetIp {
  @override
  String? build() {
    return null;
  }

  void updateIp(String newIp) {
    if (state != newIp) {
      print('CONNECTION: Target IP updated to $newIp');
      state = newIp;
    }
  }
}
