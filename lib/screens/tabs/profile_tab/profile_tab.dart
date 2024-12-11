import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, child) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.profile)
            : RefreshIndicator(
                onRefresh: _userService.syncUser,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Gap(32),
                      Center(
                        child: StreamBuilder<User>(
                          stream: _userService.user,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasData &&
                                snapshot.data?.profilePictureUrl != null &&
                                snapshot.data!.profilePictureUrl!.isNotEmpty) {
                              return SizedBox.square(
                                dimension: 200,
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
                      ),
                      const Gap(32),
                      StreamBuilder<User>(
                        stream: _userService.user,
                        builder: (context, snapshot) {
                          return AutoSizeText(
                            snapshot.data?.username ?? 'Nieznany',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      const Gap(16),
                      StreamBuilder<User>(
                        stream: _userService.user,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data?.totalPoints != null ? '${snapshot.data?.totalPoints} pkt' : '0 pkt',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      const Gap(32),
                      ProfileButton(
                        pressFunction: () {
                          context.router.push(UserTracesRoute());
                        },
                        buttonText: 'Dodane ślady',
                      ),
                      const Gap(16),
                      ProfileButton(
                        pressFunction: () {
                          context.router.push(AccountSettingsRoute());
                        },
                        buttonText: 'Ustawienia konta',
                      ),
                      const Gap(16),
                      ProfileButton(
                        pressFunction: () {
                          context.router.push(const AppSettingsRoute());
                        },
                        buttonText: 'Ustawienia aplikacji',
                      ),
                      const Gap(32),
                      TextButton(
                        child: Text('Wyloguj się', style: Theme.of(context).textTheme.labelMedium),
                        onPressed: () async {
                          await _authService.logout();
                          if (!context.mounted) return;
                          unawaited(context.router.replace(LoginRoute()));
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
