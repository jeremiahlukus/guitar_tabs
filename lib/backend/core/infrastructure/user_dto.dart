// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDTO with _$UserDTO {
  const UserDTO._();
  const factory UserDTO({
    required int id,
    required String email,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

  factory UserDTO.fromDomain(User _) {
    return UserDTO(
      id: _.id,
      email: _.email,
    );
  }
  User toDomain() {
    return User(
      id: id,
      email: email,
    );
  }
}
