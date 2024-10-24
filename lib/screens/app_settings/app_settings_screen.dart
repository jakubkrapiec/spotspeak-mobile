import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/change_data/change_app_data_screen.dart';
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_button.dart';

@RoutePage()
class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ustawienia aplikacji'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAppDataRoute(appData: AppData.notifications));
              },
              buttonText: 'Ustawienia powiadomień',
            ),
            Gap(16),
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAppDataRoute(appData: AppData.appTheme));
              },
              buttonText: 'Motyw aplikacji',
            ),
          ],
        ),
      ),
    );
  }
}
