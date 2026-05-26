// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'releases_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(releasesRepository)
final releasesRepositoryProvider = ReleasesRepositoryProvider._();

final class ReleasesRepositoryProvider
    extends
        $FunctionalProvider<
          ReleasesRepository,
          ReleasesRepository,
          ReleasesRepository
        >
    with $Provider<ReleasesRepository> {
  ReleasesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'releasesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$releasesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReleasesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReleasesRepository create(Ref ref) {
    return releasesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReleasesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReleasesRepository>(value),
    );
  }
}

String _$releasesRepositoryHash() =>
    r'94d1f2b726eb6ad7ec49a45686f200e35585866b';

@ProviderFor(releases)
final releasesProvider = ReleasesProvider._();

final class ReleasesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  ReleasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'releasesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$releasesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return releases(ref);
  }
}

String _$releasesHash() => r'b4a9e185b6fb63ea0f94e981aff9c0c2637ff8cd';
