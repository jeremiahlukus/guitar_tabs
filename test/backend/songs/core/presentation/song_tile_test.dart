// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_tile.dart';
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
import '../../../../utils/router_test_utils.dart';

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class MockSongDetailRepository extends Mock implements SongDetailRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

void main() {
  group('SongTile', () {
    testWidgets('contains the artist and title text in a ListTile', (tester) async {
      final song = mockSong(1);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SongTile(
              song: song,
            ),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      final listTileFinder = find.byType(ListTile);

      expect(listTileFinder, findsOneWidget);
      expect(find.text('new 1'), findsOneWidget);
      expect(find.text('artist'), findsOneWidget);
    });

    testWidgets('contains the PaginatedSongsListView widget', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockProvider = FavoriteSongNotifier(mockFavoriteSongRepository);
      final mockSongDetailRepository = MockSongDetailRepository();
      final mockDetailProvider = SongDetailNotifier(mockSongDetailRepository);

      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      when(() => mockSongDetailRepository.getSongDetail(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes(const SongDetail(isFavorite: true, songId: '1')))));
      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(const FavoriteSongsRoute());
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockProvider),
          songDetailNotifierProvider.overrideWithValue(mockDetailProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      final favoriteSongsButton = find.byKey(SongTile.favoriteSongButtonKey).first;

      await tester.tap(favoriteSongsButton);
      await tester.pumpAndSettle();
      final finder = find.byType(AppBar);
      expect(finder, findsOneWidget);
      expect(router.currentUrl, '/song_detail');
    });
  });

  group('SongTile Golden Test', () {
    Widget buildWidgetUnderTest() => MaterialApp(
          home: Scaffold(
            body: SongTile(
              song: mockSong(1),
            ),
          ),
        );

    goldenTest(
      'renders correctly on mobile',
      fileName: 'SongTile',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            device: Device.smallPhone,
            name: 'golden test SongTile on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletLandscape,
            name: 'golden test SongTile on tablet landscape',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletPortrait,
            name: 'golden test SongTile on tablet Portrait',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            name: 'golden test SongTile on iphone11',
            builder: buildWidgetUnderTest,
          ),
        ],
      ),
    );
  });
}
