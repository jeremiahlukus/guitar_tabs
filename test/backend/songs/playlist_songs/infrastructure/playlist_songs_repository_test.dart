// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockFavoriteSongRemoteService extends Mock implements PlaylistSongsRemoteService {}

void main() {
  group('PlaylistSongRepository', () {
    late PlaylistSongsRemoteService mockPlaylistSongRemoteService;
    late PlaylistSongsRepository favoriteSongRepository;
    const playlistName = 'test';
    const page = 1;

    setUp(() {
      mockPlaylistSongRemoteService = MockFavoriteSongRemoteService();
      favoriteSongRepository = PlaylistSongsRepository(mockPlaylistSongRemoteService);
    });

    test('returns Left<BackendFailure, Fresh<List<Song>>> on RestApiException', () async {
      when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName))
          .thenThrow(RestApiException(400));

      final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
      final expectedResult = isA<Left<BackendFailure, Fresh<List<Song>>>>();

      expect(actualResult, expectedResult);
    });

    test(
        'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.noConnection',
        () async {
      when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName)).thenAnswer((_) {
        return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
      });

      final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
      final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

      expect(actualResult, expectedResult);
    });

    test(
        'returns Right<BackendFailure,  Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.notModified',
        () async {
      when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName)).thenAnswer((_) {
        return Future.value(const RemoteResponse<List<SongDTO>>.notModified());
      });

      final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
      final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

      expect(actualResult, expectedResult);
    });

    test(
        'returns Right<BackendFailure, Fresh<List<Song>>> when FavoriteSongRemoteService returns RemoteResponse.withNewData',
        () async {
      final songDTO = [
        mockSongDTO(1),
        mockSongDTO(2),
      ];

      when(() => mockPlaylistSongRemoteService.getPlaylistSongsPage(page, playlistName)).thenAnswer((_) {
        return Future.value(
          RemoteResponse<List<SongDTO>>.withNewData(songDTO),
        );
      });

      final actualResult = await favoriteSongRepository.getPlaylistSong(page, playlistName);
      final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

      expect(actualResult, expectedResult);
    });
  });
}
