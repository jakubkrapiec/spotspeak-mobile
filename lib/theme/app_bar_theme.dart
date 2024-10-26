import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

abstract class CustomAppBarTheme {
  static final lightAppBarTheme = AppBarTheme(
    color: CustomColors.blue5,
    centerTitle: true,
    titleTextStyle: const TextStyle().copyWith(
      color: CustomColors.grey1,
      fontFamily: 'Inconsolata',
      fontSize: 22,
    ),
    iconTheme: const IconThemeData(
      color: CustomColors.blue2,
    ),
  );

  static final darkAppBarTheme = AppBarTheme(
    color: CustomColors.grey6,
    centerTitle: true,
    titleTextStyle: const TextStyle().copyWith(
      color: CustomColors.green5,
      fontFamily: 'Inconsolata',
      fontSize: 22,
    ),
    iconTheme: const IconThemeData(
      color: CustomColors.green7,
    ),
  );
}
