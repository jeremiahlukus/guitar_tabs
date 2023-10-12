// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  String get lyrics => throw _privateConstructorUsedError; //required String category,
  String get artist => throw _privateConstructorUsedError;
  String get chords => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SongCopyWith<Song> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongCopyWith<$Res> {
  factory $SongCopyWith(Song value, $Res Function(Song) then) = _$SongCopyWithImpl<$Res, Song>;
  @useResult
  $Res call({int id, String title, int songNumber, String lyrics, String artist, String chords, String url});
}

/// @nodoc
class _$SongCopyWithImpl<$Res, $Val extends Song> implements $SongCopyWith<$Res> {
  _$SongCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? songNumber = null,
    Object? lyrics = null,
    Object? artist = null,
    Object? chords = null,
    Object? url = null,
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
      songNumber: null == songNumber
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SongImplCopyWith<$Res> implements $SongCopyWith<$Res> {
  factory _$$SongImplCopyWith(_$SongImpl value, $Res Function(_$SongImpl) then) = __$$SongImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, int songNumber, String lyrics, String artist, String chords, String url});
}

/// @nodoc
class __$$SongImplCopyWithImpl<$Res> extends _$SongCopyWithImpl<$Res, _$SongImpl> implements _$$SongImplCopyWith<$Res> {
  __$$SongImplCopyWithImpl(_$SongImpl _value, $Res Function(_$SongImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? songNumber = null,
    Object? lyrics = null,
    Object? artist = null,
    Object? chords = null,
    Object? url = null,
  }) {
    return _then(_$SongImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      songNumber: null == songNumber
          ? _value.songNumber
          : songNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
    ));
  }
}

/// @nodoc

class _$SongImpl extends _Song {
  const _$SongImpl(
      {required this.id,
      required this.title,
      required this.songNumber,
      required this.lyrics,
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
//required String category,
  @override
  final String artist;
  @override
  final String chords;
  @override
  final String url;

  @override
  String toString() {
    return 'Song(id: $id, title: $title, songNumber: $songNumber, lyrics: $lyrics, artist: $artist, chords: $chords, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.songNumber, songNumber) || other.songNumber == songNumber) &&
            (identical(other.lyrics, lyrics) || other.lyrics == lyrics) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.chords, chords) || other.chords == chords) &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, songNumber, lyrics, artist, chords, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongImplCopyWith<_$SongImpl> get copyWith => __$$SongImplCopyWithImpl<_$SongImpl>(this, _$identity);
}

abstract class _Song extends Song {
  const factory _Song(
      {required final int id,
      required final String title,
      required final int songNumber,
      required final String lyrics,
      required final String artist,
      required final String chords,
      required final String url}) = _$SongImpl;
  const _Song._() : super._();

  @override
  int get id;
  @override
  String get title;
  @override
  int get songNumber;
  @override
  String get lyrics;
  @override //required String category,
  String get artist;
  @override
  String get chords;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$SongImplCopyWith<_$SongImpl> get copyWith => throw _privateConstructorUsedError;
}
