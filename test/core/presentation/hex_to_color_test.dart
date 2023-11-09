// Flutter imports:
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:joyful_noise/core/presentation/styles/hex_to_color.dart';

void main() {
  group('HexColor', () {
    testWidgets('converts Hex Color to Color', (tester) async {
      final color = HexColor('#333333').value;
      expect(color, const Color(0xff333333).value);
    });
  });
}
