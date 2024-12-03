import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class TraceTile extends StatelessWidget {
  TraceTile({
    required this.trace,
    required this.currentLocation,
    required this.traceIconPath,
    required this.onTap,
    super.key,
  });

  final Trace trace;
  final Position currentLocation;
  final String traceIconPath;
  final VoidCallback onTap;

  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    final isActive = trace.isActive();
    return ListTile(
      onTap: onTap,
      tileColor: isActive
          ? null
          : _appService.themeMode == ThemeMode.light
              ? CustomColors.grey2
              : CustomColors.grey3,
      leading: SvgPicture.asset(
        width: 40,
        height: 40,
        theme: SvgTheme(currentColor: Theme.of(context).primaryColor),
        traceIconPath,
        //_appService.isDarkMode(context) ? 'assets/trace_icon_white.png' : 'assets/trace_icon.png',
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Odległość: ',
              children: [
                TextSpan(
                  text: trace.convertedDistance(currentLocation.toLatLng()),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: isActive
                            ? null
                            : _appService.themeMode == ThemeMode.light
                                ? CustomColors.grey4
                                : CustomColors.grey5,
                      ),
                ),
              ],
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isActive
                        ? null
                        : _appService.themeMode == ThemeMode.light
                            ? CustomColors.grey4
                            : CustomColors.grey5,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Data dodania: ',
              children: [
                TextSpan(
                  text: DateFormat('dd.MM.yyyy H:m').format(trace.createdAt),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: isActive
                            ? null
                            : _appService.themeMode == ThemeMode.light
                                ? CustomColors.grey4
                                : CustomColors.grey5,
                      ),
                ),
              ],
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isActive
                        ? null
                        : _appService.themeMode == ThemeMode.light
                            ? CustomColors.grey4
                            : CustomColors.grey5,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: isActive ? null : CustomColors.grey5,
      ),
    );
  }
}
