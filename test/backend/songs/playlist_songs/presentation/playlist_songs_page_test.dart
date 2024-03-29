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
import 'package:joyful_noise/backend/core/domain/user.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/backend/core/notifiers/user_notifier.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/notifiers/playlist_songs_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart' as pub_search_bar;
import 'package:joyful_noise/search/shared/providers.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/router_test_utils.dart';

class MockPlaylistSongRepository extends Mock implements PlaylistSongsRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class FakeUserNotifier extends UserNotifier {
  FakeUserNotifier(super.userRepository);

  @override
  Future<void> getUserPage() async {
    state = const UserState.loadSuccess(
      User(id: 0, email: 'hey@hey.com'),
    );
    return;
  }
}

class MockAuthNotifier extends Mock implements AuthNotifier {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

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
  group('PlaylistSongsPage', () {
    testWidgets('contains the PaginatedSongsListView widget', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      const playlistName = 'test';
      const page = 1;
      when(() => mockPlaylistSongRepository.getPlaylistSong(page, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(PlaylistSongsRoute(playlistName: playlistName));
      await pumpRouterApp(
        tester,
        [
          playlistSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final finder = find.byType(PaginatedSongsListView);

      expect(finder, findsOneWidget);
    });

    testWidgets('contains the SearchBar widget', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      const page = 1;
      const playlistName = 'test';

      when(() => mockPlaylistSongRepository.getPlaylistSong(page, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(PlaylistSongsRoute(playlistName: playlistName));
      await pumpRouterApp(
        tester,
        [
          playlistSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final finder = find.byType(pub_search_bar.SearchBar);

      expect(finder, findsOneWidget);
    });

    testWidgets('contains the right noResultsMessage', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      const page = 1;
      const playlistName = 'test';

      when(() => mockPlaylistSongRepository.getPlaylistSong(page, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(PlaylistSongsRoute(playlistName: playlistName));
      await pumpRouterApp(
        tester,
        [
          playlistSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final finder = find.byType(PaginatedSongsListView);

      final paginatedSongsListView = finder.evaluate().single.widget as PaginatedSongsListView;

      expect(
        paginatedSongsListView.noResultsMessage,
        "That's everything we could find right now.",
      );
    });
    testWidgets('clicking on Search button navigates to SearchedSongsRoute', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      final AuthNotifier mockAuthNotifier = MockAuthNotifier();
      final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
      final mockObserver = MockNavigatorObserver();
      const page = 1;
      const playlistName = 'test';
      when(() => mockPlaylistSongRepository.getPlaylistSong(page, playlistName)).thenAnswer(
        (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
      );
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));
      when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());

      // ignore: unawaited_futures
      router.push(PlaylistSongsRoute(playlistName: playlistName));
      await pumpRouterApp(
        tester,
        [
          userNotifierProvider.overrideWith(
            (_) => fakeUserNotifier,
          ),
          authNotifierProvider.overrideWith(
            (_) => mockAuthNotifier,
          ),
          playlistSongsNotifierProvider.overrideWith((_) => mockProvider),
          searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
        ],
        router,
        mockObserverOverride: mockObserver,
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final finder = find.byType(pub_search_bar.SearchBar);
      expect(finder, findsOneWidget);

      final searchButtonFinder = find.byKey(const ValueKey('searchKey'));
      await tester.tap(searchButtonFinder);
      await tester.pump();
      verify(() => mockObserver.didPush(any(), any()));
      await tester.sendKeyDownEvent(LogicalKeyboardKey.enter);

      await tester.pumpAndSettle();
    });
  });
}
