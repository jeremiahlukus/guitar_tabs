// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';

Song mockSong(int id) {
  return Song(
    id: id,
    title: 'new $id',
    songNumber: id,
    lyrics:
        '#Eph 4:13, Rev. 19:7\n# Capo 3\n\nUn[D7]til we all arrive[C] \nAt the oneness of the [Em]faith\nAnd of the full kno[D]wledge\nOf the [G]Son of God[C],\nAt the oneness of the f[Em]aith \nAt a full-grown [D]man,\nAt the [C]measure of the [G]stature of the\n[Am]Fullness of [C]Christ,\nU[G]ntil we [D]all [G]arrive.\n \n  [G]Let us rejoice and\n  [C]let us give the glory to [Em]Him\n  For the marriage of the \n  [D]Lamb has come,\n  [G]Let us exult and \n  [C]let us give the glory to [Em]Him\n  For the marriage of the \n  [D]Lamb has [D7]come,\n  And His [C]wife has \n  [G]made herself [C]re[D]ad[Em]y,\n  For the [C]marriage of the \n  [D]Lamb has [G]come.\n\n',
    category: 'category',
    artist: 'artist',
    chords: 'chords',
    url: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
  );
}

Song mockEmptySong(int id) {
  return Song(
    id: id,
    title: 'new $id',
    songNumber: id,
    lyrics:
        '#Eph 4:13, Rev. 19:7\n# Capo 3\n\nUn[D7]til we all arrive[C] \nAt the oneness of the [Em]faith\nAnd of the full kno[D]wledge\nOf the [G]Son of God[C],\nAt the oneness of the f[Em]aith \nAt a full-grown [D]man,\nAt the [C]measure of the [G]stature of the\n[Am]Fullness of [C]Christ,\nU[G]ntil we [D]all [G]arrive.\n \n  [G]Let us rejoice and\n  [C]let us give the glory to [Em]Him\n  For the marriage of the \n  [D]Lamb has come,\n  [G]Let us exult and \n  [C]let us give the glory to [Em]Him\n  For the marriage of the \n  [D]Lamb has [D7]come,\n  And His [C]wife has \n  [G]made herself [C]re[D]ad[Em]y,\n  For the [C]marriage of the \n  [D]Lamb has [G]come.\n\n',
    category: 'category',
    artist: 'artist',
    chords: 'chords',
    url: '',
  );
}

SongDTO mockSongDTO(int id) {
  return SongDTO(
    id: id,
    title: 'new $id',
    url: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
    songNumber: id,
    lyrics:
        '#Eph 4:13, Rev. 19:7\n# Capo 3\n\nUn[D7]til we all arrive[C] \nAt the oneness of the [Em]faith\nAnd of the full kno[D]wledge\nOf the [G]Son of God[C],\nAt the oneness of the f[Em]aith \nAt a full-grown [D]man,\nAt the [C]measure of the [G]stature of the\n[Am]Fullness of [C]Christ,\nU[G]ntil we [D]all [G]arrive.\n \n  [G]Let us rejoice and\n  [C]let us give the glory to [Em]Him\n  For the marriage of the \n  [D]Lamb has come,\n  [G]Let us exult and \n  [C]let us give the glory to [Em]Him\n  For the marriage of the \n  [D]Lamb has [D7]come,\n  And His [C]wife has \n  [G]made herself [C]re[D]ad[Em]y,\n  For the [C]marriage of the \n  [D]Lamb has [G]come.\n\n',
    category: 'category',
    artist: 'artist',
    chords: 'chords',
  );
}

Map<String, dynamic> mockSongJson(int id) {
  return <String, dynamic>{
    'id': id,
    'title': 'new $id',
    'song_number': 1,
    'url': 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
    'artist': 'New',
    'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
    'chords': null,
    'created_at': '2022-06-29T11:42:10.614-04:00',
    'updated_at': '2022-06-29T11:42:10.614-04:00',
    'category': 'general',
    'sub_category': null
  };
}

Map<String, dynamic> mockSongJson2(int id) {
  return <String, dynamic>{
    'id': id,
    'title': 'new $id',
    'song_number': 1,
    'url': 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
    'artist': 'New',
    'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home test',
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
    'url': 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
    'artist': 'New',
    'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
    'chords': '',
    'category': 'general',
  };
}
