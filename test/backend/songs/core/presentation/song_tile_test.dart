// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_tile.dart';

void main() {
  group('SongTile', () {
    testWidgets('contains the artist and title text in a ListTile', (tester) async {
      const song = Song(
        id: 1,
        title: 'title',
        songNumber: 1,
        lyrics: 'lyrics',
        category: 'category',
        artist: 'artist',
        chords: 'chords',
        url: 'url',
      );
      await tester.pumpWidget(
        const MaterialApp(
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

    testWidgets('when icon button pressed favorites song', (tester) async {});
  });
}
