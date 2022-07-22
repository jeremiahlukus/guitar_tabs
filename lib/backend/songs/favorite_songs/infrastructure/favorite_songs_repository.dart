// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/extensions.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_remote_service.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';

class FavoriteSongsRepository {
  final FavoriteSongsRemoteService _remoteService;
  final FavoriteSongsLocalService _localService;

  FavoriteSongsRepository(this._remoteService, this._localService);

  Future<Either<BackendFailure, Fresh<List<Song>>>> getFavoritePage(
    int page,
  ) async {
    try {
      final remotePageItems = await _remoteService.getFavoriteSongsPage(page);
      return right(
        await remotePageItems.when(
          noConnection: () async => Fresh.no(
            await _localService.getPage(page).then((_) => _.toDomain()),
            isNextPageAvailable: page < await _localService.getLocalPageCount(),
          ),
          notModified: (maxPage) async => Fresh.yes(
            await _localService.getPage(page).then((_) => _.toDomain()),
            isNextPageAvailable: page < (maxPage ?? 0),
          ),
          withNewData: (data, maxPage) async {
            await _localService.upsertPage(data, page);
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
