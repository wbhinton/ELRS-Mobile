# Implementation Patterns

**Project**: ELRS (ExpressLRS) Mobile App
**Last Updated**: 2026-03-12

## Naming & Organization

**Files**: snake_case for Dart files (target_definition.dart), feature-first directory structure
**Functions**: camelCase for methods, descriptive verbs (downloadFirmware, selectVendor)
**Imports**: absolute imports with package prefix, grouped by external/first-party/internal

Evidence: `lib/src/router.dart`, `lib/src/features/settings/presentation/widgets/settings_master_detail.dart`

## Type & Data Modeling

**Data Representation**: Freezed immutable classes with @freezed annotation, using factory constructors
**Type Strictness**: Gradual typing - explicit types on public API, inference for locals
**Immutability**: Freezed generates copyWith methods; @Default values for nullable fields

Evidence: `lib/src/features/flashing/domain/target_definition.dart:6-46`

## Error Handling

**Strategy**: Exception-based with custom error messages; throw Exception('message')
**Propagation**: Try-catch at boundary, rethrow with context; early returns for validation failures
**Common Types**: Exception, DioException

Evidence: `lib/src/features/flashing/utils/firmware_assembler.dart:131-134`

## Validation & Boundaries

**Location**: Domain layer and service layer; validators as static utility classes
**Method**: Custom validators returning String? (error message) or null (valid); throw on invalid input in services

Evidence: `lib/src/core/utils/validation_utils.dart:3-37`, `lib/src/features/config/utils/frequency_validator.dart`

## Observability

**Logging**: print statements in repositories/services, debugPrint in UI
**Metrics**: None detected
**Tracing**: None detected

Evidence: `lib/src/features/flashing/utils/firmware_assembler.dart:77-82`

## Testing Idioms

**Organization**: test/ directory mirroring src/ structure, feature-based
**Fixtures**: Riverpod providers as test fixtures; test_setup.dart for shared configuration
**Levels**: Unit tests dominant with integration tests for discovery services

Evidence: `test/firmware_cache_service_test.dart`, `test/setup/test_setup.dart`, `test/flashing_pipeline_test.dart`

## I/O & Integration

**Database**: No local DB; SharedPreferences via PersistenceService for bind phrase/wifi settings
**HTTP Clients**: Dio for HTTP; custom dio providers with timeouts; ResponseType.bytes for binary downloads
**Resilience**: Basic error handling, no circuit breaker

Evidence: `lib/src/features/config/services/device_config_service.dart:21-35`

## Concurrency & Async

**Async Usage**: async/await throughout; Future<T> returns for all I/O; Future.microtask for deferred initialization
**Parallelism**: Parallel download/extract operations; no async streams observed

Evidence: `lib/src/features/dashboard/presentation/dashboard_screen.dart:27-31`, `lib/src/features/flashing/utils/firmware_assembler.dart`

## Dependency & Configuration

**DI Pattern**: Riverpod @riverpod annotated providers; constructor injection for repositories
**Config Loading**: Environment via ProviderScope; runtime config via RuntimeConfig model; @Default values for optional config

Evidence: `lib/src/features/config/domain/runtime_config_model.dart:15-23`, `lib/src/app.dart`

## Widget Lifecycle: Mounted Guards

**Pattern**: if (!ref.mounted) return; placed before all async state mutations in Riverpod notifiers
**Purpose**: Prevents state updates on disposed widgets causing setState during build errors

Evidence: `lib/src/features/config/presentation/config_view_model.dart:63`, `lib/src/features/config/presentation/config_view_model.dart:67`, `lib/src/features/config/presentation/config_view_model.dart:118`

## Responsive Layout Patterns

**Breakpoints**: Static constants: tablet=600, desktop=1200, maxContentWidth=800
**Detection**: MediaQuery.of(context).size.width >= breakpoint
**Layout Adaptation**: Conditional rendering: 2-col mobile, 3-col tablet; master-detail on tablet

Evidence: `lib/src/core/presentation/responsive_layout.dart:4-26`, `lib/src/features/dashboard/presentation/dashboard_screen.dart:22`, `lib/src/features/dashboard/presentation/dashboard_screen.dart:72`

## Master-Detail Pattern

**Implementation**: Stateful widget tracking selected category enum; Row layout tablet, single list mobile
**Category Enum**: SettingsCategory enum (flashing, about, advanced) exported for navigation
**Conditional Content**: if (!isTablet || selected == category) for conditional section rendering

Evidence: `lib/src/features/settings/presentation/widgets/settings_master_detail.dart:4`, `lib/src/features/settings/presentation/widgets/settings_master_detail.dart:31-54`, `lib/src/features/settings/presentation/settings_screen.dart:64`
