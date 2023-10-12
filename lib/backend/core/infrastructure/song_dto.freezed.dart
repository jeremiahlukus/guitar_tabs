// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'song_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SongDTO _$SongDTOFromJson(Map<String, dynamic> json) {
  return _SongDTO.fromJson(json);
}

/// @nodoc
mixin _$SongDTO {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get lyrics =>
      throw _privateConstructorUsedError; // @JsonKey(fromJson: _nullFromJson) required String category,
  @JsonKey(fromJson: _nullFromJson)
  String get artist => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullFromJson)
  String get chords => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullFromJson)
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'song_number')
  int get songNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongDTOCopyWith<SongDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongDTOCopyWith<$Res> {
  factory $SongDTOCopyWith(SongDTO value, $Res Function(SongDTO) then) = _$SongDTOCopyWithImpl<$Res, SongDTO>;
  @useResult
  $Res call(
      {int id,
      String title,
      String lyrics,
      @JsonKey(fromJson: _nullFromJson) String artist,
      @JsonKey(fromJson: _nullFromJson) String chords,
      @JsonKey(fromJson: _nullFromJson) String url,
      @JsonKey(name: 'song_number') int songNumber});
}

/// @nodoc
class _$SongDTOCopyWithImpl<$Res, $Val extends SongDTO> implements $SongDTOCopyWith<$Res> {
  _$SongDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? lyrics = null,
    Object? artist = null,
    Object? chords = null,
    Object? url = null,
    Object? songNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lyrics: null == lyrics
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      chords: null == chords
          ? _value.chords
          : chords // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      songNumber: null == songNumber
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SongDTOImplCopyWith<$Res> implements $SongDTOCopyWith<$Res> {
  factory _$$SongDTOImplCopyWith(_$SongDTOImpl value, $Res Function(_$SongDTOImpl) then) =
      __$$SongDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String lyrics,
      @JsonKey(fromJson: _nullFromJson) String artist,
      @JsonKey(fromJson: _nullFromJson) String chords,
      @JsonKey(fromJson: _nullFromJson) String url,
      @JsonKey(name: 'song_number') int songNumber});
}

/// @nodoc
class __$$SongDTOImplCopyWithImpl<$Res> extends _$SongDTOCopyWithImpl<$Res, _$SongDTOImpl>
    implements _$$SongDTOImplCopyWith<$Res> {
  __$$SongDTOImplCopyWithImpl(_$SongDTOImpl _value, $Res Function(_$SongDTOImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? lyrics = null,
    Object? artist = null,
    Object? chords = null,
    Object? url = null,
    Object? songNumber = null,
  }) {
    return _then(_$SongDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lyrics: null == lyrics
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      chords: null == chords
          ? _value.chords
          : chords // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      songNumber: null == songNumber
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SongDTOImpl extends _SongDTO {
  const _$SongDTOImpl(
      {required this.id,
      required this.title,
      required this.lyrics,
      @JsonKey(fromJson: _nullFromJson) required this.artist,
      @JsonKey(fromJson: _nullFromJson) required this.chords,
      @JsonKey(fromJson: _nullFromJson) required this.url,
      @JsonKey(name: 'song_number') required this.songNumber})
      : super._();

  factory _$SongDTOImpl.fromJson(Map<String, dynamic> json) => _$$SongDTOImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String lyrics;
// @JsonKey(fromJson: _nullFromJson) required String category,
  @override
  @JsonKey(fromJson: _nullFromJson)
  final String artist;
  @override
  @JsonKey(fromJson: _nullFromJson)
  final String chords;
  @override
  @JsonKey(fromJson: _nullFromJson)
  final String url;
  @override
  @JsonKey(name: 'song_number')
  final int songNumber;

  @override
  String toString() {
    return 'SongDTO(id: $id, title: $title, lyrics: $lyrics, artist: $artist, chords: $chords, url: $url, songNumber: $songNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lyrics, lyrics) || other.lyrics == lyrics) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.chords, chords) || other.chords == chords) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.songNumber, songNumber) || other.songNumber == songNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, lyrics, artist, chords, url, songNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongDTOImplCopyWith<_$SongDTOImpl> get copyWith => __$$SongDTOImplCopyWithImpl<_$SongDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SongDTOImplToJson(
      this,
    );
  }
}

abstract class _SongDTO extends SongDTO {
  const factory _SongDTO(
      {required final int id,
      required final String title,
      required final String lyrics,
      @JsonKey(fromJson: _nullFromJson) required final String artist,
      @JsonKey(fromJson: _nullFromJson) required final String chords,
      @JsonKey(fromJson: _nullFromJson) required final String url,
      @JsonKey(name: 'song_number') required final int songNumber}) = _$SongDTOImpl;
  const _SongDTO._() : super._();

  factory _SongDTO.fromJson(Map<String, dynamic> json) = _$SongDTOImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get lyrics;
  @override // @JsonKey(fromJson: _nullFromJson) required String category,
  @JsonKey(fromJson: _nullFromJson)
  String get artist;
  @override
  @JsonKey(fromJson: _nullFromJson)
  String get chords;
  @override
  @JsonKey(fromJson: _nullFromJson)
  String get url;
  @override
  @JsonKey(name: 'song_number')
  int get songNumber;
  @override
  @JsonKey(ignore: true)
  _$$SongDTOImplCopyWith<_$SongDTOImpl> get copyWith => throw _privateConstructorUsedError;
}
