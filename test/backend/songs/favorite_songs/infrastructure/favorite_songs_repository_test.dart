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

class FavoriteSongRemoteServiceMock extends Mock implements FavoriteSongsRemoteService {}

class FavoriteSongLocalServiceMock extends Mock implements FavoriteSongsLocalService {}

void main() {
  group('FavoriteSongRepository', () {
    final FavoriteSongsRemoteService remoteServiceMock = FavoriteSongRemoteServiceMock();
    final FavoriteSongsLocalService localServiceMock = FavoriteSongLocalServiceMock();
    const page = 1;
    final songDTO = [
      mockSongDTO(1),
      mockSongDTO(2),
    ];
    final favoriteSongRepository = FavoriteSongsRepository(remoteServiceMock, localServiceMock);

    group('.getFavoritePage', () {
      test('returns Left<BackendFailure, Fresh<List<Song>>> on RestApiException', () async {
        when(() => remoteServiceMock.getFavoriteSongsPage(page)).thenThrow(RestApiException(400));

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Left<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.noConnection',
          () async {
        when(() => remoteServiceMock.getFavoriteSongsPage(page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });

        when(() => localServiceMock.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        when(localServiceMock.getLocalPageCount).thenAnswer((_) => Future.value(1));

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.notModified',
          () async {
        when(() => remoteServiceMock.getFavoriteSongsPage(page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.notModified());
        });

        when(() => localServiceMock.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.withNewData',
          () async {
        when(() => remoteServiceMock.getFavoriteSongsPage(page)).thenAnswer((_) {
          return Future.value(
            RemoteResponse<List<SongDTO>>.withNewData(songDTO),
          );
        });

        when(() => localServiceMock.upsertPage(songDTO, page)).thenAnswer((_) => Future.value());

        final actualResult = await favoriteSongRepository.getFavoritePage(page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });
    });
  });
}
