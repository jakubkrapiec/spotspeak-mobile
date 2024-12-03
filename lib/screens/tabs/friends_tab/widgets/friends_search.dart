import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class FriendsSearch extends StatelessWidget {
  FriendsSearch({required this.controller, super.key});

  final TextEditingController controller;
  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _appService.isDarkMode(context) ? CustomColors.grey5 : CustomColors.blue1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration:
              _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Wyszukaj znajomego'),
                  controller: controller,
                  style: const TextStyle(fontSize: 16),
                  autofocus: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
