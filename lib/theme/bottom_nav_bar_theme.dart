import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class CustomBottomNavBarTheme {
  CustomBottomNavBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavBarTheme = const BottomNavigationBarThemeData(
    selectedItemColor: CustomColors.blue1,
    unselectedItemColor: CustomColors.blue5,
  );

  static BottomNavigationBarThemeData darkBottomNavBarTheme = const BottomNavigationBarThemeData(
    selectedItemColor: CustomColors.green5,
    unselectedItemColor: CustomColors.green8,
  );
}
