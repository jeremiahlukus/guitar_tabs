// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_songs_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PaginatedSongsState {
  Fresh<List<Song>> get songs => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Fresh<List<Song>> songs) initial,
    required TResult Function(Fresh<List<Song>> songs, int itemsPerPage)
        loadInProgress,
    required TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)
        loadSuccess,
    required TResult Function(Fresh<List<Song>> songs, BackendFailure failure)
        loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Fresh<List<Song>> songs)? initial,
    TResult? Function(Fresh<List<Song>> songs, int itemsPerPage)?
        loadInProgress,
    TResult? Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult? Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
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
  $PaginatedSongsStateCopyWith<PaginatedSongsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedSongsStateCopyWith<$Res> {
  factory $PaginatedSongsStateCopyWith(
          PaginatedSongsState value, $Res Function(PaginatedSongsState) then) =
      _$PaginatedSongsStateCopyWithImpl<$Res, PaginatedSongsState>;
  @useResult
  $Res call({Fresh<List<Song>> songs});

  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class _$PaginatedSongsStateCopyWithImpl<$Res, $Val extends PaginatedSongsState>
    implements $PaginatedSongsStateCopyWith<$Res> {
  _$PaginatedSongsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
  }) {
    return _then(_value.copyWith(
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FreshCopyWith<List<Song>, $Res> get songs {
    return $FreshCopyWith<List<Song>, $Res>(_value.songs, (value) {
      return _then(_value.copyWith(songs: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Fresh<List<Song>> songs});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
  }) {
    return _then(_$InitialImpl(
      null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
    ));
  }
}

/// @nodoc

class _$InitialImpl extends _Initial {
  const _$InitialImpl(this.songs) : super._();

  @override
  final Fresh<List<Song>> songs;

  @override
  String toString() {
    return 'PaginatedSongsState.initial(songs: $songs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.songs, songs) || other.songs == songs));
  }

  @override
  int get hashCode => Object.hash(runtimeType, songs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Fresh<List<Song>> songs) initial,
    required TResult Function(Fresh<List<Song>> songs, int itemsPerPage)
        loadInProgress,
    required TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)
        loadSuccess,
    required TResult Function(Fresh<List<Song>> songs, BackendFailure failure)
        loadFailure,
  }) {
    return initial(songs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Fresh<List<Song>> songs)? initial,
    TResult? Function(Fresh<List<Song>> songs, int itemsPerPage)?
        loadInProgress,
    TResult? Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult? Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
  }) {
    return initial?.call(songs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(songs);
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

abstract class _Initial extends PaginatedSongsState {
  const factory _Initial(final Fresh<List<Song>> songs) = _$InitialImpl;
  const _Initial._() : super._();

  @override
  Fresh<List<Song>> get songs;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadInProgressImplCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$LoadInProgressImplCopyWith(_$LoadInProgressImpl value,
          $Res Function(_$LoadInProgressImpl) then) =
      __$$LoadInProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Fresh<List<Song>> songs, int itemsPerPage});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class __$$LoadInProgressImplCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res, _$LoadInProgressImpl>
    implements _$$LoadInProgressImplCopyWith<$Res> {
  __$$LoadInProgressImplCopyWithImpl(
      _$LoadInProgressImpl _value, $Res Function(_$LoadInProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? itemsPerPage = null,
  }) {
    return _then(_$LoadInProgressImpl(
      null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
      null == itemsPerPage
          ? _value.itemsPerPage
          : itemsPerPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadInProgressImpl extends _LoadInProgress {
  const _$LoadInProgressImpl(this.songs, this.itemsPerPage) : super._();

  @override
  final Fresh<List<Song>> songs;
  @override
  final int itemsPerPage;

  @override
  String toString() {
    return 'PaginatedSongsState.loadInProgress(songs: $songs, itemsPerPage: $itemsPerPage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadInProgressImpl &&
            (identical(other.songs, songs) || other.songs == songs) &&
            (identical(other.itemsPerPage, itemsPerPage) ||
                other.itemsPerPage == itemsPerPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, songs, itemsPerPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadInProgressImplCopyWith<_$LoadInProgressImpl> get copyWith =>
      __$$LoadInProgressImplCopyWithImpl<_$LoadInProgressImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Fresh<List<Song>> songs) initial,
    required TResult Function(Fresh<List<Song>> songs, int itemsPerPage)
        loadInProgress,
    required TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)
        loadSuccess,
    required TResult Function(Fresh<List<Song>> songs, BackendFailure failure)
        loadFailure,
  }) {
    return loadInProgress(songs, itemsPerPage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Fresh<List<Song>> songs)? initial,
    TResult? Function(Fresh<List<Song>> songs, int itemsPerPage)?
        loadInProgress,
    TResult? Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult? Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
  }) {
    return loadInProgress?.call(songs, itemsPerPage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(songs, itemsPerPage);
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

abstract class _LoadInProgress extends PaginatedSongsState {
  const factory _LoadInProgress(
          final Fresh<List<Song>> songs, final int itemsPerPage) =
      _$LoadInProgressImpl;
  const _LoadInProgress._() : super._();

  @override
  Fresh<List<Song>> get songs;
  int get itemsPerPage;
  @override
  @JsonKey(ignore: true)
  _$$LoadInProgressImplCopyWith<_$LoadInProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadSuccessImplCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$LoadSuccessImplCopyWith(
          _$LoadSuccessImpl value, $Res Function(_$LoadSuccessImpl) then) =
      __$$LoadSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Fresh<List<Song>> songs, bool isNextPageAvailable});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class __$$LoadSuccessImplCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res, _$LoadSuccessImpl>
    implements _$$LoadSuccessImplCopyWith<$Res> {
  __$$LoadSuccessImplCopyWithImpl(
      _$LoadSuccessImpl _value, $Res Function(_$LoadSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? isNextPageAvailable = null,
  }) {
    return _then(_$LoadSuccessImpl(
      null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
      isNextPageAvailable: null == isNextPageAvailable
          ? _value.isNextPageAvailable
          : isNextPageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadSuccessImpl extends _LoadSuccess {
  const _$LoadSuccessImpl(this.songs, {required this.isNextPageAvailable})
      : super._();

  @override
  final Fresh<List<Song>> songs;
  @override
  final bool isNextPageAvailable;

  @override
  String toString() {
    return 'PaginatedSongsState.loadSuccess(songs: $songs, isNextPageAvailable: $isNextPageAvailable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSuccessImpl &&
            (identical(other.songs, songs) || other.songs == songs) &&
            (identical(other.isNextPageAvailable, isNextPageAvailable) ||
                other.isNextPageAvailable == isNextPageAvailable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, songs, isNextPageAvailable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      __$$LoadSuccessImplCopyWithImpl<_$LoadSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Fresh<List<Song>> songs) initial,
    required TResult Function(Fresh<List<Song>> songs, int itemsPerPage)
        loadInProgress,
    required TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)
        loadSuccess,
    required TResult Function(Fresh<List<Song>> songs, BackendFailure failure)
        loadFailure,
  }) {
    return loadSuccess(songs, isNextPageAvailable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Fresh<List<Song>> songs)? initial,
    TResult? Function(Fresh<List<Song>> songs, int itemsPerPage)?
        loadInProgress,
    TResult? Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult? Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
  }) {
    return loadSuccess?.call(songs, isNextPageAvailable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(songs, isNextPageAvailable);
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

abstract class _LoadSuccess extends PaginatedSongsState {
  const factory _LoadSuccess(final Fresh<List<Song>> songs,
      {required final bool isNextPageAvailable}) = _$LoadSuccessImpl;
  const _LoadSuccess._() : super._();

  @override
  Fresh<List<Song>> get songs;
  bool get isNextPageAvailable;
  @override
  @JsonKey(ignore: true)
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadFailureImplCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$LoadFailureImplCopyWith(
          _$LoadFailureImpl value, $Res Function(_$LoadFailureImpl) then) =
      __$$LoadFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Fresh<List<Song>> songs, BackendFailure failure});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
  $BackendFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$LoadFailureImplCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res, _$LoadFailureImpl>
    implements _$$LoadFailureImplCopyWith<$Res> {
  __$$LoadFailureImplCopyWithImpl(
      _$LoadFailureImpl _value, $Res Function(_$LoadFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? failure = null,
  }) {
    return _then(_$LoadFailureImpl(
      null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as BackendFailure,
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

class _$LoadFailureImpl extends _LoadFailure {
  const _$LoadFailureImpl(this.songs, this.failure) : super._();

  @override
  final Fresh<List<Song>> songs;
  @override
  final BackendFailure failure;

  @override
  String toString() {
    return 'PaginatedSongsState.loadFailure(songs: $songs, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadFailureImpl &&
            (identical(other.songs, songs) || other.songs == songs) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, songs, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadFailureImplCopyWith<_$LoadFailureImpl> get copyWith =>
      __$$LoadFailureImplCopyWithImpl<_$LoadFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Fresh<List<Song>> songs) initial,
    required TResult Function(Fresh<List<Song>> songs, int itemsPerPage)
        loadInProgress,
    required TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)
        loadSuccess,
    required TResult Function(Fresh<List<Song>> songs, BackendFailure failure)
        loadFailure,
  }) {
    return loadFailure(songs, failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Fresh<List<Song>> songs)? initial,
    TResult? Function(Fresh<List<Song>> songs, int itemsPerPage)?
        loadInProgress,
    TResult? Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult? Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
  }) {
    return loadFailure?.call(songs, failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
        loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(songs, failure);
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

abstract class _LoadFailure extends PaginatedSongsState {
  const factory _LoadFailure(
          final Fresh<List<Song>> songs, final BackendFailure failure) =
      _$LoadFailureImpl;
  const _LoadFailure._() : super._();

  @override
  Fresh<List<Song>> get songs;
  BackendFailure get failure;
  @override
  @JsonKey(ignore: true)
  _$$LoadFailureImplCopyWith<_$LoadFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
