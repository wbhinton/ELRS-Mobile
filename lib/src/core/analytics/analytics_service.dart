import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/settings/presentation/settings_controller.dart';

part 'analytics_service.g.dart';

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) {
  return AnalyticsService(ref);
}

class AnalyticsService {
  final Ref _ref;
  bool _isAptabaseInitialized = false;
  Future<void>? _initFuture;
  static const _aptabaseAppId = "A-US-0489684056";

  AnalyticsService(this._ref);

  Future<void> _ensureInitialized() async {
    if (_isAptabaseInitialized) return;
    
    // If initialization is already in progress, wait for it
    if (_initFuture != null) return _initFuture;

    _initFuture = _doInit();
    return _initFuture;
  }

  Future<void> _doInit() async {
    try {
      await Aptabase.init(_aptabaseAppId);
      _isAptabaseInitialized = true;
    } catch (e) {
      debugPrint('[AnalyticsService] Failed to initialize Aptabase: $e');
      _initFuture = null; // Allow retry if it failed
    }
  }

  Future<void> trackEvent(String name, [Map<String, dynamic>? properties]) async {
    final enabled = _ref.read(settingsControllerProvider).shareAnalytics;
    if (enabled) {
      await _ensureInitialized();
      Aptabase.instance.trackEvent(name, properties);
    }
  }
}
