import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _authService = getIt<AuthenticationService>();
  final _userService = getIt<UserService>();

  Future<void> _loginUser() async {
    try {
      await _authService.login();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _getUserAccount() async {
    try {
      await _userService.syncUser();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? CustomColors.backgroundGradientLight
            : CustomColors.backgroundGradientDark,
        child: Column(
          children: [
            const Gap(50),
            SizedBox.square(
              dimension: 350,
              child: SvgPicture.asset('assets/SPOT.svg'),
            ),
            Text(
              'Zacznijmy wspólną przygodę!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Container(
                width: double.infinity,
                decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
                    ? CustomTheme.lightContainerStyle.copyWith(color: Colors.white)
                    : CustomTheme.darkContainerStyle.copyWith(color: CustomColors.grey5),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Zaloguj się do aplikacji:',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () async {
                            await _loginUser();
                            await _getUserAccount();
                            if (!context.mounted) return;
                            unawaited(context.router.replace(HomeRoute()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                            child: Text('Logowanie'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              child: const Text('Kontynuuj jako gość', textAlign: TextAlign.start),
              onPressed: () {
                context.router.replace(const HomeRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
