import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class FriendshipStatusBar extends StatelessWidget {
  const FriendshipStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? CustomTheme.lightContainerStyle
                  : CustomTheme.darkContainerStyle,
              child: Row(
                children: [
                  Icon(Icons.people),
                  Gap(16),
                  Text('Znajomi'),
                ],
              ),
            ),
          ),
          Gap(16),
          GestureDetector(
            child: Container(
              decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? CustomTheme.lightContainerStyle.copyWith(color: CustomColors.blue2)
                  : CustomTheme.darkContainerStyle.copyWith(color: CustomColors.grey4),
              padding: EdgeInsets.all(16),
              child: Icon(Icons.person_remove),
            ),
          ),
        ],
      ),
    );
  }
}
