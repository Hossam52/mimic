import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#FF4546');
  static Color accentColor = HexColor.fromHex('#4D99C0E1');
  static Color darkPrimary = HexColor.fromHex('#FF4546');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color grey = HexColor.fromHex('#B0B0B0');
  static Color lightGrey = HexColor.fromHex('#737477');
  static Color grey1 = HexColor.fromHex('#737477');
  static Color white = HexColor.fromHex('#ffffff');
  static Color primaryOpacity70 = HexColor.fromHex('#B0FF4546');
  static Color primaryOpacity60 = HexColor.fromHex('#8FFF4546');
  static Color error = HexColor.fromHex("#ff0000");
  static Color selectedColor = HexColor.fromHex('#4D99C0E1');
  static Color black = HexColor.fromHex('#000000');
  static Color visibilityColor = HexColor.fromHex('#081ED6');
  static Color likeColor = HexColor.fromHex('#ff0000');
  static Color commentsColor = HexColor.fromHex('#707070');
  static Color drawerFillColor = HexColor.fromHex('#F1F9FF');
  static Color selectedBottomColor = HexColor.fromHex('#99C0E1');
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    hexString = hexString.replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
