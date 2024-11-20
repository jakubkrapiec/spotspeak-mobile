import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class FriendsSearch extends StatelessWidget {
  const FriendsSearch({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: MediaQuery.platformBrightnessOf(context) == Brightness.light ? CustomColors.blue1 : CustomColors.grey5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
              ? CustomTheme.lightContainerStyle
              : CustomTheme.darkContainerStyle,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Wyszukaj znajomego'),
                  controller: controller,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
