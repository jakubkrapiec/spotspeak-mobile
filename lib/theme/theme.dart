import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/app_bar_theme.dart';
import 'package:spotspeak_mobile/theme/bottom_nav_bar_theme.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class CustomTheme {
  CustomTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.blue5,
      surface: CustomColors.blue1,
      error: CustomColors.red1,
      onTertiary: Colors.orange,
    ),
    canvasColor: CustomColors.blue3,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    iconTheme: const IconThemeData(
      color: CustomColors.blue5,
    ),
    bottomNavigationBarTheme: CustomBottomNavBarTheme.lightBottomNavBarTheme,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.green5,
      surface: CustomColors.grey5,
      error: CustomColors.red1,
      onTertiary: Colors.orange,
    ),
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    iconTheme: const IconThemeData(
      color: CustomColors.green5,
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle().copyWith(
        color: CustomColors.green5,
      ),
    ),
    bottomNavigationBarTheme: CustomBottomNavBarTheme.darkBottomNavBarTheme,
  );
}
