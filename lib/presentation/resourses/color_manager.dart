import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#FF4546');
  static Color blue = Colors.lightBlue;
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
  static Color favoriteColor = HexColor.fromHex('#FF4546');
  static Color emotionColor = HexColor.fromHex('#E5F50A');
  static Color commentsBackgroundColor = HexColor.fromHex('#EFEFEF');
  static Color tabBarIndicator = HexColor.fromHex('#081ED6');
  static Color iconDrawerColor = HexColor.fromHex('#000000').withOpacity(0.25);
  static Color hashtagColor = HexColor.fromHex('#081ED6');
  static Color timeAgo = HexColor.fromHex('#ffffff').withOpacity(0.76);
  static Color complain = HexColor.fromHex('#464444');
  static Color profileName = HexColor.fromHex('#454F63');
  static Color profileLocation = HexColor.fromHex('#78849E');
  static Color profileStatisticIcon = HexColor.fromHex('#081ED6');
  static Color challengeDescription = HexColor.fromHex('#7F7F7F');
  static Color achievedRank = HexColor.fromHex('#BECBFF');
  static Color unAchievedRank = HexColor.fromHex('#707070').withOpacity(0.56);
  static Color notificationPersonDetails =
      HexColor.fromHex('#E2E4E5').withOpacity(0.56);
  static Color seenNotificationBackground = HexColor.fromHex('#E2E4E5');
  static Color allRanksStatisticItem = HexColor.fromHex('#0C092A');
  static Color backButtonColor = HexColor.fromHex('#707070');
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
