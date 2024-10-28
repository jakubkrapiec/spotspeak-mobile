import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = getIt<AuthenticationService>();

  Future<void> _tryReathenticate() async {
    try {
      await _authService.accessToken;
      if (mounted) {
        unawaited(context.router.replace(HomeRoute()));
      }
    } catch (e) {
      if (mounted) {
        unawaited(context.router.replace(LoginRoute()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tryReathenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
