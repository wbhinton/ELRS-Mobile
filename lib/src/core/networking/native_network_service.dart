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

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_network_service.g.dart';

@riverpod
NativeNetworkService nativeNetworkService(Ref ref) {
  return NativeNetworkService();
}

class NativeNetworkService {
  static const _channel = MethodChannel('org.expresslrs.elrs_mobile/network');

  /// Binds the entire app process to the WiFi network even if it lacks internet access.
  /// This prevents the OS from routing traffic to 10.0.0.1 over cellular.
  Future<void> bindProcessToWiFi() async {
    try {
      await _channel.invokeMethod('bindProcessToWiFi');
      print('NATIVE: Process bound to WiFi interface');
    } on PlatformException catch (e) {
      print('NATIVE: Failed to bind to WiFi: ${e.message}');
    }
  }

  /// Unbinds the process from the specific network, returning to default OS routing.
  Future<void> unbindProcess() async {
    try {
      await _channel.invokeMethod('unbindProcess');
      print('NATIVE: Process unbound from specific interface');
    } on PlatformException catch (e) {
      print('NATIVE: Failed to unbind: ${e.message}');
    }
  }
}
