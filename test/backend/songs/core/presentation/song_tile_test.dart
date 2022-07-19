// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:alchemist/alchemist.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_tile.dart';

import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockSong extends Mock implements Song {}

void main() {
  group('SongTile', () {
    testWidgets('contains the artist and title text in a ListTile', (tester) async {
      final song = MockSong();
      when(() => song.artist).thenReturn('artist');
      when(() => song.title).thenReturn('title');

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
      expect(find.text('title'), findsOneWidget);
      expect(find.text('artist'), findsOneWidget);
    });

    testWidgets('when icon button pressed favorites song', (tester) async {
      final song = MockSong();
      when(() => song.artist).thenReturn('artist');
      when(() => song.title).thenReturn('title');
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

  final song = MockSong();
  when(() => song.artist).thenReturn('artist');
  when(() => song.title).thenReturn('title');
  Widget buildWidgetUnderTest() => const MaterialApp(
        home: Scaffold(
          body: SongTile(
            song: Song(
              id: 1,
              title: 'title',
              lyrics: 'lyrics',
              category: 'category',
              artist: 'artist',
              chords: 'chords',
              url: 'url',
              songNumber: 1,
            ),
          ),
        ),
      );

  group('SongTile Golden Test', () {
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
