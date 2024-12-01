import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/new_trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class TraceTile extends StatelessWidget {
  TraceTile({required this.trace, required this.currentLocation, super.key});

  final Trace trace;
  final Position currentLocation;

  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    final isActive = trace.isActive();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: () async {
          await showDialog<TraceDialogResult?>(context: context, builder: (context) => TraceDialog(trace: trace));
        },
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
              'Odległość: ${trace.convertedDistance(currentLocation.toLatLng())}',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isActive
                        ? null
                        : _appService.themeMode == ThemeMode.light
                            ? CustomColors.grey4
                            : CustomColors.grey5,
                  ),
            ),
            Text(
              'Data dodania: ${DateFormat('yyyy-MM-dd').format(trace.createdAt)}',
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
