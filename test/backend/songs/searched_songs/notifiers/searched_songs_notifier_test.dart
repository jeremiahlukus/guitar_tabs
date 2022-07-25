// Package imports:
import 'package:dartz/dartz.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/backend/songs/searched_songs/notifiers/searched_songs_notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

class MockSearchedSongRepository extends Mock implements SearchedSongsRepository {}

class MockSong extends Mock implements Song {}

void main() {
  group('SearchedSongsNotifier', () {
    group('.getNextSearchedSongsPage', () {
      test(
          'sets state to PaginatedSongsState.loadFailure if SearchedSongRepository.getNextSearchedSongsPage returns a BackendFailure',
          () async {
        final SearchedSongsRepository mockSearchedSongRepository = MockSearchedSongRepository();
        const page = 1;
        when(() => mockSearchedSongRepository.getSearchedSongsPage('query', page)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final searchedSongNotifier = SearchedSongsNotifier(mockSearchedSongRepository);
        final defaultSong = [MockSong()];
        // ignore: invalid_use_of_protected_member
        searchedSongNotifier.state = searchedSongNotifier.state.copyWith(songs: Fresh.yes(defaultSong));

        await searchedSongNotifier.getNextSearchedSongsPage('query');

        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchedSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadFailure(
            Fresh.yes(defaultSong),
            const BackendFailure.api(400, 'message'),
          ),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test(
          'sets state to PaginatedSongsState.loadSuccess if  SearchedSongRepository.getNextSearchedSongsPage returns a Song',
          () async {
        final SearchedSongsRepository mockSearchedSongRepository = MockSearchedSongRepository();
        const page = 1;
        final defaultSong = [MockSong()];
        when(() => mockSearchedSongRepository.getSearchedSongsPage('query', page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(defaultSong))),
        );

        final searchedSongNotifier = SearchedSongsNotifier(mockSearchedSongRepository);

        await searchedSongNotifier.getNextSearchedSongsPage('query');

        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchedSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to PaginatedSongsState.initial if SearchedSongRepository.getNextSearchedSongsPage not called',
          () async {
        final SearchedSongsRepository mockSearchedSongRepository = MockSearchedSongRepository();
        final searchedSongNotifier = SearchedSongsNotifier(mockSearchedSongRepository);
        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchedSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.initial(Fresh.yes([])),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
  });
  group('SearchedSongsNotifier', () {
    group('.getFirstSearchedSongsPage', () {
      test(
          'sets state to PaginatedSongsState.loadSuccess if  SearchedSongRepository.getFirstSearchedSongsPage returns a Song',
          () async {
        final SearchedSongsRepository mockSearchedSongRepository = MockSearchedSongRepository();
        const page = 1;
        final defaultSong = [MockSong()];

        when(() => mockSearchedSongRepository.getSearchedSongsPage('query', page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(defaultSong))),
        );

        final searchedSongNotifier = SearchedSongsNotifier(mockSearchedSongRepository);

        await searchedSongNotifier.getFirstSearchedSongsPage('query');

        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchedSongNotifier.state;

        final expectedStateResultMatcher = equals(
          PaginatedSongsState.loadSuccess(Fresh.yes(defaultSong), isNextPageAvailable: false),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });

    test('resets the page to 2', () async {
      final SearchedSongsRepository mockSearchedSongRepository = MockSearchedSongRepository();
      const page = 1;
      final defaultSong = [MockSong()];

      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', page)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes(defaultSong))),
      );

      final searchedSongNotifier = SearchedSongsNotifier(mockSearchedSongRepository)..page = 10;

      await searchedSongNotifier.getFirstSearchedSongsPage('query');

      final actualPageResult = searchedSongNotifier.page;

      const expectedPageResult = 2;

      expect(actualPageResult, expectedPageResult);
    });
  });
}
