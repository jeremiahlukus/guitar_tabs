// Package imports:
import 'package:diox/diox.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/songs_page_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class SearchedSongsRemoteService extends SongsPageRemoteService {
  SearchedSongsRemoteService(
    Dio dio,
    BackendHeadersCache headersCache,
  ) : super(dio, headersCache);

  Future<RemoteResponse<List<SongDTO>>> getSearchedSongsPage(
    String query,
    int page,
  ) async =>
      super.getPage(
        storeEtag: false,
        requestUri: Uri.https(
          BackendConstants().backendBaseUrl(),
          '/api/v1/songs',
          <String, dynamic>{
            'query': query,
            'page': '$page',
            'per_page': PaginationConfig.itemsPerPage.toString(),
          },
        ),
        jsonDataSelector: (dynamic json) => json as List<dynamic>,
      );
}
