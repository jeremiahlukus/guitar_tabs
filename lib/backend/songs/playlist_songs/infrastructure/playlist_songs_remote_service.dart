// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/songs_page_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class PlaylistSongsRemoteService extends SongsPageRemoteService {
  PlaylistSongsRemoteService(
    Dio dio,
    BackendHeadersCache headersCache,
  ) : super(dio, headersCache);

  Future<RemoteResponse<List<SongDTO>>> getPlaylistSongsPage(int page, String playlistName) async => super.getPage(
        storeEtag: false,
        // TODO(jeremiah): http for local https for
        requestUri: Uri.http(
          BackendConstants().backendBaseUrl(),
          '/api/v1/playlist_songs/$playlistName',
          <String, String>{
            'page': '$page',
          },
        ),
        jsonDataSelector: (dynamic json) => json as List<dynamic>,
      );
}
