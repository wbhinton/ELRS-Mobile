# Implementation Patterns

**Project**: ELRS Mobile
**Last Updated**: 2026-03-18

## Naming & Organization

**Files**: feature-based folders under `lib/src/features/`, co-located widgets
**Functions**: camelCase, descriptive verbs (`discoverDevices`, `assembleFirmware`)
**Imports**: grouped: flutter -> external -> internal -> relative

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart`

## Type & Data Modeling

**Data Representation**: Freezed immutable classes with `@freezed` annotation
**Type Strictness**: Strong typing with Dart null safety
**Immutability**: All state via `copyWith()` from generated code

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart:1-50`

## Error Handling

**Strategy**: Try-catch-finally with status enum tracking
**Propagation**: Errors captured in state, UI reacts to `status == FlashingStatus.error`
**Common Types**: `FlashingStatus.error`, validation errors in dedicated fields

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart:200-250`

## Validation & Boundaries

**Location**: Controller level before persistence or network calls
**Method**: Dedicated `ValidationUtils` class with static methods
**Normalization**: Bind phrase sanitization, IP address validation

Evidence: `lib/src/core/utils/validation_utils.dart`

## Observability

**Logging**: `print()` statements with `NATIVE:` prefix for native calls
**Metrics**: Aptabase for feature usage, Sentry for errors
**Tracing**: None detected (would add in future)

Evidence: `lib/src/core/analytics/analytics_service.dart`

## Testing Idioms

**Organization**: `test/` mirrors `lib/` structure
**Fixtures**: Mocks via `riverpod_test` and custom providers
**Levels**: Unit tests dominant

Evidence: `test/features/flashing/`

## I/O & Integration

**HTTP Clients**: Dio with device-specific configuration
**Resilience**: Platform channel guards, try-catch with graceful degradation
**Offline**: FirmwareCacheService for pre-downloaded archives

Evidence: `lib/src/core/networking/`, `lib/src/core/storage/firmware_cache_service.dart`

## Concurrency & Async

**Async Usage**: All I/O is async, controllers use `async/await`
**Parallelism**: Sequential flashing pipeline (download → patch → upload)
**Safety**: No shared mutable state in controllers (immutable Freezed states)

Evidence: `lib/src/features/flashing/presentation/flashing_controller.dart`

## Dependency & Configuration

**DI Pattern**: Riverpod providers with `@Riverpod` annotation
**Config Loading**: SharedPreferences for app settings, platform channels for native
**Initialization**: `build()` in Notifiers, `useEffect()` in HookConsumerWidgets

Evidence: `lib/src/features/settings/presentation/settings_controller.dart`

## State Management

**Pattern**: HookConsumerWidget + Riverpod Notifier with Freezed
**Keep Alive**: `@Riverpod(keepAlive: true)` for persistent state
**Cross-Provider Sync**: `ref.listen()` in build() for reactive updates

Evidence: `lib/src/features/flashing/presentation/flashing_screen.dart:1-50`

## Platform Integration

**Pattern**: MethodChannel with static string constant for channel name
**Guards**: `Platform.isIOS` checks for conditional iOS/Android behavior
**Error Handling**: Try-catch around invokeMethod with fallback behavior

Evidence: `lib/src/core/networking/native_network_service.dart`
