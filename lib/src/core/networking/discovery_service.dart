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
  
  final List<RawDatagramSocket> _sockets = [];
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
    if (_isScanning || _sockets.isNotEmpty) return;
    _isScanning = true;

    _log.info('Discovery Service started (RawDatagramSocket).');

    try {
      if (Platform.isAndroid) {
        await _ref?.read(nativeNetworkServiceProvider).acquireMulticastLock();
        await _ref?.read(nativeNetworkServiceProvider).bindProcessToWiFi();
      }
      
      _ref?.read(analyticsServiceProvider).trackEvent('mDNS Scan Started');
      
      final interfaces = await NetworkInterface.list(
        includeLinkLocal: false,
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );

      final address = InternetAddress('224.0.0.251');
      const port = 5353;
      
      // Standard mDNS PTR query for _http._tcp.local
      final query = <int>[
        0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 
        0x00, 0x00, 0x00, 0x00, 0x05, 0x5f, 0x68, 0x74, 
        0x74, 0x70, 0x04, 0x5f, 0x74, 0x63, 0x70, 0x05, 
        0x6c, 0x6f, 0x63, 0x61, 0x6c, 0x00, 0x00, 0x0c, 
        0x00, 0x01
      ];

      for (final interface in interfaces) {
        // Broadly accept wlan, en (iOS/macOS), or eth interfaces
        if (interface.name.toLowerCase().contains('wlan') || 
            interface.name.toLowerCase().contains('en') || 
            interface.name.toLowerCase().contains('eth')) {
          _log.info('Binding mDNS to interface: ${interface.name}');
          final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5353, reuseAddress: true);
          socket.multicastHops = 255;
          socket.joinMulticast(address, interface);
          
          socket.listen((event) {
            if (event == RawSocketEvent.read) {
              final datagram = socket.receive();
              if (datagram != null) {
                // Check if the response contains "elrs" or "expresslrs" in ASCII
                final responseStr = String.fromCharCodes(datagram.data).toLowerCase();
                if (responseStr.contains('elrs') || responseStr.contains('expresslrs')) {
                  final host = datagram.address.address;
                  if (!_hasFoundDevice) {
                    _log.info('ELRS device found via raw mDNS at host: $host');
                    _hasFoundDevice = true;
                    _ref?.read(analyticsServiceProvider).trackEvent('mDNS Device Found', {
                      'connection_type': host == '10.0.0.1' ? 'Access Point' : 'Home WiFi',
                      'method': 'RawDatagramSocket'
                    });
                    _ipController.add(host);
                  }
                }
              }
            }
          });
          
          _sockets.add(socket);
        }
      }

      // Retry mechanism: blast query every second for 5 seconds
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
        
        for (final socket in _sockets) {
          socket.send(query, address, port);
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
    
    for (final socket in _sockets) {
      socket.close();
    }
    _sockets.clear();
    
    _hasFoundDevice = false;
    _ipController.add(null);
    
    if (Platform.isAndroid) {
      await _ref?.read(nativeNetworkServiceProvider).releaseMulticastLock();
      await _ref?.read(nativeNetworkServiceProvider).unbindProcess();
    }
  }
}
