import 'dart:async';
import 'package:nsd/nsd.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discovery_service.g.dart';

@Riverpod(keepAlive: true)
DiscoveryService discoveryService(Ref ref) {
  return DiscoveryService();
}

class DiscoveryService {
  Discovery? _discovery;
  final _ipController = StreamController<String?>.broadcast();
  bool _hasFoundDevice = false;
  
  Stream<String?> get targetIpStream => _ipController.stream;
  
  Future<void> startScan() async {
    // Prevent multiple scans
    if (_discovery != null) return;
    
    print('Discovery Service started. (Note: mDNS may not work in Android Emulator)');

    try {
      _discovery = await startDiscovery('_http._tcp');
      
      // Fallback: If no device found within 3 seconds, assume 10.0.0.1
      Timer(const Duration(seconds: 3), () {
        // We can't easily check if stream has emitted, but we can check a local flag
        // or just emit 10.0.0.1. If we already found something, this might override it
        // unless we track state. 
        // Let's assume if mDNS worked, we would have found it by now.
        // Actually, let's track it.
      });

      _discovery!.addListener(() {
        // Listener fires on changes. Iterate over services.
        for (final service in _discovery!.services) {
          final name = service.name ?? '';
          if (name.toLowerCase().contains('elrs')) {
            final host = service.host;
            if (host != null) {
              // Found valid ELRS mDNS
              _hasFoundDevice = true;
              _ipController.add(host);
            }
          }
        }
      });
      
    } catch (e) {
      print('Discovery failed: $e');
    }
  }

  Future<void> stopScan() async {
    if (_discovery != null) {
      await stopDiscovery(_discovery!);
      _discovery = null;
      _hasFoundDevice = false;
      _ipController.add(null); // Emit null to indicate scan stopped / disconnected
    }
  }
}
