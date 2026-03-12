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
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'native_network_service.dart';

part 'connectivity_service.g.dart';

@Riverpod(keepAlive: true)
class ConnectivityService extends _$ConnectivityService {
  @override
  Stream<List<ConnectivityResult>> build() {
    return Connectivity().onConnectivityChanged;
  }

  /// Binds the app process to the current WiFi interface.
  /// Returns true if successful.
  Future<bool> bindToWiFi({int retries = 3}) async {
    for (var i = 0; i < retries; i++) {
      print('CONNECTIVITY: Binding attempt ${i + 1}...');
      try {
        await ref.read(nativeNetworkServiceProvider).bindProcessToWiFi();
        // We assume success if no exception, though the native side logs detail.
        return true;
      } catch (e) {
        print('CONNECTIVITY: Binding attempt ${i + 1} failed: $e');
        if (i < retries - 1) {
          await Future.delayed(const Duration(seconds: 1));
        }
      }
    }
    return false;
  }

  /// Unbinds the app from any specific interface, reverting to OS defaults.
  Future<void> unbind() async {
    print('CONNECTIVITY: Explicitly unbinding process...');
    await ref.read(nativeNetworkServiceProvider).unbindProcess();
  }

  /// Attempts to bind the app to WiFi if we are connected to one.
  Future<void> autoBindIfWiFi() async {
    final results = await Connectivity().checkConnectivity();
    print('CONNECTIVITY: Check results: $results (length: ${results.length})');
    print(
      'CONNECTIVITY: Contains wifi: ${results.contains(ConnectivityResult.wifi)}',
    );
    print(
      'CONNECTIVITY: Contains cellular: ${results.contains(ConnectivityResult.mobile)}',
    );

    // If we have any network connections, try to bind to WiFi
    // This handles the case where WiFi has no internet but we're still connected
    if (results.isNotEmpty) {
      print('CONNECTIVITY: We have network connections, attempting bind...');
      final success = await bindToWiFi();
      if (!success) {
        print('CONNECTIVITY: Auto-bind failed after retries.');
      } else {
        print('CONNECTIVITY: Auto-bind succeeded!');
      }
    } else {
      print('CONNECTIVITY: No network connections detected, unbinding...');
      await unbind();
    }
  }
}
