// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/presentation/no_results_display.dart';

void main() {
  group('NoResultsDisplay', () {
    testWidgets('contains the artist and title text in a ListTile', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoResultsDisplay(
              message: 'No Results Test',
            ),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      final iconFinder = find.byType(Icon);

      expect(iconFinder, findsOneWidget);
      expect(find.text('No Results Test'), findsOneWidget);
    });
  });
}
