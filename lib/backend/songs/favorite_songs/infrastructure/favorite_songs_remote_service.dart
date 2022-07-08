// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/songs_page_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class FavoriteSongsRemoteService extends SongsPageRemoteService {
  FavoriteSongsRemoteService(
    Dio dio,
    BackendHeadersCache headersCache,
  ) : super(dio, headersCache);

  final requestUri = Uri.http(
    BackendConstants().backendBaseUrl(),
    'api/v1/me',
  );
  Future<RemoteResponse<List<SongDTO>>> getFavoriteSongsPage(
    int page,
  ) async =>
      super.getPage(
        requestUri: Uri.https(
          BackendConstants().backendBaseUrl(),
          '/api/v1/user_favorite_songs',
          <String, String>{
            'page': '$page',
            'per_page': PaginationConfig.itemsPerPage.toString(),
          },
        ),
        jsonDataSelector: (dynamic json) => json as List<dynamic>,
      );
}
