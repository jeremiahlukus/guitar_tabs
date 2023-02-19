// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_dto.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_remote_service.dart';
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
  group('UserRemoteService', () {
    group('.getUserDetails', () {
      test('returns RemoteResponse.notModified when response status code is 304 ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

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

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final userRemoteService = UserRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await userRemoteService.getUserDetails();
        const expectedResult = RemoteResponse<UserDTO>.notModified();

        expect(actualResult, expectedResult);
      });

      test('returns RemoteResponse.withNewData when response status code is 200 ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

        const mockData = {'name': 'John Doe', 'avatar_url': 'https://example.com/avatarUrl', 'email': 'hey@hey.com'};

        final convertedData = UserDTO.fromJson(mockData);

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

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        when(() => mockBackendHeadersCache.saveHeaders(any(), any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final userRemoteService = UserRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await userRemoteService.getUserDetails();
        final expectedResult = RemoteResponse<UserDTO>.withNewData(convertedData);

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
              requestOptions: RequestOptions(),
              statusCode: 400,
            ),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final userRemoteService = UserRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = userRemoteService.getUserDetails;
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
            requestOptions: RequestOptions(),
            error: const SocketException(''),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final userRemoteService = UserRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = await userRemoteService.getUserDetails();
        const expectedResult = RemoteResponse<UserDTO>.noConnection();

        expect(actualResult, expectedResult);
      });

      test('throws RestApiException on a non No Connection DioError with non-null error response ', () async {
        final Dio mockDio = MockDio();
        final BackendHeadersCache mockBackendHeadersCache = MockBackendHeadersCache();

        when(
          () => mockDio.getUri<dynamic>(any(), options: any(named: 'options')),
        ).thenThrow(
          DioError(
            requestOptions: RequestOptions(),
            response: Response<dynamic>(requestOptions: RequestOptions()),
          ),
        );

        when(() => mockBackendHeadersCache.getHeaders(any())).thenAnswer(
          (invocation) => Future.value(),
        );

        final userRemoteService = UserRemoteService(mockDio, mockBackendHeadersCache);

        final actualResult = userRemoteService.getUserDetails;
        final expectedResult = throwsA(isA<RestApiException>());

        expect(actualResult, expectedResult);
      });
    });
  });
}
