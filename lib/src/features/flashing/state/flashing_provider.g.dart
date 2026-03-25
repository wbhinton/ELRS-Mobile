// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsFlashing)
final isFlashingProvider = IsFlashingProvider._();

final class IsFlashingProvider extends $NotifierProvider<IsFlashing, bool> {
  IsFlashingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isFlashingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isFlashingHash();

  @$internal
  @override
  IsFlashing create() => IsFlashing();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isFlashingHash() => r'f0187edf035d87f380a28008dbd69c1e4eac6e2c';

abstract class _$IsFlashing extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
