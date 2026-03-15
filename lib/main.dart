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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'src/app.dart';
import 'src/core/analytics/analytics_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create a container to access providers before the app starts
  final container = ProviderContainer();
  
  const String sentryDsn = String.fromEnvironment('SENTRY_DSN');
  debugPrint('[Sentry] DSN loaded: ${sentryDsn.isNotEmpty ? "YES ✓" : "NO — check dart-defines"}');

  // Pre-initialize Aptabase during the boot sequence.
  // This ensures the SDK state is ready even before the user opts-in to tracking.
  try {
    await container.read(analyticsServiceProvider).init();
  } catch (e) {
    debugPrint('[Main] Analytics initialization failed: $e');
  }

  if (sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      ),
    );
  } else {
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const App(),
      ),
    );
  }
}
