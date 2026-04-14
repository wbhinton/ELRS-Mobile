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

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'native_network_service.dart';

part 'connectivity_service.g.dart';

@Riverpod(keepAlive: true)
class ConnectivityService extends _$ConnectivityService {
  static final _log = Logger('ConnectivityService');

  @override
  Stream<List<ConnectivityResult>> build() {
    return Connectivity().onConnectivityChanged;
  }

  Future<bool>? _bindingFuture;
  bool _isBound = false;
  bool _lockAcquired = false;

  /// Binds the app process to the current WiFi interface.
  /// Returns true if successful.
  Future<bool> bindToWiFi({int retries = 3}) {
    if (_bindingFuture != null) return _bindingFuture!;
    _bindingFuture = _executeBind(retries: retries).whenComplete(() {
      _bindingFuture = null;
    });
    return _bindingFuture!;
  }

  Future<bool> _executeBind({int retries = 3}) async {
    for (var i = 0; i < retries; i++) {
      _log.info('Binding attempt ${i + 1}...');
      try {
        final native = ref.read(nativeNetworkServiceProvider);
        
        await native.bindProcessToWiFi().timeout(const Duration(seconds: 4));
        _isBound = true;
        
        await native.acquireMulticastLock();
        _lockAcquired = true;
        
        return true;
      } catch (e) {
        _log.warning('Binding attempt ${i + 1} failed: $e');
        if (i < retries - 1) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }
    return false;
  }

  /// Unbinds the process and releases locks.
  Future<void> unbind() async {
    _log.info('Explicitly unbinding process and releasing locks...');
    final native = ref.read(nativeNetworkServiceProvider);
    await native.releaseMulticastLock();
    _lockAcquired = false;
    await native.unbindProcess();
    _isBound = false;
  }

  /// Executes an action with the process guaranteed to be unbound from any
  /// local-only interfaces. This ensures the request can use the system's 
  /// best available internet route (e.g. cellular fallback).
  Future<T> withInternetAccess<T>(Future<T> Function() action) async {
    if (_isBound) {
      _log.info('Temporarily unbinding for internet access...');
      await unbind();
    }
    return await action();
  }

  /// Ensures the process is bound to WiFi and the multicast lock is acquired.
  /// Does NOT trigger a discovery scan restart.
  Future<void> ensureBound() async {
    if (_isBound && _lockAcquired) return;
    _log.info('Ensuring process is bound to WiFi...');
    await bindToWiFi();
  }

  /// Attempts to bind the app to WiFi if we are connected to one.
  Future<void> autoBindIfWiFi() async {
    final results = await Connectivity().checkConnectivity();
    _log.info('Check results: $results (length: ${results.length})');
    _log.info(
      'Contains wifi: ${results.contains(ConnectivityResult.wifi)}',
    );
    _log.info(
      'Contains cellular: ${results.contains(ConnectivityResult.mobile)}',
    );

    // If we have any network connections, try to bind to WiFi
    // This handles the case where WiFi has no internet but we're still connected
    if (results.contains(ConnectivityResult.wifi)) {
      _log.info('WiFi detected, assessing internet capability...');
      
      final native = ref.read(nativeNetworkServiceProvider);
      await native.acquireMulticastLock();
      _lockAcquired = true;

      // Smart Auto-Bind: 
      // Only bind automatically if the WiFi LACKS internet (not validated).
      // This makes AP Mode "Just Work" (like an app reboot) while keeping 
      // Home WiFi open for internet (Artifactory/GitHub).
      final isInternetAvailable = await native.isWiFiValidated();
      if (!isInternetAvailable && !_isBound) {
        _log.info('WiFi lacks internet (AP Mode), triggering automatic bind...');
        await bindToWiFi();
      } else if (isInternetAvailable && _isBound) {
        _log.info('WiFi has internet (Home Mode), ensuring process is unbound...');
        await unbind();
      }
    } else if (results.isEmpty || !results.contains(ConnectivityResult.wifi)) {
      // ONLY unbind if we truly lost WiFi. 
      // This prevents ConnectivityResult.mobile from unbinding a WiFi AP (10.0.0.1) 
      // that lacks internet access during subtle OS network assessments.
      _log.info('WiFi connection lost or none detected, unbinding...');
      if (_isBound || _lockAcquired) {
        await unbind();
      }
    }
  }
}
