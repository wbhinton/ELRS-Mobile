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
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:nsd/nsd.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'connectivity_service.dart';
import '../../features/flashing/state/flashing_provider.dart';

part 'discovery_service.g.dart';

@Riverpod(keepAlive: true)
DiscoveryService discoveryService(Ref ref) {
  final service = DiscoveryService(ref);

  // ── Connectivity: proactive discovery ────────────────────────────────────
  // Automatically restart the mDNS scan whenever the network interface changes.
  // This ensures we pick up the device at its new IP (e.g. Home WiFi vs AP) 
  // without requiring a manual "Retry" click.
  ref.listen<AsyncValue<List<ConnectivityResult>>>(
    connectivityServiceProvider, 
    (previous, next) {
      if (ref.read(isFlashingProvider)) return;
      
      final prevResults = previous?.value ?? [];
      final nextResults = next.value ?? [];
      
      final hadWifi = prevResults.contains(ConnectivityResult.wifi);
      final hasWifi = nextResults.contains(ConnectivityResult.wifi);
      
      // Only act on actual transitions of Wi-Fi state
      if (hasWifi && !hadWifi) {
        service.restartScan();
      } else if (!hasWifi && hadWifi) {
        service.stopScan();
      }
    }
  );

  return service;
}

class DiscoveryService {
  final Ref? _ref;
  final _ipController = StreamController<String?>.broadcast();
  bool _hasFoundDevice = false;
  static final _log = Logger('DiscoveryService');
  
  Discovery? _discovery;
  Future<void>? _pendingOperation;

  DiscoveryService([this._ref]);

  Stream<String?> get targetIpStream => _ipController.stream;
  bool _isScanning = false;

  /// Serializes operations sequentially to prevent concurrent socket binding races
  Future<void> _runOperation(Future<void> Function() operation) async {
    final previousOp = _pendingOperation;
    final completer = Completer<void>();
    _pendingOperation = completer.future;

    try {
      if (previousOp != null) {
        await previousOp;
      }
      await operation();
    } finally {
      completer.complete();
      if (_pendingOperation == completer.future) {
        _pendingOperation = null;
      }
    }
  }

  Future<void> restartScan() {
    return _runOperation(() async {
      _log.info('Restarting discovery scan...');
      await _stopScan();
      await Future.delayed(const Duration(milliseconds: 200));
      await _startScan();
    });
  }

  Future<void> startScan() {
    return _runOperation(() => _startScan());
  }

  Future<void> stopScan() {
    return _runOperation(() => _stopScan());
  }

  Future<void> _startScan() async {
    if (_isScanning || _discovery != null) return;

    // Guard Clause: Only scan if connected to Wi-Fi to prevent cellular socket crashes
    final connectivityAsync = _ref?.read(connectivityServiceProvider);
    final results = connectivityAsync?.value ?? [];
    if (!results.contains(ConnectivityResult.wifi)) {
      _log.warning('Aborting mDNS startup: Device is not on local Wi-Fi.');
      return;
    }

    _isScanning = true;

    _log.info('Discovery Service started (nsd).');
      
    // Attempt nsd discovery with SocketException suppression
    try {
      _discovery = await startDiscovery('_http._tcp', ipLookupType: IpLookupType.any);
      _discovery?.addListener(() {
        if (_hasFoundDevice) return;
        
        for (final service in _discovery?.services ?? []) {
          final name = service.name?.toLowerCase() ?? '';
          if (name.contains('elrs') || name.contains('expresslrs')) {
            final addresses = service.addresses;
            final host = (addresses != null && addresses.isNotEmpty) 
                ? addresses.first.address 
                : null;
            if (host != null) {
              _log.info('ELRS device found via nsd at host: $host');
              _hasFoundDevice = true;
              _ipController.add(host);
              break;
            }
          }
        }
      });
    } on SocketException catch (e) {
      // Suppress SocketException (errno = 101 / errno = 48) — reset scanning flag
      // so the startScan() guard doesn't permanently block future scan attempts.
      _log.warning('mDNS scan failed (SocketException): $e. Resetting scan state; will resume when Wi-Fi is restored.');
      _isScanning = false;
    } catch (e) {
      _log.warning('Discovery failed to start: $e');
    }
  }

  Future<void> _stopScan() async {
    // Await full teardown of the nsd discovery session before resetting the
    // scanning flag. This prevents restartScan()'s startScan() call from
    // re-entering while the underlying UDP port (5353) is still bound,
    // which would trigger errno = 48 (Address already in use) on iOS/iPadOS.
    if (_discovery != null) {
      try {
        await stopDiscovery(_discovery!);
      } catch (e) {
        _log.warning('Error stopping nsd discovery session: $e');
      } finally {
        _discovery = null;
      }
    }

    // Only mark scanning as stopped after the socket is fully released.
    _isScanning = false;
    _hasFoundDevice = false;
    _ipController.add(null);
  }

  /// Resets the found-device flag so the mDNS listener can fire again
  /// after a device disconnects or reboots — without tearing down the
  /// entire nsd session.
  void resetFoundState() {
    _hasFoundDevice = false;
    _log.info('mDNS found-state reset — listening for new device advertisements.');

    // If we already have active services in the current nsd session, check them
    // immediately to avoid the "ignored cache" issue where the listener doesn't fire.
    final services = _discovery?.services;
    if (services != null && services.isNotEmpty) {
      for (final service in services) {
        final name = service.name?.toLowerCase() ?? '';
        if (name.contains('elrs') || name.contains('expresslrs')) {
          final addresses = service.addresses;
          final host = (addresses != null && addresses.isNotEmpty)
              ? addresses.first.address
              : null;
          if (host != null) {
            _log.info('mDNS found-state reset: Found cached device in services list at host: $host');
            _hasFoundDevice = true;
            _ipController.add(host);
            break;
          }
        }
      }
    }
  }
}
