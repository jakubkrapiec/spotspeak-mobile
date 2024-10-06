import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class CustomBottomNavBarTheme {
  CustomBottomNavBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavBarTheme = const BottomNavigationBarThemeData(
    selectedItemColor: CustomColors.blue9,
    unselectedItemColor: CustomColors.blue6,
  );

  static BottomNavigationBarThemeData darkBottomNavBarTheme = const BottomNavigationBarThemeData(
    selectedItemColor: CustomColors.green5,
    unselectedItemColor: CustomColors.green8,
  );
}
