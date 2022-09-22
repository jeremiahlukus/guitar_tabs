// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/backend/songs/song_detail/notifiers/song_detail_notifier.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/auth/notifiers/auth_notifier.dart';
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/user.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/backend/core/notifiers/user_notifier.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart';
import 'package:joyful_noise/search/shared/providers.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/router_test_utils.dart';

class MockSongDetailRepository extends Mock implements SongDetailRepository {}

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

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return Container();
        },
      ),
    );
  });
  group('SongsDetailPage', () {
    testWidgets('contains the LyricsRenderer widget', (tester) async {
      final router = AppRouter();
      final mockSongDetailRepository = MockSongDetailRepository();
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockDetailProvider = SongDetailNotifier(mockSongDetailRepository);
      const songDetail = SongDetail(isFavorite: true, songId: '1');
      when(() => mockSongDetailRepository.getSongDetail(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes(songDetail))));

      when(() => mockSongDetailRepository.getChordTabs('D7')).thenAnswer((invocation) => Future.value(['x 1 2 3 4 4']));
      when(() => mockSongDetailRepository.switchFavoriteStatus(songDetail)).thenAnswer((_) {
        return Future.value(right(unit));
      });
      when(() => mockFavoriteSongRepository.getFavoritePage(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes([mockSong(1)]))));

      // ignore: invalid_use_of_protected_member
      mockDetailProvider.state = mockDetailProvider.state.copyWith(hasFavoriteStatusChanged: true);

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(SongDetailRoute(song: mockSong(1)));
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWithValue(mockProvider),
          songDetailNotifierProvider.overrideWithValue(mockDetailProvider),
        ],
        router,
      );

      expect(find.byType(LyricsRenderer), findsOneWidget);
      expect(find.text('Title: new 1'), findsOneWidget);
      expect(
        find.textContaining(
          'Capo 3',
          findRichText: true,
        ),
        findsOneWidget,
      );

      await tester.tap(find
          .textContaining(
            'D7',
            findRichText: true,
          )
          .first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(TabWidget), findsOneWidget);
    });
  });
}
