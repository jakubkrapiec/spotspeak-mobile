import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/dtos/edit_user_dto.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/dtos/notification_settings_dto.dart';
import 'package:spotspeak_mobile/dtos/update_password_dto.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';

part 'user_repository_impl.g.dart';

@prod
@Singleton(as: UserRepository)
@RestApi(baseUrl: '/api/users/me')
abstract class UserRepositoryImpl implements UserRepository {
  @factoryMethod
  factory UserRepositoryImpl(Dio dio) = _UserRepositoryImpl;

  @override
  @GET('')
  Future<User> getUser();

  @override
  @PUT('')
  Future<void> updateUser(@Body() EditUserDto editUserDto);

  @override
  @DELETE('')
  Future<void> deleteUser();

  @override
  @PUT('/update-password')
  Future<void> updatePassword(@Body() UpdatePasswordDto updatePasswordDto);

  @override
  @POST('/picture')
  @MultiPart()
  Future<void> addPicture(@Body() FormData data);

  @override
  @PUT('/fcm-token')
  Future<void> updateFCMToken(@Body() FcmTokenDto fcmTokenDto);

  @override
  @PUT('/preferences/notifications')
  Future<void> updateNotificationPreferences(@Body() NotificationSettingsDto notificationSettingsDto);
}
