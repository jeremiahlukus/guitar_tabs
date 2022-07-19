// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/presentation/favorite_songs_page.dart';
import 'package:joyful_noise/core/shared/providers.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteSongRepository extends Mock
    implements FavoriteSongsRepository {}

void main() {
  group('FavoriteSongsPage', () {
    testWidgets('contains the PaginatedSongsListView widget', (tester) async {
      final mockFavoriteSongRepository = MockFavoriteSongRepository();

      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) =>
            Future.value(left(const BackendFailure.api(400, 'message'))),
      );

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier,
              PaginatedSongsState>(
        (ref) => FavoriteSongNotifier(mockFavoriteSongRepository),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoriteSongsNotifierProvider
                .overrideWithProvider(mockFavoriteSongsNotifierProvider)
          ],
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
        (invocation) =>
            Future.value(left(const BackendFailure.api(400, 'message'))),
      );

      final mockFavoriteSongsNotifierProvider =
          AutoDisposeStateNotifierProvider<FavoriteSongNotifier,
              PaginatedSongsState>(
        (ref) => FavoriteSongNotifier(mockFavoriteSongRepository),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoriteSongsNotifierProvider
                .overrideWithProvider(mockFavoriteSongsNotifierProvider)
          ],
          child: const MaterialApp(
            home: FavoriteSongsPage(),
          ),
        ),
      );

      final finder = find.byType(PaginatedSongsListView);

      final paginatedSongsListView =
          finder.evaluate().single.widget as PaginatedSongsListView;

      expect(
        paginatedSongsListView.noResultsMessage,
        "That's everything we could find in your favorite songs right now.",
      );
    });
  });
}
