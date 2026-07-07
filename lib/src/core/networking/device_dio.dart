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
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'connection_repository.dart';

part 'device_dio.g.dart';

/// A custom interceptor that forces all HTTP requests to execute sequentially.
/// This prevents the limited ESP8285 hardware web servers from kernel panicking
/// and rebooting due to concurrent connection memory exhaustion.
class SequentialRequestInterceptor extends Interceptor {
  Future<void>? _pendingRequest;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final previousRequest = _pendingRequest;
    final completer = Completer<void>();
    _pendingRequest = completer.future;

    // Await any active request before allowing this one to hit the network
    if (previousRequest != null) {
      try {
        await previousRequest;
      } catch (_) {} // Swallow previous errors so the queue doesn't stall
    }

    // Attach the completer to the request extras so we can resolve it later
    options.extra['lock_completer'] = completer;
    super.onRequest(options, handler);
  }

  void _releaseLock(RequestOptions options) {
    final completer = options.extra['lock_completer'] as Completer<void>?;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
    // Only clear the pending request if we are the one holding the active lock
    if (_pendingRequest == completer?.future) {
      _pendingRequest = null;
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _releaseLock(response.requestOptions);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _releaseLock(err.requestOptions);
    super.onError(err, handler);
  }
}

@riverpod
Dio localDio(Ref ref) {
  // Watch centralized target IP provider
  final ip = ref.watch(targetIpProvider);
  final baseUrl = ip != null ? 'http://$ip' : '';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      // Increased from 10s to 30s to allow ESP hardware more time to accept OTA connections
      connectTimeout: const Duration(seconds: 30),
      // Generous 2-minute timeouts to ensure the physical binary upload completes on slow field Wi-Fi
      receiveTimeout: const Duration(seconds: 120), 
      sendTimeout: const Duration(seconds: 120),
      headers: {
        'User-Agent': 'ELRSMobile/1.0',
      },
    ),
  );

  // Attach the sequential lock to protect ESP8285 hardware
  dio.interceptors.add(SequentialRequestInterceptor());

  return dio;
}

@riverpod
Dio internetDio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'User-Agent': 'ELRSMobile/1.0',
      },
    ),
  );

  // If forceMobileData is true, we might want to do something here,
  // but usually "Internet" traffic should just follow OS default.
  // The "Local" traffic is what we forced to WiFi.
  
  return dio;
}
