// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/auth/notifiers/auth_notifier.dart';
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/domain/user.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/backend/core/notifiers/user_notifier.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/backend/songs/searched_songs/notifiers/searched_songs_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart' as PubSearchBar;
import 'package:joyful_noise/search/shared/providers.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/router_test_utils.dart';

class MockSearchedSongsRepository extends Mock implements SearchedSongsRepository {}

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeUserNotifier extends UserNotifier {
  FakeUserNotifier(super.userRepository);

  @override
  Future<void> getUserPage() async {
    state = const UserState.loadSuccess(
      User(name: 'Jon Doe', avatarUrl: 'www.example.com/avatarUrl', email: 'hey@hey.com'),
    );
    return;
  }
}

class MockAuthNotifier extends Mock implements AuthNotifier {}

class MockSong extends Mock implements Song {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return Container();
        },
      ),
    );
  });
  group('SearchedSongsPage', () {
    testWidgets('contains the PaginatedSongsListView widget', (tester) async {
      final mockSearchedSongRepository = MockSearchedSongsRepository();
      final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();

      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', 1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes([mockSong(1)]))),
      );
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      // ignore: unawaited_futures, cascade_invocations
      router.push(SearchedSongsRoute(searchTerm: 'query'));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      await pumpRouterApp(
        tester,
        [
          searchedSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      await tester.pumpAndSettle();
      final finder = find.byType(PaginatedSongsListView);

      expect(finder, findsOneWidget);
    });
    testWidgets('contains the SearchBar widget', (tester) async {
      final mockSearchedSongRepository = MockSearchedSongsRepository();
      final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();

      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', 1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes([mockSong(1)]))),
      );
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      // ignore: unawaited_futures, cascade_invocations
      router.push(SearchedSongsRoute(searchTerm: 'query'));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      await pumpRouterApp(
        tester,
        [
          searchedSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      await tester.pumpAndSettle();
      final finder = find.byType(PubSearchBar.SearchBar);

      expect(finder, findsOneWidget);
    });
    testWidgets('clicking on Sign Out button triggers provided AuthNotifiers signOut method', (tester) async {
      final mockSearchedSongRepository = MockSearchedSongsRepository();
      final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final AuthNotifier mockAuthNotifier = MockAuthNotifier();
      final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());

      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));
      when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());
      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', 1)).thenAnswer(
        (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
      );

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures, cascade_invocations
      router.push(SearchedSongsRoute(searchTerm: 'query'));

      await pumpRouterApp(
        tester,
        [
          userNotifierProvider.overrideWith(
            (_) => fakeUserNotifier,
          ),
          authNotifierProvider.overrideWith(
            (_) => mockAuthNotifier,
          ),
          searchedSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);

      final signOutButtonFinder = find.byKey(const ValueKey('signOutButtonKey'));

      await tester.tap(signOutButtonFinder);

      await tester.pump();

      verify(mockAuthNotifier.signOut).called(1);
    });

    testWidgets('clicking on Search button triggers provided Navigates', (tester) async {
      final mockSearchedSongRepository = MockSearchedSongsRepository();
      final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final AuthNotifier mockAuthNotifier = MockAuthNotifier();
      final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
      final mockObserver = MockNavigatorObserver();
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));
      when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());
      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', 1)).thenAnswer(
        (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
      );

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures, cascade_invocations
      router.push(SearchedSongsRoute(searchTerm: 'query'));

      await pumpRouterApp(
        tester,
        [
          userNotifierProvider.overrideWith(
            (_) => fakeUserNotifier,
          ),
          authNotifierProvider.overrideWith(
            (_) => mockAuthNotifier,
          ),
          searchedSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
        mockObserverOverride: mockObserver,
      );

      await tester.pump(Duration.zero);

      final finder = find.byType(PubSearchBar.SearchBar);
      expect(finder, findsOneWidget);

      final searchButtonFinder = find.byKey(const ValueKey('searchKey'));
      await tester.tap(searchButtonFinder);
      await tester.pump();
      verify(() => mockObserver.didPush(any(), any()));
      await tester.sendKeyDownEvent(LogicalKeyboardKey.enter);
    });
    testWidgets('contains the right noResultsMessage', (tester) async {
      final mockSearchedSongRepository = MockSearchedSongsRepository();
      final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();

      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', 1)).thenAnswer(
        (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
      );
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      // ignore: unawaited_futures, cascade_invocations
      router.push(SearchedSongsRoute(searchTerm: 'query'));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      await pumpRouterApp(
        tester,
        [
          searchedSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
      );

      final finder = find.byType(PaginatedSongsListView);

      final paginatedSongsListView = finder.evaluate().single.widget as PaginatedSongsListView;

      expect(
        paginatedSongsListView.noResultsMessage,
        'This is all we could find for your search term.',
      );
    });
  });
}
