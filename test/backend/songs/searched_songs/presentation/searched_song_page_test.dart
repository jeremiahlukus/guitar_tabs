// Flutter imports:
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/shared/providers.dart';
import 'package:mockingjay/mockingjay.dart';
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
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/backend/songs/searched_songs/notifiers/searched_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/searched_songs/presentation/searched_songs_page.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/shared/providers.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockSearchedSongsRepository extends Mock implements SearchedSongsRepository {}

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeUserNotifier extends UserNotifier {
  FakeUserNotifier(UserRepository userRepository) : super(userRepository);

  @override
  Future<void> getUserPage() async {
    state = const UserState.loadSuccess(
      User(name: 'Jon Doe', avatarUrl: 'www.example.com/avatarUrl'),
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
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockObserver = MockNavigatorObserver();
      final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final navigator = MockNavigator();

      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', 1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes([mockSong(1)]))),
      );
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));
      when(() => navigator.push(any())).thenAnswer((_) async {});

      // ignore: unawaited_futures, cascade_invocations
      router.push(SearchedSongsRoute(searchTerm: 'query'));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchedSongsNotifierProvider.overrideWithValue(mockProvider),
            searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
          ],
          child: MaterialApp.router(
            routerDelegate: AutoRouterDelegate(
              router,
              navigatorObservers: () => [mockObserver],
            ),
            routeInformationParser: AppRouter().defaultRouteParser(),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      await tester.pumpAndSettle();
      final finder = find.byType(PaginatedSongsListView);

      expect(finder, findsOneWidget);
    });

    testWidgets('contains the right noResultsMessage', (tester) async {
      final mockSearchedSongRepository = MockSearchedSongsRepository();
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockObserver = MockNavigatorObserver();
      final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final navigator = MockNavigator();

      when(() => mockSearchedSongRepository.getSearchedSongsPage('query', 1)).thenAnswer(
        (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
      );
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));
      when(() => navigator.push(any())).thenAnswer((_) async {});

      // ignore: unawaited_futures, cascade_invocations
      router.push(SearchedSongsRoute(searchTerm: 'query'));

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchedSongsNotifierProvider.overrideWithValue(mockProvider),
            searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
          ],
          child: MaterialApp.router(
            routerDelegate: AutoRouterDelegate(
              router,
              navigatorObservers: () => [mockObserver],
            ),
            routeInformationParser: AppRouter().defaultRouteParser(),
          ),
        ),
      );

      final finder = find.byType(PaginatedSongsListView);

      final paginatedSongsListView = finder.evaluate().single.widget as PaginatedSongsListView;

      expect(
        paginatedSongsListView.noResultsMessage,
        'This is all we could find for your search term.',
      );
    });
  });

  group('SearchedSongsPage Golden Test', () {
    final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
    final AuthNotifier mockAuthNotifier = MockAuthNotifier();
    final mockSearchedSongRepository = MockSearchedSongsRepository();
    final mockSearchHistoryRepository = MockSearchHistoryRepository();
    final mockProvider = SearchedSongsNotifier(mockSearchedSongRepository);
    final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
    final router = AppRouter();
    final mockObserver = MockNavigatorObserver();
    when(() => mockSearchedSongRepository.getSearchedSongsPage(any(), any())).thenAnswer((invocation) {
      return Future.value(
        right(
          Fresh.yes(
            [
              const Song(
                id: 1,
                title: 'title',
                songNumber: 1,
                lyrics: 'lyrics',
                category: 'category',
                artist: 'artist',
                chords: 'chords',
                url: 'url',
              ),
            ],
          ),
        ),
      );
    });
    when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));
    // router.push(SearchedSongsRoute(searchTerm: 'query'));
    when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());
    final mockSearchedSongsNotifierProvider =
        AutoDisposeStateNotifierProvider<SearchedSongsNotifier, PaginatedSongsState>(
      (ref) => SearchedSongsNotifier(mockSearchedSongRepository),
    );

    Widget buildWidgetUnderTest() {
      router.push(SearchedSongsRoute(
        searchTerm: 'query',
      ));

      return ProviderScope(
        overrides: [
          userNotifierProvider.overrideWithValue(
            fakeUserNotifier,
          ),
          authNotifierProvider.overrideWithValue(
            mockAuthNotifier,
          ),
          searchedSongsNotifierProvider.overrideWithProvider(mockSearchedSongsNotifierProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        child: MaterialApp.router(
          routerDelegate: AutoRouterDelegate(
            router,
            navigatorObservers: () => [mockObserver],
            initialDeepLink: DashboardRoute.name,
          ),
          routeInformationParser: AppRouter().defaultRouteParser(),
        ),
      );
    }

    goldenTest(
      'renders correctly on mobile',
      fileName: 'SearchedSongsPage',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            key: GlobalKey(debugLabel: 'scaffoldKey'),
            device: Device.smallPhone,
            name: 'golden test SearchedSongsPage on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            key: GlobalKey(debugLabel: 'scaffoldKeysss'),
            device: Device.tabletLandscape,
            name: 'golden test SearchedSongsPage on tablet landscape',
            builder: buildWidgetUnderTest,
          ),
          // GoldenTestDeviceScenario(
          //   device: Device.tabletPortrait,
          //   name: 'golden test SearchedSongsPage on tablet Portrait',
          //   builder: buildWidgetUnderTest,
          // ),
          // GoldenTestDeviceScenario(
          //   name: 'golden test SearchedSongsPage on iphone11',
          //   builder: buildWidgetUnderTest,
          // ),
        ],
      ),
    );
  });
}
