import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

abstract class CustomBottomNavBarTheme {
  static const lightBottomNavBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: CustomColors.blue5,
    unselectedItemColor: CustomColors.blue3,
  );

  static const darkBottomNavBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: CustomColors.green5,
    unselectedItemColor: CustomColors.green8,
  );
}
