// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flash/flash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/presentation/no_results_display.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/core/presentation/failure_song_tile.dart';
import 'package:joyful_noise/backend/songs/core/presentation/loading_song_tile.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_tile.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockPaginatedSongsNotifier extends Mock implements PaginatedSongsNotifier {}

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class MockWidgetRef extends Mock implements WidgetRef {}

class MockBuildContext extends Mock implements BuildContext {}

// ignore: one_member_abstracts
abstract class MyFunction {
  void call(WidgetRef ref, BuildContext context);
}

class MyFunctionMock extends Mock implements MyFunction {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockWidgetRef());
    registerFallbackValue(MockBuildContext());
  });
  group('PaginatedSongsListView', () {
    final songList = [
      mockSong(1),
      mockSong(2),
      mockSong(3),
    ];

    testWidgets('shows no connection toast on loading outdated songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotificerProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PaginatedSongsListView(
                paginatedSongsNotifierProvider: paginatedSongsNotificerProvider,
                getNextPage: (ref, context) {},
                noResultsMessage: "That's everything we could find in your favorite songs right now.",
              ),
            ),
          ),
        ),
      );

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.no(songList),
        isNextPageAvailable: true,
      );

      await tester.pump();

      final flashFinder = find.byType(Flash);

      expect(flashFinder, findsOneWidget);

      final noConnectionMessageFinder = find.text("You're not online. Some information may be outdated.");

      expect(noConnectionMessageFinder, findsOneWidget);

      /// Needed to let the timer for the dialog complete
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('displays NoResultsDisplay on no results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) {
          return favoriteSongNotifier;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: MaterialApp(
            home: PaginatedSongsListView(
              paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
              getNextPage: (ref, context) {},
              noResultsMessage: "That's everything we could find in your favorite songs right now.",
            ),
          ),
        ),
      );

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.yes([], isNextPageAvailable: false),
        isNextPageAvailable: false,
      );

      // ignore: invalid_use_of_protected_member
      favoriteSongNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.yes([], isNextPageAvailable: false),
        isNextPageAvailable: false,
      );

      await tester.pump();

      final noResultsDisplayFinder = find.byType(NoResultsDisplay);

      expect(noResultsDisplayFinder, findsOneWidget);

      final noResultsDisplayMessageFinder =
          find.text("That's everything we could find in your favorite songs right now.");

      expect(noResultsDisplayMessageFinder, findsOneWidget);
    });

    testWidgets('LoadSuccess displays SongTile when results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) {
          return favoriteSongNotifier;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: MaterialApp(
            home: Scaffold(
              body: PaginatedSongsListView(
                paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
                getNextPage: (ref, context) {},
                noResultsMessage: "That's everything we could find in your favorite songs right now.",
              ),
            ),
          ),
        ),
      );

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.yes([mockSong(1), mockSong(2)], isNextPageAvailable: false),
        isNextPageAvailable: false,
      );

      // ignore: invalid_use_of_protected_member
      favoriteSongNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.yes([mockSong(1), mockSong(2)], isNextPageAvailable: false),
        isNextPageAvailable: false,
      );

      await tester.pump();

      final songTileFinder = find.byType(SongTile);

      expect(songTileFinder, findsNWidgets(2));
    });
    testWidgets('loadInProgress displays SongTile when results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) {
          return favoriteSongNotifier;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: MaterialApp(
            home: Scaffold(
              body: PaginatedSongsListView(
                paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
                getNextPage: (ref, context) {},
                noResultsMessage: "That's everything we could find in your favorite songs right now.",
              ),
            ),
          ),
        ),
      );

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state =
          PaginatedSongsState.loadInProgress(Fresh.yes(songList, isNextPageAvailable: false), 25);

      // ignore: invalid_use_of_protected_member
      favoriteSongNotifier.state =
          PaginatedSongsState.loadInProgress(Fresh.yes(songList, isNextPageAvailable: false), 25);

      await tester.pump();

      final songTileFinder = find.byType(SongTile);

      expect(songTileFinder, findsNWidgets(3));
    });
    testWidgets('loadInProgress displays LoadingSongTile when NO results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) {
          return favoriteSongNotifier;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: MaterialApp(
            home: Scaffold(
              body: PaginatedSongsListView(
                paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
                getNextPage: (ref, context) {},
                noResultsMessage: "That's everything we could find in your favorite songs right now.",
              ),
            ),
          ),
        ),
      );

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state =
          PaginatedSongsState.loadInProgress(Fresh.yes([], isNextPageAvailable: false), 25);

      // ignore: invalid_use_of_protected_member
      favoriteSongNotifier.state = PaginatedSongsState.loadInProgress(Fresh.yes([], isNextPageAvailable: false), 25);

      await tester.pump();

      final loadingSongTileFinder = find.byType(LoadingSongTile);
      final songTileFinder = find.byType(SongTile);

      expect(loadingSongTileFinder, findsNWidgets(9));
      expect(songTileFinder, findsNothing);
    });
    testWidgets('loadFailure does not display SongTile when results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) {
          return favoriteSongNotifier;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: MaterialApp(
            home: Scaffold(
              body: PaginatedSongsListView(
                paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
                getNextPage: (ref, context) {},
                noResultsMessage: "That's everything we could find in your favorite songs right now.",
              ),
            ),
          ),
        ),
      );

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state = PaginatedSongsState.loadFailure(
        Fresh.yes([], isNextPageAvailable: false),
        const BackendFailure.api(400, 'message'),
      );

      // ignore: invalid_use_of_protected_member
      favoriteSongNotifier.state = PaginatedSongsState.loadFailure(
        Fresh.yes([], isNextPageAvailable: false),
        const BackendFailure.api(400, 'message'),
      );
      await tester.pump();

      final failureSongTileFinder = find.byType(FailureSongTile);
      final songTileFinder = find.byType(SongTile);

      expect(failureSongTileFinder, findsOneWidget);
      expect(songTileFinder, findsNothing);
    });

    testWidgets('loadInitial does not display Tiles', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) {
          return favoriteSongNotifier;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: MaterialApp(
            home: Scaffold(
              body: PaginatedSongsListView(
                paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
                getNextPage: (ref, context) {},
                noResultsMessage: "That's everything we could find in your favorite songs right now.",
              ),
            ),
          ),
        ),
      );

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state = PaginatedSongsState.initial(Fresh.yes(songList, isNextPageAvailable: true));

      // ignore: invalid_use_of_protected_member
      favoriteSongNotifier.state = PaginatedSongsState.initial(Fresh.yes(songList, isNextPageAvailable: true));

      await tester.pump();
      final loadingSongTileFinder = find.byType(LoadingSongTile);
      final failureSongTileFinder = find.byType(FailureSongTile);
      final songTileFinder = find.byType(SongTile);

      expect(loadingSongTileFinder, findsNothing);
      expect(failureSongTileFinder, findsNothing);
      expect(songTileFinder, findsNothing);
    });

    testWidgets('ScrollNotification when screen is scrolled calls getNextPage', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();

      final paginatedSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
        (ref) => mockPaginatedSongsNotifier,
      );

      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier, PaginatedSongsState>(
        (ref) {
          return favoriteSongNotifier;
        },
      );

      final mock = MyFunctionMock();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [favoriteSongsNotifierProvider.overrideWithProvider(mockFavoriteSongsNotifierProvider)],
          child: MaterialApp(
            home: Scaffold(
              body: PaginatedSongsListView(
                paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
                getNextPage: mock,
                noResultsMessage: "That's everything we could find in your favorite songs right now.",
              ),
            ),
          ),
        ),
      );
      final songs = [mockSong(1)];

      // ignore: invalid_use_of_protected_member
      mockPaginatedSongsNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.yes(songs, isNextPageAvailable: true),
        isNextPageAvailable: true,
      );

      // ignore: invalid_use_of_protected_member
      favoriteSongNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.yes(songs, isNextPageAvailable: true),
        isNextPageAvailable: true,
      );

      await tester.pump();
      expect(PaginatedSongsListViewState.canLoadNextPage, true);
      verifyNever(() => mock(any(), any()));
      await tester.drag(find.byType(ListView), const Offset(0, -8000));
      await tester.pump(const Duration(seconds: 1));
      verify(() => mock(any(), any())).called(1);
      expect(PaginatedSongsListViewState.canLoadNextPage, false);
    });
  });
}
