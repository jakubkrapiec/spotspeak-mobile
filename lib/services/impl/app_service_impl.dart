import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/services/app_service.dart';

@prod
@test
@Singleton(as: AppService)
class AppServiceImpl implements AppService {
  @override
  ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

  @override
  ThemeMode get themeMode => themeModeNotifier.value;

  @override
  bool isDarkMode(BuildContext context) {
    return themeModeNotifier.value == ThemeMode.system
        ? MediaQuery.platformBrightnessOf(context) == Brightness.dark
        : themeModeNotifier.value == ThemeMode.dark;
  }
}
