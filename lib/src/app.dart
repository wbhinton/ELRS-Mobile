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

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'router.dart';
import 'core/networking/connectivity_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: _AppContent(),
    );
  }
}

class _AppContent extends HookConsumerWidget {
  const _AppContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    
    // Automatic Network Binding
    useEffect(() {
      // Run initial check
      Future.microtask(() => ref.read(connectivityServiceProvider.notifier).autoBindIfWiFi());
      return null;
    }, []);

    // Listen for network changes
    ref.listen(connectivityServiceProvider, (prev, next) {
      ref.read(connectivityServiceProvider.notifier).autoBindIfWiFi();
    });

    return MaterialApp.router(
      title: 'ELRS Mobile',
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
