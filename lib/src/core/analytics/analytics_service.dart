import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/settings/presentation/settings_controller.dart';

part 'analytics_service.g.dart';

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) {
  return AnalyticsService(ref);
}

class AnalyticsService {
  final Ref _ref;

  AnalyticsService(this._ref);

  void trackEvent(String name, [Map<String, dynamic>? properties]) {
    final enabled = _ref.read(settingsControllerProvider).shareAnalytics;
    if (enabled) {
      Aptabase.instance.trackEvent(name, properties);
    }
  }
}
