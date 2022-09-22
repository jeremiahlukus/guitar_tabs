// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class MockSong extends Mock implements Song {}

void main() {
  group('FavoriteSongNotifier', () {
    group('.getNextFavoriteSongsPage', () {
      test(
          'sets state to PaginatedSongsState.loadFailure if FavoriteSongRepository.getFavoritePage returns a BackendFailure',
          () async {
        final FavoriteSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
        final defaultSong = [MockSong()];
        // ignore: invalid_use_of_protected_member
        favoriteSongNotifier.state = favoriteSongNotifier.state.copyWith(songs: Fresh.yes(defaultSong));

        await favoriteSongNotifier.getNextFavoriteSongsPage();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadFailure(
            Fresh.yes(defaultSong),
            const BackendFailure.api(400, 'message'),
          ),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to PaginatedSongsState.loadSuccess if  FavoriteSongRepository.getFavoritePage returns a Song',
          () async {
        final FavoriteSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        final defaultSong = [MockSong()];
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(defaultSong))),
        );

        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.getNextFavoriteSongsPage();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to PaginatedSongsState.initial if FavoriteSongRepository.getFavoritePage not called', () async {
        final FavoriteSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
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
        final FavoriteSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
        const page = 1;
        final defaultSong = [MockSong()];

        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(defaultSong))),
        );

        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.getFirstFavoriteSongsPage();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });

    test('resets the page to 2', () async {
      final FavoriteSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
      const page = 1;
      final defaultSong = [MockSong()];

      when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes(defaultSong))),
      );

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository)..page = 10;

      await favoriteSongNotifier.getFirstFavoriteSongsPage();

      final actualPageResult = favoriteSongNotifier.page;

      const expectedPageResult = 2;

      expect(actualPageResult, expectedPageResult);
    });
  });
}
