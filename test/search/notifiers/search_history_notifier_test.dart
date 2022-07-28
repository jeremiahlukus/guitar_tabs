// Package imports:

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

class MockStream extends Mock implements Stream<List<String>> {}

void main() {
  group('SearchHistoryNotifier', () {
    group('.addSearchTerm', () {
      test('returns a AsyncLoading with no data', () async {
        final SearchHistoryRepository mockFavoriteSongRepository = MockSearchHistoryRepository();
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
        when(() => mockSearchHistoryRepository.watchSearchTerms(filter: 'query'))
            .thenAnswer((_) => Stream.value(['query1', 'query2']));
        final searchHistoryNotifier = SearchHistoryNotifier(mockSearchHistoryRepository);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchHistoryNotifier.state;
        expect(actualStateResult, const AsyncLoading<List<String>>());
        // ignore: cascade_invocations
        await searchHistoryNotifier.watchSearchTerms(filter: 'query');

        final actualStateResult2 = searchHistoryNotifier.state;
        expect(actualStateResult2, const TypeMatcher<AsyncData>());
      });
      test('returns a AsyncValue.error when error', () async {
        final SearchHistoryRepository mockSearchHistoryRepository = MockSearchHistoryRepository();
        when(() => mockSearchHistoryRepository.watchSearchTerms(filter: 'query'))
            .thenAnswer((_) => Stream.error('Error'));

        final searchHistoryNotifier = SearchHistoryNotifier(mockSearchHistoryRepository);

        await searchHistoryNotifier.watchSearchTerms(filter: 'query');

        // ignore: invalid_use_of_protected_member
        final actualStateResult = searchHistoryNotifier.state;
        final expectedStateResultMatcher = equals(const AsyncValue<List<String>>.error('Error'));
        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
  });
}
