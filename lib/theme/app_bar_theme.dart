import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    color: CustomColors.blue5,
    centerTitle: true,
    titleTextStyle: const TextStyle().copyWith(
      color: CustomColors.grey1,
      fontFamily: 'Inconsolata',
      fontSize: 22,
    ),
    iconTheme: const IconThemeData(
      color: CustomColors.blue1,
    ),
  );

  static AppBarTheme darkAppBarTheme = AppBarTheme(
    color: CustomColors.grey6,
    centerTitle: true,
    titleTextStyle: const TextStyle().copyWith(
      color: CustomColors.green5,
      fontFamily: 'Inconsolata',
      fontSize: 22,
    ),
    iconTheme: const IconThemeData(
      color: CustomColors.grey3,
    ),
  );
}
