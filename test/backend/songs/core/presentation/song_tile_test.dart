// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_tile.dart';

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
}
