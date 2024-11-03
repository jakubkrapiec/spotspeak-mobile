import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/auth_user.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_button.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@RoutePage()
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  //final _authService = getIt<AuthenticationService>();

  final _userService = getIt<UserService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder<User>(
            stream: _userService.user,
            builder: (context, snapshot) {
              return ClipOval(
                child: Image.asset(
                  snapshot.data?.profilePictureUrl ?? 'assets/default_icon.jpg',
                ),
              );
            },
          ),
          StreamBuilder<User>(
            stream: _userService.user,
            builder: (context, snapshot) {
              return Text(snapshot.data?.username ?? 'Nieznany', style: Theme.of(context).textTheme.bodyLarge);
            },
          ),
          Text('2137 pkt', style: Theme.of(context).textTheme.bodySmall),
          ProfileButton(
            pressFunction: () {
              context.router.push(const FriendsRoute());
            },
            buttonText: 'Lista znajomych',
          ),
          ProfileButton(
            pressFunction: () {
              context.router.push(const UserTracesRoute());
            },
            buttonText: 'Dodane ślady',
          ),
          ProfileButton(
            pressFunction: () {
              context.router.push(AccountSettingsRoute());
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
              context.router.replace(LoginRoute());
            },
          ),
        ],
      ),
    );
  }
}
