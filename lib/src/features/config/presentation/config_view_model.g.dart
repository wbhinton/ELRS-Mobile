// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceConfigService)
final deviceConfigServiceProvider = DeviceConfigServiceProvider._();

final class DeviceConfigServiceProvider
    extends
        $FunctionalProvider<
          DeviceConfigService,
          DeviceConfigService,
          DeviceConfigService
        >
    with $Provider<DeviceConfigService> {
  DeviceConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceConfigServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceConfigServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceConfigService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceConfigService create(Ref ref) {
    return deviceConfigService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceConfigService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceConfigService>(value),
    );
  }
}

String _$deviceConfigServiceHash() =>
    r'3754746e7042d9d49591b32256229b063ac8652b';

@ProviderFor(ConfigViewModel)
final configViewModelProvider = ConfigViewModelProvider._();

final class ConfigViewModelProvider
    extends $AsyncNotifierProvider<ConfigViewModel, RuntimeConfig?> {
  ConfigViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'configViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$configViewModelHash();

  @$internal
  @override
  ConfigViewModel create() => ConfigViewModel();
}

String _$configViewModelHash() => r'9c6a6a120353eefdb5c7a15f57c8cbc4171d8214';

abstract class _$ConfigViewModel extends $AsyncNotifier<RuntimeConfig?> {
  FutureOr<RuntimeConfig?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RuntimeConfig?>, RuntimeConfig?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RuntimeConfig?>, RuntimeConfig?>,
              AsyncValue<RuntimeConfig?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
