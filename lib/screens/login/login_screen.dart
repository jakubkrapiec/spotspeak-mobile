import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/login/login_widget.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _appService.isDarkMode(context)
            ? CustomColors.backgroundGradientDark
            : CustomColors.backgroundGradientLight,
        child: SingleChildScrollView(
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
              LoginWidget(isFirstLogin: true),
              TextButton(
                child: const Text('Kontynuuj jako gość', textAlign: TextAlign.start),
                onPressed: () => context.router.replace(HomeRoute()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
