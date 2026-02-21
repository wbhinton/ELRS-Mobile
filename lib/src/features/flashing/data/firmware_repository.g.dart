// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firmwareRepository)
final firmwareRepositoryProvider = FirmwareRepositoryProvider._();

final class FirmwareRepositoryProvider
    extends
        $FunctionalProvider<
          FirmwareRepository,
          FirmwareRepository,
          FirmwareRepository
        >
    with $Provider<FirmwareRepository> {
  FirmwareRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firmwareRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firmwareRepositoryHash();

  @$internal
  @override
  $ProviderElement<FirmwareRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirmwareRepository create(Ref ref) {
    return firmwareRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirmwareRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirmwareRepository>(value),
    );
  }
}

String _$firmwareRepositoryHash() =>
    r'ef9be44ff90638b0540919502726bc7edafdda82';
