// Dart imports:

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_dto.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_remote_service.dart';
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
  group('SongDetailRemoteService', () {
    group('.getFavoriteStatus', () {
      test('returns RestApiException when response status code is 304 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 304,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        try {
          await songDetailRemoteService.getFavoriteStatus(1);
          // if it gets here fail test
          throw Error();
        } catch (e) {
          expect(e, isA<RestApiException>());
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
              requestOptions: RequestOptions(),
              statusCode: 400,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        try {
          await songDetailRemoteService.getFavoriteStatus(1);
          // if it gets here fail test
          throw Error();
        } catch (e) {
          expect(e, isA<RestApiException>());
        }
      });
      test('returns RemoteResponse.noConnection() when no connection ', () async {
        final Dio mockDio = MockDio();
        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(),
            error: const SocketException(''),
          ),
        );
        final songDetailRemoteService = SongDetailRemoteService(mockDio);

        final actualResult = await songDetailRemoteService.getFavoriteStatus(1);
        const expectedResult = RemoteResponse<SongDetailDTO>.noConnection();

        expect(actualResult, expectedResult);
      });
      test('returns RestApiException when DioError and response ', () async {
        final Dio mockDio = MockDio();

        final mockData = {'is_favorite': true, 'song_id': '1'};

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            response: Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 400,
              data: mockData,
            ),
            requestOptions: RequestOptions(),
            error: Exception('error'),
          ),
        );
        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        try {
          await songDetailRemoteService.getFavoriteStatus(1);
        } catch (e) {
          expect(e, isA<RestApiException>());
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
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: mockData,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);

        final actualResult = await songDetailRemoteService.getFavoriteStatus(1);
        final expectedResult = RemoteResponse<SongDetailDTO>.withNewData(convertedData, maxPage: 0);

        expect(actualResult, expectedResult);
      });
    });
  });

  group('.getChordTabs', () {
    test('returns RestApiException when response status code is 304 ', () async {
      final Dio mockDio = MockDio();

      when(
        () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
      ).thenAnswer(
        (invocation) => Future.value(
          Response<dynamic>(
            requestOptions: RequestOptions(),
            statusCode: 304,
          ),
        ),
      );

      final songDetailRemoteService = SongDetailRemoteService(mockDio);
      final actualResult = await songDetailRemoteService.getChordTabs('C');
      const expectedResult = [''];

      expect(actualResult, expectedResult);
    });
    // double testing but just being safe for 304
    test('returns RestApiException when response status code is anything other than 200 ', () async {
      final Dio mockDio = MockDio();

      when(
        () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
      ).thenAnswer(
        (invocation) => Future.value(
          Response<dynamic>(
            requestOptions: RequestOptions(),
            statusCode: 400,
          ),
        ),
      );

      final songDetailRemoteService = SongDetailRemoteService(mockDio);
      final actualResult = await songDetailRemoteService.getChordTabs('C');
      const expectedResult = [''];

      expect(actualResult, expectedResult);
    });
    test('returns empty array when no connection ', () async {
      final Dio mockDio = MockDio();

      when(
        () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(),
          error: const SocketException(''),
        ),
      );
      final songDetailRemoteService = SongDetailRemoteService(mockDio);

      final actualResult = await songDetailRemoteService.getChordTabs('C');
      const expectedResult = [''];

      expect(actualResult, expectedResult);
    });

    test('returns chord data when response status code is 200 ', () async {
      final Dio mockDio = MockDio();

      final mockData = {'tabs': 'x 1 2 3 4 5'};

      when(
        () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
      ).thenAnswer(
        (invocation) => Future.value(
          Response<dynamic>(
            requestOptions: RequestOptions(),
            statusCode: 200,
            data: mockData,
          ),
        ),
      );

      final songDetailRemoteService = SongDetailRemoteService(mockDio);

      final actualResult = await songDetailRemoteService.getChordTabs('C');
      final expectedResult = ['x 1 2 3 4 5'];

      expect(actualResult, expectedResult);
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
              requestOptions: RequestOptions(),
              statusCode: 204,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, isA<Unit>());
      });
      test('returns Unit when response status code is 200 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, isA<Unit>());
      });
      test('returns RestApiException when response status code is not 204 or 200', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 400,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true).onError((error, stackTrace) {
          expect(error, isA<RestApiException>());
          return null;
        });
      });
      test('returns null when no connection ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(),
            error: const SocketException(''),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, null);
      });
      test('returns RestApiException when DioError when status code', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            response: Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 400,
            ),
            requestOptions: RequestOptions(),
            error: Exception('error'),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);

        await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true).onError((error, stackTrace) {
          expect(error, isA<RestApiException>());
          return null;
        });
      });
    });
    test('returns DioError when DioError without status code', () async {
      final Dio mockDio = MockDio();

      when(
        () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(),
          error: Exception('error'),
        ),
      );

      final songDetailRemoteService = SongDetailRemoteService(mockDio);

      await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true).onError((error, stackTrace) {
        expect(error, isA<DioError>());
        return null;
      });
    });

    group('isCurrentlyFavorite is false', () {
      test('returns Unit when response status code is 204 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.putUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 204,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, isA<Unit>());
      });
      test('returns Unit when response status code is 200 ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.putUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);
        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, isA<Unit>());
      });
      test('returns RestApiException when response status code is not 204 or 200', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.putUri<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (invocation) => Future.value(
            Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 400,
            ),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);

        await songDetailRemoteService
            .switchFavoriteStatus('1', isCurrentlyFavorite: false)
            .onError((error, stackTrace) {
          expect(error, isA<RestApiException>());
          return null;
        });
      });
      test('returns null when no connection ', () async {
        final Dio mockDio = MockDio();

        when(
          () => mockDio.putUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(),
            error: const SocketException(''),
          ),
        );

        final songDetailRemoteService = SongDetailRemoteService(mockDio);

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, null);
      });
    });
  });
}
