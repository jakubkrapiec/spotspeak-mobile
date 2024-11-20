import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class SendRequestButton extends StatelessWidget {
  SendRequestButton({super.key});

  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
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
