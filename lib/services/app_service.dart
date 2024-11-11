import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppService {
  AppService();

  ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

  void changeTheme(ThemeMode themeMode) {
    themeModeNotifier.value = themeMode;
  }
}
