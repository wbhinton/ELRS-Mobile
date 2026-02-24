// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashing_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FlashingController)
final flashingControllerProvider = FlashingControllerProvider._();

final class FlashingControllerProvider
    extends $NotifierProvider<FlashingController, FlashingState> {
  FlashingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flashingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flashingControllerHash();

  @$internal
  @override
  FlashingController create() => FlashingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlashingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlashingState>(value),
    );
  }
}

String _$flashingControllerHash() =>
    r'96aadeff9940a6d217e48ed05acae268818ec916';

abstract class _$FlashingController extends $Notifier<FlashingState> {
  FlashingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FlashingState, FlashingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FlashingState, FlashingState>,
              FlashingState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
