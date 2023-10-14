// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/user.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_dto.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_local_service.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_remote_service.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class MockUserRemoteService extends Mock implements UserRemoteService {}

class MockUserLocalService extends Mock implements UserLocalService {}

void main() {
  group('UserRepository', () {
    group('.deleteUser', () {
      test('returns Left<BackendFailure, Unit> on RestApiException', () async {
        final UserRemoteService mockUserRemoteService = MockUserRemoteService();
        final UserLocalService mockUserLocalService = MockUserLocalService();

        when(mockUserRemoteService.deleteUser).thenThrow(RestApiException(400));

        final userRepository = UserRepository(mockUserRemoteService, mockUserLocalService);

        final actualResult = await userRepository.deleteUser();
        final expectedResult = isA<Left<BackendFailure, Unit>>();

        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, Unit> when UserRemoteService returns Unit', () async {
        final UserRemoteService mockUserRemoteService = MockUserRemoteService();
        final UserLocalService mockUserLocalService = MockUserLocalService();

        when(mockUserRemoteService.deleteUser).thenAnswer((_) {
          return Future.value();
        });

        final userRepository = UserRepository(mockUserRemoteService, mockUserLocalService);

        final actualResult = await userRepository.deleteUser();
        final expectedResult = isA<Right<BackendFailure, Unit>>();

        expect(actualResult, expectedResult);
      });
    });
    group('.getUserPage', () {
      test('returns Left<BackendFailure, User> on RestApiException', () async {
        final UserRemoteService mockUserRemoteService = MockUserRemoteService();
        final UserLocalService mockUserLocalService = MockUserLocalService();

        when(mockUserRemoteService.getUserDetails).thenThrow(RestApiException(400));

        final userRepository = UserRepository(mockUserRemoteService, mockUserLocalService);

        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Left<BackendFailure, User>>();

        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, User> when UserRemoteService returns RemoteResponse.noConnection', () async {
        final UserRemoteService mockUserRemoteService = MockUserRemoteService();
        final UserLocalService mockUserLocalService = MockUserLocalService();

        const userDTO = UserDTO(id: 0, email: 'hey@hey.com');

        when(mockUserRemoteService.getUserDetails).thenAnswer((_) {
          return Future.value(const RemoteResponse<UserDTO>.noConnection());
        });

        when(mockUserLocalService.getUser).thenAnswer((_) => Future.value(userDTO));

        final userRepository = UserRepository(mockUserRemoteService, mockUserLocalService);

        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Right<BackendFailure, User>>();

        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, User> when UserRemoteService returns RemoteResponse.notModified', () async {
        final UserRemoteService mockUserRemoteService = MockUserRemoteService();
        final UserLocalService mockUserLocalService = MockUserLocalService();

        const userDTO = UserDTO(id: 0, email: 'hey@hey.com');

        when(mockUserRemoteService.getUserDetails).thenAnswer((_) {
          return Future.value(const RemoteResponse<UserDTO>.notModified());
        });

        when(mockUserLocalService.getUser).thenAnswer((_) => Future.value(userDTO));

        final userRepository = UserRepository(mockUserRemoteService, mockUserLocalService);

        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Right<BackendFailure, User>>();

        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, User> when UserRemoteService returns RemoteResponse.withNewData', () async {
        final UserRemoteService mockUserRemoteService = MockUserRemoteService();
        final UserLocalService mockUserLocalService = MockUserLocalService();

        const userDTO = UserDTO(id: 0, email: 'hey@hey.com');

        when(mockUserRemoteService.getUserDetails).thenAnswer((_) {
          return Future.value(
            const RemoteResponse<UserDTO>.withNewData(userDTO),
          );
        });

        when(() => mockUserLocalService.saveUser(userDTO)).thenAnswer((_) => Future.value());

        final userRepository = UserRepository(mockUserRemoteService, mockUserLocalService);

        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Right<BackendFailure, User>>();

        expect(actualResult, expectedResult);
      });
    });
  });
}
