import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _authService = getIt<AuthenticationService>();

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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color:
                      MediaQuery.platformBrightnessOf(context) == Brightness.light ? Colors.white : CustomColors.grey5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Zaloguj się do aplikacji:',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await _authService.login();
                            } catch (e) {
                              debugPrint('Error: $e');
                            }
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
                context.router.push(const HomeRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
