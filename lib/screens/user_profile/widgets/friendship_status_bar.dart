import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class FriendshipStatusBar extends StatelessWidget {
  FriendshipStatusBar({required this.onRemoveFriend, super.key});

  final _appService = getIt<AppService>();

  final VoidCallback onRemoveFriend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration:
                  _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
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
          IconButton(onPressed: onRemoveFriend, icon: Icon(Icons.person_remove)),
        ],
      ),
    );
  }
}
