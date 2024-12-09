import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/dtos/edit_user_dto.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/dtos/notification_settings_dto.dart';
import 'package:spotspeak_mobile/dtos/update_password_dto.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';

@test
@Singleton(as: UserRepository)
class UserRepositoryMock implements UserRepository {
  final _user = User(
    id: '1',
    email: 'test@gmail.com',
    firstName: 'Test',
    lastName: 'User',
    username: 'testuser',
    profilePictureUrl: 'https://picsum.photos/100/100',
    totalPoints: 100,
  );

  @override
  Future<User> getUser() async => _user;

  @override
  Future<void> updateUser(EditUserDto editUserDto) => throw UnimplementedError();

  @override
  Future<void> deleteUser() => Future.value();

  @override
  Future<void> updatePassword(UpdatePasswordDto updatePasswordDto) => Future.value();

  @override
  Future<void> addPicture(FormData data) => throw UnimplementedError();

  @override
  Future<void> updateFCMToken(FcmTokenDto fcmTokenDto) => Future.value();

  @override
  Future<void> updateNotificationPreferences(NotificationSettingsDto notificationSettingsDto) => Future.value();
}
