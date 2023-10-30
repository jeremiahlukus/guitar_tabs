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
  late Dio mockDio;
  late SongDetailRemoteService songDetailRemoteService;

  setUp(() {
    mockDio = MockDio();
    songDetailRemoteService = SongDetailRemoteService(mockDio);
  });
  group('SongDetailRemoteService', () {
    group('.getFavoriteStatus', () {
      test('returns RestApiException when response status code is 304 ', () async {
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

        expect(() => songDetailRemoteService.getFavoriteStatus(1), throwsA(isA<RestApiException>()));
      });
      // double testing but just being safe for 304
      test('returns RestApiException when response status code is anything other than 200 ', () async {
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

        expect(() => songDetailRemoteService.getFavoriteStatus(1), throwsA(isA<RestApiException>()));
      });
      test('returns RemoteResponse.noConnection() when no connection ', () async {
        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            error: const SocketException(''),
          ),
        );

        final actualResult = await songDetailRemoteService.getFavoriteStatus(1);
        const expectedResult = RemoteResponse<SongDetailDTO>.noConnection();

        expect(actualResult, expectedResult);
      });
      test('returns RestApiException when DioException and response ', () async {
        final mockData = {'is_favorite': true, 'song_id': '1'};

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            response: Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 400,
              data: mockData,
            ),
            requestOptions: RequestOptions(),
            error: Exception('error'),
          ),
        );

        expect(() => songDetailRemoteService.getFavoriteStatus(1), throwsA(isA<RestApiException>()));
      });

      test('returns RemoteResponse.withNewData when response status code is 200 ', () async {
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

        final actualResult = await songDetailRemoteService.getFavoriteStatus(1);
        final expectedResult = RemoteResponse<SongDetailDTO>.withNewData(convertedData, maxPage: 0);

        expect(actualResult, expectedResult);
      });
    });
  });

  group('.getChordTabs', () {
    test('returns RestApiException when response status code is 304 ', () async {
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

      final actualResult = await songDetailRemoteService.getChordTabs('C');
      const expectedResult = [''];

      expect(actualResult, expectedResult);
    });
    // double testing but just being safe for 304
    test('returns RestApiException when response status code is anything other than 200 ', () async {
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

      final actualResult = await songDetailRemoteService.getChordTabs('C');
      const expectedResult = [''];

      expect(actualResult, expectedResult);
    });
    test('returns empty array when no connection ', () async {
      when(
        () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          error: const SocketException(''),
        ),
      );

      final actualResult = await songDetailRemoteService.getChordTabs('C');
      const expectedResult = [''];

      expect(actualResult, expectedResult);
    });

    test('returns chord data when response status code is 200 ', () async {
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

      final actualResult = await songDetailRemoteService.getChordTabs('C');
      final expectedResult = ['x 1 2 3 4 5'];

      expect(actualResult, expectedResult);
    });
  });

  group('.switchFavoriteStatus', () {
    group('isCurrentlyFavorite is true', () {
      test('returns Unit when response status code is 204 ', () async {
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

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, isA<Unit>());
      });
      test('returns Unit when response status code is 200 ', () async {
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

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, isA<Unit>());
      });
      test('returns RestApiException when response status code is not 204 or 200', () async {
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

        expect(() => songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true),
            throwsA(isA<RestApiException>()),);
      });
      test('returns null when no connection ', () async {
        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            error: const SocketException(''),
          ),
        );

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true);

        expect(actualResult, null);
      });
      test('returns RestApiException when DioException when status code', () async {
        when(
          () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            response: Response<dynamic>(
              requestOptions: RequestOptions(),
              statusCode: 400,
            ),
            requestOptions: RequestOptions(),
            error: Exception('error'),
          ),
        );

        expect(() => songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true),
            throwsA(isA<RestApiException>()),);
      });
    });
    test('returns DioException when DioException without status code', () async {
      when(
        () => mockDio.deleteUri<dynamic>(any(), options: any(named: 'options')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          error: Exception('error'),
        ),
      );

      expect(() => songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: true),
          throwsA(isA<DioException>()),);
    });

    group('isCurrentlyFavorite is false', () {
      test('returns Unit when response status code is 204 ', () async {
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

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, isA<Unit>());
      });
      test('returns Unit when response status code is 200 ', () async {
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

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, isA<Unit>());
      });
      test('returns RestApiException when response status code is not 204 or 200', () async {
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

        expect(() => songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false),
            throwsA(isA<RestApiException>()),);
      });
      test('returns null when no connection ', () async {
        when(
          () => mockDio.putUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            error: const SocketException(''),
          ),
        );

        final actualResult = await songDetailRemoteService.switchFavoriteStatus('1', isCurrentlyFavorite: false);

        expect(actualResult, null);
      });
    });
  });
}
