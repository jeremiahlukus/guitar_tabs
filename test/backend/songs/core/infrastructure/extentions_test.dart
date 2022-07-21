// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/core/infrastructure/extentions.dart';
import '../../../../_mocks/song/mock_song.dart';

class MockSong extends Mock implements SongDTO {}

void main() {
  testWidgets('Returns a List of Song from SongDTO', (tester) async {
    final songDTOs = [mockSongDTO(1), mockSongDTO(2)];
    final expectedSongs = [mockSong(1), mockSong(2)];

    final actualSongs = songDTOs.toDomain();
    expect(actualSongs, expectedSongs);
  });
}
