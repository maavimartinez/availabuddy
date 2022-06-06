import 'dart:math';

import 'package:flutter/material.dart';

class AbColors {
  static MaterialColor primarySwatch = generateMaterialColor(primary);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static const Color primary =
      Color.fromRGBO(16, 167, 3, 1); // Color(0xFF0B8F5B);
  static const Color accent = Color(0xFF999999);

  static const Color black = Color(0xFF0D0D0D);

  static const Color scaffoldWhite = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite1 = Color(0xFFFAFAFA);
  static const Color offWhite2 = Color(0xFFF5F5F5);
  static const Color offWhite3 = Color(0xFFEEEEEE);
  static const Color offWhite4 = Color(0xFFEFEFEF);
  static const Color offWhite5 = Color(0xFFBDBDBD);

  static const Color lighterGray = Color(0xFFE5E5E5);
  static const Color lightGray = Color(0xFFCCCCCC);
  static const Color gray = Color(0xFF757575);
  static const Color gray2 = Color(0xFF5F6367);
  static const Color disabledGray = Color(0xFF979592);
  static const Color darkGray = Color(0xFF5c5c5c);

  static const Color almostBlack = Color(0xFF2f2f2f);

  static const Color lightTransparentGray = Color(0xEEF2F2F2);

  static const Color blue = Color(0xFF4A75FF);
  static const Color lightBlue = Color(0xFFF1F4FF);
  static const Color lighterBlue = Color(0xFFE1F5FE);

  static const Color lightGreen = Color(0xFF8DC63F);
  static const Color green = Color.fromRGBO(16, 167, 3, 1);
  static const Color greenGray = Color(0xFF7E8D92);
  static const Color lightAqua = Color(0xFFF0FFF9);
  static const Color blueGreen = Color(0xFF6DBC9C);

  static const Color lightOrange = Color(0xFFFFB74D);
  static const Color orange = Color(0xFFFF6B00);
  static const Color pink = Color(0xFFEB4969);
  static const Color salmon = Color(0xFFF49997);
  static const Color lightPink = Color(0xFFF392A5);
  static const Color purple = Color(0xFF855CF8);
  static const Color medicationPurple = Color(0xFFC30CE1);
  static const Color red = Color(0xFFFC324B);
  static const Color lightRed = Color(0xFFFFF2F5);
  static const Color blockedRed = Color(0xFFEB4969);
  static const Color gold = Color(0xFFFAB941);
  static const Color lilac = Color.fromRGBO(231, 207, 255, 1);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
