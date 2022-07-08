// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/songs_page_remote_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class MockDio extends Mock implements Dio {}

class MockBackendHeadersCache extends Mock implements BackendHeadersCache {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(Options());
    registerFallbackValue(const BackendHeaders());
  });
  group('SongsPageRemoteService', () {
    group('.getPage', () {
      test('returns RemoteResponse.notModified when response status code is 304 ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(path: ''),
              statusCode: 304,
            ),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final songsRemoteService = SongsPageRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await songsRemoteService.getPage(
          requestUri: Uri.https(
            'example.com',
            '/api/v1/user_favorite_songs',
            <String, String>{
              'page': '1',
              'per_page': '50',
            },
          ),
          jsonDataSelector: (dynamic json) => json as List<dynamic>,
        );
        const expectedResult = RemoteResponse<List<SongDTO>>.notModified(maxPage: 0);

        expect(actualResult, expectedResult);
      });

      test('returns RemoteResponse.withNewData when response status code is 200 ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

        const mockData = [
          {
            'id': 50098,
            'title': 'new 1',
            'song_number': 1,
            'url': 'gogole',
            'artist': 'New',
            'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
            'chords': null,
            'created_at': '2022-06-29T11:42:10.614-04:00',
            'updated_at': '2022-06-29T11:42:10.614-04:00',
            'category': 'general',
            'sub_category': null
          }
        ];

        final convertedData = [SongDTO.fromJson(mockData.first)];

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
              data: mockData,
            ),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        when(() => mockBackendHeadersCache.saveHeaders(any(), any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final songsRemoteService = SongsPageRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await songsRemoteService.getPage(
          requestUri: Uri.https(
            'example.com',
            '/api/v1/user_favorite_songs',
            <String, String>{
              'page': '1',
              'per_page': '50',
            },
          ),
          jsonDataSelector: (dynamic json) => json as List<dynamic>,
        );
        final expectedResult = RemoteResponse<List<SongDTO>>.withNewData(convertedData, maxPage: 1);

        expect(actualResult, expectedResult);
      });

      test('throws RestApiException when response status code is neither 304 nor 200 ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(path: ''),
              statusCode: 400,
            ),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final songsRemoteService = SongsPageRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await songsRemoteService.getPage(
          requestUri: Uri.https(
            'example.com',
            '/api/v1/user_favorite_songs',
            <String, String>{
              'page': '1',
              'per_page': '50',
            },
          ),
          jsonDataSelector: (dynamic json) => json as List<dynamic>,
        );
        final expectedResult = throwsA(isA<RestApiException>());

        expect(actualResult, expectedResult);
      });

      test('returns RemoteResponse.noConnection on No Connection DioError ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(path: ''),
            error: const SocketException(''),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final songsRemoteService = SongsPageRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await songsRemoteService.getPage(
          requestUri: Uri.https(
            'example.com',
            '/api/v1/user_favorite_songs',
            <String, String>{
              'page': '1',
              'per_page': '50',
            },
          ),
          jsonDataSelector: (dynamic json) => json as List<dynamic>,
        );
        const expectedResult = RemoteResponse<List<SongDTO>>.noConnection();

        expect(actualResult, expectedResult);
      });

      test('throws RestApiException on a non No Connection DioError with non-null error response ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(path: ''),
            response: Response<dynamic>(requestOptions: RequestOptions(path: '')),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final songsRemoteService = SongsPageRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await songsRemoteService.getPage(
          requestUri: Uri.https(
            'example.com',
            '/api/v1/user_favorite_songs',
            <String, String>{
              'page': '1',
              'per_page': '50',
            },
          ),
          jsonDataSelector: (dynamic json) => json as List<dynamic>,
        );
        final expectedResult = throwsA(isA<RestApiException>());

        expect(actualResult, expectedResult);
      });
    });
  });
}
