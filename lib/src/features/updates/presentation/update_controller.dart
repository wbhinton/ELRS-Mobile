import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/update_state.dart';

part 'update_controller.g.dart';

@Riverpod(keepAlive: true)
class UpdateController extends _$UpdateController {
  @override
  UpdateState build() {
    return const UpdateState();
  }

  Future<void> checkForUpdates() async {
    // Legacy Gist update check removed as the app is now on official stores.
    return;
  }

  void dismissUpdate() {
    state = state.copyWith(dismissed: true);
  }
}
