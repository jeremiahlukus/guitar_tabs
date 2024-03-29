// Package imports:
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/auth/domain/auth_failure.dart';
import 'package:joyful_noise/auth/infrastructure/webapp_authenticator.dart';
import 'package:joyful_noise/auth/notifiers/auth_notifier.dart';

class MockWebAppAuthenticator extends Mock implements WebAppAuthenticator {}

void main() {
  group('AuthNotifier', () {
    group('.checkAndUpdateAuthStatus', () {
      test('sets state to AuthState.authenticated() if WebAppAuthenticator().isSignedIn returns true', () async {
        final mockWebAppAuthenticator = MockWebAppAuthenticator();

        when(mockWebAppAuthenticator.isSignedIn).thenAnswer((_) => Future.value(true));

        final authNotifier = AuthNotifier(mockWebAppAuthenticator);

        await authNotifier.checkAndUpdateAuthStatus();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = authNotifier.state;

        final expectedStateResult = equals(const AuthState.authenticated());

        expect(actualStateResult, expectedStateResult);
      });

      test('sets state to AuthState.unauthenticated() if WebAppAuthenticator().isSignedIn returns false', () async {
        final mockWebAppAuthenticator = MockWebAppAuthenticator();

        when(mockWebAppAuthenticator.isSignedIn).thenAnswer((_) => Future.value(false));

        final authNotifier = AuthNotifier(mockWebAppAuthenticator);

        await authNotifier.checkAndUpdateAuthStatus();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = authNotifier.state;

        final expectedStateResultMatcher = equals(const AuthState.unauthenticated());

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });

    group('.signIn', () {
      test('sets state to AuthState.failure if WebAppAuthenticator().handleAuthorizationResponse() returns a Left',
          () async {
        final mockWebAppAuthenticator = MockWebAppAuthenticator();

        final uri = Uri.https('example.org', '/path', <String, String>{'q': 'dart'});

        when(mockWebAppAuthenticator.getAuthorizationUrl).thenReturn(uri);

        when(() => mockWebAppAuthenticator.handleAuthorizationResponse(any())).thenAnswer(
          (_) => Future.value(left(const AuthFailure.storage())),
        );

        final authNotifier = AuthNotifier(mockWebAppAuthenticator);
        await authNotifier.signIn((_) async => _);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = authNotifier.state;

        final expectedStateResultMatcher = equals(const AuthState.failure(AuthFailure.storage()));

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test(
          'sets state to AuthState.authenticated() if WebAppAuthenticator().handleAuthorizationResponse() returns a Right',
          () async {
        final mockWebAppAuthenticator = MockWebAppAuthenticator();

        final uri = Uri.http('example.org', '/path', <String, String>{'q': 'dart'});

        when(mockWebAppAuthenticator.getAuthorizationUrl).thenReturn(uri);

        when(() => mockWebAppAuthenticator.handleAuthorizationResponse(any()))
            .thenAnswer((_) => Future.value(right(unit)));

        final authNotifier = AuthNotifier(mockWebAppAuthenticator);
        await authNotifier.signIn((_) async => _);

        // ignore: invalid_use_of_protected_member
        final actualStateResult = authNotifier.state;

        final expectedStateResultMatcher = equals(const AuthState.authenticated());

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });

    group('.signOut', () {
      test('sets state to AuthState.failure if WebAppAuthenticator().signOut returns a Left', () async {
        final mockWebAppAuthenticator = MockWebAppAuthenticator();

        when(mockWebAppAuthenticator.signOut).thenAnswer(
          (_) => Future.value(left(const AuthFailure.storage())),
        );

        final authNotifier = AuthNotifier(mockWebAppAuthenticator);
        await authNotifier.signOut();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = authNotifier.state;
        final expectedStateResultMatcher = equals(const AuthState.failure(AuthFailure.storage()));

        expect(actualStateResult, expectedStateResultMatcher);
      });

      test('sets state to AuthState.unauthenticated if WebAppAuthenticator().signOut returns a Right', () async {
        final mockWebAppAuthenticator = MockWebAppAuthenticator();

        when(mockWebAppAuthenticator.signOut).thenAnswer((_) => Future.value(right(unit)));

        final authNotifier = AuthNotifier(mockWebAppAuthenticator);
        await authNotifier.signOut();

        // ignore: invalid_use_of_protected_member
        final actualStateResult = authNotifier.state;

        final expectedStateResultMatcher = equals(const AuthState.unauthenticated());

        expect(actualStateResult, expectedStateResultMatcher);
      });
    });
  });
}
