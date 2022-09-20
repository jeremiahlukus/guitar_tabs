// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_remote_service.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';

class SongDetailRepository {
  final SongDetailRemoteService _remoteService;

  SongDetailRepository(this._remoteService);

  Future<Either<BackendFailure, Fresh<SongDetail?>>> getSongDetail(
    int songId,
  ) async {
    try {
      final remoteResponse = await _remoteService.getFavoriteStatus(songId);
      return right(
        await remoteResponse.maybeWhen(
          // only care about new data throw everything else
          // ignore: only_throw_errors
          orElse: () => throw RestApiException,
          withNewData: (data, _) async {
            return Fresh.yes(data.toDomain());
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(BackendFailure.api(e.errorCode, ''));
    }
  }

  /// Returns `right(null)` if there's no Internet connection.
  Future<Either<BackendFailure, Unit?>> switchFavoriteStatus(
    SongDetail songDetail,
  ) async {
    try {
      final actionCompleted = await _remoteService.switchFavoriteStatus(
        songDetail.songId,
        isCurrentlyFavorite: songDetail.isFavorite,
      );
      return right(actionCompleted);
    } on RestApiException catch (e) {
      return left(BackendFailure.api(e.errorCode, ''));
    }
  }
}
