// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';

part 'song_dto.freezed.dart';

@freezed
class SongDTO with _$SongDTO {
  const SongDTO._();
  const factory SongDTO({
    required int id,
    required String title,
    required String lyrics,
    required String category,
    required String artist,
    required String chords,
    required String url,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'song_number') required int songNumber,
  }) = _SongDTO;

  factory SongDTO.fromJson(Map<String, dynamic> json) => _$SongDTOFromJson(json);

  factory SongDTO.fromDomain(Song _) {
    return SongDTO(
      id: _.id,
      title: _.title,
      lyrics: _.lyrics,
      category: _.category,
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
      category: category,
      artist: artist,
      chords: chords,
      songNumber: songNumber,
      url: url,
    );
  }
}
