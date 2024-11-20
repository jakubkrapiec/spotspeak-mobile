import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class ManageRequestButtons extends StatelessWidget {
  ManageRequestButtons({super.key});

  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration:
                  _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
              child: Row(
                children: [
                  Icon(Icons.person_add),
                  Gap(16),
                  Text('Akceptuj'),
                ],
              ),
            ),
          ),
          Gap(24),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: _appService.themeMode == ThemeMode.light
                  ? CustomTheme.lightContainerStyle.copyWith(color: CustomColors.blue2)
                  : CustomTheme.darkContainerStyle.copyWith(color: CustomColors.grey4),
              child: Row(
                children: [
                  Icon(Icons.person_remove),
                  Gap(16),
                  Text('Odrzuć'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
