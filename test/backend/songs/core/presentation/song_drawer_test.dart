// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_drawer.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/presentation/favorite_songs_page.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/notifiers/playlist_songs_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/shared/providers.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';
import '../../../../utils/router_test_utils.dart';

class MockPlaylistSongRepository extends Mock implements PlaylistSongsRepository {}

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

void main() {
  group('SongDrawer', () {
    testWidgets('contains DrawerHeader', (tester) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            drawer: const SongDrawer(),
            appBar: AppBar(title: const Text('test')),
            body: const Center(
              child: Text('My Page!'),
            ),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
    });
    testWidgets('taping on Athens Song Book navigates to playlist song page', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockPlaylistProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockFavoriteProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      const playlistName = 'Athens Songbook';
      when(() => mockPlaylistSongRepository.getPlaylistSong(1, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      // ignore: invalid_use_of_protected_member
      mockPlaylistProvider.state = mockPlaylistProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: invalid_use_of_protected_member
      mockFavoriteProvider.state = mockFavoriteProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(const FavoriteSongsRoute());
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockFavoriteProvider),
          playlistSongsNotifierProvider.overrideWithValue(mockPlaylistProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      FavoriteSongsPageState.scaffoldKey.currentState!.openDrawer();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
      await tester.tap(find.byKey(SongDrawer.athensSongBook));
      expect(router.currentUrl, '/playlist_songs');
      expect(find.text('Athens Songbook'), findsOneWidget);
    });
    testWidgets('taping on Hymnal navigates to playlist song page', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockPlaylistProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockFavoriteProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      const playlistName = 'Hymnal';
      when(() => mockPlaylistSongRepository.getPlaylistSong(1, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      // ignore: invalid_use_of_protected_member
      mockPlaylistProvider.state = mockPlaylistProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: invalid_use_of_protected_member
      mockFavoriteProvider.state = mockFavoriteProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(const FavoriteSongsRoute());
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockFavoriteProvider),
          playlistSongsNotifierProvider.overrideWithValue(mockPlaylistProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      FavoriteSongsPageState.scaffoldKey.currentState!.openDrawer();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
      await tester.tap(find.byKey(SongDrawer.hymnal));
      expect(router.currentUrl, '/playlist_songs');
      expect(find.text('Hymnal'), findsOneWidget);
    });
    testWidgets('taping on Blue Songbook navigates to playlist song page', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockPlaylistProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockFavoriteProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      const playlistName = 'Blue Songbook';
      when(() => mockPlaylistSongRepository.getPlaylistSong(1, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      // ignore: invalid_use_of_protected_member
      mockPlaylistProvider.state = mockPlaylistProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: invalid_use_of_protected_member
      mockFavoriteProvider.state = mockFavoriteProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(const FavoriteSongsRoute());
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockFavoriteProvider),
          playlistSongsNotifierProvider.overrideWithValue(mockPlaylistProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      FavoriteSongsPageState.scaffoldKey.currentState!.openDrawer();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
      await tester.tap(find.byKey(SongDrawer.blueSongbook));
      expect(router.currentUrl, '/playlist_songs');
      expect(find.text('Blue Songbook'), findsOneWidget);
    });
    testWidgets('taping on Himnos navigates to playlist song page', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockPlaylistProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockFavoriteProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      const playlistName = 'Himnos';
      when(() => mockPlaylistSongRepository.getPlaylistSong(1, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      // ignore: invalid_use_of_protected_member
      mockPlaylistProvider.state = mockPlaylistProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: invalid_use_of_protected_member
      mockFavoriteProvider.state = mockFavoriteProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(const FavoriteSongsRoute());
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockFavoriteProvider),
          playlistSongsNotifierProvider.overrideWithValue(mockPlaylistProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      FavoriteSongsPageState.scaffoldKey.currentState!.openDrawer();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
      await tester.tap(find.byKey(SongDrawer.himnos));
      expect(router.currentUrl, '/playlist_songs');
      expect(find.text('Himnos'), findsOneWidget);
    });
    testWidgets('taping on Liederbuch navigates to playlist song page', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockPlaylistProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockFavoriteProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      const playlistName = 'Liederbuch';
      when(() => mockPlaylistSongRepository.getPlaylistSong(1, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      // ignore: invalid_use_of_protected_member
      mockPlaylistProvider.state = mockPlaylistProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: invalid_use_of_protected_member
      mockFavoriteProvider.state = mockFavoriteProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(const FavoriteSongsRoute());
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockFavoriteProvider),
          playlistSongsNotifierProvider.overrideWithValue(mockPlaylistProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      FavoriteSongsPageState.scaffoldKey.currentState!.openDrawer();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
      await tester.tap(find.byKey(SongDrawer.liederbuch));
      expect(router.currentUrl, '/playlist_songs');
      expect(find.text('Liederbuch'), findsOneWidget);
    });
    testWidgets('taping on Cantiques navigates to playlist song page', (tester) async {
      final mockSearchHistoryRepository = MockSearchHistoryRepository();
      final mockSearchHistoryProvider = SearchHistoryNotifier(mockSearchHistoryRepository);
      final router = AppRouter();
      final mockPlaylistSongRepository = MockPlaylistSongRepository();
      final mockPlaylistProvider = PlaylistSongsNotifier(mockPlaylistSongRepository);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockFavoriteProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      const playlistName = 'Cantiques';
      when(() => mockPlaylistSongRepository.getPlaylistSong(1, playlistName))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      when(mockSearchHistoryRepository.watchSearchTerms).thenAnswer((_) => Stream.value(['query1', 'query2']));

      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));
      // ignore: invalid_use_of_protected_member
      mockPlaylistProvider.state = mockPlaylistProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: invalid_use_of_protected_member
      mockFavoriteProvider.state = mockFavoriteProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(const FavoriteSongsRoute());
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockFavoriteProvider),
          playlistSongsNotifierProvider.overrideWithValue(mockPlaylistProvider),
          searchHistoryNotifierProvider.overrideWithValue(mockSearchHistoryProvider),
        ],
        router,
      );

      await tester.pump(Duration.zero);
      FavoriteSongsPageState.scaffoldKey.currentState!.openDrawer();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(DrawerHeader), findsOneWidget);
      await tester.tap(find.byKey(SongDrawer.cantiques));
      expect(router.currentUrl, '/playlist_songs');
      expect(find.text('Cantiques'), findsOneWidget);
    });
  });

  Widget buildWidgetUnderTest() => MaterialApp(
        home: Scaffold(
          drawer: const SongDrawer(),
          appBar: AppBar(title: const Text('test')),
          body: const Center(
            child: Text('My Page!'),
          ),
        ),
      );

  group('SongDrawer Golden Test', () {
    goldenTest(
      'renders correctly on mobile',
      fileName: 'SongDrawer',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            device: Device.smallPhone,
            name: 'golden test SongDrawer on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletLandscape,
            name: 'golden test SongDrawer on tablet landscape',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletPortrait,
            name: 'golden test SongDrawer on tablet Portrait',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            name: 'golden test SongDrawer on iphone11',
            builder: buildWidgetUnderTest,
          ),
        ],
      ),
    );
  });
}
