// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/extensions.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_remote_service.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

class SearchedSongsRepository {
  final SearchedSongsRemoteService _remoteService;
  final FavoriteSongsLocalService _localService;
  SearchedSongsRepository(this._remoteService, this._localService);

  Future<Either<BackendFailure, Fresh<List<Song>>>> getSearchedSongsPage(
    String query,
    int page,
  ) async {
    try {
      final remotePageItems = await _remoteService.getSearchedSongsPage(query, page);
      final localDTO = await remotePageItems.maybeWhen(
        noConnection: () {
          return _localService.searchLocalSongs(query).then((_) => _.toDomain());
        },
        orElse: () {},
      );

      final localPage = await remotePageItems.maybeWhen(
        noConnection: () async {
          return page < await _localService.getLocalPageCount();
        },
        orElse: () {},
      );
      return right(
        remotePageItems.maybeWhen(
          noConnection: () {
            if (localDTO == null) {
              return Fresh.no([], isNextPageAvailable: false);
            } else {
              return Fresh.no(
                localDTO,
                isNextPageAvailable: localPage,
              );
            }
          },
          withNewData: (data, maxPage) => Fresh.yes(
            data.toDomain(),
            isNextPageAvailable: page < (maxPage ?? 0),
          ),
          orElse: () => Fresh.no([], isNextPageAvailable: false),
        ),
      );
    } on RestApiException catch (e) {
      logger.e(e);
      return left(BackendFailure.api(e.errorCode, ''));
    }
  }
}
