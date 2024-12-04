import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/notification_settings_dto.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@RoutePage()
class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  final _appService = getIt<AppService>();
  final _userService = getIt<UserService>();

  late ThemeMode themeMode = _appService.themeMode;

  // late bool areNotificationsAllowed = _userService.user.value.receiveNotifications ?? true;

  // @override
  // void initState() {
  //   super.initState();
  //   areNotificationsAllowed = _userService.user.value.receiveNotifications ?? true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ustawienia aplikacji'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ustawienia motywu aplikacji:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gap(8),
            Divider(),
            Gap(16),
            RadioListTile<ThemeMode>(
              title: const Text('Zgodnie z systemem'),
              value: ThemeMode.system,
              groupValue: _appService.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  setState(() {
                    _appService.themeModeNotifier.value = value;
                  });
                }
              },
            ),
            Gap(16),
            RadioListTile<ThemeMode>(
              title: const Text('Jasny motyw'),
              value: ThemeMode.light,
              groupValue: _appService.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  setState(() {
                    _appService.themeModeNotifier.value = value;
                  });
                }
              },
            ),
            Gap(16),
            RadioListTile<ThemeMode>(
              title: const Text('Ciemny motyw'),
              value: ThemeMode.dark,
              groupValue: _appService.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  setState(() {
                    _appService.themeModeNotifier.value = value;
                  });
                }
              },
            ),
            Gap(32),
            Text(
              'Ustawienia powiadomień:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gap(8),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Wszystkie powiadomienia'),
                Switch(
                  value: _userService.user.value.receiveNotifications ?? true,
                  onChanged: (bool value) async {
                    await _userService.userRepo
                        .updateNotificationPreferences(NotificationSettingsDto(receiveNotifications: value));
                    await _userService.syncUser();
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
