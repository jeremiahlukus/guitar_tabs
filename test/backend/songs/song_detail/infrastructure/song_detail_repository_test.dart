// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_dto.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_remote_service.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class MockSongDetailRemoteService extends Mock implements SongDetailRemoteService {}

void main() {
  group('SongDetailRepository', () {
    final SongDetailRemoteService mockFavoriteSongRemoteService = MockSongDetailRemoteService();
    final favoriteSongRepository = SongDetailRepository(mockFavoriteSongRemoteService);

    group('.getSongDetail', () {
      const page = 1;
      test('returns Left<BackendFailure, Fresh<List<Song>>> on RestApiException', () async {
        when(() => mockFavoriteSongRemoteService.getFavoriteStatus(page)).thenThrow(RestApiException(400));
        final actualResult = await favoriteSongRepository.getSongDetail(page);
        final expectedResult = isA<Left<BackendFailure, Fresh<SongDetail?>>>();
        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, Fresh<List<Song>>> when not withNewData', () async {
        when(() => mockFavoriteSongRemoteService.getFavoriteStatus(page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<SongDetailDTO>.noConnection());
        });
        final actualResult = await favoriteSongRepository.getSongDetail(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<SongDetail?>>>();
        expect(actualResult, expectedResult);
        expect(
          actualResult.getOrElse(() => Fresh.yes(const SongDetail(isFavorite: false, songId: '1'))),
          Fresh<SongDetail?>.no(null),
        );
      });

      test(
          'return Right<BackendFailure, Fresh<SongDetail?>>> when SongDetailRemoteService returns RemoteResponse.withNewData',
          () async {
        const songDTO = SongDetailDTO(songId: '1', isFavorite: true);
        when(() => mockFavoriteSongRemoteService.getFavoriteStatus(page)).thenAnswer((_) {
          return Future.value(
            const RemoteResponse<SongDetailDTO>.withNewData(songDTO),
          );
        });
        final actualResult = await favoriteSongRepository.getSongDetail(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<SongDetail?>>>();
        expect(actualResult, expectedResult);
      });
    });

    group('.getChordTabs', () {
      const page = 'C';
      test('returns empty List<String> on RestApiException', () async {
        when(() => mockFavoriteSongRemoteService.getChordTabs(page)).thenThrow(RestApiException(400));
        final actualResult = await favoriteSongRepository.getChordTabs(page);
        expect(actualResult, ['']);
      });

      test('return List<String> when SongDetailRemoteService returns RemoteResponse.withNewData', () async {
        when(() => mockFavoriteSongRemoteService.getChordTabs(page)).thenAnswer((_) {
          return Future.value(
            ['x 1 2 3 4'],
          );
        });
        final actualResult = await favoriteSongRepository.getChordTabs(page);
        expect(actualResult, ['x 1 2 3 4']);
      });
    });

    group('.switchFavoriteStatus', () {
      const songDetail = SongDetail(songId: '1', isFavorite: true);
      test('returns null on RestApiException', () async {
        when(
          () => mockFavoriteSongRemoteService.switchFavoriteStatus(
            songDetail.songId,
            isCurrentlyFavorite: songDetail.isFavorite,
          ),
        ).thenThrow(RestApiException(400));
        final actualResult = await favoriteSongRepository.switchFavoriteStatus(songDetail);
        final expectedResult = isA<Left<BackendFailure, Unit?>>();
        expect(actualResult, expectedResult);
      });

      test('return List<String> when SongDetailRemoteService returns RemoteResponse.withNewData', () async {
        when(
          () => mockFavoriteSongRemoteService.switchFavoriteStatus(
            songDetail.songId,
            isCurrentlyFavorite: songDetail.isFavorite,
          ),
        ).thenAnswer((_) {
          return Future.value(unit);
        });
        final actualResult = await favoriteSongRepository.switchFavoriteStatus(songDetail);
        final expectedResult = isA<Right<BackendFailure, Unit?>>();
        expect(actualResult, expectedResult);
      });
    });
  });
}
