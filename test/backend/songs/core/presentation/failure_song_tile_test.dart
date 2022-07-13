import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/core/presentation/failure_song_tile.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/presentation/favorite_songs_page.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import 'package:joyful_noise/core/shared/providers.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class FakeSongNotifier extends FavoriteSongNotifier {
  FakeSongNotifier(FavoriteSongsRepository favoriteSongRepository) : super(favoriteSongRepository);

  @override
  Future<void> getNextFavoriteSongsPage() async {
    const songs = [
      Song(
        id: 1,
        title: 'New Song',
        lyrics: 'lyrics',
        category: 'category',
        artist: 'artist',
        chords: 'chords',
        url: 'url',
        songNumber: 1,
      ),
      Song(
        id: 2,
        title: 'title 2',
        lyrics: 'lyrics 2',
        category: 'category 2',
        artist: 'artist 2',
        chords: 'chords 2',
        url: 'url 2',
        songNumber: 2,
      )
    ];
    state = PaginatedSongsState.loadSuccess(Fresh.yes(songs), isNextPageAvailable: true);
    return;
  }
}

void main() {
  group('FailureSongTile', () {
    testWidgets('contains the error code and error text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FailureSongTile(
              backendFailure: BackendFailure.api(400, 'message'),
            ),
          ),
        ),
      );
      await tester.pump(Duration.zero);

      expect(find.text('An error occurred please retry'), findsOneWidget);
      expect(find.text('API returned: 400'), findsOneWidget);
    });

    testWidgets('when icon button pressed loads new songs', (tester) async {
      final FavoriteSongNotifier fakeFavoriteSongNotifier = FakeSongNotifier(MockFavoriteSongRepository());
      const songs = [
        Song(
          id: 1,
          title: 'New Song',
          lyrics: 'lyrics',
          category: 'category',
          artist: 'artist',
          chords: 'chords',
          url: 'url',
          songNumber: 1,
        ),
        Song(
          id: 2,
          title: 'title 2',
          lyrics: 'lyrics 2',
          category: 'category 2',
          artist: 'artist 2',
          chords: 'chords 2',
          url: 'url 2',
          songNumber: 2,
        )
      ];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoriteSongsNotifierProvider.overrideWithValue(
              fakeFavoriteSongNotifier,
            ),
          ],
          child: const MaterialApp(
            home: FailureSongTile(
              backendFailure: BackendFailure.api(400, 'message'),
            ),
          ),
        ),
      );

      await tester.pump(Duration.zero);
      final getNextFavoriteSongsButton = find.byKey(FailureSongTile.getNextFavoriteSongsButtonKey);

      await tester.tap(getNextFavoriteSongsButton);

      await tester.pumpAndSettle();
      logger.e(find.byElementType(Text));
      expect(find.text('New Song'), findsOneWidget);
    });
  });
}
