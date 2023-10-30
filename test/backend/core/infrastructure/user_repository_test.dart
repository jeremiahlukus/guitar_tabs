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
    final UserRemoteService mockUserRemoteService = MockUserRemoteService();
    final UserLocalService mockUserLocalService = MockUserLocalService();
    final userRepository = UserRepository(mockUserRemoteService, mockUserLocalService);

    group('.deleteUser', () {
      test('returns Left<BackendFailure, Unit> on RestApiException', () async {
        when(mockUserRemoteService.deleteUser).thenThrow(RestApiException(400));
        final actualResult = await userRepository.deleteUser();
        final expectedResult = isA<Left<BackendFailure, Unit>>();
        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, Unit> when UserRemoteService returns Unit', () async {
        when(mockUserRemoteService.deleteUser).thenAnswer((_) => Future.value());
        final actualResult = await userRepository.deleteUser();
        final expectedResult = isA<Right<BackendFailure, Unit>>();
        expect(actualResult, expectedResult);
      });
    });

    group('.getUserPage', () {
      test('returns Left<BackendFailure, User> on RestApiException', () async {
        when(mockUserRemoteService.getUserDetails).thenThrow(RestApiException(400));
        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Left<BackendFailure, User>>();
        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, User> when UserRemoteService returns RemoteResponse.noConnection', () async {
        const userDTO = UserDTO(id: 0, email: 'hey@hey.com');
        when(mockUserRemoteService.getUserDetails)
            .thenAnswer((_) => Future.value(const RemoteResponse<UserDTO>.noConnection()));
        when(mockUserLocalService.getUser).thenAnswer((_) => Future.value(userDTO));
        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Right<BackendFailure, User>>();
        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, User> when UserRemoteService returns RemoteResponse.notModified', () async {
        const userDTO = UserDTO(id: 0, email: 'hey@hey.com');
        when(mockUserRemoteService.getUserDetails)
            .thenAnswer((_) => Future.value(const RemoteResponse<UserDTO>.notModified()));
        when(mockUserLocalService.getUser).thenAnswer((_) => Future.value(userDTO));
        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Right<BackendFailure, User>>();
        expect(actualResult, expectedResult);
      });

      test('returns Right<BackendFailure, User> when UserRemoteService returns RemoteResponse.withNewData', () async {
        const userDTO = UserDTO(id: 0, email: 'hey@hey.com');
        when(mockUserRemoteService.getUserDetails)
            .thenAnswer((_) => Future.value(const RemoteResponse<UserDTO>.withNewData(userDTO)));
        when(() => mockUserLocalService.saveUser(userDTO)).thenAnswer((_) => Future.value());
        final actualResult = await userRepository.getUserPage();
        final expectedResult = isA<Right<BackendFailure, User>>();
        expect(actualResult, expectedResult);
      });
    });
  });
}
