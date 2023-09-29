// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
    TResult? Function(bool hasFavoriteStatusChanged)? initial,
    TResult? Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult? Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult? Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
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
      _$SongDetailStateCopyWithImpl<$Res, SongDetailState>;
  @useResult
  $Res call({bool hasFavoriteStatusChanged});
}

/// @nodoc
class _$SongDetailStateCopyWithImpl<$Res, $Val extends SongDetailState>
    implements $SongDetailStateCopyWith<$Res> {
  _$SongDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasFavoriteStatusChanged = null,
  }) {
    return _then(_value.copyWith(
      hasFavoriteStatusChanged: null == hasFavoriteStatusChanged
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $SongDetailStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasFavoriteStatusChanged});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$SongDetailStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasFavoriteStatusChanged = null,
  }) {
    return _then(_$_Initial(
      hasFavoriteStatusChanged: null == hasFavoriteStatusChanged
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
            (identical(
                    other.hasFavoriteStatusChanged, hasFavoriteStatusChanged) ||
                other.hasFavoriteStatusChanged == hasFavoriteStatusChanged));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasFavoriteStatusChanged);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(bool hasFavoriteStatusChanged)? initial,
    TResult? Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult? Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult? Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
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
  @useResult
  $Res call({bool hasFavoriteStatusChanged});
}

/// @nodoc
class __$$_LoadInProgressCopyWithImpl<$Res>
    extends _$SongDetailStateCopyWithImpl<$Res, _$_LoadInProgress>
    implements _$$_LoadInProgressCopyWith<$Res> {
  __$$_LoadInProgressCopyWithImpl(
      _$_LoadInProgress _value, $Res Function(_$_LoadInProgress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasFavoriteStatusChanged = null,
  }) {
    return _then(_$_LoadInProgress(
      hasFavoriteStatusChanged: null == hasFavoriteStatusChanged
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
            (identical(
                    other.hasFavoriteStatusChanged, hasFavoriteStatusChanged) ||
                other.hasFavoriteStatusChanged == hasFavoriteStatusChanged));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasFavoriteStatusChanged);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(bool hasFavoriteStatusChanged)? initial,
    TResult? Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult? Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult? Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
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
  @useResult
  $Res call({Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged});

  $FreshCopyWith<SongDetail?, $Res> get songDetail;
}

/// @nodoc
class __$$_LoadSuccessCopyWithImpl<$Res>
    extends _$SongDetailStateCopyWithImpl<$Res, _$_LoadSuccess>
    implements _$$_LoadSuccessCopyWith<$Res> {
  __$$_LoadSuccessCopyWithImpl(
      _$_LoadSuccess _value, $Res Function(_$_LoadSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songDetail = null,
    Object? hasFavoriteStatusChanged = null,
  }) {
    return _then(_$_LoadSuccess(
      null == songDetail
          ? _value.songDetail
          : songDetail // ignore: cast_nullable_to_non_nullable
              as Fresh<SongDetail?>,
      hasFavoriteStatusChanged: null == hasFavoriteStatusChanged
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.songDetail, songDetail) ||
                other.songDetail == songDetail) &&
            (identical(
                    other.hasFavoriteStatusChanged, hasFavoriteStatusChanged) ||
                other.hasFavoriteStatusChanged == hasFavoriteStatusChanged));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, songDetail, hasFavoriteStatusChanged);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(bool hasFavoriteStatusChanged)? initial,
    TResult? Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult? Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult? Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
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
  @useResult
  $Res call({BackendFailure failure, bool hasFavoriteStatusChanged});

  $BackendFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$_LoadFailureCopyWithImpl<$Res>
    extends _$SongDetailStateCopyWithImpl<$Res, _$_LoadFailure>
    implements _$$_LoadFailureCopyWith<$Res> {
  __$$_LoadFailureCopyWithImpl(
      _$_LoadFailure _value, $Res Function(_$_LoadFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
    Object? hasFavoriteStatusChanged = null,
  }) {
    return _then(_$_LoadFailure(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as BackendFailure,
      hasFavoriteStatusChanged: null == hasFavoriteStatusChanged
          ? _value.hasFavoriteStatusChanged
          : hasFavoriteStatusChanged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(
                    other.hasFavoriteStatusChanged, hasFavoriteStatusChanged) ||
                other.hasFavoriteStatusChanged == hasFavoriteStatusChanged));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, failure, hasFavoriteStatusChanged);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(bool hasFavoriteStatusChanged)? initial,
    TResult? Function(bool hasFavoriteStatusChanged)? loadInProgress,
    TResult? Function(
            Fresh<SongDetail?> songDetail, bool hasFavoriteStatusChanged)?
        loadSuccess,
    TResult? Function(BackendFailure failure, bool hasFavoriteStatusChanged)?
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
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
