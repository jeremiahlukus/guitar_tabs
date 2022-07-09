// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';

void main() {
  group('Song', () {
    test('creates Song object', () {
      const song = Song(
          id: 1,
          title: 'title',
          songNumber: 1,
          lyrics: 'lyrics',
          category: 'category',
          artist: 'artist',
          chords: 'chords',
          url: 'url',);
      const expected = 'title';

      final actual = song.title;

      expect(actual, expected);
    });
  });
}
