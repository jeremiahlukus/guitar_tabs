// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_dto.dart';
import 'package:joyful_noise/core/infrastructure/dio_extensions.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

class SongDetailRemoteService {
  final Dio _dio;

  SongDetailRemoteService(
    this._dio,
  );

  Future<RemoteResponse<SongDetailDTO>> getFavoriteStatus(int songId) async {
    final requestUri = Uri.https(
      BackendConstants().backendBaseUrl(),
      '/api/v1/user_favorite_songs/$songId',
    );

    try {
      final response = await _dio.getUri<dynamic>(requestUri);
      if (response.statusCode == 200) {
        final dto = SongDetailDTO.fromJson(response.data as Map<String, dynamic>);
        return RemoteResponse.withNewData(dto, maxPage: 0);
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }

  Future<List<String>> getChordTabs(String chord) async {
    final requestUri = Uri.https(
      BackendConstants().backendBaseUrl(),
      '/api/v1/chord_tabs/$chord',
    );

    try {
      final response = await _dio.getUri<dynamic>(requestUri);

      if (response.statusCode == 200 && response.data != null) {
        // ignore: avoid_dynamic_calls
        final dynamic dto = response.data['tabs'];
        return [dto.toString()];
      } else {
        throw RestApiException(response.statusCode);
      }
    } catch (e) {
      return [''];
    }
  }

  /// Returns `null` if there's no Internet connection.
  Future<Unit?> switchFavoriteStatus(
    String songId, {
    required bool isCurrentlyFavorite,
  }) async {
    final requestUri = Uri.https(
      BackendConstants().backendBaseUrl(),
      '/api/v1/user_favorite_songs/$songId',
    );
    try {
      final response =
          await (isCurrentlyFavorite ? _dio.deleteUri<dynamic>(requestUri) : _dio.putUri<dynamic>(requestUri));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return unit;
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        return null;
      } else if (e.response != null) {
        if (!Platform.environment.containsKey('FLUTTER_TEST')) {
          // coverage:ignore-start
          await Sentry.captureException(e, stackTrace: StackTrace.current);
          // coverage:ignore-end
        }
        throw RestApiException(e.response?.statusCode);
      } else {
        logger.e(e);
        rethrow;
      }
    }
  }
}
