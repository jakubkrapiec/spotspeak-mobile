import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/login/login_widget.dart';
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
            LoginWidget(),
            TextButton(
              child: const Text('Kontynuuj jako gość', textAlign: TextAlign.start),
              onPressed: () {
                context.router.replace(HomeRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
