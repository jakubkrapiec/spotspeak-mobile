import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/screens/guest_screen/guest_screen.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

@RoutePage()
class AchievementsTab extends StatelessWidget {
  AchievementsTab({super.key});

  final _authService = getIt<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, _) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.achievements)
            : Container(
                child: Text('User Content'),
              );
      },
    );
  }
}
