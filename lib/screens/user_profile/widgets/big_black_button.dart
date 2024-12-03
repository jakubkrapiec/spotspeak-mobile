import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class BigBlackButton extends StatelessWidget {
  BigBlackButton({required this.label, required this.icon, required this.onTap, super.key});

  final _appService = getIt<AppService>();

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      label: Text(label),
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: _appService.isDarkMode(context)
            ? CustomTheme.darkContainerStyle.color
            : CustomTheme.lightContainerStyle.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
