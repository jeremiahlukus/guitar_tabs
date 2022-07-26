// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

class MockStream extends Mock implements Stream<List<String>> {}

void main() {
  group('SearchHistoryNotifier', () {
    group('.addSearchTerm', () {
      test('returns a AsyncLoading with no data', () async {
        final SearchHistoryRepository mockFavoriteSongRepository = MockSearchHistoryRepository();
        const page = 1;
        when(() => mockFavoriteSongRepository.addSearchTerm('term')).thenAnswer(
          (invocation) => Future.value(),
        );

        final favoriteSongNotifier = SearchHistoryNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.addSearchTerm('term');

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;
        expect(actualStateResult, const AsyncLoading<List<String>>());
        expect(actualStateResult.asData, null);
      });
    });
    group('.deleteSearchTerm', () {
      test('returns a AsyncLoading with no data', () async {
        final SearchHistoryRepository mockFavoriteSongRepository = MockSearchHistoryRepository();
        const page = 1;
        when(() => mockFavoriteSongRepository.deleteSearchTerm('term')).thenAnswer(
          (invocation) => Future.value(),
        );

        final favoriteSongNotifier = SearchHistoryNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.deleteSearchTerm('term');

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;
        expect(actualStateResult, const AsyncLoading<List<String>>());
        expect(actualStateResult.asData, null);
      });
    });
    group('.putSearchTermFirst', () {
      test('returns a AsyncLoading with no data', () async {
        final SearchHistoryRepository mockFavoriteSongRepository = MockSearchHistoryRepository();
        const page = 1;
        when(() => mockFavoriteSongRepository.putSearchTermFirst('term')).thenAnswer(
          (invocation) => Future.value(),
        );

        final favoriteSongNotifier = SearchHistoryNotifier(mockFavoriteSongRepository);

        await favoriteSongNotifier.putSearchTermFirst('term');

        // ignore: invalid_use_of_protected_member
        final actualStateResult = favoriteSongNotifier.state;
        expect(actualStateResult, const AsyncLoading<List<String>>());
        expect(actualStateResult.asData, null);
      });
    });

    group('.watchSearchTerms', () {
      test('returns AsyncValue.data when success', () async {
        final SearchHistoryRepository mockSearchHistoryRepository = MockSearchHistoryRepository();
        when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));
        final searchHistoryNotifier = SearchHistoryNotifier(mockSearchHistoryRepository);

        // ignore: cascade_invocations
        searchHistoryNotifier.watchSearchTerms();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchHistoryNotifier.state;
        final expectedStateResultMatcher = equals(const AsyncValue.data('data'));
        expect(actualStateResult, expectedStateResultMatcher);
        // expect(actualStateResult.asData, ['query1', 'query2']);
      });
      test('returns a AsyncValue.error when error', () async {
        final SearchHistoryRepository mockSearchHistoryRepository = MockSearchHistoryRepository();
        when(mockSearchHistoryRepository.watchSearchTerms).thenThrow(Error);
        final searchHistoryNotifier = SearchHistoryNotifier(mockSearchHistoryRepository);
        // ignore: cascade_invocations
        searchHistoryNotifier.watchSearchTerms();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchHistoryNotifier.state;
        final expectedStateResultMatcher = equals(const AsyncValue<dynamic>.error(Error));
        expect(actualStateResult, expectedStateResultMatcher);
        // expect(actualStateResult.asData, ['query1', 'query2']);
      });
    });
  });
}
