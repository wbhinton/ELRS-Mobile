// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backpack_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BackpackController)
final backpackControllerProvider = BackpackControllerProvider._();

final class BackpackControllerProvider
    extends $NotifierProvider<BackpackController, BackpackState> {
  BackpackControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backpackControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backpackControllerHash();

  @$internal
  @override
  BackpackController create() => BackpackController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackpackState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackpackState>(value),
    );
  }
}

String _$backpackControllerHash() =>
    r'b0b9cad162bdccd891cb1147d28d7163f3500096';

abstract class _$BackpackController extends $Notifier<BackpackState> {
  BackpackState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BackpackState, BackpackState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BackpackState, BackpackState>,
              BackpackState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
