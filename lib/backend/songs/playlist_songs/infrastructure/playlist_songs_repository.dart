// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/extensions.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_remote_service.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';

class PlaylistSongsRepository {
  final PlaylistSongsRemoteService _remoteService;

  PlaylistSongsRepository(this._remoteService);

  Future<Either<BackendFailure, Fresh<List<Song>>>> getPlaylistSong(
    int page,
    String playlistName,
  ) async {
    try {
      final remotePageItems = await _remoteService.getPlaylistSongsPage(page, playlistName);
      return right(
        await remotePageItems.maybeWhen(
          orElse: () => Fresh.no([]),
          withNewData: (data, maxPage) async {
            return Fresh.yes(
              data.toDomain(),
              isNextPageAvailable: page < (maxPage ?? 0),
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(BackendFailure.api(e.errorCode, ''));
    }
  }
}
