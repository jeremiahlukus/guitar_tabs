// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/extensions.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockSong extends Mock implements SongDTO {}

void main() {
  group('SongDTO to Domain conversion', () {
    test('Returns a List of Song from SongDTO', () {
      final songDTOs = [mockSongDTO(1), mockSongDTO(2)];
      final expectedSongs = [mockSong(1), mockSong(2)];

      final actualSongs = songDTOs.toDomain();
      expect(actualSongs, expectedSongs);
    });
  });
}
