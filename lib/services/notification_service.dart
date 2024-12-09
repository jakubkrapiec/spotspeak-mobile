import 'dart:async';

abstract interface class NotificationService {
  Future<void> initNotifications();
  Future<void> updateFCMToken();
}
