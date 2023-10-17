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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/shared/providers.dart';

import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

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

class MockSong extends Mock implements Song {}

final router = AppRouter();
Widget buildWidgetUnderTest() {
  final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
  final AuthNotifier mockAuthNotifier = MockAuthNotifier();

  final mockSearchHistoryRepository = MockSearchHistoryRepository();
  final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
  final mockFavoriteSongRepository = MockFavoriteSongRepository();
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
              //category: 'category',
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
  final mockFavoriteSongsNotifierProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

  return ProviderScope(
    overrides: [
      userNotifierProvider.overrideWith(
        (_) => fakeUserNotifier,
      ),
      authNotifierProvider.overrideWith(
        (_) => mockAuthNotifier,
      ),
      favoriteSongsNotifierProvider.overrideWith((_) => mockFavoriteSongsNotifierProvider),
      searchHistoryNotifierProvider.overrideWith((_) => mockSearchHistoryProvider),
    ],
    child: MaterialApp.router(
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(
        deepLinkBuilder: (_) => const DeepLink.path(FavoriteSongsRoute.name),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'abc',
      packageName: 'com.example.example',
      version: '1.0',
      buildNumber: '2',
      buildSignature: 'buildSignature',
    );
    preferences = await SharedPreferences.getInstance();
  });

  tearDown(() async {
    await preferences.clear();
    return true;
  });
  router.push(const FavoriteSongsRoute());
  goldenTest(
    'renders correctly on smallPhone',
    fileName: 'FavoriteSongsPage smallPhone',
    builder: () => const GoldenTestGroup(
      children: [
        GoldenTestDeviceScenario(
          device: Device.smallPhone,
          name: 'golden test FavoriteSongsPage on small phone',
          builder: buildWidgetUnderTest,
        ),
      ],
    ),
  );
}
