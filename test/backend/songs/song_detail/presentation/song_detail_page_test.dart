// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/auth/notifiers/auth_notifier.dart';
import 'package:joyful_noise/backend/core/domain/user.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/backend/core/notifiers/user_notifier.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/backend/songs/song_detail/notifiers/song_detail_notifier.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/audio_control_buttons.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/common_audio.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/song_detail_page.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import '../../../../_mocks/song/mock_song.dart';
import '../../../../utils/router_test_utils.dart';

class MockSongDetailRepository extends Mock implements SongDetailRepository {}

class MockFavoriteSongRepository extends Mock implements FavoriteSongsRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class FakeUserNotifier extends UserNotifier {
  FakeUserNotifier(super.userRepository);

  @override
  Future<void> getUserPage() async {
    state = const UserState.loadSuccess(
      User(
        name: 'Jon Doe',
        avatarUrl: 'www.example.com/avatarUrl',
        email: 'hey@hey.com',
      ),
    );
    return;
  }
}

class MockAuthNotifier extends Mock implements AuthNotifier {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockSearchHistoryRepository extends Mock implements SearchHistoryRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(const SongDetail(isFavorite: true, songId: '1'));
    registerFallbackValue(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return Container();
        },
      ),
    );
  });
  group('SongsDetailPage', () {
    testWidgets('taping on LyricsRenderer opens dialog with TabWidget', (tester) async {
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
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );

      expect(find.byType(InteractiveViewer), findsOneWidget);
      expect(find.byType(LyricsRenderer), findsOneWidget);
      expect(find.text('new 1'), findsOneWidget);
      expect(
        find.textContaining(
          'Capo 3',
          findRichText: true,
        ),
        findsOneWidget,
      );

      await tester.tap(
        find
            .textContaining(
              'D7',
              findRichText: true,
            )
            .first,
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(TabWidget), findsOneWidget);

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(TabWidget), findsNothing);
    });
    testWidgets('taping on transposeIncrement button transposes song', (tester) async {
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
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );

      expect(
        find
            .textContaining(
              'D7',
              findRichText: true,
            )
            .first,
        findsOneWidget,
      );

      await tester.tap(find.byKey(SongDetailPageState.transposeDecrementKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('-1'), findsOneWidget);
      expect(
        find
            .textContaining(
              'C#7',
              findRichText: true,
            )
            .first,
        findsOneWidget,
      );
      expect(
        find.textContaining(
          'D7',
          findRichText: true,
        ),
        findsNothing,
      );
      await tester.tap(find.byKey(SongDetailPageState.transposeIncrementKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(
        find.textContaining(
          'C#7',
          findRichText: true,
        ),
        findsNothing,
      );
      expect(
        find
            .textContaining(
              'D7',
              findRichText: true,
            )
            .first,
        findsOneWidget,
      );
    });
    testWidgets('taping on scrollSpeed button increases scrollSpeed', (tester) async {
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
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );

      await tester.tap(find.byKey(SongDetailPageState.scrollSpeedIncrementKey));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.byKey(SongDetailPageState.scrollSpeedDecrementKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('0'), findsNWidgets(2));
      // Doesnt go negitive
      await tester.tap(find.byKey(SongDetailPageState.scrollSpeedDecrementKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('0'), findsNWidgets(2));
    });

    testWidgets('taping on hideChords button hides Chords', (tester) async {
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
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );

      expect(
        find.textContaining(
          'D7',
          findRichText: true,
        ),
        findsWidgets,
      );

      await tester.tap(find.byKey(SongDetailPageState.hideChordsKey));
      await tester.pumpAndSettle();

      double effectiveFontSize(RichText text) => (text.textScaleFactor ?? 1) * text.text.style!.fontSize!;
      final text = tester.widget<RichText>(
        find
            .textContaining(
              'D7',
              findRichText: true,
            )
            .first,
      );
      expect(effectiveFontSize(text), 0);
    });

    testWidgets('taping on favorite button favorites song', (tester) async {
      final router = AppRouter();
      final mockSongDetailRepository = MockSongDetailRepository();
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockDetailProvider = SongDetailNotifier(mockSongDetailRepository);
      const songDetail = SongDetail(isFavorite: true, songId: '1');
      when(() => mockSongDetailRepository.getSongDetail(1))
          .thenAnswer((invocation) => Future.value(right(Fresh.yes(songDetail))));

      when(() => mockSongDetailRepository.getChordTabs('D7')).thenAnswer((invocation) => Future.value(['x 1 2 3 4 4']));
      when(() => mockSongDetailRepository.switchFavoriteStatus(any())).thenAnswer((_) {
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
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.star_outline), findsNothing);
      verifyNever(() => mockSongDetailRepository.switchFavoriteStatus(any()));
      await tester.tap(find.byKey(SongDetailPageState.favoriteKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      verify(() => mockSongDetailRepository.switchFavoriteStatus(any())).called(1);
      expect(find.byIcon(Icons.star), findsNothing);
      expect(find.byIcon(Icons.star_outline), findsOneWidget);
    });

    testWidgets('taping on Play/Pause plays/pauses Audio', (tester) async {
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
      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes([mockSong(1)]))),
      );

      // ignore: invalid_use_of_protected_member
      mockDetailProvider.state = mockDetailProvider.state.copyWith(hasFavoriteStatusChanged: true);

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(SongDetailRoute(song: mockSong(1)));
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);
      await tester.tap(find.byKey(ControlButtons.playButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byIcon(Icons.play_arrow), findsNothing);
      expect(find.byIcon(Icons.pause), findsOneWidget);
      await tester.tap(find.byKey(ControlButtons.pauseButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);
    });

    testWidgets('taping on Speed Button open dialog', (tester) async {
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
      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes([mockSong(1)]))),
      );

      // ignore: invalid_use_of_protected_member
      mockDetailProvider.state = mockDetailProvider.state.copyWith(hasFavoriteStatusChanged: true);

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(SongDetailRoute(song: mockSong(1)));
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );
      expect(find.byKey(ControlButtons.speedButton), findsOneWidget);
      await tester.tap(find.byKey(ControlButtons.speedButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(Dialog), findsOneWidget);
    });

    testWidgets('able to drag the seek slider', (tester) async {
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
      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes([mockSong(1)]))),
      );

      // ignore: invalid_use_of_protected_member
      mockDetailProvider.state = mockDetailProvider.state.copyWith(hasFavoriteStatusChanged: true);

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockSong(1)]));

      // ignore: unawaited_futures
      router.push(SongDetailRoute(song: mockSong(1)));
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);
      await tester.tap(find.byKey(ControlButtons.playButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byKey(SeekBar.seekbarKey), findsOneWidget);
      await tester.drag(find.byKey(SeekBar.seekbarKey), const Offset(-800, 0));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.byKey(ControlButtons.pauseButton));
    });

    testWidgets('when song url is empty does not display audio control buttons', (tester) async {
      final router = AppRouter();
      final mockSongDetailRepository = MockSongDetailRepository();
      final mockFavoriteSongRepository = MockFavoriteSongRepository();
      final mockProvider = FavoriteSongNotifier(mockFavoriteSongRepository);

      final mockDetailProvider = SongDetailNotifier(mockSongDetailRepository);
      const songDetail = SongDetail(isFavorite: true, songId: '1');
      when(() => mockSongDetailRepository.getSongDetail(1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes(songDetail))),
      );

      when(() => mockFavoriteSongRepository.getFavoritePage(1)).thenAnswer(
        (invocation) => Future.value(right(Fresh.yes([mockEmptySong(1)]))),
      );

      // ignore: invalid_use_of_protected_member
      mockDetailProvider.state = mockDetailProvider.state.copyWith(hasFavoriteStatusChanged: true);

      // ignore: invalid_use_of_protected_member
      mockProvider.state = mockProvider.state.copyWith(songs: Fresh.yes([mockEmptySong(1)]));

      // ignore: unawaited_futures
      router.push(SongDetailRoute(song: mockEmptySong(1)));
      await pumpRouterApp(
        tester,
        [
          favoriteSongsNotifierProvider.overrideWith((_) => mockProvider),
          songDetailNotifierProvider.overrideWith((_) => mockDetailProvider),
        ],
        router,
      );
      expect(find.byIcon(Icons.play_arrow), findsNothing);
      expect(find.byIcon(Icons.pause), findsNothing);
      expect(find.byKey(SeekBar.seekbarKey), findsNothing);
      expect(find.textContaining('Suggest Changes'), findsOneWidget);
    });
  });
}
