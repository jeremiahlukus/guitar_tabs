// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    required int id,
    required String email,
  }) = _User;
}
