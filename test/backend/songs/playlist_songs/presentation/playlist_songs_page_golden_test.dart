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
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/notifiers/playlist_songs_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/shared/providers.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockFavoriteSongRepository extends Mock
    implements PlaylistSongsRepository {}

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

final router = AppRouter();
Widget buildWidgetUnderTest() {
  final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
  final AuthNotifier mockAuthNotifier = MockAuthNotifier();

  final mockSearchHistoryRepository = MockSearchHistoryRepository();
  final mockSearchHistoryProvider =
      SearchHistoryNotifier(mockSearchHistoryRepository);
  final mockPlaylistSongRepository = MockFavoriteSongRepository();

  final mockObserver = MockNavigatorObserver();
  when(() => mockPlaylistSongRepository.getPlaylistSong(any(), any()))
      .thenAnswer((invocation) {
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
  when(mockSearchHistoryRepository.watchSearchTerms)
      .thenAnswer((_) => Stream.value(['query1', 'query2']));
  // router.push(SearchedSongsRoute(searchTerm: 'query'));
  when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());
  final mockFavoriteSongsNotifierProvider = AutoDisposeStateNotifierProvider<
      PlaylistSongsNotifier, PaginatedSongsState>(
    (ref) => PlaylistSongsNotifier(mockPlaylistSongRepository),
  );

  return ProviderScope(
    overrides: [
      userNotifierProvider.overrideWithValue(
        fakeUserNotifier,
      ),
      authNotifierProvider.overrideWithValue(
        mockAuthNotifier,
      ),
      playlistSongsNotifierProvider
          .overrideWithProvider(mockFavoriteSongsNotifierProvider),
      searchHistoryNotifierProvider
          .overrideWithValue(mockSearchHistoryProvider),
    ],
    child: MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        router,
        navigatorObservers: () => [mockObserver],
        initialDeepLink: PlaylistSongsRoute.name,
      ),
      routeInformationParser: AppRouter().defaultRouteParser(),
    ),
  );
}

void main() {
  router.push(PlaylistSongsRoute(playlistName: 'test'));
  goldenTest(
    'renders correctly on smallPhone',
    fileName: 'PlaylistSongsPage smallPhone',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.smallPhone,
          name: 'golden test PlaylistSongsPage on small phone',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on tabletLandscape',
    fileName: 'PlaylistSongsPage tabletLandscape',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.tabletLandscape,
          name: 'golden test PlaylistSongsPage on tablet landscape',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on tabletPortrait',
    fileName: 'PlaylistSongsPage tabletPortrait',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.tabletPortrait,
          name: 'golden test PlaylistSongsPage on tablet Portrait',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on iphone11',
    fileName: 'PlaylistSongsPage iphone11',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          name: 'golden test PlaylistSongsPage on iphone11',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
}
