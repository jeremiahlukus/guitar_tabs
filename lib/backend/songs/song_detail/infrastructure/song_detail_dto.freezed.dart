// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'song_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SongDetailDTO _$SongDetailDTOFromJson(Map<String, dynamic> json) {
  return _SongDetailDTO.fromJson(json);
}

/// @nodoc
mixin _$SongDetailDTO {
// ignore: invalid_annotation_target
  @JsonKey(name: 'song_id')
  String get songId => throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'is_favorite')
  bool get isFavorite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongDetailDTOCopyWith<SongDetailDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongDetailDTOCopyWith<$Res> {
  factory $SongDetailDTOCopyWith(SongDetailDTO value, $Res Function(SongDetailDTO) then) =
      _$SongDetailDTOCopyWithImpl<$Res, SongDetailDTO>;
  @useResult
  $Res call({@JsonKey(name: 'song_id') String songId, @JsonKey(name: 'is_favorite') bool isFavorite});
}

/// @nodoc
class _$SongDetailDTOCopyWithImpl<$Res, $Val extends SongDetailDTO> implements $SongDetailDTOCopyWith<$Res> {
  _$SongDetailDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songId = null,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      songId: null == songId
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SongDetailDTOCopyWith<$Res> implements $SongDetailDTOCopyWith<$Res> {
  factory _$$_SongDetailDTOCopyWith(_$_SongDetailDTO value, $Res Function(_$_SongDetailDTO) then) =
      __$$_SongDetailDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'song_id') String songId, @JsonKey(name: 'is_favorite') bool isFavorite});
}

/// @nodoc
class __$$_SongDetailDTOCopyWithImpl<$Res> extends _$SongDetailDTOCopyWithImpl<$Res, _$_SongDetailDTO>
    implements _$$_SongDetailDTOCopyWith<$Res> {
  __$$_SongDetailDTOCopyWithImpl(_$_SongDetailDTO _value, $Res Function(_$_SongDetailDTO) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songId = null,
    Object? isFavorite = null,
  }) {
    return _then(_$_SongDetailDTO(
      songId: null == songId
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SongDetailDTO extends _SongDetailDTO {
  const _$_SongDetailDTO(
      {@JsonKey(name: 'song_id') required this.songId, @JsonKey(name: 'is_favorite') required this.isFavorite})
      : super._();

  factory _$_SongDetailDTO.fromJson(Map<String, dynamic> json) => _$$_SongDetailDTOFromJson(json);

// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'song_id')
  final String songId;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;

  @override
  String toString() {
    return 'SongDetailDTO(songId: $songId, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SongDetailDTO &&
            (identical(other.songId, songId) || other.songId == songId) &&
            (identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, songId, isFavorite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SongDetailDTOCopyWith<_$_SongDetailDTO> get copyWith =>
      __$$_SongDetailDTOCopyWithImpl<_$_SongDetailDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongDetailDTOToJson(
      this,
    );
  }
}

abstract class _SongDetailDTO extends SongDetailDTO {
  const factory _SongDetailDTO(
      {@JsonKey(name: 'song_id') required final String songId,
      @JsonKey(name: 'is_favorite') required final bool isFavorite}) = _$_SongDetailDTO;
  const _SongDetailDTO._() : super._();

  factory _SongDetailDTO.fromJson(Map<String, dynamic> json) = _$_SongDetailDTO.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'song_id')
  String get songId;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'is_favorite')
  bool get isFavorite;
  @override
  @JsonKey(ignore: true)
  _$$_SongDetailDTOCopyWith<_$_SongDetailDTO> get copyWith => throw _privateConstructorUsedError;
}
