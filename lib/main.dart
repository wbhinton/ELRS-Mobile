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
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  const String sentryDsn = String.fromEnvironment('SENTRY_DSN');
  debugPrint('[Sentry] DSN loaded: ${sentryDsn.isNotEmpty ? "YES ✓" : "NO — check dart-defines"}');

  try {
    await Aptabase.init("A-US-0489684056");
    debugPrint('[Aptabase] Initialized successfully');
  } catch (e) {
    debugPrint('[Aptabase] Failed to initialize: $e');
  }

  if (sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        // Adjust these as needed
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const App()),
    );
  } else {
    runApp(const App());
  }
}
