// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:joyful_noise/backend/songs/core/presentation/song_tile.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

void main() {
  group('SongTile', () {
    testWidgets('contains the artist and title text in a ListTile', (tester) async {
      final song = mockSong(1);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SongTile(
              song: song,
            ),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      final listTileFinder = find.byType(ListTile);

      expect(listTileFinder, findsOneWidget);
      expect(find.text('new 1'), findsOneWidget);
      expect(find.text('artist'), findsOneWidget);
    });

    testWidgets('when icon button pressed favorites song', (tester) async {
      final song = mockSong(1);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SongTile(
              song: song,
            ),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      final favoriteSongsButton = find.byKey(SongTile.favoriteSongButtonKey);
      await tester.tap(favoriteSongsButton);
      await tester.pumpAndSettle();

      // TODO(jeremiah): once tap method implemented test and remove
      final listTileFinder = find.byType(ListTile);
      expect(listTileFinder, findsOneWidget);
    });
  });

  group('SongTile Golden Test', () {
    Widget buildWidgetUnderTest() => MaterialApp(
          home: Scaffold(
            body: SongTile(
              song: mockSong(1),
            ),
          ),
        );

    goldenTest(
      'renders correctly on mobile',
      fileName: 'SongTile',
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
