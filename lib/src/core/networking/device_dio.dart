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

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'connection_repository.dart';

part 'device_dio.g.dart';

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
