// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appUpdateService)
final appUpdateServiceProvider = AppUpdateServiceProvider._();

final class AppUpdateServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppUpdateService>,
          AppUpdateService,
          FutureOr<AppUpdateService>
        >
    with $FutureModifier<AppUpdateService>, $FutureProvider<AppUpdateService> {
  AppUpdateServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appUpdateServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appUpdateServiceHash();

  @$internal
  @override
  $FutureProviderElement<AppUpdateService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppUpdateService> create(Ref ref) {
    return appUpdateService(ref);
  }
}

String _$appUpdateServiceHash() => r'06b4a29c4700e3a79772e26fbb37c40d478bc207';
