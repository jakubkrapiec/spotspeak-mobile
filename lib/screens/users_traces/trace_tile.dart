import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class TraceTile extends StatelessWidget {
  TraceTile({required this.isActive, super.key});

  final bool isActive;

  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: () {},
        tileColor: isActive
            ? null
            : _appService.themeMode == ThemeMode.light
                ? CustomColors.grey2
                : CustomColors.grey3,
        leading: Image.asset(
          _appService.themeMode == ThemeMode.light || !isActive
              ? 'assets/trace_icon.png'
              : 'assets/trace_icon_white.png',
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Odległość: 12km',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isActive
                        ? null
                        : _appService.themeMode == ThemeMode.light
                            ? CustomColors.grey4
                            : CustomColors.grey5,
                  ),
            ),
            Text(
              'Data dodania: 12-10-24',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isActive
                        ? null
                        : _appService.themeMode == ThemeMode.light
                            ? CustomColors.grey4
                            : CustomColors.grey5,
                  ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isActive ? null : CustomColors.grey5,
        ),
      ),
    );
  }
}
