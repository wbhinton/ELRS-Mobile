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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'src/app.dart';
import 'src/core/analytics/analytics_service.dart';

Future<void> main() async {
  // Initialize logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');

    // Pipe logs to Sentry Breadcrumbs
    Sentry.addBreadcrumb(Breadcrumb(
      message: record.message,
      category: record.loggerName,
      level: SentryLevel.info,
    ));
  });

  SentryWidgetsFlutterBinding.ensureInitialized();
  
  // Create a container to access providers before the app starts
  final container = ProviderContainer();
  
  const String sentryDsn = String.fromEnvironment('SENTRY_DSN');
  debugPrint('Sentry DSN: ${sentryDsn.isNotEmpty ? "SET" : "NOT SET"}');
  debugPrint('Sentry Init: Attempting to start...');

  // Pre-initialize Aptabase asynchronously during the boot sequence.
  // We do not 'await' this call so the Splash Screen can render immediately on slow hardware.
  container.read(analyticsServiceProvider).init().catchError((e) {
    debugPrint('[Main] Analytics initialization failed: $e');
  });

  // Instantly paint the UI without waiting for Sentry's heavy native initializers
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );

  if (sentryDsn.isNotEmpty) {
    SentryFlutter.init((options) {
      options.dsn = sentryDsn;
      // Performance monitoring disabled entirely per user preference to focus purely on errors
      options.debug = kDebugMode;
      
      // Sample 50% of captured errors to save event quota in stable maturity
      options.sampleRate = 0.5;

      // Filter out expected, benign network/socket drops that occur during device reboots or disconnects
      options.beforeSend = (event, hint) {
        final throwable = event.throwable;
        if (throwable != null) {
          final errStr = throwable.toString().toLowerCase();
          if (errStr.contains('software caused connection abort') ||
              errStr.contains('connection closed before full header') ||
              errStr.contains('connection reset by peer') ||
              errStr.contains('broken pipe') ||
              errStr.contains('connection refused') ||
              errStr.contains('socketexception') ||
              errStr.contains('handshake failed')) {
            return null; // Ignore network/socket errors
          }
        }
        return event;
      };
    }).catchError((e) {
      debugPrint('[Main] Sentry initialization failed: $e');
    });
  }
}
