import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/screens/login/login_widget.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({required this.screen, super.key});

  final ScreenType screen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Aby móc korzystać z tej funkcjonalności musisz zalogować się na swoje konto',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Gap(32),
          LoginWidget(),
        ],
      ),
    );
  }
}
