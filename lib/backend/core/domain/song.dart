import 'package:freezed_annotation/freezed_annotation.dart';

part 'song.freezed.dart';

@freezed
class Song with _$Song {
  const Song._();
  const factory Song({
    required int id,
    required String title,
    required int songNumber,
    required String lyrics,
    required String category,
    required String artist,
    required String chords,
    required String url,
  }) = _Song;
}
