import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/core/networking/discovery_service.dart';
import 'package:elrs_mobile/src/core/networking/discovery_provider.dart';

class MockDiscoveryService extends Mock implements DiscoveryService {}

void main() {
  late MockDiscoveryService mockService;
  late StreamController<String?> ipController;

  setUp(() {
    mockService = MockDiscoveryService();
    ipController = StreamController<String?>.broadcast();
    
    when(() => mockService.targetIpStream).thenAnswer((_) => ipController.stream);
    when(() => mockService.startScan()).thenAnswer((_) async {});
    when(() => mockService.stopScan()).thenAnswer((_) async {});
  });

  tearDown(() {
    ipController.close();
  });

  test('Provider emits IP when device is found', () async {
    final container = ProviderContainer(
      overrides: [
        discoveryServiceProvider.overrideWithValue(mockService),
      ],
    );
    addTearDown(container.dispose);

    // Listen to the provider to trigger startScan
    // ignore: unused_local_variable
    final sub = container.listen(discoveryProvider, (_, __) {});

    // Act 1: Found device
    ipController.add('192.168.1.50');
    
    // Wait for stream event propagation
    await Future.microtask(() {});

    // Assert
    expect(container.read(discoveryProvider).value, '192.168.1.50');

    // Act 2: Device lost (null)
    ipController.add(null);
    await Future.microtask(() {});

    // Assert
    expect(container.read(discoveryProvider).value, null);
    
    // Check method calls
    verify(() => mockService.startScan()).called(1);
    
    // Cleanup triggers stopScan
    container.dispose();
    verify(() => mockService.stopScan()).called(1);
  });
}
