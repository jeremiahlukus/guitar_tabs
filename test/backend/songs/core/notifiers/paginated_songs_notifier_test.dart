// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

class MockSongsRepository extends Mock implements FavoriteSongsRepository {}

class MockPlaylistSongsRepository extends Mock implements PlaylistSongsRepository {}

class MockSong extends Mock implements Song {}

void main() {
  group('PaginatedSongsNotifier', () {
    late PaginatedSongsNotifier paginatedSongNotifier;
    late FavoriteSongsRepository mockFavoriteSongRepository;
    const page = 1;
    final songs = [MockSong(), MockSong()];

    setUp(() {
      paginatedSongNotifier = PaginatedSongsNotifier();
      mockFavoriteSongRepository = MockSongsRepository();
    });

    group('.resetState', () {
      test('resets the state to PaginatedSongsState.initial', () async {
        paginatedSongNotifier
          ..state = paginatedSongNotifier.state.copyWith(songs: Fresh.yes(songs))
          ..resetState();

        final actualStateResult = paginatedSongNotifier.state;
        final expectedStateResultMatcher = equals(
          PaginatedSongsState.initial(Fresh.yes([])),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('resets the page to 1 if set to any other page', () {
        paginatedSongNotifier = PaginatedSongsNotifier(page: 10);
        paginatedSongNotifier
          ..state = paginatedSongNotifier.state.copyWith(songs: Fresh.yes(songs))
          ..resetState();

        final actualPageResult = paginatedSongNotifier.page;
        const expectedPageResult = 1;

        expect(actualPageResult, expectedPageResult);
      });
    });

    group('.getNextPage', () {
      test(
          'sets state to the state to PaginatedSongsState.loadFailure if FavoriteSongRepository.getFavoritePage returns a BackendFailure',
          () async {
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (_) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        paginatedSongNotifier.state = paginatedSongNotifier.state.copyWith(songs: Fresh.yes(songs));
        await paginatedSongNotifier.getNextPage(mockFavoriteSongRepository.getFavoritePage);

        final actualStateResult = paginatedSongNotifier.state;
        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadFailure(
            Fresh.yes(songs),
            const BackendFailure.api(400, 'message'),
          ),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test(
          'sets state to PaginatedSongsState.loadSuccess if FavoriteSongRepository.getFavoritePage returns a List<Song>',
          () async {
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (_) => Future.value(right(Fresh.yes(songs))),
        );

        await paginatedSongNotifier.getNextPage(mockFavoriteSongRepository.getFavoritePage);

        final actualStateResult = paginatedSongNotifier.state;
        final expectedStateResultMatcher =
            equals(PaginatedSongsState.loadSuccess(Fresh.yes(songs), isNextPageAvailable: false));

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
  });
}
