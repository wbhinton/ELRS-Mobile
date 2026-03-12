// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistence_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(persistenceService)
final persistenceServiceProvider = PersistenceServiceProvider._();

final class PersistenceServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<PersistenceService>,
          PersistenceService,
          FutureOr<PersistenceService>
        >
    with
        $FutureModifier<PersistenceService>,
        $FutureProvider<PersistenceService> {
  PersistenceServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'persistenceServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$persistenceServiceHash();

  @$internal
  @override
  $FutureProviderElement<PersistenceService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PersistenceService> create(Ref ref) {
    return persistenceService(ref);
  }
}

String _$persistenceServiceHash() =>
    r'ab3be81338f22fea923c637dc0e7629cf0f3d144';
