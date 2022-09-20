// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

// Project imports:
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';

part 'song_detail_dto.freezed.dart';
part 'song_detail_dto.g.dart';

@freezed
class SongDetailDTO with _$SongDetailDTO {
  const SongDetailDTO._();
  const factory SongDetailDTO({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'song_id') required String songId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'is_favorite') required bool isFavorite,
  }) = _SongDetailDTO;

  factory SongDetailDTO.fromJson(Map<String, dynamic> json) => _$SongDetailDTOFromJson(json);

  SongDetail toDomain() => SongDetail(isFavorite: isFavorite, songId: songId);
}
