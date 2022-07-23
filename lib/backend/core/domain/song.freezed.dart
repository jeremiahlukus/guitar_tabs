// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'song.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Song {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get songNumber => throw _privateConstructorUsedError;
  String get lyrics => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String get chords => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SongCopyWith<Song> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongCopyWith<$Res> {
  factory $SongCopyWith(Song value, $Res Function(Song) then) = _$SongCopyWithImpl<$Res>;
  $Res call(
      {int id, String title, int songNumber, String lyrics, String category, String artist, String chords, String url});
}

/// @nodoc
class _$SongCopyWithImpl<$Res> implements $SongCopyWith<$Res> {
  _$SongCopyWithImpl(this._value, this._then);

  final Song _value;
  // ignore: unused_field
  final $Res Function(Song) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? songNumber = freezed,
    Object? lyrics = freezed,
    Object? category = freezed,
    Object? artist = freezed,
    Object? chords = freezed,
    Object? url = freezed,
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
      songNumber: songNumber == freezed
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
    ));
  }
}

/// @nodoc
abstract class _$$_SongCopyWith<$Res> implements $SongCopyWith<$Res> {
  factory _$$_SongCopyWith(_$_Song value, $Res Function(_$_Song) then) = __$$_SongCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id, String title, int songNumber, String lyrics, String category, String artist, String chords, String url});
}

/// @nodoc
class __$$_SongCopyWithImpl<$Res> extends _$SongCopyWithImpl<$Res> implements _$$_SongCopyWith<$Res> {
  __$$_SongCopyWithImpl(_$_Song _value, $Res Function(_$_Song) _then) : super(_value, (v) => _then(v as _$_Song));

  @override
  _$_Song get _value => super._value as _$_Song;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? songNumber = freezed,
    Object? lyrics = freezed,
    Object? category = freezed,
    Object? artist = freezed,
    Object? chords = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_Song(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      songNumber: songNumber == freezed
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
    ));
  }
}

/// @nodoc

class _$_Song extends _Song {
  const _$_Song(
      {required this.id,
      required this.title,
      required this.songNumber,
      required this.lyrics,
      required this.category,
      required this.artist,
      required this.chords,
      required this.url})
      : super._();

  @override
  final int id;
  @override
  final String title;
  @override
  final int songNumber;
  @override
  final String lyrics;
  @override
  final String category;
  @override
  final String artist;
  @override
  final String chords;
  @override
  final String url;

  @override
  String toString() {
    return 'Song(id: $id, title: $title, songNumber: $songNumber, lyrics: $lyrics, category: $category, artist: $artist, chords: $chords, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Song &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.songNumber, songNumber) &&
            const DeepCollectionEquality().equals(other.lyrics, lyrics) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.artist, artist) &&
            const DeepCollectionEquality().equals(other.chords, chords) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(songNumber),
      const DeepCollectionEquality().hash(lyrics),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(artist),
      const DeepCollectionEquality().hash(chords),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$$_SongCopyWith<_$_Song> get copyWith => __$$_SongCopyWithImpl<_$_Song>(this, _$identity);
}

abstract class _Song extends Song {
  const factory _Song(
      {required final int id,
      required final String title,
      required final int songNumber,
      required final String lyrics,
      required final String category,
      required final String artist,
      required final String chords,
      required final String url}) = _$_Song;
  const _Song._() : super._();

  @override
  int get id;
  @override
  String get title;
  @override
  int get songNumber;
  @override
  String get lyrics;
  @override
  String get category;
  @override
  String get artist;
  @override
  String get chords;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_SongCopyWith<_$_Song> get copyWith => throw _privateConstructorUsedError;
}
