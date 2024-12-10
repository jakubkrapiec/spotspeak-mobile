import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/notification_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = getIt<AuthenticationService>();

  final _userService = getIt<UserService>();

  final _notificationService = getIt<NotificationService>();

  Future<void> _tryReathenticate() async {
    setState(() {
      _networkError = false;
    });
    try {
      final accessToken = await _authService.accessToken;
      if (accessToken != null) {
        await _userService.syncUser();
        unawaited(_notificationService.initNotifications());
        if (mounted) {
          unawaited(context.router.replace(HomeRoute()));
        }
      } else {
        if (mounted) {
          unawaited(context.router.replace(LoginRoute()));
        }
      }
    } catch (e, st) {
      debugPrint('$e\n$st');
      if (e is FlutterAppAuthPlatformException && e.platformErrorDetails.code == '3') {
        if (mounted) {
          setState(() {
            _networkError = true;
          });
        }
      } else {
        if (mounted) {
          unawaited(context.router.replace(LoginRoute()));
        }
      }
    }
  }

  bool _networkError = false;

  @override
  void initState() {
    super.initState();
    _tryReathenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _networkError
            ? LoadingError(
                onRetry: _tryReathenticate,
                title: 'Brak połączenia z internetem',
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
