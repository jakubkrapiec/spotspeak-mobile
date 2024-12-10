import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({this.isFirstLogin = false, super.key});

  final bool isFirstLogin;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _authService = getIt<AuthenticationService>();
  final _userService = getIt<UserService>();
  final _appService = getIt<AppService>();

  bool _isLoading = false;

  Future<void> _logIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _authService.login();
      await _userService.syncUser();
      if (widget.isFirstLogin && mounted) {
        unawaited(context.router.replace(HomeRoute()));
      }
    } finally {
      if (context.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: _appService.isDarkMode(context)
            ? CustomTheme.darkContainerStyle.copyWith(color: CustomColors.grey6)
            : CustomTheme.lightContainerStyle.copyWith(color: Colors.white),
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
                  onPressed: _logIn,
                  child: _isLoading
                      ? Center(child: SizedBox.square(dimension: 16, child: CircularProgressIndicator()))
                      : Center(
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            child: Text('Logowanie'),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
