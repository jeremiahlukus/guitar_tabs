// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/songs/core/presentation/song_drawer.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockFavoriteSongNotifier extends Mock implements FavoriteSongNotifier {}

void main() {
  group('SongDrawer', () {
    testWidgets('taping the drawer opens and contains DrawerHeader', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: SongDrawer(),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      await tester.tap(find.byType(Drawer));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
    });
  });

  Widget buildWidgetUnderTest() => const MaterialApp(
        home: Scaffold(
          drawer: SongDrawer(),
        ),
      );

  group('FailureTile Golden Test', () {
    goldenTest(
      'renders correctly on mobile',
      fileName: 'SongDrawer',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            device: Device.smallPhone,
            name: 'golden test SongDrawer on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletLandscape,
            name: 'golden test SongDrawer on tablet landscape',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletPortrait,
            name: 'golden test SongDrawer on tablet Portrait',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            name: 'golden test SongDrawer on iphone11',
            builder: buildWidgetUnderTest,
          ),
        ],
      ),
    );
  });
}
