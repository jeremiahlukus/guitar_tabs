// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/core/domain/fresh.dart';

// Project imports:

void main() {
  group('Fresh', () {
    test('returns isFresh false when Fresh.no', () {
      const expectedFresh = Fresh(entity: 'test', isFresh: false);
      final actualFresh = Fresh.no('test');
      expect(actualFresh, expectedFresh);
    });
    test('returns isFresh true when Fresh.yes', () {
      const expectedFresh = Fresh(entity: 'test', isFresh: true);
      final actualFresh = Fresh.yes('test');
      expect(actualFresh, expectedFresh);
    });
  });
}
