import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/services/notification_service.dart';

@test
@Singleton(as: NotificationService)
class NotificationServiceMock implements NotificationService {
  const NotificationServiceMock();

  @override
  Future<void> initNotifications() async {}

  @override
  Future<void> updateFCMToken() async {}
}
