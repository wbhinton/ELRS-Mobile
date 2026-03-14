// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

import 'dart:async';
import 'package:nsd/nsd.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../analytics/analytics_service.dart';

part 'discovery_service.g.dart';

@Riverpod(keepAlive: true)
DiscoveryService discoveryService(Ref ref) {
  return DiscoveryService(ref);
}

class DiscoveryService {
  final Ref _ref;
  Discovery? _discovery;
  final _ipController = StreamController<String?>.broadcast();
  bool _hasFoundDevice = false;

  DiscoveryService(this._ref);

  Stream<String?> get targetIpStream => _ipController.stream;

  Future<void> startScan() async {
    // Prevent multiple scans
    if (_discovery != null) return;

    print(
      'Discovery Service started. (Note: mDNS may not work in Android Emulator)',
    );

    try {
      _ref.read(analyticsServiceProvider).trackEvent('mDNS Scan Started');
      _discovery = await startDiscovery('_http._tcp');
      print(
        'Discovery: mDNS discovery started, scanning for _http._tcp services...',
      );

      // Fallback: If no device found within 3 seconds, assume 10.0.0.1
      Timer(const Duration(seconds: 3), () {
        if (!_hasFoundDevice) {
          print(
            'Discovery: No mDNS device found within 3s, falling back to 10.0.0.1',
          );
          _ref.read(analyticsServiceProvider).trackEvent('mDNS Fallback Triggered');
          _ipController.add('10.0.0.1');
        }
      });

      _discovery!.addListener(() {
        print(
          'Discovery: Service list changed, checking ${_discovery!.services.length} services...',
        );
        // Listener fires on changes. Iterate over services.
        for (final service in _discovery!.services) {
          final name = service.name ?? '';
          print('Discovery: Found service: $name');
          if (name.toLowerCase().contains('elrs')) {
            final host = service.host;
            print('Discovery: ELRS device found at host: $host');
            if (host != null) {
              // Found valid ELRS mDNS
              _hasFoundDevice = true;
              _ref.read(analyticsServiceProvider).trackEvent('mDNS Device Found', {
                'name': name,
                'host': host,
              });
              _ipController.add(host);
            }
          }
        }
      });
    } catch (e) {
      print('Discovery failed: $e');
      _ref.read(analyticsServiceProvider).trackEvent('mDNS Scan Failed', {'error': e.toString()});
    }
  }

  Future<void> stopScan() async {
    if (_discovery != null) {
      await stopDiscovery(_discovery!);
      _discovery = null;
      _hasFoundDevice = false;
      _ipController.add(
        null,
      ); // Emit null to indicate scan stopped / disconnected
    }
  }
}
