// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:joyful_noise/backend/songs/song_detail/domain/song_detail.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_dto.dart';

void main() {
  group('SongDetailDTO', () {
    test('converts DTO toDomain', () {
      const dto = SongDetailDTO(songId: '1', isFavorite: true);
      final domain = dto.toDomain();
      expect(domain, const SongDetail(isFavorite: true, songId: '1'));
    });
  });
}
