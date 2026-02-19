// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_manager_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FirmwareManagerController)
final firmwareManagerControllerProvider = FirmwareManagerControllerProvider._();

final class FirmwareManagerControllerProvider
    extends $NotifierProvider<FirmwareManagerController, FirmwareManagerState> {
  FirmwareManagerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firmwareManagerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firmwareManagerControllerHash();

  @$internal
  @override
  FirmwareManagerController create() => FirmwareManagerController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirmwareManagerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirmwareManagerState>(value),
    );
  }
}

String _$firmwareManagerControllerHash() =>
    r'8c16f60a20c68afe5609a81bbb360f1df902af72';

abstract class _$FirmwareManagerController
    extends $Notifier<FirmwareManagerState> {
  FirmwareManagerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FirmwareManagerState, FirmwareManagerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FirmwareManagerState, FirmwareManagerState>,
              FirmwareManagerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
