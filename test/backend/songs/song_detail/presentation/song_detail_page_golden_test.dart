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
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/backend/songs/song_detail/notifiers/song_detail_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/shared/providers.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class MockSongDetailRepository extends Mock implements SongDetailRepository {}

class FakeUserNotifier extends UserNotifier {
  FakeUserNotifier(UserRepository userRepository) : super(userRepository);

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

  final mockSearchHistoryRepository = MockSearchHistoryRepository();
  final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
  final mockSongDetailRepository = MockSongDetailRepository();
  final mockSongDetailProvider = SongDetailNotifier(mockSongDetailRepository);
  final mockFavoriteSongRepository = MockFavoriteSongRepository();

  final mockObserver = MockNavigatorObserver();
  const songDetail = SongDetail(isFavorite: true, songId: '1');
  when(() => mockSongDetailRepository.getSongDetail(1))
      .thenAnswer((invocation) => Future.value(right(Fresh.yes(songDetail))));

  when(() => mockSongDetailRepository.getChordTabs('C')).thenAnswer((invocation) => Future.value(['x 1 2 3 4 4']));
  when(() => mockSongDetailRepository.switchFavoriteStatus(songDetail)).thenAnswer((_) {
    return Future.value(right(unit));
  });
  when(() => mockFavoriteSongRepository.getFavoritePage(any())).thenAnswer((invocation) {
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

  when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());
  final mockFavoriteSongsNotifierProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

  return ProviderScope(
    overrides: [
      userNotifierProvider.overrideWith(
        (_) => fakeUserNotifier,
      ),
      authNotifierProvider.overrideWith(
        (_) => mockAuthNotifier,
      ),
      songDetailNotifierProvider.overrideWith((_) => mockSongDetailProvider),
      favoriteSongsNotifierProvider.overrideWith((_) => mockFavoriteSongsNotifierProvider),
      searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
    ],
    child: MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        router,
        navigatorObservers: () => [mockObserver],
        initialDeepLink: SongDetailRoute.name,
      ),
      routeInformationParser: AppRouter().defaultRouteParser(),
    ),
  );
}

void main() {
  router.push(SongDetailRoute(song: mockSong(1)));
  goldenTest(
    'renders correctly on smallPhone',
    fileName: 'SongDetailPage smallPhone',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.smallPhone,
          name: 'golden test SongDetailPage on small phone',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on tabletLandscape',
    fileName: 'SongDetailPage tabletLandscape',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.tabletLandscape,
          name: 'golden test SongDetailPage on tablet landscape',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on tabletPortrait',
    fileName: 'SongDetailPage tabletPortrait',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.tabletPortrait,
          name: 'golden test SongDetailPage on tablet Portrait',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
  goldenTest(
    'renders correctly on iphone11',
    fileName: 'SongDetailPage iphone11',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          name: 'golden test SongDetailPage on iphone11',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
}
