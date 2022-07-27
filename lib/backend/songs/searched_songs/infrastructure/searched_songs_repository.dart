// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/extensions.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_remote_service.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import 'package:joyful_noise/core/infrastructure/network_exceptions.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

class SearchedSongsRepository {
  final SearchedSongsRemoteService _remoteService;

  SearchedSongsRepository(this._remoteService);

  Future<Either<BackendFailure, Fresh<List<Song>>>> getSearchedSongsPage(
    String query,
    int page,
  ) async {
    try {
      logger.e("message");
      final remotePageItems = await _remoteService.getSearchedSongsPage(query, page);
      logger.e(remotePageItems);
      return right(
        remotePageItems.maybeWhen(
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
