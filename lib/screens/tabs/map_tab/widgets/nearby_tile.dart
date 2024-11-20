import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class NearbyTile extends StatelessWidget {
  NearbyTile({required this.trace, super.key});

  final _appService = getIt<AppService>();

  final TraceLocation trace;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
        child: ListTile(
          onTap: () {},
          leading: Image.asset(
            _appService.isDarkMode(context) ? 'assets/trace_icon_white.png' : 'assets/trace_icon.png',
          ),
          title: Text('900 m'),
          trailing: IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
