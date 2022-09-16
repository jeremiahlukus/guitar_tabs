// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'song_detail_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SongDetailState {
  bool get hasFavoriteStatusChanged => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasFavoriteStatusChanged) initial,
    required TResult Function(bool hasFavoriteStatusChanged) loadInProgress,
    required TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)
        loadSuccess,
    required TResult Function(
            BackendFailure failure, bool hasFavoriteStatusChanged)
        loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SongDetailStateCopyWith<SongDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongDetailStateCopyWith<$Res> {
  factory $SongDetailStateCopyWith(
          SongDetailState value, $Res Function(SongDetailState) then) =
      _$SongDetailStateCopyWithImpl<$Res>;
  $Res call({bool hasFavoriteStatusChanged});
}

/// @nodoc
class _$SongDetailStateCopyWithImpl<$Res>
    implements $SongDetailStateCopyWith<$Res> {
  _$SongDetailStateCopyWithImpl(this._value, this._then);

  final SongDetailState _value;
  // ignore: unused_field
  final $Res Function(SongDetailState) _then;

  @override
  $Res call({
    Object? hasFavoriteStatusChanged = freezed,
  }) {
    return _then(_value.copyWith(
      hasFavoriteStatusChanged: hasFavoriteStatusChanged == freezed
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $SongDetailStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  $Res call({bool hasFavoriteStatusChanged});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res> extends _$SongDetailStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;

  @override
  $Res call({
    Object? hasFavoriteStatusChanged = freezed,
  }) {
    return _then(_$_Initial(
      hasFavoriteStatusChanged: hasFavoriteStatusChanged == freezed
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Initial extends _Initial {
  const _$_Initial({this.hasFavoriteStatusChanged = false}) : super._();

  @override
  @JsonKey()
  final bool hasFavoriteStatusChanged;

  @override
  String toString() {
    return 'SongDetailState.initial(hasFavoriteStatusChanged: $hasFavoriteStatusChanged)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            const DeepCollectionEquality().equals(
                other.hasFavoriteStatusChanged, hasFavoriteStatusChanged));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(hasFavoriteStatusChanged));

  @JsonKey(ignore: true)
  @override
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasFavoriteStatusChanged) initial,
    required TResult Function(bool hasFavoriteStatusChanged) loadInProgress,
    required TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)
        loadSuccess,
    required TResult Function(
            BackendFailure failure, bool hasFavoriteStatusChanged)
        loadFailure,
  }) {
    return initial(hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
  }) {
    return initial?.call(hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(hasFavoriteStatusChanged);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends SongDetailState {
  const factory _Initial({final bool hasFavoriteStatusChanged}) = _$_Initial;
  const _Initial._() : super._();

  @override
  bool get hasFavoriteStatusChanged;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadInProgressCopyWith<$Res>
    implements $SongDetailStateCopyWith<$Res> {
  factory _$$_LoadInProgressCopyWith(
          _$_LoadInProgress value, $Res Function(_$_LoadInProgress) then) =
      __$$_LoadInProgressCopyWithImpl<$Res>;
  @override
  $Res call({bool hasFavoriteStatusChanged});
}

/// @nodoc
class __$$_LoadInProgressCopyWithImpl<$Res>
    extends _$SongDetailStateCopyWithImpl<$Res>
    implements _$$_LoadInProgressCopyWith<$Res> {
  __$$_LoadInProgressCopyWithImpl(
      _$_LoadInProgress _value, $Res Function(_$_LoadInProgress) _then)
      : super(_value, (v) => _then(v as _$_LoadInProgress));

  @override
  _$_LoadInProgress get _value => super._value as _$_LoadInProgress;

  @override
  $Res call({
    Object? hasFavoriteStatusChanged = freezed,
  }) {
    return _then(_$_LoadInProgress(
      hasFavoriteStatusChanged: hasFavoriteStatusChanged == freezed
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LoadInProgress extends _LoadInProgress {
  const _$_LoadInProgress({this.hasFavoriteStatusChanged = false}) : super._();

  @override
  @JsonKey()
  final bool hasFavoriteStatusChanged;

  @override
  String toString() {
    return 'SongDetailState.loadInProgress(hasFavoriteStatusChanged: $hasFavoriteStatusChanged)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoadInProgress &&
            const DeepCollectionEquality().equals(
                other.hasFavoriteStatusChanged, hasFavoriteStatusChanged));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(hasFavoriteStatusChanged));

  @JsonKey(ignore: true)
  @override
  _$$_LoadInProgressCopyWith<_$_LoadInProgress> get copyWith =>
      __$$_LoadInProgressCopyWithImpl<_$_LoadInProgress>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasFavoriteStatusChanged) initial,
    required TResult Function(bool hasFavoriteStatusChanged) loadInProgress,
    required TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)
        loadSuccess,
    required TResult Function(
            BackendFailure failure, bool hasFavoriteStatusChanged)
        loadFailure,
  }) {
    return loadInProgress(hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
  }) {
    return loadInProgress?.call(hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(hasFavoriteStatusChanged);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class _LoadInProgress extends SongDetailState {
  const factory _LoadInProgress({final bool hasFavoriteStatusChanged}) =
      _$_LoadInProgress;
  const _LoadInProgress._() : super._();

  @override
  bool get hasFavoriteStatusChanged;
  @override
  @JsonKey(ignore: true)
  _$$_LoadInProgressCopyWith<_$_LoadInProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadSuccessCopyWith<$Res>
    implements $SongDetailStateCopyWith<$Res> {
  factory _$$_LoadSuccessCopyWith(
          _$_LoadSuccess value, $Res Function(_$_LoadSuccess) then) =
      __$$_LoadSuccessCopyWithImpl<$Res>;
  @override
  $Res call({Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged});

  $FreshCopyWith<SongDetail?, $Res> get songDetail;
}

/// @nodoc
class __$$_LoadSuccessCopyWithImpl<$Res>
    extends _$SongDetailStateCopyWithImpl<$Res>
    implements _$$_LoadSuccessCopyWith<$Res> {
  __$$_LoadSuccessCopyWithImpl(
      _$_LoadSuccess _value, $Res Function(_$_LoadSuccess) _then)
      : super(_value, (v) => _then(v as _$_LoadSuccess));

  @override
  _$_LoadSuccess get _value => super._value as _$_LoadSuccess;

  @override
  $Res call({
    Object? songDetail = freezed,
    Object? hasFavoriteStatusChanged = freezed,
  }) {
    return _then(_$_LoadSuccess(
      songDetail == freezed
          ? _value.songDetail
          : songDetail // ignore: cast_nullable_to_non_nullable
              as Fresh<SongDetail?>,
      hasFavoriteStatusChanged: hasFavoriteStatusChanged == freezed
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $FreshCopyWith<SongDetail?, $Res> get songDetail {
    return $FreshCopyWith<SongDetail?, $Res>(_value.songDetail, (value) {
      return _then(_value.copyWith(songDetail: value));
    });
  }
}

/// @nodoc

class _$_LoadSuccess extends _LoadSuccess {
  const _$_LoadSuccess(this.songDetail, {this.hasFavoriteStatusChanged = false})
      : super._();

  @override
  final Fresh<SongDetail?> songDetail;
  @override
  @JsonKey()
  final bool hasFavoriteStatusChanged;

  @override
  String toString() {
    return 'SongDetailState.loadSuccess(songDetail: $songDetail, hasFavoriteStatusChanged: $hasFavoriteStatusChanged)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoadSuccess &&
            const DeepCollectionEquality()
                .equals(other.songDetail, songDetail) &&
            const DeepCollectionEquality().equals(
                other.hasFavoriteStatusChanged, hasFavoriteStatusChanged));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(songDetail),
      const DeepCollectionEquality().hash(hasFavoriteStatusChanged));

  @JsonKey(ignore: true)
  @override
  _$$_LoadSuccessCopyWith<_$_LoadSuccess> get copyWith =>
      __$$_LoadSuccessCopyWithImpl<_$_LoadSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasFavoriteStatusChanged) initial,
    required TResult Function(bool hasFavoriteStatusChanged) loadInProgress,
    required TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)
        loadSuccess,
    required TResult Function(
            BackendFailure failure, bool hasFavoriteStatusChanged)
        loadFailure,
  }) {
    return loadSuccess(songDetail, hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
  }) {
    return loadSuccess?.call(songDetail, hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(songDetail, hasFavoriteStatusChanged);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return loadSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(this);
    }
    return orElse();
  }
}

abstract class _LoadSuccess extends SongDetailState {
  const factory _LoadSuccess(final Fresh<SongDetail?> songDetail,
      {final bool hasFavoriteStatusChanged}) = _$_LoadSuccess;
  const _LoadSuccess._() : super._();

  Fresh<SongDetail?> get songDetail;
  @override
  bool get hasFavoriteStatusChanged;
  @override
  @JsonKey(ignore: true)
  _$$_LoadSuccessCopyWith<_$_LoadSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadFailureCopyWith<$Res>
    implements $SongDetailStateCopyWith<$Res> {
  factory _$$_LoadFailureCopyWith(
          _$_LoadFailure value, $Res Function(_$_LoadFailure) then) =
      __$$_LoadFailureCopyWithImpl<$Res>;
  @override
  $Res call({BackendFailure failure, bool hasFavoriteStatusChanged});

  $BackendFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$_LoadFailureCopyWithImpl<$Res>
    extends _$SongDetailStateCopyWithImpl<$Res>
    implements _$$_LoadFailureCopyWith<$Res> {
  __$$_LoadFailureCopyWithImpl(
      _$_LoadFailure _value, $Res Function(_$_LoadFailure) _then)
      : super(_value, (v) => _then(v as _$_LoadFailure));

  @override
  _$_LoadFailure get _value => super._value as _$_LoadFailure;

  @override
  $Res call({
    Object? failure = freezed,
    Object? hasFavoriteStatusChanged = freezed,
  }) {
    return _then(_$_LoadFailure(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as BackendFailure,
      hasFavoriteStatusChanged: hasFavoriteStatusChanged == freezed
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $BackendFailureCopyWith<$Res> get failure {
    return $BackendFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_LoadFailure extends _LoadFailure {
  const _$_LoadFailure(this.failure, {this.hasFavoriteStatusChanged = false})
      : super._();

  @override
  final BackendFailure failure;
  @override
  @JsonKey()
  final bool hasFavoriteStatusChanged;

  @override
  String toString() {
    return 'SongDetailState.loadFailure(failure: $failure, hasFavoriteStatusChanged: $hasFavoriteStatusChanged)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoadFailure &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            const DeepCollectionEquality().equals(
                other.hasFavoriteStatusChanged, hasFavoriteStatusChanged));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(failure),
      const DeepCollectionEquality().hash(hasFavoriteStatusChanged));

  @JsonKey(ignore: true)
  @override
  _$$_LoadFailureCopyWith<_$_LoadFailure> get copyWith =>
      __$$_LoadFailureCopyWithImpl<_$_LoadFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasFavoriteStatusChanged) initial,
    required TResult Function(bool hasFavoriteStatusChanged) loadInProgress,
    required TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)
        loadSuccess,
    required TResult Function(
            BackendFailure failure, bool hasFavoriteStatusChanged)
        loadFailure,
  }) {
    return loadFailure(failure, hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
  }) {
    return loadFailure?.call(failure, hasFavoriteStatusChanged);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasFavoriteStatusChanged)? initial,
    TResult Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(failure, hasFavoriteStatusChanged);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return loadFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(this);
    }
    return orElse();
  }
}

abstract class _LoadFailure extends SongDetailState {
  const factory _LoadFailure(final BackendFailure failure,
      {final bool hasFavoriteStatusChanged}) = _$_LoadFailure;
  const _LoadFailure._() : super._();

  BackendFailure get failure;
  @override
  bool get hasFavoriteStatusChanged;
  @override
  @JsonKey(ignore: true)
  _$$_LoadFailureCopyWith<_$_LoadFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
