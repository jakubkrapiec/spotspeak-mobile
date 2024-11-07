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
    iconTheme: const IconThemeData(color: CustomColors.blue7, size: 26),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: CustomColors.blue9,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: CustomColors.blue7,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: CustomColors.blue7,
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
      labelSmall: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: CustomColors.blue7,
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
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        color: CustomColors.grey3,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 16,
      ),
      suffixIconColor: CustomColors.blue7,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: CustomColors.blue2,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: CustomColors.blue8,
      labelStyle: TextStyle(
        fontSize: 19,
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: CustomColors.grey4,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: CustomColors.blue3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      titleTextStyle: TextStyle(fontSize: 20, fontFamily: 'Inconsolata', color: CustomColors.blue7),
      iconColor: CustomColors.blue7,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: CustomColors.blue2,
      textStyle: TextStyle(
        fontSize: 12,
        fontFamily: 'Inconsolata',
        color: CustomColors.blue7,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: CustomColors.blue7,
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(fontSize: 20, fontFamily: 'Inconsolata', color: CustomColors.blue7),
    ),
    bottomNavigationBarTheme: CustomBottomNavBarTheme.lightBottomNavBarTheme,
  );

  static final lightContainerStyle = BoxDecoration(
    color: CustomColors.blue3,
    borderRadius: BorderRadius.all(Radius.circular(15)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 8,
        offset: const Offset(5, 3),
      ),
    ],
  );

  static final lightSliderButton =
      BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12)));

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.green5,
      surface: CustomColors.grey5,
      error: CustomColors.red1,
      onTertiary: Colors.orange,
    ),
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    iconTheme: const IconThemeData(color: CustomColors.green7),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: CustomColors.green4,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: CustomColors.green7,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: CustomColors.green3,
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
      labelSmall: TextStyle(
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: CustomColors.green2,
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
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
        color: CustomColors.grey3,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Inconsolata',
        fontSize: 16,
      ),
      suffixIconColor: CustomColors.green7,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: CustomColors.grey5,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: CustomColors.green8,
      unselectedLabelColor: CustomColors.grey3,
      labelStyle: TextStyle(
        fontSize: 19,
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontFamily: 'Inconsolata',
        fontWeight: FontWeight.bold,
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: CustomColors.grey6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      titleTextStyle: TextStyle(fontSize: 20, fontFamily: 'Inconsolata', color: CustomColors.green3),
      iconColor: CustomColors.green7,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: CustomColors.grey5,
      textStyle: TextStyle(
        fontSize: 12,
        fontFamily: 'Inconsolata',
        color: CustomColors.green7,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: CustomColors.green3,
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(fontSize: 22, fontFamily: 'Inconsolata', color: CustomColors.green6),
    ),
    bottomNavigationBarTheme: CustomBottomNavBarTheme.darkBottomNavBarTheme,
  );

  static final darkContainerStyle = BoxDecoration(
    color: CustomColors.grey6,
    borderRadius: BorderRadius.all(Radius.circular(15)),
    boxShadow: [
      BoxShadow(
        color: CustomColors.grey3.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 8,
        offset: const Offset(5, 3),
      ),
    ],
  );

  static final darkSliderButton =
      BoxDecoration(color: CustomColors.grey4, borderRadius: BorderRadius.all(Radius.circular(12)));
}
