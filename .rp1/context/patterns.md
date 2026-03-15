# Implementation Patterns

**Project**: ELRS (ExpressLRS) Mobile App
**Last Updated**: 2026-03-15

## Naming & Organization

**Files**: snake_case for Dart files, feature-first directory structure
**Functions**: camelCase for methods, descriptive verbs (downloadFirmware, trackEvent)
**Imports**: absolute imports with package prefix, grouped by external/first-party/internal

Evidence: `lib/src/router.dart`, `lib/src/features/settings/`

## Type & Data Modeling

**Data Representation**: Freezed immutable classes with @freezed annotation
**Type Strictness**: Gradual typing - explicit types on public API, inference for locals
**Immutability**: Freezed generates copyWith methods; @Default values for nullable fields

Evidence: `lib/src/features/flashing/domain/target_definition.dart`

## Error Handling

**Strategy**: Exception-based with custom error messages; throw Exception('message')
**Propagation**: Try-catch at boundary, rethrow with context; early returns for validation failures

Evidence: `lib/src/features/flashing/utils/firmware_assembler.dart`

## Validation & Boundaries

**Location**: Domain layer and service layer; validators as static utility classes
**Method**: Custom validators returning String? (error message) or null (valid)

Evidence: `lib/src/core/utils/validation_utils.dart`

## Observability

**Logging**: print statements in repositories/services, debugPrint in UI
**Metrics**: Aptabase analytics integration - AnalyticsService with trackEvent() method
**Tracing**: None detected

Evidence: `lib/src/core/analytics/analytics_service.dart`

## Testing Idioms

**Organization**: test/ directory mirroring src/ structure, feature-based
**Fixtures**: Riverpod providers as test fixtures
**Levels**: Unit tests dominant

Evidence: `test/firmware_cache_service_test.dart`

## I/O & Integration

**HTTP Clients**: Dio for HTTP with custom dio providers, ResponseType.bytes for binary
**Resilience**: Basic error handling, no circuit breaker

## Concurrency & Async

**Async Usage**: async/await throughout; Future<T> returns for all I/O
**Parallelism**: Parallel download/extract operations

## Dependency & Configuration

**DI Pattern**: Riverpod @riverpod annotated providers; constructor injection
**Config Loading**: @Default values for optional config; SharedPreferences for settings

## Analytics Patterns

### Service Integration
**Pattern**: AnalyticsService as @Riverpod(keepAlive: true) singleton; reads shareAnalytics setting before tracking

**Code**:
```dart
@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) {
  return AnalyticsService(ref);
}

Future<void> trackEvent(String name, [Map<String, dynamic>? properties]) async {
  final enabled = _ref.read(settingsControllerProvider).shareAnalytics;
  if (!enabled) return;
  // ... track event
}
```

**Evidence**: `lib/src/core/analytics/analytics_service.dart:21-47`

### Initialization
**Pattern**: init() called early in app lifecycle; graceful handling if not initialized (early return with debugPrint)

**Code**:
```dart
// In main.dart
try {
  await container.read(analyticsServiceProvider).init();
} catch (e) {
  debugPrint('[Main] Analytics initialization failed: $e');
}
```

### Event Tracking
**Pattern**: trackEvent(name, [properties]) - optional Map<String, dynamic> for properties

**Events**:
- mDNS: "mDNS Scan Started", "mDNS Fallback Triggered", "mDNS Device Found", "mDNS Scan Failed"
- Flashing: "Firmware Downloaded", "Firmware Download Error", "Firmware Flashed", "Firmware Flash Error"
- Device: "Device Connected", "Device Connection Failed", "Settings Changed"

### shareAnalytics Setting
**Pattern**: @Default(true) for opt-in default, SharedPreferences persistence, setter method

**Code**:
```dart
@Default(true) bool shareAnalytics,

// In loadSettings:
shareAnalytics: prefs.getBool('shareAnalytics') ?? true,

// Setter:
Future<void> setShareAnalytics(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('shareAnalytics', value);
  state = state.copyWith(shareAnalytics: value);
}
```

**Evidence**: `lib/src/features/settings/presentation/settings_controller.dart`

## Widget Lifecycle: Mounted Guards

**Pattern**: if (!ref.mounted) return; placed before all async state mutations

Evidence: `lib/src/features/config/presentation/config_view_model.dart`

## Responsive Layout Patterns

**Breakpoints**: Static constants: tablet=600, desktop=1200, maxContentWidth=800

Evidence: `lib/src/core/presentation/responsive_layout.dart`

## Master-Detail Pattern

**Implementation**: Stateful widget tracking selected category enum; Row layout tablet, single list mobile

Evidence: `lib/src/features/settings/presentation/widgets/settings_master_detail.dart`

## Legacy Removal

**Pattern**: Deprecated methods return early with explanatory comment; no stub implementations

**Example**:
```dart
Future<void> checkForUpdates() async {
  // Legacy Gist update check removed as the app is now on official stores.
  return;
}
```

Evidence: `lib/src/features/updates/presentation/update_controller.dart:13-16`
