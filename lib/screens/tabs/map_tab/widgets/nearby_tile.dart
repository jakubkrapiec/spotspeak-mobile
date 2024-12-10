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
      child: DecoratedBox(
        decoration: _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            onTap: onTapFunction,
            leading: SvgPicture.asset(
              width: 40,
              height: 40,
              theme: SvgTheme(currentColor: Theme.of(context).primaryColor),
              traceIconPath,
            ),
            title: Text(trace.convertedDistance(currentPostion)),
            subtitle: StreamBuilder<void>(
              stream: Stream<void>.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return RichText(
                  text: TextSpan(
                    text: 'Pozostało: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text:
                            '${trace.timeLeft.inHours}:${trace.timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0')}:${trace.timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
            trailing: Icon(Icons.location_on),
          ),
        ),
      ),
    );
  }
}
