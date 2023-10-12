// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SongDTOImpl _$$SongDTOImplFromJson(Map<String, dynamic> json) => _$SongDTOImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      lyrics: json['lyrics'] as String,
      artist: _nullFromJson(json['artist']),
      chords: _nullFromJson(json['chords']),
      url: _nullFromJson(json['url']),
      songNumber: json['song_number'] as int,
    );

Map<String, dynamic> _$$SongDTOImplToJson(_$SongDTOImpl instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lyrics': instance.lyrics,
      'artist': instance.artist,
      'chords': instance.chords,
      'url': instance.url,
      'song_number': instance.songNumber,
    };
