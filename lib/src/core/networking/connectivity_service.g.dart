// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConnectivityService)
final connectivityServiceProvider = ConnectivityServiceProvider._();

final class ConnectivityServiceProvider
    extends
        $StreamNotifierProvider<ConnectivityService, List<ConnectivityResult>> {
  ConnectivityServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityServiceHash();

  @$internal
  @override
  ConnectivityService create() => ConnectivityService();
}

String _$connectivityServiceHash() =>
    r'567959719466213bde507166391dfac1dbf47263';

abstract class _$ConnectivityService
    extends $StreamNotifier<List<ConnectivityResult>> {
  Stream<List<ConnectivityResult>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ConnectivityResult>>,
              List<ConnectivityResult>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ConnectivityResult>>,
                List<ConnectivityResult>
              >,
              AsyncValue<List<ConnectivityResult>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
