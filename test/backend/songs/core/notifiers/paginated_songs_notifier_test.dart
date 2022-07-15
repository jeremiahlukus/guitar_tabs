// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

class MockSongsRepository extends Mock implements FavoriteSongsRepository {}

void main() {
  group('PaginatedSongsNotifier', () {
    group('.resetState', () {
      test('resets the state to PaginatedSongsState.initial', () async {
        final FavoriteSongsRepository mockFavoriteSongRepository = MockSongsRepository();
        const page = 2;
        final paginatedSongNotifier = PaginatedSongsNotifier();
        const songs = [
          Song(
            id: 1,
            title: 'title',
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
        paginatedSongNotifier
          // ignore: invalid_use_of_protected_member
          ..state = paginatedSongNotifier.state.copyWith(songs: Fresh.yes(songs))
          ..resetState();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = paginatedSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.initial(Fresh.yes([])),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
    group('.getNextPage', () {
      test(
          'sets state to the state to PaginatedSongsState.loadFailure if FavoriteSongRepository.getFavoritePage returns a BackendFailure',
          () async {
        final FavoriteSongsRepository mockFavoriteSongRepository = MockSongsRepository();
        const page = 1;
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );
        final paginatedSongNotifier = PaginatedSongsNotifier();
        const songs = [
          Song(
            id: 1,
            title: 'title',
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

        // ignore: invalid_use_of_protected_member
        paginatedSongNotifier.state = paginatedSongNotifier.state.copyWith(songs: Fresh.yes(songs));
        await paginatedSongNotifier.getNextPage(mockFavoriteSongRepository.getFavoritePage);

        // ignore: invalid_use_of_protected_member
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
        final FavoriteSongsRepository mockFavoriteSongRepository = MockSongsRepository();
        const page = 1;
        final paginatedSongNotifier = PaginatedSongsNotifier();
        const songs = [
          Song(
            id: 1,
            title: 'title',
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
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );
        when(() => mockFavoriteSongRepository.getFavoritePage(page)).thenAnswer(
          (invocation) => Future.value(
            right(Fresh.yes(songs)),
          ),
        );

        await paginatedSongNotifier.getNextPage(mockFavoriteSongRepository.getFavoritePage);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = paginatedSongNotifier.state;

        final expectedStateResultMatcher =
            equals(PaginatedSongsState.loadSuccess(Fresh.yes(songs), isNextPageAvailable: false));

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
  });
}
