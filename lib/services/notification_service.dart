import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@singleton
class NotificationService {
  NotificationService() {
    _initNotifications();
  }

  final _firebaseMessaging = FirebaseMessaging.instance;
  late final AppRouter appRouter;

  Future<void> _initNotifications() async {
    await _firebaseMessaging.requestPermission(provisional: true);
    final fCMToken = await _firebaseMessaging.getToken();

    debugPrint('Token: $fCMToken');
    if (fCMToken != null) {
      await getIt<UserService>().userRepo.updatefCMToken(fCMToken);
    }

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }
}

Future<void> _handleBackgroundMessage(RemoteMessage remoteMessage) async {
  debugPrint('title: ${remoteMessage.notification?.title}');
  debugPrint('body: ${remoteMessage.notification?.body}');
  debugPrint('Payload: ${remoteMessage.data}');

  final deepLink = remoteMessage.data['deep_link'];
  if (deepLink != null) {
    final uri = Uri.parse(deepLink as String);

    //   final urlState = UrlState(uri);

    // // Create the PlatformDeepLink object using the private constructor and passing UrlState and initial flag
    // final platformDeepLink = PlatformDeepLink._(urlState, true); // Set 'initial' flag to true for initial deep link

    // getIt<NotificationService>().appRouter.deepLinkBuilder(uri);
  }
}
