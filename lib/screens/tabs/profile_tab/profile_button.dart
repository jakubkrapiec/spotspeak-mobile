import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton({required this.pressFunction, required this.buttonText, super.key});

  final _appService = getIt<AppService>();
  final VoidCallback pressFunction;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _appService.themeModeNotifier,
      builder: (context, themeMode, child) {
        final isDarkMode = _appService.isDarkMode(context);

        return GestureDetector(
          onTap: pressFunction,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: isDarkMode ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonText,
                  style: buttonText == 'Usunięcie konta' ? Theme.of(context).textTheme.labelMedium : null,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        );
      },
    );
  }
}
