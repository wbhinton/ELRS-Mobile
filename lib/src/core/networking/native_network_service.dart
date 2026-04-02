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

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_network_service.g.dart';

@riverpod
NativeNetworkService nativeNetworkService(Ref ref) {
  return NativeNetworkService();
}

class NativeNetworkService {
  static final _log = Logger('NativeNetworkService');
  static const _channel = MethodChannel('org.expresslrs.elrs_mobile/network');

  /// Binds the entire app process to the WiFi network even if it lacks internet access.
  /// This prevents the OS from routing traffic to 10.0.0.1 over cellular.
  Future<void> bindProcessToWiFi() async {
    if (Platform.isIOS) return;
    try {
      await _channel.invokeMethod('bindProcessToWiFi');
      _log.info('Process bound to WiFi interface');
    } on Exception catch (e) {
      _log.warning('Failed to bind to WiFi: $e');
    }
  }

  /// Unbinds the process from the specific network, returning to default OS routing.
  Future<void> unbindProcess() async {
    if (Platform.isIOS) return;
    try {
      await _channel.invokeMethod('unbindProcess');
      _log.info('Process unbound from specific interface');
    } on Exception catch (e) {
      _log.warning('Failed to unbind: $e');
    }
  }

  /// Acquires a multicast lock on Android to allow mDNS discovery.
  Future<void> acquireMulticastLock() async {
    if (Platform.isIOS) return;
    try {
      await _channel.invokeMethod('acquireMulticastLock');
      _log.info('Multicast lock acquired');
    } on Exception catch (e) {
      _log.warning('Failed to acquire multicast lock: $e');
    }
  }

  /// Releases the multicast lock.
  Future<void> releaseMulticastLock() async {
    if (Platform.isIOS) return;
    try {
      await _channel.invokeMethod('releaseMulticastLock');
      _log.info('Multicast lock released');
    } on Exception catch (e) {
      _log.warning('Failed to release multicast lock: $e');
    }
  }
}
