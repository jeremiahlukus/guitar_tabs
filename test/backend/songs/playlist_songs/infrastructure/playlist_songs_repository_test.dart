// Package imports:
import 'package:dartz/dartz.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';
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

class MockFavoriteSongRemoteService extends Mock implements PlaylistSongsRemoteService {}

void main() {
  group('PlaylistSongRepository', () {
    group('.getFavoritePage', () {
      test('returns Left<BackendFailure, Fresh<List<Song>>> on RestApiException', () async {
        final PlaylistSongsRemoteService mockPlaylistSongRemoteService = MockFavoriteSongRemoteService();

        const playlistName = 'test';
        const page = 1;
        when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName))
            .thenThrow(RestApiException(400));

        final favoriteSongRepository = PlaylistSongsRepository(mockPlaylistSongRemoteService);

        final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
        final expectedResult = isA<Left<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.noConnection',
          () async {
        final PlaylistSongsRemoteService mockPlaylistSongRemoteService = MockFavoriteSongRemoteService();

        const playlistName = 'test';
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });

        final favoriteSongRepository = PlaylistSongsRepository(mockPlaylistSongRemoteService);

        final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.notModified',
          () async {
        final PlaylistSongsRemoteService mockPlaylistSongRemoteService = MockFavoriteSongRemoteService();

        const playlistName = 'test';
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.notModified());
        });

        final favoriteSongRepository = PlaylistSongsRepository(mockPlaylistSongRemoteService);

        final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.withNewData',
          () async {
        final PlaylistSongsRemoteService mockPlaylistSongRemoteService = MockFavoriteSongRemoteService();

        const playlistName = 'test';
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName)).thenAnswer((_) {
          return Future.value(
            RemoteResponse<List<SongDTO>>.withNewData(songDTO),
          );
        });

        final favoriteSongRepository = PlaylistSongsRepository(mockPlaylistSongRemoteService);

        final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });
    });
  });
}
