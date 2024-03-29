// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2/oauth2.dart';
import 'package:platform/platform.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:joyful_noise/auth/domain/auth_failure.dart';
import 'package:joyful_noise/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:joyful_noise/core/infrastructure/dio_extensions.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

class WebAppAuthenticator {
  WebAppAuthenticator(
    this._credentialsStorage,
    this._dio,
  );

  /// Returns [LocalPlatform] by default
  /// Swap it during tests with [FakePlatform] and ensure to set it to null in
  /// the tear down
  @visibleForTesting
  static Platform getPlatform() => _platform ?? const LocalPlatform();

  static Platform? _platform;

  // ignore: avoid_setters_without_getters
  static set platform(Platform? platformArgument) => _platform = platformArgument;

  /// Returns [kDebugMode]] by default
  /// Swap it during tests with a [bool] or and ensure to set it to null in
  /// the tear down
  static bool getIsDebugMode() => _isDebugMode ?? kDebugMode;

  static bool? _isDebugMode;

  // ignore: avoid_setters_without_getters
  static set isDebugMode(bool? isDebugModeArgument) => _isDebugMode = isDebugModeArgument;

  final CredentialsStorage _credentialsStorage;
  final Dio _dio;
  static Uri authorizationEndpoint() {
    const useStaging = bool.fromEnvironment('USE_STAGING');
    if (getIsDebugMode() && !useStaging) {
      final isAndroid = getPlatform().isAndroid;
      return isAndroid ? Uri.parse('http://10.0.2.2:8888/login') : Uri.parse('http://127.0.0.1:8888/login');
    } else {
      return Uri.parse('https://${dotenv.env['API_URL']}/login');
    }
  }

  static Uri revocationEndpoint() {
    const useStaging = bool.fromEnvironment('USE_STAGING');
    if (getIsDebugMode() && !useStaging) {
      final isAndroid = getPlatform().isAndroid;
      return isAndroid ? Uri.parse('http://10.0.2.2:8888/api/v1/auth') : Uri.parse('http://127.0.0.1:8888/api/v1/auth');
    } else {
      return Uri.parse('https://${dotenv.env['API_URL']}/api/v1/auth');
    }
  }

  static Uri redirectUrl() {
    const useStaging = bool.fromEnvironment('USE_STAGING');
    if (getIsDebugMode() && !useStaging) {
      final isAndroid = getPlatform().isAndroid;
      return isAndroid ? Uri.parse('http://10.0.2.2:8888/callback') : Uri.parse('http://127.0.0.1:8888/callback');
    } else {
      return Uri.parse('https://${dotenv.env['API_URL']}/callback');
    }
  }

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();
      // if (storedCredentials != null) {
      //   if (storedCredentials.canRefresh && storedCredentials.isExpired) {
      //     final failureOrCredentials = await refresh(storedCredentials);
      //     // if failure from refresh return null else return creds.
      //     failureOrCredentials.fold((l) => null, (r) => r);
      //   }
      // }
      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn() => getSignedInCredentials().then((creds) => creds != null);

  // unit == void
  Future<Either<AuthFailure, Unit>> handleAuthorizationResponse(
    Map<String, String> queryParams,
  ) async {
    try {
      if (queryParams['state'] != null && queryParams['state']!.isNotEmpty) {
        final credentials = Credentials(queryParams['state'].toString());
        await _credentialsStorage.save(credentials);
        return right(unit);
      } else {
        return left(const AuthFailure.server('Query Params are empty'));
      }
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Uri getAuthorizationUrl() {
    return authorizationEndpoint();
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final credentials = await _credentialsStorage.read();
      final accessToken = credentials?.accessToken;

      try {
        await _dio.deleteUri<dynamic>(
          revocationEndpoint(),
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );
      } on DioException catch (e) {
        if (e.isNoConnectionError) {
          logger.e('No internet connect, did not revoke token');
        } else {
          if (!getIsDebugMode()) {
            // coverage:ignore-start
            await Sentry.captureException(e, stackTrace: StackTrace.current);
            // coverage:ignore-end
          }
          logger.e(e.error);
          rethrow;
        }
      }
      await clearCredentialsStorage();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    } catch (e) {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Unit>> clearCredentialsStorage() async {
    try {
      await _credentialsStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  // Future<Either<AuthFailure, Credentials>> refresh(Credentials credentials) async {
  //   try {
  //     final refreshedCreds =
  //         await credentials.refresh(httpClient: client, identifier: clientId, secret: clientSecret);
  //     await _credentialsStorage.save(refreshedCreds);
  //     return right(refreshedCreds);
  //   } on FormatException {
  //     return left(const AuthFailure.server());
  //   } on AuthorizationException catch (e) {
  //     return left(AuthFailure.server('${e.error}: ${e.description}'));
  //   } on PlatformException {
  //     return left(const AuthFailure.storage());
  //   }
  // }
}
