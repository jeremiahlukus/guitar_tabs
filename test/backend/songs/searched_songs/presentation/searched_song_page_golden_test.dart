// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/auth/notifiers/auth_notifier.dart';
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/domain/user.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/backend/core/notifiers/user_notifier.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/backend/songs/searched_songs/notifiers/searched_songs_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/shared/providers.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

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

final router = AppRouter();
Widget buildWidgetUnderTest() {
  final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
  final AuthNotifier mockAuthNotifier = MockAuthNotifier();
  final mockSearchedSongRepository = MockSearchedSongsRepository();
  final mockSearchHistoryRepository = MockSearchHistoryRepository();
  final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
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
              // category: 'category',
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
  final mockSearchedSongsNotifierProvider = SearchedSongsNotifier(mockSearchedSongRepository);

  return ProviderScope(
    overrides: [
      userNotifierProvider.overrideWith(
        (_) => fakeUserNotifier,
      ),
      authNotifierProvider.overrideWith(
        (_) => mockAuthNotifier,
      ),
      searchedSongsNotifierProvider.overrideWith((_) => mockSearchedSongsNotifierProvider),
      searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
    ],
    child: MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        router,
        navigatorObservers: () => [mockObserver],
        initialDeepLink: FavoriteSongsRoute.name,
      ),
      routeInformationParser: AppRouter().defaultRouteParser(),
    ),
  );
}

void main() {
  router.push(
    SearchedSongsRoute(
      searchTerm: 'query',
    ),
  );
  goldenTest(
    'renders correctly on smallPhone',
    fileName: 'SearchedSongsPage smallPhone',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.smallPhone,
          name: 'golden test SearchedSongsPage on small phone',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on tabletLandscape',
    fileName: 'SearchedSongsPage tabletLandscape',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.tabletLandscape,
          name: 'golden test SearchedSongsPage on tablet landscape',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on tabletPortrait',
    fileName: 'SearchedSongsPage tabletPortrait',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.tabletPortrait,
          name: 'golden test SearchedSongsPage on tablet Portrait',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on iphone11',
    fileName: 'SearchedSongsPage iphone11',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          name: 'golden test SearchedSongsPage on iphone11',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
}
