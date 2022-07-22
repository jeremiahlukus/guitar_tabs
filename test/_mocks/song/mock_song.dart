// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';

Song mockSong(int id) {
  return Song(
    id: id,
    title: 'title',
    songNumber: id,
    lyrics: 'lyrics',
    category: 'category',
    artist: 'artist',
    chords: 'chords',
    url: 'url',
  );
}

SongDTO mockSongDTO(int id) {
  return SongDTO(
    id: id,
    title: 'title',
    songNumber: id,
    lyrics: 'lyrics',
    category: 'category',
    artist: 'artist',
    chords: 'chords',
    url: 'url',
  );
}

Map<String, dynamic> mockSongJson(int id) {
  return <String, dynamic>{
    'id': id,
    'title': 'new $id',
    'song_number': 1,
    'url': 'url',
    'artist': 'New',
    'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
    'chords': null,
    'created_at': '2022-06-29T11:42:10.614-04:00',
    'updated_at': '2022-06-29T11:42:10.614-04:00',
    'category': 'general',
    'sub_category': null
  };
}

Map<String, dynamic> mockSongStrippedJson(int id) {
  return <String, dynamic>{
    'id': id,
    'title': 'new $id',
    'song_number': 1,
    'url': 'url',
    'artist': 'New',
    'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
    'chords': '',
    'category': 'general',
  };
}