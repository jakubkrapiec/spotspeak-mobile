import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_button.dart';

@RoutePage()
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/default_icon.jpg',
            ),
          ),
          Text('Username', style: Theme.of(context).textTheme.bodyLarge),
          Text('2137 pkt', style: Theme.of(context).textTheme.bodySmall),
          ProfileButton(
            pressFunction: () {
              context.router.push(const FriendsRoute());
            },
            buttonText: 'Lista znajomych',
          ),
          ProfileButton(pressFunction: () {}, buttonText: 'Dodane ślady'),
          ProfileButton(
            pressFunction: () {
              context.router.push(const AccountSettingsRoute());
            },
            buttonText: 'Ustawienia konta',
          ),
          ProfileButton(
            pressFunction: () {
              context.router.push(const AppSettingsRoute());
            },
            buttonText: 'Ustawienia aplikacji',
          ),
          TextButton(
            child: Text('Wyloguj się', style: Theme.of(context).textTheme.labelMedium),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
