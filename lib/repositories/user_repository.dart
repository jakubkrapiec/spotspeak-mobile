import 'package:dio/dio.dart';
import 'package:spotspeak_mobile/dtos/edit_user_dto.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/dtos/notification_settings_dto.dart';
import 'package:spotspeak_mobile/dtos/update_password_dto.dart';
import 'package:spotspeak_mobile/models/user.dart';

abstract interface class UserRepository {
  Future<User> getUser();
  Future<void> updateUser(EditUserDto editUserDto);
  Future<void> deleteUser();
  Future<void> updatePassword(UpdatePasswordDto updatePasswordDto);
  Future<void> addPicture(FormData data);
  Future<void> updateFCMToken(FcmTokenDto fcmTokenDto);
  Future<void> updateNotificationPreferences(NotificationSettingsDto notificationSettingsDto);
}
