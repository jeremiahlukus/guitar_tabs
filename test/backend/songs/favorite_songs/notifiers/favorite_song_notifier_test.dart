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
    final FavoriteSongsRepository mockFavoriteSongRepository = MockFavoriteSongRepository();
    final defaultSong = [MockSong()];
    const page = 1;

    setUp(() {
      when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes(defaultSong))),
      );
    });

    group('.getNextFavoriteSongsPage', () {
      test(
          'sets state to PaginatedSongsState.loadFailure if FavoriteSongRepository.getFavoritePage returns a BackendFailure',
          () async {
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
        favoriteSongNotifier.state = favoriteSongNotifier.state.copyWith(songs: Fresh.yes(defaultSong));

        await favoriteSongNotifier.getNextFavoriteSongsPage();

        expect(
          favoriteSongNotifier.state,
          equals(
            PaginatedSongsState.loadFailure(
              Fresh.yes(defaultSong),
              const BackendFailure.api(400, 'message'),
            ),
          ),
        );
      });

      test('sets state to PaginatedSongsState.loadSuccess if  FavoriteSongRepository.getFavoritePage returns a Song',
          () async {
        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.getNextFavoriteSongsPage();

        expect(
          favoriteSongNotifier.state,
          equals(
            PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
          ),
        );
      });

      test('sets state to PaginatedSongsState.initial if FavoriteSongRepository.getFavoritePage not called', () async {
        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

        expect(
          favoriteSongNotifier.state,
          equals(
            PaginatedSongsState.initial(Fresh.yes([])),
          ),
        );
      });
    });

    group('.getFirstFavoriteSongsPage', () {
      test('sets state to PaginatedSongsState.loadSuccess if  FavoriteSongRepository.getFavoritePage returns a Song',
          () async {
        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.getFirstFavoriteSongsPage();

        expect(
          favoriteSongNotifier.state,
          equals(
            PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
          ),
        );
      });

      test('resets the page to 2', () async {
        final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository)..page = 10;

        await favoriteSongNotifier.getFirstFavoriteSongsPage();

        expect(favoriteSongNotifier.page, equals(2));
      });
    });
  });
}
