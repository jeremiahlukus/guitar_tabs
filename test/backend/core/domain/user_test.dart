// Dart imports:

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/user.dart';

void main() {
  group('User', () {
    test("avatarUrlOverride returns the avatarUrl with '&size=48' replaced with the size argument", () {
      const name = 'name';
      const avatarUrl = 'www.example.com/avatar?color=blue&size=48';
      const email = 'hey@hey.com';
      const user = User(name: name, avatarUrl: avatarUrl, email: email);

      const size = '24';

      const expectedOverriddenAvatarUrl = 'www.example.com/avatar?color=blue&size=$size';

      final actualOverriddenAvatarUrl = user.avatarUrlOverride(size);

      expect(actualOverriddenAvatarUrl, expectedOverriddenAvatarUrl);
    });
  });
}
