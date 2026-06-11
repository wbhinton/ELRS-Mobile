// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(discoveryService)
final discoveryServiceProvider = DiscoveryServiceProvider._();

final class DiscoveryServiceProvider
    extends
        $FunctionalProvider<
          DiscoveryService,
          DiscoveryService,
          DiscoveryService
        >
    with $Provider<DiscoveryService> {
  DiscoveryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoveryServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoveryServiceHash();

  @$internal
  @override
  $ProviderElement<DiscoveryService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DiscoveryService create(Ref ref) {
    return discoveryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoveryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoveryService>(value),
    );
  }
}

String _$discoveryServiceHash() => r'2c9291ac0caf6d8bd0eeb70c17a3312d2420fe0c';
