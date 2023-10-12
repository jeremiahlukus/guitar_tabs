// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backend_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BackendFailure {
  int? get errorCode => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? errorCode, String? message) api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? errorCode, String? message)? api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? errorCode, String? message)? api,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Api value) api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Api value)? api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Api value)? api,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BackendFailureCopyWith<BackendFailure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackendFailureCopyWith<$Res> {
  factory $BackendFailureCopyWith(BackendFailure value, $Res Function(BackendFailure) then) =
      _$BackendFailureCopyWithImpl<$Res, BackendFailure>;
  @useResult
  $Res call({int? errorCode, String? message});
}

/// @nodoc
class _$BackendFailureCopyWithImpl<$Res, $Val extends BackendFailure> implements $BackendFailureCopyWith<$Res> {
  _$BackendFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiImplCopyWith<$Res> implements $BackendFailureCopyWith<$Res> {
  factory _$$ApiImplCopyWith(_$ApiImpl value, $Res Function(_$ApiImpl) then) = __$$ApiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? errorCode, String? message});
}

/// @nodoc
class __$$ApiImplCopyWithImpl<$Res> extends _$BackendFailureCopyWithImpl<$Res, _$ApiImpl>
    implements _$$ApiImplCopyWith<$Res> {
  __$$ApiImplCopyWithImpl(_$ApiImpl _value, $Res Function(_$ApiImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ApiImpl(
      freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ApiImpl extends _Api {
  const _$ApiImpl(this.errorCode, this.message) : super._();

  @override
  final int? errorCode;
  @override
  final String? message;

  @override
  String toString() {
    return 'BackendFailure.api(errorCode: $errorCode, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiImpl &&
            (identical(other.errorCode, errorCode) || other.errorCode == errorCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorCode, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiImplCopyWith<_$ApiImpl> get copyWith => __$$ApiImplCopyWithImpl<_$ApiImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? errorCode, String? message) api,
  }) {
    return api(errorCode, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? errorCode, String? message)? api,
  }) {
    return api?.call(errorCode, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? errorCode, String? message)? api,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(errorCode, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Api value) api,
  }) {
    return api(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Api value)? api,
  }) {
    return api?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Api value)? api,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(this);
    }
    return orElse();
  }
}

abstract class _Api extends BackendFailure {
  const factory _Api(final int? errorCode, final String? message) = _$ApiImpl;
  const _Api._() : super._();

  @override
  int? get errorCode;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ApiImplCopyWith<_$ApiImpl> get copyWith => throw _privateConstructorUsedError;
}
