// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
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
  $PaginatedSongsStateCopyWith<PaginatedSongsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedSongsStateCopyWith<$Res> {
  factory $PaginatedSongsStateCopyWith(
          PaginatedSongsState value, $Res Function(PaginatedSongsState) then) =
      _$PaginatedSongsStateCopyWithImpl<$Res>;
  $Res call({Fresh<List<Song>> songs});

  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class _$PaginatedSongsStateCopyWithImpl<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  _$PaginatedSongsStateCopyWithImpl(this._value, this._then);

  final PaginatedSongsState _value;
  // ignore: unused_field
  final $Res Function(PaginatedSongsState) _then;

  @override
  $Res call({
    Object? songs = freezed,
  }) {
    return _then(_value.copyWith(
      songs: songs == freezed
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
    ));
  }

  @override
  $FreshCopyWith<List<Song>, $Res> get songs {
    return $FreshCopyWith<List<Song>, $Res>(_value.songs, (value) {
      return _then(_value.copyWith(songs: value));
    });
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  $Res call({Fresh<List<Song>> songs});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;

  @override
  $Res call({
    Object? songs = freezed,
  }) {
    return _then(_$_Initial(
      songs == freezed
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
    ));
  }
}

/// @nodoc

class _$_Initial extends _Initial {
  const _$_Initial(this.songs) : super._();

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
            other is _$_Initial &&
            const DeepCollectionEquality().equals(other.songs, songs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(songs));

  @JsonKey(ignore: true)
  @override
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

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
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
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

abstract class _Initial extends PaginatedSongsState {
  const factory _Initial(final Fresh<List<Song>> songs) = _$_Initial;
  const _Initial._() : super._();

  @override
  Fresh<List<Song>> get songs => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadInProgressCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$_LoadInProgressCopyWith(
          _$_LoadInProgress value, $Res Function(_$_LoadInProgress) then) =
      __$$_LoadInProgressCopyWithImpl<$Res>;
  @override
  $Res call({Fresh<List<Song>> songs, int itemsPerPage});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class __$$_LoadInProgressCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res>
    implements _$$_LoadInProgressCopyWith<$Res> {
  __$$_LoadInProgressCopyWithImpl(
      _$_LoadInProgress _value, $Res Function(_$_LoadInProgress) _then)
      : super(_value, (v) => _then(v as _$_LoadInProgress));

  @override
  _$_LoadInProgress get _value => super._value as _$_LoadInProgress;

  @override
  $Res call({
    Object? songs = freezed,
    Object? itemsPerPage = freezed,
  }) {
    return _then(_$_LoadInProgress(
      songs == freezed
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
      itemsPerPage == freezed
          ? _value.itemsPerPage
          : itemsPerPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_LoadInProgress extends _LoadInProgress {
  const _$_LoadInProgress(this.songs, this.itemsPerPage) : super._();

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
            other is _$_LoadInProgress &&
            const DeepCollectionEquality().equals(other.songs, songs) &&
            const DeepCollectionEquality()
                .equals(other.itemsPerPage, itemsPerPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(songs),
      const DeepCollectionEquality().hash(itemsPerPage));

  @JsonKey(ignore: true)
  @override
  _$$_LoadInProgressCopyWith<_$_LoadInProgress> get copyWith =>
      __$$_LoadInProgressCopyWithImpl<_$_LoadInProgress>(this, _$identity);

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
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
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

abstract class _LoadInProgress extends PaginatedSongsState {
  const factory _LoadInProgress(
          final Fresh<List<Song>> songs, final int itemsPerPage) =
      _$_LoadInProgress;
  const _LoadInProgress._() : super._();

  @override
  Fresh<List<Song>> get songs => throw _privateConstructorUsedError;
  int get itemsPerPage => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LoadInProgressCopyWith<_$_LoadInProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadSuccessCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$_LoadSuccessCopyWith(
          _$_LoadSuccess value, $Res Function(_$_LoadSuccess) then) =
      __$$_LoadSuccessCopyWithImpl<$Res>;
  @override
  $Res call({Fresh<List<Song>> songs, bool isNextPageAvailable});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
}

/// @nodoc
class __$$_LoadSuccessCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res>
    implements _$$_LoadSuccessCopyWith<$Res> {
  __$$_LoadSuccessCopyWithImpl(
      _$_LoadSuccess _value, $Res Function(_$_LoadSuccess) _then)
      : super(_value, (v) => _then(v as _$_LoadSuccess));

  @override
  _$_LoadSuccess get _value => super._value as _$_LoadSuccess;

  @override
  $Res call({
    Object? songs = freezed,
    Object? isNextPageAvailable = freezed,
  }) {
    return _then(_$_LoadSuccess(
      songs == freezed
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
      isNextPageAvailable: isNextPageAvailable == freezed
          ? _value.isNextPageAvailable
          : isNextPageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LoadSuccess extends _LoadSuccess {
  const _$_LoadSuccess(this.songs, {required this.isNextPageAvailable})
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
            other is _$_LoadSuccess &&
            const DeepCollectionEquality().equals(other.songs, songs) &&
            const DeepCollectionEquality()
                .equals(other.isNextPageAvailable, isNextPageAvailable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(songs),
      const DeepCollectionEquality().hash(isNextPageAvailable));

  @JsonKey(ignore: true)
  @override
  _$$_LoadSuccessCopyWith<_$_LoadSuccess> get copyWith =>
      __$$_LoadSuccessCopyWithImpl<_$_LoadSuccess>(this, _$identity);

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
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
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

abstract class _LoadSuccess extends PaginatedSongsState {
  const factory _LoadSuccess(final Fresh<List<Song>> songs,
      {required final bool isNextPageAvailable}) = _$_LoadSuccess;
  const _LoadSuccess._() : super._();

  @override
  Fresh<List<Song>> get songs => throw _privateConstructorUsedError;
  bool get isNextPageAvailable => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LoadSuccessCopyWith<_$_LoadSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadFailureCopyWith<$Res>
    implements $PaginatedSongsStateCopyWith<$Res> {
  factory _$$_LoadFailureCopyWith(
          _$_LoadFailure value, $Res Function(_$_LoadFailure) then) =
      __$$_LoadFailureCopyWithImpl<$Res>;
  @override
  $Res call({Fresh<List<Song>> songs, BackendFailure failure});

  @override
  $FreshCopyWith<List<Song>, $Res> get songs;
  $BackendFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$_LoadFailureCopyWithImpl<$Res>
    extends _$PaginatedSongsStateCopyWithImpl<$Res>
    implements _$$_LoadFailureCopyWith<$Res> {
  __$$_LoadFailureCopyWithImpl(
      _$_LoadFailure _value, $Res Function(_$_LoadFailure) _then)
      : super(_value, (v) => _then(v as _$_LoadFailure));

  @override
  _$_LoadFailure get _value => super._value as _$_LoadFailure;

  @override
  $Res call({
    Object? songs = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$_LoadFailure(
      songs == freezed
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as Fresh<List<Song>>,
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as BackendFailure,
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
  const _$_LoadFailure(this.songs, this.failure) : super._();

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
            other is _$_LoadFailure &&
            const DeepCollectionEquality().equals(other.songs, songs) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(songs),
      const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$$_LoadFailureCopyWith<_$_LoadFailure> get copyWith =>
      __$$_LoadFailureCopyWithImpl<_$_LoadFailure>(this, _$identity);

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
    TResult Function(Fresh<List<Song>> songs)? initial,
    TResult Function(Fresh<List<Song>> songs, int itemsPerPage)? loadInProgress,
    TResult Function(Fresh<List<Song>> songs, bool isNextPageAvailable)?
        loadSuccess,
    TResult Function(Fresh<List<Song>> songs, BackendFailure failure)?
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

abstract class _LoadFailure extends PaginatedSongsState {
  const factory _LoadFailure(
          final Fresh<List<Song>> songs, final BackendFailure failure) =
      _$_LoadFailure;
  const _LoadFailure._() : super._();

  @override
  Fresh<List<Song>> get songs => throw _privateConstructorUsedError;
  BackendFailure get failure => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LoadFailureCopyWith<_$_LoadFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
