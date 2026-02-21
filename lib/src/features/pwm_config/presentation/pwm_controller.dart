import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../flashing/data/device_repository.dart';

part 'pwm_controller.freezed.dart';
part 'pwm_controller.g.dart';

enum PwmStatus {
  idle,
  loading,
  saving,
  error,
  success,
}

@freezed
abstract class PwmState with _$PwmState {
  const factory PwmState({
    @Default([]) List<int> outputs, // Index = Pin, Value = Channel
    @Default(PwmStatus.idle) PwmStatus status,
    String? errorMessage,
  }) = _PwmState;
}

@riverpod
class PwmController extends _$PwmController {
  @override
  PwmState build() {
    return const PwmState();
  }

  Future<void> loadConfig() async {
    state = state.copyWith(status: PwmStatus.loading, errorMessage: null);
    try {
      final repo = ref.read(deviceRepositoryProvider);
      final config = await repo.fetchConfig();
      
      // Parse pwm.
      if (config.config.pwm.isNotEmpty) {
        state = state.copyWith(
          status: PwmStatus.idle,
          outputs: config.config.pwm.cast<int>(),
        );
      } else {
        // Fallback or empty if not present
        state = state.copyWith(status: PwmStatus.idle, outputs: []);
      }
    } catch (e) {
      state = state.copyWith(
        status: PwmStatus.error,
        errorMessage: 'Failed to load config: $e',
      );
    }
  }

  void updateOutput(int pinIndex, int channelIndex) {
    if (pinIndex < 0 || pinIndex >= state.outputs.length) return;
    
    final newOutputs = List<int>.from(state.outputs);
    newOutputs[pinIndex] = channelIndex;
    
    state = state.copyWith(outputs: newOutputs);
  }

  Future<void> save() async {
    state = state.copyWith(status: PwmStatus.saving, errorMessage: null);
    try {
      final repo = ref.read(deviceRepositoryProvider);
      
      // Convert List to Map<int, int> as required by Repo signature
      final Map<int, int> mapping = {};
      for (int i = 0; i < state.outputs.length; i++) {
        mapping[i] = state.outputs[i];
      }
      
      await repo.setPwmMapping(mapping);
      
      state = state.copyWith(status: PwmStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: PwmStatus.error,
        errorMessage: 'Failed to save: $e',
      );
    }
  }
}
