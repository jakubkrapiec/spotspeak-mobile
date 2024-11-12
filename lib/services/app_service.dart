import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppService {
  AppService();

  ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

  set themeMode(ThemeMode themeMode) {
    themeModeNotifier.value = themeMode;
  }

  ThemeMode get themeMode => themeModeNotifier.value;
}
