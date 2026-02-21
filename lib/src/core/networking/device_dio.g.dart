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

String _$localDioHash() => r'94c8dd9b78b042551ca37ff7563f3f6084bc0074';

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

String _$internetDioHash() => r'1f651b69ea724df77041f2147b1a9c076f0ed7f5';
