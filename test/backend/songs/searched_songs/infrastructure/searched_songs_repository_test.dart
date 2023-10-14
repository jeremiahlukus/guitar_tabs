// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockSearchedSongRemoteService extends Mock implements SearchedSongsRemoteService {}

class MockFavoriteSongLocalService extends Mock implements FavoriteSongsLocalService {}

void main() {
  group('SearchedSongsRepository', () {
    group('.getSearchedSongsPage', () {
      test('returns Right<BackendFailure, Fresh<List<Song>>> on No connection', () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];
        final song = [mockSong(1), mockSong(2)];
        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });
        when(() => mockFavoriteSongLocalService.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        when(() => mockFavoriteSongLocalService.searchLocalSongs(any())).thenAnswer((_) => Future.value(songDTO));

        when(mockFavoriteSongLocalService.getLocalPageCount).thenAnswer((_) => Future.value(1));

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
        expect(actualResult.getOrElse(() => Fresh.yes([])), Fresh.no(song, isNextPageAvailable: false));
      });

      test('returns Right<BackendFailure, Fresh<List<Song>>> on No connection and no local data', () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];
        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });
        when(() => mockFavoriteSongLocalService.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        when(() => mockFavoriteSongLocalService.searchLocalSongs(any())).thenAnswer((_) => Future.value([]));

        when(mockFavoriteSongLocalService.getLocalPageCount).thenAnswer((_) => Future.value(1));

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test('returns Left<BackendFailure,  Fresh<List<Song>>> when SearchedSongsRemoteService returns RestApiException',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;
        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenThrow(RestApiException(400));

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);
        final actualResult = await searchedSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Left<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when SearchedSongsRemoteService returns RemoteResponse.withNewData',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenAnswer((_) {
          return Future.value(
            RemoteResponse<List<SongDTO>>.withNewData(songDTO),
          );
        });

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });
      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when SearchedSongsRemoteService returns RemoteResponse.notModified',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;

        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenAnswer((_) {
          return Future.value(
            const RemoteResponse<List<SongDTO>>.notModified(),
          );
        });

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
        // set else to fresh true to fail if it doesnt get value
        expect(
          actualResult.getOrElse(() => Fresh.yes([])),
          const Fresh<List<Song>>(entity: [], isFresh: false, isNextPageAvailable: false),
        );
      });
    });

    group('.getPlaylistSearchedSongsPage', () {
      test('returns Right<BackendFailure, Fresh<List<Song>>> on No connection', () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;
        const playlist = 'Hymnal';

        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];
        final song = [mockSong(1), mockSong(2)];
        when(() => mockSearchedSongRemoteService.getPlaylistSearchedSongsPage('query', page, playlist)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });
        when(() => mockFavoriteSongLocalService.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        when(() => mockFavoriteSongLocalService.searchLocalSongs(any())).thenAnswer((_) => Future.value(songDTO));

        when(mockFavoriteSongLocalService.getLocalPageCount).thenAnswer((_) => Future.value(1));

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getPlaylistSearchedSongsPage('query', page, playlist);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
        expect(actualResult.getOrElse(() => Fresh.yes([])), Fresh.no(song, isNextPageAvailable: false));
      });

      test('returns Right<BackendFailure, Fresh<List<Song>>> on No connection and no local data', () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;
        const playlist = 'Hymnal';
        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];
        when(() => mockSearchedSongRemoteService.getPlaylistSearchedSongsPage('query', page, playlist)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });
        when(() => mockFavoriteSongLocalService.getPage(page)).thenAnswer((_) => Future.value(songDTO));

        when(() => mockFavoriteSongLocalService.searchLocalSongs(any())).thenAnswer((_) => Future.value([]));

        when(mockFavoriteSongLocalService.getLocalPageCount).thenAnswer((_) => Future.value(1));

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getPlaylistSearchedSongsPage('query', page, playlist);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test('returns Left<BackendFailure,  Fresh<List<Song>>> when SearchedSongsRemoteService returns RestApiException',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;
        const playlist = 'Hymnal';
        when(() => mockSearchedSongRemoteService.getPlaylistSearchedSongsPage('query', page, playlist))
            .thenThrow(RestApiException(400));

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);
        final actualResult = await searchedSongRepository.getPlaylistSearchedSongsPage('query', page, playlist);
        final expectedResult = isA<Left<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when SearchedSongsRemoteService returns RemoteResponse.withNewData',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;
        const playlist = 'Hymnal';
        final songDTO = [
          mockSongDTO(1),
          mockSongDTO(2),
        ];

        when(() => mockSearchedSongRemoteService.getPlaylistSearchedSongsPage('query', page, playlist)).thenAnswer((_) {
          return Future.value(
            RemoteResponse<List<SongDTO>>.withNewData(songDTO),
          );
        });

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getPlaylistSearchedSongsPage('query', page, playlist);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });
      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when SearchedSongsRemoteService returns RemoteResponse.notModified',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
        final FavoriteSongsLocalService mockFavoriteSongLocalService = MockFavoriteSongLocalService();
        const page = 1;
        const playlist = 'Hymnal';
        when(() => mockSearchedSongRemoteService.getPlaylistSearchedSongsPage('query', page, playlist)).thenAnswer((_) {
          return Future.value(
            const RemoteResponse<List<SongDTO>>.notModified(),
          );
        });

        final searchedSongRepository =
            SearchedSongsRepository(mockSearchedSongRemoteService, mockFavoriteSongLocalService);

        final actualResult = await searchedSongRepository.getPlaylistSearchedSongsPage('query', page, playlist);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
        // set else to fresh true to fail if it doesnt get value
        expect(
          actualResult.getOrElse(() => Fresh.yes([])),
          const Fresh<List<Song>>(entity: [], isFresh: false, isNextPageAvailable: false),
        );
      });
    });
  });
}
