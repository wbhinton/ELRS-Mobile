# Implementation Patterns

**Project**: ExpressLRS Configurator
**Last Updated**: 2026-04-02

## Naming & Organization

**Files**: Feature-based folders under `lib/src/features/`, co-located presentation/data/domain/utils within each feature
**Functions**: camelCase with descriptive verbs (discoverDevices, assembleFirmware, buildFirmwarePayload)
**Imports**: Grouped: flutter -> external packages -> internal packages -> relative imports

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart`, `lib/src/features/flashing/data/`

## Type & Data Modeling

**Data Representation**: Freezed immutable classes with @freezed annotation for state, simple data classes for transfer objects (FirmwareData)
**Type Strictness**: Dart null safety with strong typing, nullable fields marked with ?
**Immutability**: All state via copyWith() from generated Freezed code

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart:44-64`, `lib/src/features/flashing/data/firmware_repository.dart:22-27`

```dart
@freezed
class FlashingState with _$FlashingState {
  const factory FlashingState({
    @Default(FlashingStatus.idle) FlashingStatus status,
    @Default(0.0) double progress,
    TargetDefinition? selectedTarget,
    String? selectedVersion,
    PatchConfiguration? patchConfig,
    String? errorMessage,
  }) = _FlashingState;
}
```

## Error Handling

**Strategy**: Try-catch-finally with status enum tracking (FlashingStatus), AsyncValue for async state
**Propagation**: Errors captured in state, UI reacts to status checks; rethrow after logging for DioException
**Common Types**: FlashingStatus.error, FlashingStatus.mismatch, Exception with context messages

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart:33-42`, `lib/src/features/flashing/data/device_repository.dart:283-289`

```dart
try {
  await deviceRepository.flashFirmware(target, firmware);
} catch (e, st) {
  _log.severe('Flash failed', e, st);
  Sentry.captureException(e, stackTrace: st);
  rethrow;
}
```

## Validation & Boundaries

**Location**: Controller level before persistence or network calls, ValidationUtils static methods
**Method**: Dedicated ValidationUtils class, validation in setters before state update
**Normalization**: Input sanitization for bind phrases (lowercase, trim whitespace)

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart:145-176`, `lib/src/core/utils/validation_utils.dart`

## Observability

**Logging**: package:logging with Logger instances per class, debugPrint for development
**Metrics**: Sentry.metrics.count() and Sentry.metrics.distribution() for latency tracking
**Tracing**: Stopwatch for operation timing, Sentry metrics for distribution

Evidence: `lib/src/features/flashing/data/device_repository.dart:45-53`, `lib/src/core/networking/connection_repository.dart:20`

```dart
final stopwatch = Stopwatch()..start();
try {
  await operation();
  Sentry.metrics.distribution('flash.latency', 
    value: stopwatch.elapsedMilliseconds.toDouble(),
    unit: SentryMetricUnit.millisecond);
} finally {
  stopwatch.stop();
}
```

## Testing Idioms

**Organization**: `test/` mirrors `lib/` structure
**Fixtures**: riverpod_test, custom provider overrides with ProviderContainer
**Levels**: Unit tests dominant, integration tests for discovery

Evidence: `test/features/flashing/`, `test/setup/test_setup.dart`

## I/O & Integration

**HTTP Clients**: Two separate Dio instances: localDio (device at 10.0.0.1) and internetDio (Artifactory)
**Binary Data**: Options(responseType: ResponseType.bytes), onReceiveProgress callback
**Upload Strategy**: FormData.fromMap with MultipartFile.fromBytes, explicit content-length header

Evidence: `lib/src/core/networking/device_dio.dart`, `lib/src/features/flashing/data/device_repository.dart:240-257`

```dart
final formData = FormData.fromMap({
  'target': target.name,
  'firmware': MultipartFile.fromBytes(
    payload,
    filename: 'firmware.bin',
    contentType: DioMediaType.parse('application/octet-stream'),
  ),
});
```

