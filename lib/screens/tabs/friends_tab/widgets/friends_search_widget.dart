import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class FriendsSearchWidget extends StatelessWidget {
  const FriendsSearchWidget({
    required this.pressFunction,
    super.key,
  });

  final void Function(String val) pressFunction;
  @override
  Widget build(BuildContext context) {
    var textPattern = '';
    return ColoredBox(
      color: MediaQuery.platformBrightnessOf(context) == Brightness.light ? CustomColors.blue1 : CustomColors.grey5,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Container(
          decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
              ? CustomTheme.lightContainerStyle
              : CustomTheme.darkContainerStyle,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Wyszukaj znajomego',
                  ),
                  onChanged: (value) => {textPattern = value},
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  pressFunction(textPattern);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
