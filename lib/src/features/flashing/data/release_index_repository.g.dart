// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_index_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(releaseIndexRepository)
final releaseIndexRepositoryProvider = ReleaseIndexRepositoryProvider._();

final class ReleaseIndexRepositoryProvider
    extends
        $FunctionalProvider<
          ReleaseIndexRepository,
          ReleaseIndexRepository,
          ReleaseIndexRepository
        >
    with $Provider<ReleaseIndexRepository> {
  ReleaseIndexRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'releaseIndexRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$releaseIndexRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReleaseIndexRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReleaseIndexRepository create(Ref ref) {
    return releaseIndexRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReleaseIndexRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReleaseIndexRepository>(value),
    );
  }
}

String _$releaseIndexRepositoryHash() =>
    r'722bce76a33bc54bb845e3c46a8f131e36324621';
