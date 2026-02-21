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
  Future<void> bindToWiFi() async {
    print('CONNECTIVITY: Explicitly binding to WiFi...');
    await ref.read(nativeNetworkServiceProvider).bindProcessToWiFi();
  }

  /// Unbinds the app from any specific interface, reverting to OS defaults.
  Future<void> unbind() async {
    print('CONNECTIVITY: Explicitly unbinding process...');
    await ref.read(nativeNetworkServiceProvider).unbindProcess();
  }

  /// Attempts to bind the app to WiFi if we are connected to one.
  Future<void> autoBindIfWiFi() async {
    final results = await Connectivity().checkConnectivity();
    if (results.contains(ConnectivityResult.wifi)) {
      await bindToWiFi();
    } else {
      await unbind();
    }
  }
}
