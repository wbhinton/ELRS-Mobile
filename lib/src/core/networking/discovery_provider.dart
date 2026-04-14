import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'connectivity_service.dart';
import 'discovery_service.dart';

part 'discovery_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<String?> discovery(Ref ref) {
  final service = ref.watch(discoveryServiceProvider);

  bool? lastWasWifi;
  Timer? stopTimer;

  // Listen to connectivity changes to start/stop scanning
  ref.listen(connectivityServiceProvider, (previous, next) {
    final results = next.value ?? [];
    final isWifi = results.contains(ConnectivityResult.wifi);

    // Only react if the Wi-Fi state has distinctly changed
    if (isWifi == lastWasWifi) return;
    lastWasWifi = isWifi;

    if (isWifi) {
      // Reconnected to Wi-Fi: cancel any pending stop and start immediately
      stopTimer?.cancel();
      service.startScan();
    } else {
      // Disconnected from Wi-Fi: debounce stopScan() to ignore transient blips
      stopTimer?.cancel();
      stopTimer = Timer(const Duration(milliseconds: 500), () {
        service.stopScan();
      });
    }
  }, fireImmediately: true);

  // Ensure cleanup on disposal
  ref.onDispose(() {
    stopTimer?.cancel();
    service.stopScan();
  });

  return service.targetIpStream;
}
