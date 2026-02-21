// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_network_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nativeNetworkService)
final nativeNetworkServiceProvider = NativeNetworkServiceProvider._();

final class NativeNetworkServiceProvider
    extends
        $FunctionalProvider<
          NativeNetworkService,
          NativeNetworkService,
          NativeNetworkService
        >
    with $Provider<NativeNetworkService> {
  NativeNetworkServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nativeNetworkServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nativeNetworkServiceHash();

  @$internal
  @override
  $ProviderElement<NativeNetworkService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NativeNetworkService create(Ref ref) {
    return nativeNetworkService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NativeNetworkService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NativeNetworkService>(value),
    );
  }
}

String _$nativeNetworkServiceHash() =>
    r'deb8ebe016536b2094a461f29cb4bd8698637ada';
