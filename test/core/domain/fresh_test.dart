// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/core/domain/fresh.dart';
import '../../_mocks/song/mock_song.dart';

class MockSong extends Mock implements SongDTO {}

void main() {
  testWidgets('Fresh.yes returns isFresh: true', (tester) async {
    final actual = Fresh.yes([mockSong(1)]);
    expect(actual.isFresh, true);
  });
  testWidgets('Fresh.no returns isFresh: false', (tester) async {
    final actual = Fresh.no([mockSong(1)]);
    expect(actual.isFresh, false);
  });
}
