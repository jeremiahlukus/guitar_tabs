// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SongDetailDTO _$$_SongDetailDTOFromJson(Map<String, dynamic> json) =>
    _$_SongDetailDTO(
      songId: json['song_id'] as String,
      isFavorite: json['is_favorite'] as bool,
    );

Map<String, dynamic> _$$_SongDetailDTOToJson(_$_SongDetailDTO instance) =>
    <String, dynamic>{
      'song_id': instance.songId,
      'is_favorite': instance.isFavorite,
    };
