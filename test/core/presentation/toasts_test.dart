// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flash/flash.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:joyful_noise/core/presentation/toasts.dart';

void main() {
  group('showNoConnectionToast', () {
    const dialogMessage = 'Hello, there!';

    testWidgets('shows the Flash widget on the screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));

      // ignore: unawaited_futures
      showNoConnectionToast(dialogMessage, context);

      await tester.pump();

      final finder = find.byType(Flash);

      expect(finder, findsOneWidget);

      /// Needed to let the timer for the dialog complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('shows the dialog message on the screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));

      // ignore: unawaited_futures
      showNoConnectionToast(dialogMessage, context);

      await tester.pump();

      final finder = find.text(dialogMessage);

      expect(finder, findsOneWidget);

      /// Needed to let the timer for the dialog complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });

  group('showHelpToast', () {
    const dialogMessage = 'Hello, there!';

    testWidgets('shows the Flash widget on the screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));

      // ignore: unawaited_futures
      showHelpToast(dialogMessage, context, 2);

      await tester.pump();

      final finder = find.byType(Align);

      expect(finder, findsOneWidget);

      /// Needed to let the timer for the dialog complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('shows the dialog message on the screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));

      // ignore: unawaited_futures
      showHelpToast(dialogMessage, context, 2);

      await tester.pump();

      final finder = find.text(dialogMessage);

      expect(finder, findsOneWidget);

      /// Needed to let the timer for the dialog complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });

  group('showHelpDialog', () {
    const dialogMessage = 'Hello, there!';

    testWidgets('shows the Flash widget on the screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));

      // ignore: unawaited_futures
      showHelpDialog(dialogMessage, context);

      await tester.pump();

      final finder = find.byType(AlertDialog);

      expect(finder, findsOneWidget);
      await tester.tap(find.text('Ok'));
      await tester.pumpAndSettle();
      expect(finder, findsNothing);

      /// Needed to let the timer for the dialog complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('shows the dialog message on the screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));

      // ignore: unawaited_futures
      showHelpDialog(dialogMessage, context);

      await tester.pump();

      final finder = find.text(dialogMessage);

      expect(finder, findsOneWidget);

      /// Needed to let the timer for the dialog complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
