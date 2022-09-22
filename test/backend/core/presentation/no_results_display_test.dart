// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/presentation/no_results_display.dart';
import '../../../utils/device.dart';
import '../../../utils/golden_test_device_scenario.dart';

void main() {
  group('NoResultsDisplay', () {
    testWidgets('contains no results text', (tester) async {
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
  Widget buildWidgetUnderTest() => const MaterialApp(
        home: Scaffold(
          body: NoResultsDisplay(
            message: 'No Results Test',
          ),
        ),
      );

  group('NoResultsDisplay Golden Test', () {
    goldenTest(
      'renders correctly on mobile',
      fileName: 'NoResultsDisplay',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            device: Device.smallPhone,
            name: 'golden test SongTile on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletLandscape,
            name: 'golden test SongTile on tablet landscape',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletPortrait,
            name: 'golden test SongTile on tablet Portrait',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            name: 'golden test SongTile on iphone11',
            builder: buildWidgetUnderTest,
          ),
        ],
      ),
    );
  });
}
