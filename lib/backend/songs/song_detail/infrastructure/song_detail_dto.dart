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
    @JsonKey(name: 'song_id') required String songId,
    @JsonKey(name: 'is_favorite') required bool isFavorite,
  }) = _SongDetailDTO;

  factory SongDetailDTO.fromJson(Map<String, dynamic> json) => _$SongDetailDTOFromJson(json);

  SongDetail toDomain() => SongDetail(isFavorite: isFavorite, songId: songId);

  static const lastUsedFieldName = 'lastUsed';

  Map<String, dynamic> toSembast() {
    final json = toJson();
    // ignore: cascade_invocations
    json.remove('songId');
    json[lastUsedFieldName] = Timestamp.now();
    return json;
  }

  factory SongDetailDTO.fromSembast(
    RecordSnapshot<String, Map<String, dynamic>> snapshot,
  ) {
    final copiedMap = Map<String, dynamic>.from(snapshot.value);
    copiedMap['songId'] = snapshot.key;
    return SongDetailDTO.fromJson(copiedMap);
  }
}
