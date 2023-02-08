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
    required String name,
    required String email,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'avatar_url') required String avatarUrl,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

  factory UserDTO.fromDomain(User _) {
    return UserDTO(
      name: _.name,
      email: _.email,
      avatarUrl: _.avatarUrl,
    );
  }
  User toDomain() {
    return User(
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}
