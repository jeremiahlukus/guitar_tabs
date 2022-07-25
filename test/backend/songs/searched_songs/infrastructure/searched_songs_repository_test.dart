// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockSearchedSongRemoteService extends Mock implements SearchedSongsRemoteService {}

void main() {
  group('SearchedSongsRepository', () {
    group('.getSearchedSongsPage', () {
      test('returns Left<BackendFailure, Fresh<List<Song>>> on RestApiException', () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();

        const page = 1;
        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenThrow(RestApiException(400));

        final favoriteSongRepository = SearchedSongsRepository(mockSearchedSongRemoteService);

        final actualResult = await favoriteSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Left<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure,  Fresh<List<Song>>> when SearchedSongsRemoteService returns RemoteResponse.noConnection',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();

        const page = 1;
        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenThrow(RestApiException(400));

        when(() => mockSearchedSongRemoteService.getSearchedSongsPage('query', page)).thenAnswer((_) {
          return Future.value(const RemoteResponse<List<SongDTO>>.noConnection());
        });

        final searchedSongRepository = SearchedSongsRepository(mockSearchedSongRemoteService);

        final actualResult = await searchedSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });

      test(
          'returns Right<BackendFailure, Fresh<List<Song>>> when SearchedSongsRemoteService returns RemoteResponse.withNewData',
          () async {
        final SearchedSongsRemoteService mockSearchedSongRemoteService = MockSearchedSongRemoteService();
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

        final searchedSongRepository = SearchedSongsRepository(mockSearchedSongRemoteService);

        final actualResult = await searchedSongRepository.getSearchedSongsPage('query', page);
        final expectedResult = isA<Right<BackendFailure, Fresh<List<Song>>>>();

        expect(actualResult, expectedResult);
      });
    });
  });
}
