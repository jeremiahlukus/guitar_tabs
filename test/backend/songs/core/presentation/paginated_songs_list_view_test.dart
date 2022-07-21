// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flash/flash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/presentation/no_results_display.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/shared/providers.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockPaginatedSongsNotifier extends Mock implements PaginatedSongsNotifier {}

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

void main() {
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
            home: PaginatedSongsListView(
              paginatedSongsNotifierProvider: paginatedSongsNotificerProvider,
              getNextPage: (ref, context) {},
              noResultsMessage: "That's everything we could find in your favorite songs right now.",
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

      final flastFinder = find.byType(Flash);

      expect(flastFinder, findsOneWidget);

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

      final noResultsDisplayMessageFinder = find.text('There was nothing to be found :(');

      expect(noResultsDisplayMessageFinder, findsOneWidget);
    });
  });
}