## Concurrency & Async

**Async Usage**: async/await throughout, Future.any() for concurrent device probing
**Patterns**: Sequential flashing pipeline (download → patch → upload), wakelock management
**Safety**: ref.mounted checks before state updates, cancel timers in onDispose

Evidence: `lib/src/features/config/presentation/config_view_model.dart:105-116`, `lib/src/features/flashing/presentation/flashing_controller.dart:480-556`

```dart
@override
void dispose() {
  _heartbeatTimer?.cancel();
  super.dispose();
}
```

## Dependency Injection

**Injection**: Riverpod providers with @Riverpod/@riverpod annotations, Dio injected via constructor
**Config**: BaseOptions for Dio config, SharedPreferences for app settings
**Persistence**: One-time migration from SharedPreferences to FlutterSecureStorage

Evidence: `lib/src/features/flashing/data/device_repository.dart:27-31`, `lib/src/core/networking/device_dio.dart:19-36`

```dart
@riverpod
class DeviceRepository extends _$DeviceRepository {
  DeviceRepository({
    required Dio localDio,
    required Dio internetDio,
  }) : _localDio = localDio,
       _internetDio = internetDio;
}
```

## Riverpod State Management

**Pattern**: HookConsumerWidget + Riverpod Notifier with Freezed, @Riverpod(keepAlive: true) for persistent state
**Keep Alive**: FlashingController and TargetIp use keepAlive for cross-screen persistence
**Cross-Provider Sync**: ref.listen() in build() for reactive updates
**Async State**: AsyncValue<T?> for async providers

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart:66-91`, `lib/src/features/config/presentation/config_view_model.dart:31-57`

```dart
@riverpod
class FlashingController extends _$FlashingController {
  @override
  const FlashingController({required FlashingState state}) : _state = state;
  
  @override
  FlashingState build() => const FlashingState();

  Future<void> flash() async {
    state = state.copyWith(status: FlashingStatus.downloading);
    // ...
  }
}
```

## Repository Patterns

**Structure**: Repository classes injected with Dio, @riverpod factory providers, typed return values
**Logging**: Static Logger per class with _log naming
**Error Wrapping**: Wrap exceptions with context: throw Exception('Failed to X: $e')
**Analytics**: Track events via analyticsServiceProvider on success/failure

Evidence: `lib/src/features/flashing/data/firmware_repository.dart:29-53`, `lib/src/features/flashing/data/device_repository.dart:33-62`

## Flashing Workflow

**Pipeline**: download → patch (optional) → build payload → upload → cleanup
**Connectivity Management**: unbind() before download, bindToWiFi() before upload, autoBindIfWiFi() in finally
**Progress Tracking**: status enum + progress double, UI-driven from state changes
**Cache Strategy**: FirmwareCacheService for pre-downloaded zips, check cache before remote download
**Unified Builds**: hardware.zip → TargetResolver.resolveLayout() → overlay merge → FirmwareAssembler.assembleEspUnified()
**Platform Handling**: ESP8285: GZip compress; ESP32: raw; STM32: no support for v4+

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart:191-269`, `lib/src/features/flashing/utils/target_resolver.dart`

```dart
Future<void> flash() async {
  state = state.copyWith(status: FlashingStatus.downloading);
  
  try {
    // 1. Download
    final firmware = await firmwareRepository.download(target, version);
    
    // 2. Patch
    state = state.copyWith(status: FlashingStatus.patching);
    final patched = await firmwarePatcher.patch(firmware, patchConfig);
    
    // 3. Build payload
    state = state.copyWith(status: FlashingStatus.uploading);
    final payload = await buildPayload(patched);
    
    // 4. Upload
    await deviceRepository.flashFirmware(target, payload);
    
    state = state.copyWith(status: FlashingStatus.success);
  } catch (e) {
    state = state.copyWith(status: FlashingStatus.error, errorMessage: e.toString());
  }
}
```
