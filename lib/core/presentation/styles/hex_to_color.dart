import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    var modifiedHexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (modifiedHexColor.length == 6) {
      modifiedHexColor = 'FF$modifiedHexColor';
    }
    return int.parse(modifiedHexColor, radix: 16);
  }

  HexColor(String hexColor) : super(_getColorFromHex(hexColor));
}
