import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/app_bar_theme.dart';
import 'package:spotspeak_mobile/theme/bottom_nav_bar_theme.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

abstract class CustomTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.blue5,
      surface: CustomColors.blue1,
      error: CustomColors.red1,
      onTertiary: Colors.orange,
    ),
    canvasColor: CustomColors.blue1,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    iconTheme: const IconThemeData(
      color: CustomColors.blue5,
    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle().copyWith(
        fontFamily: 'Inconsolata',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: CustomColors.blue9,
      ),
      bodyLarge: const TextStyle().copyWith(
        fontFamily: 'Inconsolata',
        fontSize: 20,
        color: CustomColors.blue7,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: 'Inconsolata',
          fontSize: 18,
          color: CustomColors.blue8,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: 'Inconsolata',
          fontSize: 15,
          color: CustomColors.blue9,
        ),
      ),
    ),
    bottomNavigationBarTheme: CustomBottomNavBarTheme.lightBottomNavBarTheme,
  );

  static final darkTheme = ThemeData(
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
      titleLarge: const TextStyle().copyWith(
        fontFamily: 'Inconsolata',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: CustomColors.green4,
      ),
      bodyLarge: const TextStyle().copyWith(
        fontFamily: 'Inconsolata',
        fontSize: 20,
        color: CustomColors.green3,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.green1,
        textStyle: const TextStyle(
          fontFamily: 'Inconsolata',
          fontSize: 18,
          color: CustomColors.green9,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: 'Inconsolata',
          fontSize: 15,
          color: CustomColors.green2,
        ),
      ),
    ),
    bottomNavigationBarTheme: CustomBottomNavBarTheme.darkBottomNavBarTheme,
  );
}
