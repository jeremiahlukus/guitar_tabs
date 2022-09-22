// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/backend/songs/song_detail/notifiers/song_detail_notifier.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

class MockFavoriteSongRepository extends Mock implements SongDetailRepository {}

class MockSong extends Mock implements Song {}

void main() {
  group('SongDetailNotifier', () {
    group('.getSongDetail', () {
      test('sets state to SongDetailState.loadFailure if SongDetail.getSongDetail returns a BackendFailure', () async {
        final SongDetailRepository mockSongDetailRepository = MockFavoriteSongRepository();
        const page = 1;
        when(() => mockSongDetailRepository.getSongDetail(page)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final songDetailNotifier = SongDetailNotifier(mockSongDetailRepository);

        await songDetailNotifier.getSongDetail(page);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = songDetailNotifier.state;

        final expectedStateResultMatcher = equals(
          const SongDetailState.loadFailure(
            BackendFailure.api(400, 'message'),
          ),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to SongDetailState.loadSuccess if  SongDetail.getSongDetail returns a SongDetail', () async {
        final SongDetailRepository mockSongDetailRepository = MockFavoriteSongRepository();
        const page = 1;
        const songDetail = SongDetail(isFavorite: true, songId: '1');
        when(() => mockSongDetailRepository.getSongDetail(page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(songDetail))),
        );

        final songDetailNotifier = SongDetailNotifier(mockSongDetailRepository);

        await songDetailNotifier.getSongDetail(page);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = songDetailNotifier.state;

        final expectedStateResultMatcher = equals(
          SongDetailState.loadSuccess(
            Fresh.yes(songDetail),
          ),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to SongDetailState.initial if FavoriteSongRepository.getFavoritePage not called', () async {
        final SongDetailRepository mockSongDetailRepository = MockFavoriteSongRepository();
        final songDetailNotifier = SongDetailNotifier(mockSongDetailRepository);
        // ignore: invalid_use_of_protected_member
        final actualStateResult = songDetailNotifier.state;

        final expectedStateResultMatcher = equals(
          const SongDetailState.initial(),
        );

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
    group('.switchStarredStatus', () {
      test('sets hasFavoriteStatusChanged to false if SongDetail.getSongDetail returns a BackendFailure', () async {
        final SongDetailRepository mockSongDetailRepository = MockFavoriteSongRepository();
        const songDetail = SongDetail(isFavorite: true, songId: '1');
        when(() => mockSongDetailRepository.switchFavoriteStatus(songDetail)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final songDetailNotifier = SongDetailNotifier(mockSongDetailRepository);

        await songDetailNotifier.switchStarredStatus(songDetail);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = songDetailNotifier.state;

        expect(actualStateResult.hasFavoriteStatusChanged, false);
      });

      test('sets hasFavoriteStatusChanged to true if  SongDetail.getSongDetail returns a unit', () async {
        final SongDetailRepository mockSongDetailRepository = MockFavoriteSongRepository();
        const page = 1;
        const songDetail = SongDetail(isFavorite: true, songId: '1');
        when(() => mockSongDetailRepository.switchFavoriteStatus(songDetail)).thenAnswer(
          (invocation) => Future.value(right(unit)),
        );

        final songDetailNotifier = SongDetailNotifier(mockSongDetailRepository);
        when(() => mockSongDetailRepository.getSongDetail(page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(songDetail))),
        );

        await songDetailNotifier.getSongDetail(page);
        await songDetailNotifier.switchStarredStatus(songDetail);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = songDetailNotifier.state;

        expect(actualStateResult.hasFavoriteStatusChanged, true);
      });
      test('sets hasFavoriteStatusChanged to false if  SongDetail.getSongDetail returns null', () async {
        final SongDetailRepository mockSongDetailRepository = MockFavoriteSongRepository();
        const page = 1;
        const songDetail = SongDetail(isFavorite: false, songId: '1');
        when(() => mockSongDetailRepository.switchFavoriteStatus(songDetail)).thenAnswer(
          (invocation) => Future.value(right(null)),
        );

        final songDetailNotifier = SongDetailNotifier(mockSongDetailRepository);
        when(() => mockSongDetailRepository.getSongDetail(page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(songDetail))),
        );

        await songDetailNotifier.getSongDetail(page);
        await songDetailNotifier.switchStarredStatus(songDetail);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = songDetailNotifier.state;

        expect(actualStateResult.hasFavoriteStatusChanged, false);
      });

      test('sets hasFavoriteStatusChanged to false if  SongDetail.getSongDetail returns null', () async {
        final SongDetailRepository mockSongDetailRepository = MockFavoriteSongRepository();
        const page = 1;
        const songDetail = SongDetail(isFavorite: false, songId: '1');
        when(() => mockSongDetailRepository.switchFavoriteStatus(songDetail)).thenAnswer(
          (invocation) => Future.value(left(const BackendFailure.api(400, 'message'))),
        );

        final songDetailNotifier = SongDetailNotifier(mockSongDetailRepository);
        when(() => mockSongDetailRepository.getSongDetail(page)).thenAnswer(
          (invocation) => Future.value(right(Fresh.yes(songDetail))),
        );

        await songDetailNotifier.getSongDetail(page);
        await songDetailNotifier.switchStarredStatus(songDetail);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = songDetailNotifier.state;

        expect(actualStateResult.hasFavoriteStatusChanged, false);
      });
    });
  });
}
