// Package imports:
import 'package:dartz/dartz.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/notifiers/playlist_songs_notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

class MockFavoriteSongRepository extends Mock implements PlaylistSongsRepository {}

class MockSong extends Mock implements Song {}

void main() {
  group('FavoriteSongNotifier', () {

    group('.getNextFavoriteSongsPage', () {
      test(
          'sets state to PaginatedSongsState.loadFailure if FavoriteSongRepository.getFavoritePage returns a BackendFailure',
          () async {
        final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        const playlistName = 'test';
        when(() => mockFavoriteSongRepository.getPlaylistSong(page, playlistName)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository);
        final defaultSong = [MockSong()];
        // ignore: invalid_use_of_protected_member
        favoriteSongNotifier.state = favoriteSongNotifier.state.copyWith(songs: Fresh.yes(defaultSong));

        await favoriteSongNotifier.getFirstPlaylistSongsPage(playlistName);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadFailure(
            Fresh.yes([]),
            const BackendFailure.api(400, 'message'),
          ),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to PaginatedSongsState.loadSuccess if  FavoriteSongRepository.getFavoritePage returns a Song',
          () async {
        final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        const playlistName = 'test';
        final defaultSong = [MockSong()];
        when(() => mockFavoriteSongRepository.getPlaylistSong(page, playlistName)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(defaultSong))),
        );

        final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.getNextPlaylistSongsPage(playlistName);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to PaginatedSongsState.initial if FavoriteSongRepository.getFavoritePage not called', () async {
        final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository);
        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.initial(Fresh.yes([])),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
    group('.getNextFavoriteSongsPage', () {
      test(
          'sets state to PaginatedSongsState.loadFailure if FavoriteSongRepository.getFavoritePage returns a BackendFailure',
          () async {
        final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        const playlistName = 'test';
        when(() => mockFavoriteSongRepository.getPlaylistSong(page, playlistName)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository);
        final defaultSong = [MockSong()];
        // ignore: invalid_use_of_protected_member
        favoriteSongNotifier.state = favoriteSongNotifier.state.copyWith(songs: Fresh.yes(defaultSong));

        await favoriteSongNotifier.getFirstPlaylistSongsPage(playlistName);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadFailure(
            Fresh.yes([]),
            const BackendFailure.api(400, 'message'),
          ),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to PaginatedSongsState.loadSuccess if  FavoriteSongRepository.getFavoritePage returns a Song',
          () async {
        final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        const playlistName = 'test';
        final defaultSong = [MockSong()];
        when(() => mockFavoriteSongRepository.getPlaylistSong(page, playlistName)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(defaultSong))),
        );

        final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.getNextPlaylistSongsPage(playlistName);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to PaginatedSongsState.initial if FavoriteSongRepository.getFavoritePage not called', () async {
        final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository);
        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.initial(Fresh.yes([])),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
  });
  group('FavoriteSongNotifier', () {
    group('.getFirstFavoriteSongsPage', () {
      test('sets state to PaginatedSongsState.loadSuccess if  FavoriteSongRepository.getFavoritePage returns a Song',
          () async {
        final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        const playlistName = 'test';
        final defaultSong = [MockSong()];

        when(() => mockFavoriteSongRepository.getPlaylistSong(page, playlistName)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(defaultSong))),
        );

        final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.getFirstPlaylistSongsPage(playlistName);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });

    test('resets the page to 2', () async {
      final PlaylistSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
      const page = 1;
      const playlistName = 'test';
      final defaultSong = [MockSong()];

      when(() => mockFavoriteSongRepository.getPlaylistSong(page, playlistName)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes(defaultSong))),
      );

      final favoriteSongNotifier = PlaylistSongsNotifier(mockFavoriteSongRepository)..page = 10;

      final initActualPageResult = favoriteSongNotifier.page;

      const initExpectedPageResult = 10;

      expect(initActualPageResult, initExpectedPageResult);

      await favoriteSongNotifier.getFirstPlaylistSongsPage(playlistName);

      final actualPageResult = favoriteSongNotifier.page;

      const expectedPageResult = 2;

      expect(actualPageResult, expectedPageResult);
    });
  });
}
