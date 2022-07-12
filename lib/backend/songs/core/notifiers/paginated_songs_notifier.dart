// Package imports:
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

part 'paginated_songs_notifier.freezed.dart';

typedef SongGetter = Future<Either<BackendFailure, Fresh<List<Song>>>> Function(int page);

@freezed
class PaginatedSongsState with _$PaginatedSongsState {
  const PaginatedSongsState._();
  const factory PaginatedSongsState.initial(
    Fresh<List<Song>> songs,
  ) = _Initial;
  const factory PaginatedSongsState.loadInProgress(
    Fresh<List<Song>> songs,
    int itemsPerPage,
  ) = _LoadInProgress;
  const factory PaginatedSongsState.loadSuccess(
    Fresh<List<Song>> songs, {
    required bool isNextPageAvailable,
  }) = _LoadSuccess;
  const factory PaginatedSongsState.loadFailure(
    Fresh<List<Song>> songs,
    BackendFailure failure,
  ) = _LoadFailure;
}

class PaginatedSongsNotifier extends StateNotifier<PaginatedSongsState> {
  PaginatedSongsNotifier() : super(PaginatedSongsState.initial(Fresh.yes([])));

  int _page = 1;

  @protected
  void resetState() {
    _page = 1;
    state = PaginatedSongsState.initial(Fresh.yes([]));
  }

  @protected
  Future<void> getNextPage(SongGetter getter) async {
    state = PaginatedSongsState.loadInProgress(
      state.songs,
      PaginationConfig.itemsPerPage,
    );
    final failureOrSongs = await getter(_page);
    state = failureOrSongs.fold(
      (l) => PaginatedSongsState.loadFailure(state.songs, l),
      (r) {
        _page++;
        return PaginatedSongsState.loadSuccess(
          r.copyWith(
            entity: [
              ...state.songs.entity,
              ...r.entity,
            ],
          ),
          isNextPageAvailable: r.isNextPageAvailable ?? false,
        );
      },
    );
  }
}
