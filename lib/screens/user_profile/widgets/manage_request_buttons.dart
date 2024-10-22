import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class ManageRequestButtons extends StatelessWidget {
  const ManageRequestButtons({super.key});

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
              decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? CustomTheme.lightContainerStyle
                  : CustomTheme.darkContainerStyle,
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
              decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
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
