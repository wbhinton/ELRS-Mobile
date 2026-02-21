import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_screen.dart';
import 'package:elrs_mobile/src/core/theme/app_theme.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_provider.dart';
import 'package:elrs_mobile/src/features/flashing/data/releases_repository.dart';
void main() {
  testWidgets('FlashingScreen loads with correct title and button', (WidgetTester tester) async {
    // Setup
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
           targetsProvider.overrideWith((ref) => Future.value([])),
           releasesProvider.overrideWith((ref) => Future.value([])),
        ],
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const FlashingScreen(),
        ),
      ),
    );

    // Act
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('ELRS Mobile'), findsOneWidget);
    expect(find.text('FLASH'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('App applies Dark Mode background', (WidgetTester tester) async {
    // Setup
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          targetsProvider.overrideWith((ref) => Future.value([])),
          releasesProvider.overrideWith((ref) => Future.value([])),
        ],
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const FlashingScreen(),
        ),
      ),
    );

    // Act
    await tester.pumpAndSettle();

    // Assert
    final BuildContext context = tester.element(find.byType(Scaffold));
    final ThemeData theme = Theme.of(context);
    expect(theme.scaffoldBackgroundColor, equals(AppTheme.background));
  });
}
