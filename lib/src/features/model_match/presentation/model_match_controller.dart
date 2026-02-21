import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../flashing/data/device_repository.dart';

part 'model_match_controller.freezed.dart';
part 'model_match_controller.g.dart';

enum ModelMatchStatus {
  idle,
  loading,
  success,
  error,
}

@freezed
abstract class ModelMatchState with _$ModelMatchState {
  const factory ModelMatchState({
    @Default(255) int modelId,
    @Default(false) bool isEnabled,
    @Default(ModelMatchStatus.idle) ModelMatchStatus status,
    String? errorMessage,
  }) = _ModelMatchState;
}

@riverpod
class ModelMatchController extends _$ModelMatchController {
  @override
  ModelMatchState build() {
    return const ModelMatchState();
  }

  Future<void> loadConfig() async {
    state = state.copyWith(status: ModelMatchStatus.loading, errorMessage: null);
    try {
      final repo = ref.read(deviceRepositoryProvider);
      final config = await repo.fetchConfig();
      
      // Parse response.
      final modelId = config.config.modelId ?? 255;
      final isEnabled = modelId != 255;
      
      state = state.copyWith(
        status: ModelMatchStatus.success,
        modelId: modelId,
        isEnabled: isEnabled,
      );
    } catch (e) {
      state = state.copyWith(
        status: ModelMatchStatus.error,
        errorMessage: 'Failed to load config: $e',
      );
    }
  }

  Future<void> save(int newId, bool enabled) async {
    state = state.copyWith(status: ModelMatchStatus.loading, errorMessage: null);
    try {
      final repo = ref.read(deviceRepositoryProvider);
      await repo.updateModelMatch(newId, enabled);
      
      state = state.copyWith(
        status: ModelMatchStatus.success,
        modelId: newId,
        isEnabled: enabled,
      );
    } catch (e) {
      state = state.copyWith(
        status: ModelMatchStatus.error,
        errorMessage: 'Failed to save: $e',
      );
    }
  }
}
