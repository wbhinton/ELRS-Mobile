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
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:nsd/nsd.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../analytics/analytics_service.dart';
import 'native_network_service.dart';

part 'discovery_service.g.dart';

@Riverpod(keepAlive: true)
DiscoveryService discoveryService(Ref ref) {
  return DiscoveryService(ref);
}

class DiscoveryService {
  final Ref? _ref;
  final _ipController = StreamController<String?>.broadcast();
  bool _hasFoundDevice = false;
  static final _log = Logger('DiscoveryService');
  
  Discovery? _discovery;
  Timer? _retryTimer;

  DiscoveryService([this._ref]);

  Stream<String?> get targetIpStream => _ipController.stream;
  bool _isScanning = false;

  Future<void> restartScan() async {
    _log.info('Restarting discovery scan...');
    await stopScan();
    await Future.delayed(const Duration(milliseconds: 200));
    await startScan();
  }

  Future<void> startScan() async {
    if (_isScanning || _discovery != null) return;
    _isScanning = true;

    _log.info('Discovery Service started (nsd).');

    try {
      if (Platform.isAndroid) {
        await _ref?.read(nativeNetworkServiceProvider).acquireMulticastLock();
        await _ref?.read(nativeNetworkServiceProvider).bindProcessToWiFi();
      }
      
      _ref?.read(analyticsServiceProvider).trackEvent('mDNS Scan Started');
      
      // Attempt nsd discovery with SocketException suppression
      try {
        _discovery = await startDiscovery('_http._tcp', ipLookupType: IpLookupType.any);
        _discovery?.addListener(() {
          if (_hasFoundDevice) return;
          
          for (final service in _discovery?.services ?? []) {
            final name = service.name?.toLowerCase() ?? '';
            if (name.contains('elrs') || name.contains('expresslrs')) {
              final host = service.addresses?.firstOrNull?.address;
              if (host != null) {
                _log.info('ELRS device found via nsd at host: $host');
                _hasFoundDevice = true;
                _ref?.read(analyticsServiceProvider).trackEvent('mDNS Device Found', {
                  'connection_type': host == '10.0.0.1' ? 'Access Point' : 'Home WiFi',
                  'method': 'nsd'
                });
                _ipController.add(host);
                break;
              }
            }
          }
        });
      } on SocketException catch (e) {
        // Specifically catch and suppress SocketException (errno = 101) per requirement
        _log.warning('mDNS scan failed due to network unreachable: $e. Scan will resume when Wi-Fi is restored.');
      }

      // Retry mechanism: fallback to 10.0.0.1 after 5 seconds if not found
      int retries = 0;
      _retryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_hasFoundDevice || retries >= 5) {
          timer.cancel();
          if (!_hasFoundDevice) {
             _log.info('No mDNS device found within 5s, falling back to 10.0.0.1');
             _ref?.read(analyticsServiceProvider).trackEvent('mDNS Fallback Triggered');
             _ipController.add('10.0.0.1');
          }
          return;
        }
        retries++;
      });
      
    } catch (e) {
      _log.warning('Discovery failed: $e');
      _ref?.read(analyticsServiceProvider).trackEvent('mDNS Scan Failed', {'error': e.toString()});
    }
  }

  Future<void> stopScan() async {
    _isScanning = false;
    _retryTimer?.cancel();
    
    if (_discovery != null) {
      await stopDiscovery(_discovery!);
      _discovery = null;
    }
    
    _hasFoundDevice = false;
    _ipController.add(null);
    
    if (Platform.isAndroid) {
      await _ref?.read(nativeNetworkServiceProvider).releaseMulticastLock();
      await _ref?.read(nativeNetworkServiceProvider).unbindProcess();
    }
  }
}
