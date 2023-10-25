// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/core/domain/fresh.dart';

part 'song_detail_notifier.freezed.dart';

@freezed
class SongDetailState with _$SongDetailState {
  const SongDetailState._();
  const factory SongDetailState.initial({
    @Default(false) bool hasFavoriteStatusChanged,
  }) = _Initial;
  const factory SongDetailState.loadInProgress({
    @Default(false) bool hasFavoriteStatusChanged,
  }) = _LoadInProgress;
  const factory SongDetailState.loadSuccess(
    Fresh<SongDetail?> songDetail, {
    @Default(false) bool hasFavoriteStatusChanged,
  }) = _LoadSuccess;
  const factory SongDetailState.loadFailure(
    BackendFailure failure, {
    @Default(false) bool hasFavoriteStatusChanged,
  }) = _LoadFailure;
}

class SongDetailNotifier extends StateNotifier<SongDetailState> {
  final SongDetailRepository _repository;

  SongDetailNotifier(this._repository) : super(const SongDetailState.initial());

  Future<void> getSongDetail(int songId) async {
    state = const SongDetailState.loadInProgress();
    final failureOrSongDetail = await _repository.getSongDetail(songId);
    state = failureOrSongDetail.fold(
      SongDetailState.loadFailure,
      SongDetailState.loadSuccess,
    );
  }

  Future<List<String>> getChordTabs(String chord) {
    return _repository.getChordTabs(chord);
  }

  Future<void> switchStarredStatus(SongDetail songDetail) async {
    await state.maybeMap(
      orElse: () {},
      loadSuccess: (successState) async {
        final stateCopy = successState.copyWith();
        final songDetail = successState.songDetail.entity;
        if (songDetail != null) {
          state = successState.copyWith.songDetail(
            entity: songDetail.copyWith(isFavorite: !songDetail.isFavorite),
          );

          final failureOrSuccess = await _repository.switchFavoriteStatus(songDetail);

          failureOrSuccess.fold(
            (l) => state = stateCopy,
            (r) => r == null ? state = stateCopy : state = state.copyWith(hasFavoriteStatusChanged: true),
          );
        }
      },
    );
  }
}
