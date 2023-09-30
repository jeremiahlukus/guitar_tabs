// ignore_for_file: invalid_annotation_target

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

part 'song_dto.freezed.dart';
part 'song_dto.g.dart';

String _nullFromJson(Object? json) {
  return (json as String?) ?? '';
}

@freezed
class SongDTO with _$SongDTO {
  const SongDTO._();
  const factory SongDTO({
    required int id,
    required String title,
    required String lyrics,
    // @JsonKey(fromJson: _nullFromJson) required String category,
    @JsonKey(fromJson: _nullFromJson) required String artist,
    @JsonKey(fromJson: _nullFromJson) required String chords,
    @JsonKey(fromJson: _nullFromJson) required String url,
    @JsonKey(name: 'song_number') required int songNumber,
  }) = _SongDTO;

  factory SongDTO.fromJson(Map<String, dynamic> json) => _$SongDTOFromJson(json);

  factory SongDTO.fromDomain(Song _) {
    return SongDTO(
      id: _.id,
      title: _.title,
      lyrics: _.lyrics,
      //category: _.category,
      songNumber: _.songNumber,
      artist: _.artist,
      chords: _.chords,
      url: _.url,
    );
  }
  Song toDomain() {
    return Song(
      id: id,
      title: title,
      lyrics: lyrics,
      //category: category,
      artist: artist,
      chords: chords,
      songNumber: songNumber,
      url: url,
    );
  }
}
