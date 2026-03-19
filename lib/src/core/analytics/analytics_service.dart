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
  bool _isInitialized = false;
  static const _aptabaseAppId = "A-US-0489684056";

  AnalyticsService(this._ref);

  /// Initializes Aptabase. Should be called early in the app lifecycle.
  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await Aptabase.init(_aptabaseAppId);
      _isInitialized = true;
      debugPrint('[AnalyticsService] Aptabase initialized successfully');
    } catch (e) {
      debugPrint('[AnalyticsService] Failed to initialize Aptabase: $e');
    }
  }

  Future<void> trackEvent(String name, [Map<String, dynamic>? properties]) async {
    if (!_isInitialized) {
      debugPrint('[AnalyticsService] Aptabase not initialized, dropping event: $name');
      return;
    }

    final enabled = _ref.read(settingsControllerProvider).shareAnalytics;
    if (!enabled) return;

    try {
      Aptabase.instance.trackEvent(name, properties);
    } catch (e) {
      debugPrint('[AnalyticsService] Error tracking event $name: $e');
    }
  }
}
