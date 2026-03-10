# Implementation Patterns

**Project**: ELRS (ExpressLRS) Mobile App
**Last Updated**: 2026-03-09

## Naming & Organization

**Files**: snake_case for Dart files (target_definition.dart), feature-first directory structure
**Functions**: camelCase for methods, descriptive verbs (downloadFirmware, selectVendor)
**Imports**: absolute imports with package prefix, grouped by external/first-party/internal

Evidence: `lib/src/router.dart`, `lib/src/features/flashing/domain/target_definition.dart`

## Type & Data Modeling

**Data Representation**: Freezed immutable classes with @freezed annotation, using factory constructors
**Type Strictness**: Gradual typing - explicit types on public API, inference for locals
**Immutability**: Freezed generates copyWith methods; @Default values for nullable fields

Evidence: `lib/src/features/flashing/domain/target_definition.dart:6-46`

## Error Handling

**Strategy**: Exception-based with custom error messages; throw Exception('message')
**Propagation**: Try-catch at boundary, rethrow with context; early returns for validation failures
**Common Types**: Exception, DioException

Evidence: `lib/src/features/flashing/data/firmware_repository.dart:47-50`

## Validation & Boundaries

**Location**: Domain layer and service layer; validators as static utility classes
**Method**: Custom validators with business logic (FrequencyValidator), throw on invalid input

Evidence: `lib/src/features/config/utils/frequency_validator.dart:8-22`

## Observability

**Logging**: Print statements for debug output in repositories/services; debugPrint in UI
**Metrics**: None detected
**Tracing**: None detected

Evidence: `lib/src/features/flashing/data/firmware_repository.dart:44`

## Testing Idioms

**Organization**: Feature-based alongside source (not visible in sample files)
**Fixtures**: Riverpod providers as test fixtures

Evidence: `test/` directory with 18+ test files

## I/O & Integration

**Database**: No local DB - using SharedPreferences via PersistenceService for bind phrase/wifi settings
**HTTP Clients**: Dio for HTTP; custom dio providers with timeouts; ResponseType.bytes for binary downloads
**Resilience**: No circuit breaker observed; basic error handling

Evidence: `lib/src/features/config/services/device_config_service.dart:21-35`

## Concurrency & Async

**Async Usage**: async/await throughout; Future<T> returns for all I/O; no async streams observed
**Parallelism**: Future.microtask for deferred initialization; parallel download/extract

Evidence: `lib/src/app.dart:41`, `lib/src/features/flashing/data/firmware_repository.dart:33-51`

## Dependency & Configuration

**DI Pattern**: Riverpod @riverpod annotated providers; constructor injection for repositories
**Config Loading**: Environment via ProviderScope; runtime config via RuntimeConfig model

Evidence: `lib/src/features/flashing/data/firmware_repository.dart:212-215`, `lib/src/app.dart:27`

## Extension Mechanisms

**Plugin Pattern**: None detected
**Hook System**: None detected
