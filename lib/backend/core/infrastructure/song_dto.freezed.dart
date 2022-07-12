// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  String get lyrics => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
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
  factory $SongDTOCopyWith(SongDTO value, $Res Function(SongDTO) then) =
      _$SongDTOCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      String lyrics,
      String category,
      @JsonKey(fromJson: _nullFromJson) String artist,
      @JsonKey(fromJson: _nullFromJson) String chords,
      @JsonKey(fromJson: _nullFromJson) String url,
      @JsonKey(name: 'song_number') int songNumber});
}

/// @nodoc
class _$SongDTOCopyWithImpl<$Res> implements $SongDTOCopyWith<$Res> {
  _$SongDTOCopyWithImpl(this._value, this._then);

  final SongDTO _value;
  // ignore: unused_field
  final $Res Function(SongDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? lyrics = freezed,
    Object? category = freezed,
    Object? artist = freezed,
    Object? chords = freezed,
    Object? url = freezed,
    Object? songNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lyrics: lyrics == freezed
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      artist: artist == freezed
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      chords: chords == freezed
          ? _value.chords
          : chords // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      songNumber: songNumber == freezed
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_SongDTOCopyWith<$Res> implements $SongDTOCopyWith<$Res> {
  factory _$$_SongDTOCopyWith(
          _$_SongDTO value, $Res Function(_$_SongDTO) then) =
      __$$_SongDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      String lyrics,
      String category,
      @JsonKey(fromJson: _nullFromJson) String artist,
      @JsonKey(fromJson: _nullFromJson) String chords,
      @JsonKey(fromJson: _nullFromJson) String url,
      @JsonKey(name: 'song_number') int songNumber});
}

/// @nodoc
class __$$_SongDTOCopyWithImpl<$Res> extends _$SongDTOCopyWithImpl<$Res>
    implements _$$_SongDTOCopyWith<$Res> {
  __$$_SongDTOCopyWithImpl(_$_SongDTO _value, $Res Function(_$_SongDTO) _then)
      : super(_value, (v) => _then(v as _$_SongDTO));

  @override
  _$_SongDTO get _value => super._value as _$_SongDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? lyrics = freezed,
    Object? category = freezed,
    Object? artist = freezed,
    Object? chords = freezed,
    Object? url = freezed,
    Object? songNumber = freezed,
  }) {
    return _then(_$_SongDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lyrics: lyrics == freezed
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      artist: artist == freezed
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      chords: chords == freezed
          ? _value.chords
          : chords // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      songNumber: songNumber == freezed
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SongDTO extends _SongDTO {
  const _$_SongDTO(
      {required this.id,
      required this.title,
      required this.lyrics,
      required this.category,
      @JsonKey(fromJson: _nullFromJson) required this.artist,
      @JsonKey(fromJson: _nullFromJson) required this.chords,
      @JsonKey(fromJson: _nullFromJson) required this.url,
      @JsonKey(name: 'song_number') required this.songNumber})
      : super._();

  factory _$_SongDTO.fromJson(Map<String, dynamic> json) =>
      _$$_SongDTOFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String lyrics;
  @override
  final String category;
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
    return 'SongDTO(id: $id, title: $title, lyrics: $lyrics, category: $category, artist: $artist, chords: $chords, url: $url, songNumber: $songNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SongDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.lyrics, lyrics) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.artist, artist) &&
            const DeepCollectionEquality().equals(other.chords, chords) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.songNumber, songNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(lyrics),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(artist),
      const DeepCollectionEquality().hash(chords),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(songNumber));

  @JsonKey(ignore: true)
  @override
  _$$_SongDTOCopyWith<_$_SongDTO> get copyWith =>
      __$$_SongDTOCopyWithImpl<_$_SongDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongDTOToJson(this);
  }
}

abstract class _SongDTO extends SongDTO {
  const factory _SongDTO(
          {required final int id,
          required final String title,
          required final String lyrics,
          required final String category,
          @JsonKey(fromJson: _nullFromJson) required final String artist,
          @JsonKey(fromJson: _nullFromJson) required final String chords,
          @JsonKey(fromJson: _nullFromJson) required final String url,
          @JsonKey(name: 'song_number') required final int songNumber}) =
      _$_SongDTO;
  const _SongDTO._() : super._();

  factory _SongDTO.fromJson(Map<String, dynamic> json) = _$_SongDTO.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get lyrics => throw _privateConstructorUsedError;
  @override
  String get category => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: _nullFromJson)
  String get artist => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: _nullFromJson)
  String get chords => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: _nullFromJson)
  String get url => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'song_number')
  int get songNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SongDTOCopyWith<_$_SongDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
