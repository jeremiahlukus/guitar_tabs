// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_dto.dart';
import 'package:joyful_noise/core/infrastructure/dio_extensions.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class SongDetailRemoteService {
  final Dio _dio;

  SongDetailRemoteService(
    this._dio,
  );

  Future<RemoteResponse<SongDetailDTO>> getFavoriteStatus(int songId) async {
    final requestUri = Uri.http(
      BackendConstants().backendBaseUrl(),
      '/api/v1/user_favorite_songs/${songId.toString()}',
    );

    try {
      final response = await _dio.getUri<dynamic>(requestUri);
      if (response.statusCode == 200) {
        final dto = SongDetailDTO.fromJson(response.data as Map<String, dynamic>);
        return RemoteResponse.withNewData(dto, maxPage: 0);
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }

  /// Returns `null` if there's no Internet connection.
  Future<Unit?> switchFavoriteStatus(
    String songId, {
    required bool isCurrentlyFavorite,
  }) async {
    final requestUri = Uri.http(
      BackendConstants().backendBaseUrl(),
      '/api/v1/user_favorite_songs/$songId',
    );

    try {
      final response = await (isCurrentlyFavorite
          ? _dio.deleteUri<dynamic>(requestUri)
          : _dio.putUri<dynamic>(requestUri, data: {'song_id': songId}));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return unit;
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return null;
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
