import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppService {
  AppService();

  ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

  ThemeMode get themeMode => themeModeNotifier.value;

  bool isDarkMode(BuildContext context) {
    return themeModeNotifier.value == ThemeMode.system
        ? MediaQuery.platformBrightnessOf(context) == Brightness.dark
        : themeModeNotifier.value == ThemeMode.dark;
  }
}
