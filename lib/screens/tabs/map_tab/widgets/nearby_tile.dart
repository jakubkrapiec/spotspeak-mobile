import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class NearbyTile extends StatelessWidget {
  NearbyTile({
    required this.trace,
    required this.currentPostion,
    required this.onTapFunction,
    required this.traceIconPath,
    super.key,
  });

  final _appService = getIt<AppService>();

  final VoidCallback onTapFunction;

  final TraceLocation trace;

  final LatLng currentPostion;

  final String traceIconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
        child: ListTile(
          onTap: onTapFunction,
          leading: SvgPicture.asset(
            width: 40,
            height: 40,
            theme: SvgTheme(currentColor: Theme.of(context).primaryColor),
            traceIconPath,
            //_appService.isDarkMode(context) ? 'assets/trace_icon_white.png' : 'assets/trace_icon.png',
          ),
          title: Text(trace.convertedDistance(currentPostion)),
          trailing: Icon(Icons.location_on),
        ),
      ),
    );
  }
}
