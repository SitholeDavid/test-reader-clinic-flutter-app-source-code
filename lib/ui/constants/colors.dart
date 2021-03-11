import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final Color backgroundPrimary = HexColor('#191720');
final Color backgroundSecondary = HexColor('#F9F8F7');
final Color accent = HexColor('#37AFFF');
final Color textPrimary = HexColor('#131313');
final Color textSecondary = HexColor('#8B8B8B');

final Color lowValueTextColor = Colors.green[900];
final Color lowValueBackgroundColor = Colors.green[50];

final Color averageValueTextColor = Colors.orange[900];
final Color averageValueBackgroundColor = Colors.orange[50];

final Color highValueTextColor = Colors.red[900];
final Color highValueBackgroundColor = Colors.red[50];
