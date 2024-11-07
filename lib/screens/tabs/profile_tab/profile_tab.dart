import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/guest_screen/guest_screen.dart';
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
  final _authService = getIt<AuthenticationService>();

  final _userService = getIt<UserService>();

  Future<void> _logoutUser() async {
    try {
      await _authService.logout();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, _) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.profile)
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder<User>(
                      stream: _userService.user,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data?.profilePictureUrl != null &&
                            snapshot.data!.profilePictureUrl!.isNotEmpty) {
                          return SizedBox(
                            width: 200,
                            height: 200,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.profilePictureUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, _) => Image.asset('assets/default_icon.jpg'),
                              ),
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Image.asset(
                              'assets/default_icon.jpg',
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                    StreamBuilder<User>(
                      stream: _userService.user,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data?.username ?? 'Nieznany',
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                      },
                    ),
                    Text('2137 pkt', style: Theme.of(context).textTheme.bodySmall),
                    ProfileButton(
                      pressFunction: () {
                        context.router.push(FriendsRoute());
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
                      onPressed: () async {
                        await _logoutUser();
                        if (!context.mounted) return;
                        unawaited(context.router.replace(LoginRoute()));
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}
