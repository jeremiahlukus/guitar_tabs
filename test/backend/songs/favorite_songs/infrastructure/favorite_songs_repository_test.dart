// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockFavoriteSongRemoteService extends Mock implements FavoriteSongsRemoteService {}

class MockFavoriteSongLocalService extends Mock implements FavoriteSongsLocalService {}

void main() {
  group('FavoriteSongRepository', () {
    group('.getFavoritePage', () {
      test('returns Left<BackendFailure, Fresh<List<Song>>> on RestApiException', () async {
        final FavoriteSongsRemoteService mockFavoriteSongRemoteService = MockFavoriteSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;
        when(() => mockFavoriteSongRemoteService.getFavoriteSongsPage(page)).thenThrow(RestApiException(400));

        final favoriteSongRepository =
            FavoriteSongsRepository(mockFavoriteSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Left<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.noConnection',
          () async {
        final FavoriteSongsRemoteService mockFavoriteSongRemoteService = MockFavoriteSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockFavoriteSongRemoteService.getFavoriteSongsPage(page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });

        when(() => mockFavoriteSongLocalService.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        when(mockFavoriteSongLocalService.getLocalPageCount).thenAnswer((_) => Future.value(1));

        final favoriteSongRepository =
            FavoriteSongsRepository(mockFavoriteSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.notModified',
          () async {
        final FavoriteSongsRemoteService mockFavoriteSongRemoteService = MockFavoriteSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockFavoriteSongRemoteService.getFavoriteSongsPage(page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.notModified());
        });

        when(() => mockFavoriteSongLocalService.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        final favoriteSongRepository =
            FavoriteSongsRepository(mockFavoriteSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.withNewData',
          () async {
        final FavoriteSongsRemoteService mockFavoriteSongRemoteService = MockFavoriteSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockFavoriteSongRemoteService.getFavoriteSongsPage(page)).thenAnswer((_) {
          return Future.value(
            RemoteResponse<List<SongDTO>>.withNewData(songDTO),
          );
        });

        when(() => mockFavoriteSongLocalService.upsertPage(songDTO, page)).thenAnswer((_) => Future.value());

        final favoriteSongRepository =
            FavoriteSongsRepository(mockFavoriteSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });
    });
  });
}
