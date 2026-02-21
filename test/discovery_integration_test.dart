import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/core/networking/discovery_provider.dart';
import 'package:elrs_mobile/src/features/flashing/data/device_repository.dart';
import 'package:elrs_mobile/src/core/networking/connection_repository.dart';
import 'package:elrs_mobile/src/features/dashboard/presentation/widgets/connection_status_badge.dart';

void main() {
  group('Discovery Integration Test', () {
    test('Repository updates Base URL when Discovery finds device', () async {
      // Setup
      final controller = StreamController<String?>.broadcast();
      addTearDown(controller.close);

      final container = ProviderContainer(
        overrides: [
          discoveryProvider.overrideWith((ref) => controller.stream),
        ],
      );
      addTearDown(container.dispose);

      // Keep the provider alive and print logic
      container.listen(discoveryProvider, (previous, next) {
        print('Provider Transition: $previous -> $next');
      });

      // Act 1 (Default/Initial State - null)
      // StreamProvider starts with AsyncLoading.
      // We emit null.
      controller.add(null);
      await Future.microtask(() {});
      await Future.delayed(const Duration(milliseconds: 50));
      
      // Check if we have data
      // Read Repo
      var repo = container.read(deviceRepositoryProvider);
      
      // Assert Default (It should be either empty or contain the default fallback)
      expect(repo.dio.options.baseUrl, isNotNull);

      // Act 2 (Discovery)
      controller.add('192.168.1.55');
      // In the real app, a listener on discoveryProvider updates targetIpProvider.
      // In this test, we must simulate that update since we are testing the repository's reaction to the provider state.
      container.read(targetIpProvider.notifier).updateIp('192.168.1.55');
      
      // Wait for stream propagation
      await Future.delayed(const Duration(milliseconds: 50));
      
      // Verify provider updated
      final ipState = container.read(discoveryProvider);
      if (ipState.isLoading) {
         // wait a bit more if needed
         await Future.delayed(const Duration(milliseconds: 50));
      }
      print('Final Provider Value: ${container.read(discoveryProvider)}');

      // Read Repo again 
      repo = container.read(deviceRepositoryProvider);
      print('Repo Base URL: ${repo.dio.options.baseUrl}');

      // Assert New IP
      expect(repo.dio.options.baseUrl, contains('192.168.1.55'));
    });

    testWidgets('Badge shows Green when connected', (tester) async {
      final controller = StreamController<String?>.broadcast();
      addTearDown(controller.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            discoveryProvider.overrideWith((ref) => controller.stream),
          ],
          child: const MaterialApp(home: Scaffold(body: ConnectionStatusBadge())),
        ),
      );
      
      // Initial state is Loading -> "Scanning..."
      expect(find.text('Scanning...'), findsOneWidget);

      // Act 1: Searching (null)
      controller.add(null);
      await tester.pump(const Duration(milliseconds: 100)); // Allow stream to emit
      await tester.pump(); // Rebuild UI

      // Assert Searching/Scanning
      await tester.pump(const Duration(milliseconds: 100)); 
      expect(find.byWidgetPredicate((w) => w is Icon && (w.icon == Icons.wifi_off || w.icon == Icons.wifi_find)), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is Text && (w.data?.contains('Scanning') == true || w.data?.contains('Searching') == true || w.data?.contains('No Device') == true)), findsOneWidget);

      // Act 2: Connected
      controller.add('192.168.1.55');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();

      // Assert Connected
      expect(find.byIcon(Icons.wifi), findsOneWidget);
      expect(find.textContaining('192.168.1.55'), findsOneWidget);
    });
  });
}
