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

String _$discoveryServiceHash() => r'66e26f6c736c8c83f9072674d6c630f4849f0018';
