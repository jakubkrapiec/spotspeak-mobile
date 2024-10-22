import 'package:flutter/material.dart';

abstract class CustomColors {
  /// Number in colors' names describes shade of the color:
  /// 1 - the lightest, 9 - the darkest

  /// Blue:

  static const blue1 = Color(0xFFEBF8FF);
  static const blue2 = Color(0xFFC1E1F4);
  static const blue3 = Color(0xFF99DAFF);
  static const blue4 = Color(0xFF5FC0F9);
  static const blue5 = Color(0xFF38B6FF);
  static const blue6 = Color(0xFF1B8BCC);
  static const blue7 = Color(0xFF106FA7);
  static const blue8 = Color(0xFF043F61);
  static const blue9 = Color(0xFF00273D);

  /// Green:

  static const green1 = Color(0xFFF1FFEB);
  static const green2 = Color(0xFFD1F5C1);
  static const green3 = Color(0xFFB8FF99);
  static const green4 = Color(0xFF89F25C);
  static const green5 = Color(0xFF6EF235);
  static const green6 = Color(0xFF50CC1B);
  static const green7 = Color(0xFF3DA611);
  static const green8 = Color(0xFF206104);
  static const green9 = Color(0xFF123D00);

  /// Grey:

  static const grey1 = Color(0xFFF6F7F5);
  static const grey2 = Color(0xFFA3B1CC);
  static const grey3 = Color(0xFF666E80);
  static const grey4 = Color(0xFF3D424D);
  static const grey5 = Color(0xFF25282E);
  static const grey6 = Color(0xFF151515);

  /// Red:

  static const red1 = Color(0xFFF23C35);

  static const backgroundGradientLight = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.white,
        CustomColors.blue1,
        CustomColors.blue2,
        CustomColors.blue3,
      ],
    ),
  );

  static const backgroundGradientDark = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        grey2,
        grey3,
        grey4,
        grey5,
      ],
    ),
  );
}
