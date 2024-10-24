import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({required this.pressFunction, required this.buttonText, super.key});

  final VoidCallback pressFunction;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressFunction,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? CustomTheme.lightContainerStyle
            : CustomTheme.darkContainerStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(buttonText, style: TextStyle(color: buttonText == 'Usunięcie konta' ? CustomColors.red1 : null)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
