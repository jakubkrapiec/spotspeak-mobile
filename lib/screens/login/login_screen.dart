import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? CustomColors.backgroundGradientLight
            : CustomColors.backgroundGradientDark,
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: 350,
              height: 350,
              child: SvgPicture.asset('assets/SPOT.svg'),
            ),
            Text(
              'Zacznijmy wspólną przygodę!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color:
                      MediaQuery.platformBrightnessOf(context) == Brightness.light ? Colors.white : CustomColors.grey5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Zaloguj się do aplikacji:',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {},
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
