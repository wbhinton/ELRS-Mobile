// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pwm_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PwmController)
final pwmControllerProvider = PwmControllerProvider._();

final class PwmControllerProvider
    extends $NotifierProvider<PwmController, PwmState> {
  PwmControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pwmControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pwmControllerHash();

  @$internal
  @override
  PwmController create() => PwmController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PwmState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PwmState>(value),
    );
  }
}

String _$pwmControllerHash() => r'2103ba7bb609084f419da9713aee97e413549d86';

abstract class _$PwmController extends $Notifier<PwmState> {
  PwmState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PwmState, PwmState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PwmState, PwmState>,
              PwmState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
