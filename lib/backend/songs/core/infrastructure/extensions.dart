// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';

extension DTOListToDomainList on List<SongDTO> {
  List<Song> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
