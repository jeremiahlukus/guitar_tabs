// Dart imports:

// Package imports:
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_dto.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockDio extends Mock implements Dio {}

class MockBackendHeadersCache extends Mock implements BackendHeadersCache {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(Options());
    registerFallbackValue(const BackendHeaders());
  });
  group('SongDetailRemoteService', () {
    group('.getFavoriteStatus', () {
      test('returns RestApiException when response status code is 304 ', () async {
        final Dio mockDio = MockDio();

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

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);
        try {
          await favoriteSongRemoteService.getFavoriteStatus(1);
          // if it gets here fail test
          throw Error();
        } on RestApiException {
          // if we get RestApiException its pass
          return;
        }
      });
      // double testing but just being safe for 304
      test('returns RestApiException when response status code is anything other than 200 ', () async {
        final Dio mockDio = MockDio();

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

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);
        try {
          await favoriteSongRemoteService.getFavoriteStatus(1);
          // if it gets here fail test
          throw Error();
        } on RestApiException {
          // if we get RestApiException its pass
          return;
        }
      });

      test('returns RemoteResponse.withNewData when response status code is 200 ', () async {
        final Dio mockDio = MockDio();

        final mockData = {'is_favorite': true, 'song_id': '1'};

        final convertedData = SongDetailDTO.fromJson(mockData);

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

        final favoriteSongsRemoteService = SongDetailRemoteService(mockDio);

        final actualResult = await favoriteSongsRemoteService.getFavoriteStatus(1);
        final expectedResult = RemoteResponse<SongDetailDTO>.withNewData(convertedData, maxPage: 0);

        expect(actualResult, expectedResult);
      });
    });
  });
  group('.switchFavoriteStatus', () {
    group('isCurrentlyFavorite is true', () {
      test('returns Unit when response status code is 204 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(path: ''),
              statusCode: 204,
            ),
          ),
        );

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);
        final actualResult = await favoriteSongRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, isA<Unit>());
      });
      test('returns RestApiException when response status code is not 204 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
            ),
          ),
        );

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);
        await favoriteSongRemoteService
            .switchFavoriteStatus('1', isCurrentlyFavorite: true)
            .onError((error, stackTrace) {
          expect(error, isA<RestApiException>());
        });
      });
      test('returns null when no connection ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(path: ''),
            error: const SocketException(''),
          ),
        );

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);

        final actualResult = await favoriteSongRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, null);
      });
    });
    group('isCurrentlyFavorite is false', () {
      test('returns Unit when response status code is 204 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.postUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(path: ''),
              statusCode: 204,
            ),
          ),
        );

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);
        final actualResult = await favoriteSongRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, isA<Unit>());
      });
      test('returns RestApiException when response status code is not 204 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.postUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
            ),
          ),
        );

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);

        await favoriteSongRemoteService
            .switchFavoriteStatus('1', isCurrentlyFavorite: false)
            .onError((error, stackTrace) {
          expect(error, isA<RestApiException>());
        });
      });
      test('returns null when no connection ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.postUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(path: ''),
            error: const SocketException(''),
          ),
        );

        final favoriteSongRemoteService = SongDetailRemoteService(mockDio);

        final actualResult = await favoriteSongRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, null);
      });
    });
  });
}
