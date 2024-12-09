import 'package:flutter/material.dart';

abstract interface class AppService {
  abstract ValueNotifier<ThemeMode> themeModeNotifier;
  ThemeMode get themeMode;
  bool isDarkMode(BuildContext context);
}
