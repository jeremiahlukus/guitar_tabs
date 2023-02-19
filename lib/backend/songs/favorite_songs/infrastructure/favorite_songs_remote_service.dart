// Package imports:

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/songs_page_remote_service.dart';
import 'package:joyful_noise/core/infrastructure/remote_response.dart';

class FavoriteSongsRemoteService extends SongsPageRemoteService {
  FavoriteSongsRemoteService(
    super.dio,
    super.headersCache,
  );

  Future<RemoteResponse<List<SongDTO>>> getFavoriteSongsPage(
    int page,
  ) async =>
      super.getPage(
        storeEtag: true,
        requestUri: Uri.https(
          BackendConstants().backendBaseUrl(),
          '/api/v1/user_favorite_songs',
          <String, String>{
            'page': '$page',
          },
        ),
        jsonDataSelector: (dynamic json) => json as List<dynamic>,
      );
}
