import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/services/notification_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@prod
@Singleton(as: NotificationService)
class NotificationServiceImpl implements NotificationService {
  NotificationServiceImpl(this._userService, this._appRouter);

  final _firebaseMessaging = FirebaseMessaging.instance;
  final UserService _userService;
  final AppRouter _appRouter;

  @override
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    debugPrint('Token: $fCMToken');
    if (fCMToken != null) {
      await _userService.userRepo.updateFCMToken(FcmTokenDto(fcmToken: fCMToken));
    }

    final initialMessage = await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
  }

  @override
  Future<void> updateFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      await _userService.userRepo.updateFCMToken(FcmTokenDto(fcmToken: token));
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    final deepLink = message.data['deep_link'] as String;
    final uri = Uri.parse(deepLink);
    final fullPath = uri.path + (uri.hasQuery ? '?${uri.query}' : '');
    _appRouter.pushNamed(fullPath);
  }
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('title: ${message.notification?.title}');
  debugPrint('body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
}

void _handleForegroundNotification(RemoteMessage message) {
  debugPrint('Foreground Notification Received:');
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Data: ${message.data}');

  _showInAppNotification(message);
}

void _showInAppNotification(RemoteMessage message) {
  Fluttertoast.showToast(
    msg: message.notification?.title ?? 'Nowe powiadomienie',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    fontSize: 18,
    backgroundColor: CustomColors.grey1,
    textColor: CustomColors.grey6,
  );
}
