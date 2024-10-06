import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class CustomBottomNavBarTheme {
  CustomBottomNavBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavBarTheme = const BottomNavigationBarThemeData(
    selectedItemColor: CustomColors.blue9,
    unselectedItemColor: CustomColors.blue6,
  );
}
