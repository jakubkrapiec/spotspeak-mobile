import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class SendRequestButton extends StatelessWidget {
  const SendRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? CustomTheme.lightContainerStyle
            : CustomTheme.darkContainerStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Zaproś do znajomych'),
            Gap(32),
            Icon(Icons.people),
          ],
        ),
      ),
    );
  }
}
