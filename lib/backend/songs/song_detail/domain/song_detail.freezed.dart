// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  $SongDetailCopyWith<SongDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongDetailCopyWith<$Res> {
  factory $SongDetailCopyWith(
          SongDetail value, $Res Function(SongDetail) then) =
      _$SongDetailCopyWithImpl<$Res, SongDetail>;
  @useResult
  $Res call({bool isFavorite, String songId});
}

/// @nodoc
class _$SongDetailCopyWithImpl<$Res, $Val extends SongDetail>
    implements $SongDetailCopyWith<$Res> {
  _$SongDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFavorite = null,
    Object? songId = null,
  }) {
    return _then(_value.copyWith(
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      songId: null == songId
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SongDetailImplCopyWith<$Res>
    implements $SongDetailCopyWith<$Res> {
  factory _$$SongDetailImplCopyWith(
          _$SongDetailImpl value, $Res Function(_$SongDetailImpl) then) =
      __$$SongDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFavorite, String songId});
}

/// @nodoc
class __$$SongDetailImplCopyWithImpl<$Res>
    extends _$SongDetailCopyWithImpl<$Res, _$SongDetailImpl>
    implements _$$SongDetailImplCopyWith<$Res> {
  __$$SongDetailImplCopyWithImpl(
      _$SongDetailImpl _value, $Res Function(_$SongDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFavorite = null,
    Object? songId = null,
  }) {
    return _then(_$SongDetailImpl(
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      songId: null == songId
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SongDetailImpl extends _SongDetail {
  const _$SongDetailImpl({required this.isFavorite, required this.songId})
      : super._();

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
            other is _$SongDetailImpl &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.songId, songId) || other.songId == songId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFavorite, songId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongDetailImplCopyWith<_$SongDetailImpl> get copyWith =>
      __$$SongDetailImplCopyWithImpl<_$SongDetailImpl>(this, _$identity);
}

abstract class _SongDetail extends SongDetail {
  const factory _SongDetail(
      {required final bool isFavorite,
      required final String songId}) = _$SongDetailImpl;
  const _SongDetail._() : super._();

  @override
  bool get isFavorite;
  @override
  String get songId;
  @override
  @JsonKey(ignore: true)
  _$$SongDetailImplCopyWith<_$SongDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
