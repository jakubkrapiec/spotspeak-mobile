import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@singleton
class NotificationService {
  NotificationService();

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    debugPrint('Token: $fCMToken');
    if (fCMToken != null) {
      await getIt<UserService>().userRepo.updatefCMToken(FcmTokenDto(fcmToken: fCMToken));
    }

    // final initialMessage = await _firebaseMessaging.getInitialMessage();

    // if (initialMessage != null) {
    //   _handleNotificationTap(initialMessage);
    // }

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
  }
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('title: ${message.notification?.title}');
  debugPrint('body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
}

void _handleNotificationTap(RemoteMessage message) {
  final deepLink = message.data['deep_link'] as String;
  final uri = Uri.parse(deepLink);
  final fullPath = uri.path + (uri.hasQuery ? '?${uri.query}' : '');
  // if (fullPath.startsWith('/home')) {
  //   getIt<AppRouter>().replaceNamed(fullPath);
  // } else {
  getIt<AppRouter>().pushNamed(fullPath);
  // }
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
