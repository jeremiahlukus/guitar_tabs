// Dart imports:

// Package imports:
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockDio extends Mock implements Dio {}

class MockBackendHeadersCache extends Mock implements BackendHeadersCache {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(Options());
    registerFallbackValue(const BackendHeaders());
  });

  group('FavoriteSongsRemoteService', () {
    late Dio mockDio;
    late BackendHeadersCache mockBackendHeadersCache;
    late FavoriteSongsRemoteService favoriteSongRemoteService;

    setUp(() {
      mockDio = MockDio();
      mockBackendHeadersCache = MockBackendHeadersCache();
      favoriteSongRemoteService = FavoriteSongsRemoteService(mockDio, mockBackendHeadersCache);
    });

    group('.getFavoriteSongsPage', () {
      test('returns RemoteResponse.notModified when response status code is 304 ', () async {
        when(() => mockDio.getUri<dynamic>(any(), options: any(named: 'options'))).thenAnswer(
          (_) => Future.value(Response<dynamic>(requestOptions: RequestOptions(), statusCode: 304)),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer((_) => Future.value());

        final actualResult = await favoriteSongRemoteService.getFavoriteSongsPage(1);
        const expectedResult = RemoteResponse<List<SongDTO>>.notModified(maxPage: 0);

        expect(actualResult, expectedResult);
      });

      test('returns RemoteResponse.withNewData when response status code is 200 ', () async {
        final mockData = [
          mockSongJson(1),
          mockSongJson(2),
        ];

        final convertedData = [SongDTO.fromJson(mockData.first), SongDTO.fromJson(mockData.last)];

        when(() => mockDio.getUri<dynamic>(any(), options: any(named: 'options'))).thenAnswer(
          (_) => Future.value(Response<dynamic>(requestOptions: RequestOptions(), statusCode: 200, data: mockData)),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer((_) => Future.value());
        when(() => mockBackendHeadersCache.saveHeaders(any(), any())).thenAnswer((_) => Future.value());

        final actualResult = await favoriteSongRemoteService.getFavoriteSongsPage(1);
        final expectedResult = RemoteResponse<List<SongDTO>>.withNewData(convertedData, maxPage: 1);

        expect(actualResult, expectedResult);
      });
    });
  });
}
