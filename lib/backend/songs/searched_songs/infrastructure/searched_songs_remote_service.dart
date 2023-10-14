// Package imports:

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/songs_page_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class SearchedSongsRemoteService extends SongsPageRemoteService {
  SearchedSongsRemoteService(
    super.dio,
    super.headersCache,
  );

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

  Future<RemoteResponse<List<SongDTO>>> getPlaylistSearchedSongsPage(
    String query,
    int page,
    String playlistName,
  ) async =>
      super.getPage(
        storeEtag: false,
        requestUri: Uri.https(
          BackendConstants().backendBaseUrl(),
          '/api/v1/playlist_songs/$playlistName',
          <String, dynamic>{
            'query': query,
            'page': '$page',
            'per_page': PaginationConfig.itemsPerPage.toString(),
          },
        ),
        jsonDataSelector: (dynamic json) => json as List<dynamic>,
      );
}
