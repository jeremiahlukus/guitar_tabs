// Flutter imports:
import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/presentation/favorite_songs_page.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/shared/providers.dart';

import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class MockUserRepository extends Mock implements UserRepository {}

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
  group('FavoriteSongsPage', () {
    testWidgets('contains the PaginatedSongsListView widget', (tester) async {
      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) => Future.value(
          right(
            Fresh.yes(
              [
                MockSong(),
              ],
            ),
          ),
        ),
      );

      final mockProvider = FavoriteSongNotifier(mockFavoriteSongRepository);
      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) => mockProvider,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: const MaterialApp(
            home: FavoriteSongsPage(),
          ),
        ),
      );

      final finder = find.byType(PaginatedSongsListView);

      expect(finder, findsOneWidget);
    });

    testWidgets('contains the right noResultsMessage', (tester) async {
      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
      );

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) => FavoriteSongNotifier(mockFavoriteSongRepository),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: const MaterialApp(
            home: FavoriteSongsPage(),
          ),
        ),
      );

      final finder = find.byType(PaginatedSongsListView);

      final paginatedSongsListView = finder.evaluate().single.widget as PaginatedSongsListView;

      expect(
        paginatedSongsListView.noResultsMessage,
        "That's everything we could find in your favorite songs right now.",
      );
    });
    testWidgets("clicking on Sign Out button triggers provided AuthNotifier's signOut method", (tester) async {
      final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
      final AuthNotifier mockAuthNotifier = MockAuthNotifier();
      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
      );

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) => FavoriteSongNotifier(mockFavoriteSongRepository),
      );

      when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userNotifierProvider.overrideWithValue(
              fakeUserNotifier,
            ),
            authNotifierProvider.overrideWithValue(
              mockAuthNotifier,
            ),
            favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)
          ],
          child: const MaterialApp(
            home: FavoriteSongsPage(),
          ),
        ),
      );

      await tester.pump(Duration.zero);

      final signOutButtonFinder = find.byKey(FavoriteSongsPageState.signOutButtonKey);

      await tester.tap(signOutButtonFinder);

      await tester.pump();

      verify(mockAuthNotifier.signOut).called(1);
    });
  });

  group('DashboardPage Golden Test', () {
    final UserNotifier fakeUserNotifier = FakeUserNotifier(MockUserRepository());
    final AuthNotifier mockAuthNotifier = MockAuthNotifier();
    final mockFavoriteSongRepository = MockFavoriteSongRepository();
    when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
      (invocation) => Future.value(
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
                  url: 'url',),
            ],
          ),
        ),
      ),
    );
    final mockFavoriteSongsNotifierProvider =
        AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
      (ref) => FavoriteSongNotifier(mockFavoriteSongRepository),
    );

    when(mockAuthNotifier.signOut).thenAnswer((_) => Future.value());

    Widget buildWidgetUnderTest() => ProviderScope(
          overrides: [
            userNotifierProvider.overrideWithValue(
              fakeUserNotifier,
            ),
            authNotifierProvider.overrideWithValue(
              mockAuthNotifier,
            ),
            favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)
          ],
          child: const MaterialApp(
            home: FavoriteSongsPage(),
          ),
        );
    goldenTest(
      'renders correctly on mobile',
      fileName: 'FavoriteSongsPage',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            device: Device.smallPhone,
            name: 'golden test FavoriteSongsPage on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletLandscape,
            name: 'golden test FavoriteSongsPage on tablet landscape',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletPortrait,
            name: 'golden test FavoriteSongsPage on tablet Portrait',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            name: 'golden test FavoriteSongsPage on iphone11',
            builder: buildWidgetUnderTest,
          ),
        ],
      ),
    );
  });
}
