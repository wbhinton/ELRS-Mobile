// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TargetIp)
final targetIpProvider = TargetIpProvider._();

final class TargetIpProvider extends $NotifierProvider<TargetIp, String?> {
  TargetIpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'targetIpProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$targetIpHash();

  @$internal
  @override
  TargetIp create() => TargetIp();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$targetIpHash() => r'bbd05b0034dc338fe0e5a98ff2334174a4699b96';

abstract class _$TargetIp extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
