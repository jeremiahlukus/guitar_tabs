// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flash/flash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
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

AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState> createPaginatedSongsNotifierProvider(
    PaginatedSongsNotifier mockPaginatedSongsNotifier,) {
  return AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState>(
    (ref) => mockPaginatedSongsNotifier,
  );
}

PaginatedSongsState createLoadSuccessState(
  List<Song> songs, {
  required bool isNextPageAvailable,
}) {
  return PaginatedSongsState.loadSuccess(
    Fresh.yes(songs, isNextPageAvailable: isNextPageAvailable),
    isNextPageAvailable: isNextPageAvailable,
  );
}

PaginatedSongsState createLoadInProgressState(
  List<Song> songs,
  int progress, {
  required bool isNextPageAvailable,
}) {
  return PaginatedSongsState.loadInProgress(Fresh.yes(songs, isNextPageAvailable: isNextPageAvailable), progress);
}

PaginatedSongsState createLoadFailureState(
  List<Song> songs,
  BackendFailure failure, {
  required bool isNextPageAvailable,
}) {
  return PaginatedSongsState.loadFailure(
    Fresh.yes(songs, isNextPageAvailable: isNextPageAvailable),
    failure,
  );
}

PaginatedSongsState createInitialLoadState(
  List<Song> songs, {
  required bool isNextPageAvailable,
}) {
  return PaginatedSongsState.initial(Fresh.yes(songs, isNextPageAvailable: isNextPageAvailable));
}

Future<void> pumpPaginatedSongsListView(
  WidgetTester tester,
  AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState> paginatedSongsNotifierProvider,
  FavoriteSongNotifier favoriteSongNotifier, [
  void Function(WidgetRef, BuildContext)? getNextPage,
]) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [favoriteSongsNotifierProvider.overrideWith((_) => favoriteSongNotifier)],
      child: MaterialApp(
        home: Scaffold(
          body: PaginatedSongsListView(
            paginatedSongsNotifierProvider: paginatedSongsNotifierProvider,
            getNextPage: getNextPage ?? (ref, context) {},
            noResultsMessage: "That's everything we could find in your favorite songs right now.",
          ),
        ),
      ),
    ),
  );
}

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
      final paginatedSongsNotificerProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      await pumpPaginatedSongsListView(tester, paginatedSongsNotificerProvider, favoriteSongNotifier);
      mockPaginatedSongsNotifier.state = PaginatedSongsState.loadSuccess(
        Fresh.no(songList),
        isNextPageAvailable: true,
      );

      await tester.pump();
      expect(find.byType(Flash), findsOneWidget);
      expect(find.text("You're not online. Some information may be outdated."), findsOneWidget);
      // Let the dialog finish
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('displays NoResultsDisplay on no results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();
      final paginatedSongsNotifierProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      await pumpPaginatedSongsListView(tester, paginatedSongsNotifierProvider, favoriteSongNotifier);
      mockPaginatedSongsNotifier.state = createLoadSuccessState([], isNextPageAvailable: false);
      favoriteSongNotifier.state = createLoadSuccessState([], isNextPageAvailable: false);
      await tester.pump();
      expect(find.byType(NoResultsDisplay), findsOneWidget);
      expect(find.text("That's everything we could find in your favorite songs right now."), findsOneWidget);
    });

    testWidgets('LoadSuccess displays SongTile when results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();
      final paginatedSongsNotifierProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      await pumpPaginatedSongsListView(tester, paginatedSongsNotifierProvider, favoriteSongNotifier);
      mockPaginatedSongsNotifier.state = createLoadSuccessState([mockSong(1), mockSong(2)], isNextPageAvailable: false);
      favoriteSongNotifier.state = createLoadSuccessState([mockSong(1), mockSong(2)], isNextPageAvailable: false);
      await tester.pump();
      expect(find.byType(SongTile), findsNWidgets(2));
    });
    testWidgets('loadInProgress displays SongTile when results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();
      final paginatedSongsNotifierProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      await pumpPaginatedSongsListView(tester, paginatedSongsNotifierProvider, favoriteSongNotifier);
      mockPaginatedSongsNotifier.state = createLoadInProgressState(songList, isNextPageAvailable: false, 25);
      favoriteSongNotifier.state = createLoadInProgressState(songList, isNextPageAvailable: false, 25);
      await tester.pump();
      expect(find.byType(SongTile), findsNWidgets(3));
    });
    testWidgets('loadInProgress displays LoadingSongTile when NO results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();
      final paginatedSongsNotifierProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      await pumpPaginatedSongsListView(tester, paginatedSongsNotifierProvider, favoriteSongNotifier);
      mockPaginatedSongsNotifier.state = createLoadInProgressState([], isNextPageAvailable: false, 25);
      favoriteSongNotifier.state = createLoadInProgressState([], isNextPageAvailable: false, 25);
      await tester.pump();
      expect(find.byType(LoadingSongTile), findsNWidgets(9));
      expect(find.byType(SongTile), findsNothing);
    });
    testWidgets('loadFailure does not display SongTile when results for favorite songs', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();
      final paginatedSongsNotifierProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      await pumpPaginatedSongsListView(tester, paginatedSongsNotifierProvider, favoriteSongNotifier);
      mockPaginatedSongsNotifier.state =
          createLoadFailureState([], const BackendFailure.api(404, 'message'), isNextPageAvailable: false);
      favoriteSongNotifier.state =
          createLoadFailureState([], const BackendFailure.api(404, 'message'), isNextPageAvailable: false);
      await tester.pump();
      expect(find.byType(FailureSongTile), findsOneWidget);
      expect(find.byType(SongTile), findsNothing);
    });

    testWidgets('loadInitial does not display Tiles', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();
      final paginatedSongsNotifierProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      await pumpPaginatedSongsListView(tester, paginatedSongsNotifierProvider, favoriteSongNotifier);
      mockPaginatedSongsNotifier.state = createInitialLoadState(songList, isNextPageAvailable: true);
      favoriteSongNotifier.state = createInitialLoadState(songList, isNextPageAvailable: true);
      await tester.pump();
      expect(find.byType(LoadingSongTile), findsNothing);
      expect(find.byType(FailureSongTile), findsNothing);
      expect(find.byType(SongTile), findsNothing);
    });

    testWidgets('ScrollNotification when screen is scrolled calls getNextPage', (tester) async {
      final mockPaginatedSongsNotifier = PaginatedSongsNotifier();
      final paginatedSongsNotifierProvider = createPaginatedSongsNotifierProvider(mockPaginatedSongsNotifier);
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final favoriteSongNotifier = FavoriteSongNotifier(mockFavoriteSongRepository);
      final mock = MyFunctionMock();
      await pumpPaginatedSongsListView(tester, paginatedSongsNotifierProvider, favoriteSongNotifier, mock.call);
      final songs = [mockSong(1)];
      mockPaginatedSongsNotifier.state = createLoadSuccessState(songs, isNextPageAvailable: true);
      favoriteSongNotifier.state = createLoadSuccessState(songs, isNextPageAvailable: true);
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
