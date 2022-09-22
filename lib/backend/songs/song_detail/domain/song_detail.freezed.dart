// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'song_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SongDetail {
  bool get isFavorite => throw _privateConstructorUsedError;
  String get songId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SongDetailCopyWith<SongDetail> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongDetailCopyWith<$Res> {
  factory $SongDetailCopyWith(SongDetail value, $Res Function(SongDetail) then) = _$SongDetailCopyWithImpl<$Res>;
  $Res call({bool isFavorite, String songId});
}

/// @nodoc
class _$SongDetailCopyWithImpl<$Res> implements $SongDetailCopyWith<$Res> {
  _$SongDetailCopyWithImpl(this._value, this._then);

  final SongDetail _value;
  // ignore: unused_field
  final $Res Function(SongDetail) _then;

  @override
  $Res call({
    Object? isFavorite = freezed,
    Object? songId = freezed,
  }) {
    return _then(_value.copyWith(
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      songId: songId == freezed
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SongDetailCopyWith<$Res> implements $SongDetailCopyWith<$Res> {
  factory _$$_SongDetailCopyWith(_$_SongDetail value, $Res Function(_$_SongDetail) then) =
      __$$_SongDetailCopyWithImpl<$Res>;
  @override
  $Res call({bool isFavorite, String songId});
}

/// @nodoc
class __$$_SongDetailCopyWithImpl<$Res> extends _$SongDetailCopyWithImpl<$Res> implements _$$_SongDetailCopyWith<$Res> {
  __$$_SongDetailCopyWithImpl(_$_SongDetail _value, $Res Function(_$_SongDetail) _then)
      : super(_value, (v) => _then(v as _$_SongDetail));

  @override
  _$_SongDetail get _value => super._value as _$_SongDetail;

  @override
  $Res call({
    Object? isFavorite = freezed,
    Object? songId = freezed,
  }) {
    return _then(_$_SongDetail(
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      songId: songId == freezed
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SongDetail extends _SongDetail {
  const _$_SongDetail({required this.isFavorite, required this.songId}) : super._();

  @override
  final bool isFavorite;
  @override
  final String songId;

  @override
  String toString() {
    return 'SongDetail(isFavorite: $isFavorite, songId: $songId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SongDetail &&
            const DeepCollectionEquality().equals(other.isFavorite, isFavorite) &&
            const DeepCollectionEquality().equals(other.songId, songId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(isFavorite), const DeepCollectionEquality().hash(songId));

  @JsonKey(ignore: true)
  @override
  _$$_SongDetailCopyWith<_$_SongDetail> get copyWith => __$$_SongDetailCopyWithImpl<_$_SongDetail>(this, _$identity);
}

abstract class _SongDetail extends SongDetail {
  const factory _SongDetail({required final bool isFavorite, required final String songId}) = _$_SongDetail;
  const _SongDetail._() : super._();

  @override
  bool get isFavorite;
  @override
  String get songId;
  @override
  @JsonKey(ignore: true)
  _$$_SongDetailCopyWith<_$_SongDetail> get copyWith => throw _privateConstructorUsedError;
}
