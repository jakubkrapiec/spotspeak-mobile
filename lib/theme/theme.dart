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
    iconTheme: const IconThemeData(color: CustomColors.blue5),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: CustomColors.blue9,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 18,
        color: CustomColors.blue6,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 20,
        color: CustomColors.blue7,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 32,
        color: CustomColors.blue8,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: CustomColors.red1,
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
          fontWeight: FontWeight.bold,
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
    iconTheme: const IconThemeData(color: CustomColors.green5),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: CustomColors.green4,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 18,
        color: CustomColors.green2,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 20,
        color: CustomColors.green3,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 32,
        color: CustomColors.green6,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: CustomColors.red1,
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
          fontWeight: FontWeight.bold,
          color: CustomColors.green2,
        ),
      ),
    ),
    bottomNavigationBarTheme: CustomBottomNavBarTheme.darkBottomNavBarTheme,
  );
}
