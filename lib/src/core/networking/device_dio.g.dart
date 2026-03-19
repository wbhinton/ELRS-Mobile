// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_dio.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localDio)
final localDioProvider = LocalDioProvider._();

final class LocalDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  LocalDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return localDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$localDioHash() => r'e8b0055cecc739b3fd89295b33b0766be32aa1b0';

@ProviderFor(internetDio)
final internetDioProvider = InternetDioProvider._();

final class InternetDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  InternetDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'internetDioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$internetDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return internetDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$internetDioHash() => r'b2a10bdac62637d2917ffbe157c748115b86425d';
