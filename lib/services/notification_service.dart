import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@singleton
class NotificationService {
  NotificationService() {
    // _initNotifications();
  }

  final _firebaseMessaging = FirebaseMessaging.instance;
  late final AppRouter appRouter;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    debugPrint('Token: $fCMToken');
    if (fCMToken != null) {
      await getIt<UserService>().userRepo.updatefCMToken(FcmTokenDto(fcmToken: fCMToken));
    }

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }
}

@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage remoteMessage) async {
  debugPrint('title: ${remoteMessage.notification?.title}');
  debugPrint('body: ${remoteMessage.notification?.body}');
  debugPrint('Payload: ${remoteMessage.data}');

  final deepLink = remoteMessage.data['deep_link'] as String;

  final uri = Uri.parse(deepLink);
  await getIt<NotificationService>().appRouter.pushNamed(uri.path);
}
