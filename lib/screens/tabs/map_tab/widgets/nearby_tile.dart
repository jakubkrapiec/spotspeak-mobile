import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class NearbyTile extends StatelessWidget {
  const NearbyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? CustomTheme.lightContainerStyle
            : CustomTheme.darkContainerStyle,
        child: ListTile(
          onTap: () {},
          leading: Image.asset(
            MediaQuery.platformBrightnessOf(context) == Brightness.light
                ? 'assets/trace_icon.png'
                : 'assets/trace_icon_white.png',
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
