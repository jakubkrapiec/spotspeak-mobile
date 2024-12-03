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
    final isActive = trace.isActive;

    return ListTile(
      onTap: onTap,
      tileColor: isActive
          ? null
          : _appService.isDarkMode(context)
              ? CustomColors.grey3
              : CustomColors.grey2,
      leading: SvgPicture.asset(
        width: 40,
        height: 40,
        theme: SvgTheme(
          currentColor: isActive
              ? Theme.of(context).primaryColor
              : _appService.isDarkMode(context)
                  ? CustomColors.grey5
                  : CustomColors.grey4,
        ),
        traceIconPath,
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
                            : _appService.isDarkMode(context)
                                ? CustomColors.grey5
                                : CustomColors.grey4,
                      ),
                ),
              ],
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isActive
                        ? null
                        : _appService.isDarkMode(context)
                            ? CustomColors.grey5
                            : CustomColors.grey4,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Data dodania: ',
              children: [
                TextSpan(
                  text: DateFormat('dd.MM.yyyy H:mm').format(trace.createdAt),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: isActive
                            ? null
                            : _appService.isDarkMode(context)
                                ? CustomColors.grey5
                                : CustomColors.grey4,
                      ),
                ),
              ],
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isActive
                        ? null
                        : _appService.isDarkMode(context)
                            ? CustomColors.grey5
                            : CustomColors.grey4,
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
