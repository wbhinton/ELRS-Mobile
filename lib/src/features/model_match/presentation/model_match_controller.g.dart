// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_match_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModelMatchController)
final modelMatchControllerProvider = ModelMatchControllerProvider._();

final class ModelMatchControllerProvider
    extends $NotifierProvider<ModelMatchController, ModelMatchState> {
  ModelMatchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'modelMatchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$modelMatchControllerHash();

  @$internal
  @override
  ModelMatchController create() => ModelMatchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ModelMatchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ModelMatchState>(value),
    );
  }
}

String _$modelMatchControllerHash() =>
    r'8736003a99ee5e7121069ccd163d5b7ef5cd0965';

abstract class _$ModelMatchController extends $Notifier<ModelMatchState> {
  ModelMatchState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ModelMatchState, ModelMatchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ModelMatchState, ModelMatchState>,
              ModelMatchState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
