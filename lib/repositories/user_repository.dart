import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/edit_user_dto.dart';
import 'package:spotspeak_mobile/dtos/password_challenge_dto.dart';
import 'package:spotspeak_mobile/dtos/update_password_dto.dart';
import 'package:spotspeak_mobile/models/user.dart';

part 'user_repository.g.dart';

@singleton
@RestApi(baseUrl: '/api/users/me')
abstract class UserRepository {
  @factoryMethod
  factory UserRepository(Dio dio) = _UserRepository;

  @GET('')
  Future<User> getUser();

  @PUT('')
  Future<void> updateUser(
    @Body() EditUserDto editUserDto,
  );

  @DELETE('')
  Future<void> deleteUser();

  @PUT('/update-password')
  Future<void> updatePassword(
    @Body() UpdatePasswordDto updatePasswordDto,
  );

  @POST('/picture')
  @MultiPart()
  Future<void> addPicture(@Body() FormData data);

  @DELETE('/picture')
  @MultiPart()
  Future<void> deletePicture();

  @PUT('/fcm-token')
  Future<void> updatefCMToken(
    @Body() String fcmToken,
  );
}

extension UserRepositoryX on UserRepository {
  Future<PasswordChallengeResult> checkPassword(String password) async {
    final dio = getIt<Dio>();
    final response = await dio.post<Map<String, Object?>>(
      '/users/me/generate-challenge',
      data: jsonEncode({
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final dto = PasswordChallengeDto.fromJson(response.data!);
      return PasswordChallengeSuccess(dto.token);
    } else if (response.statusCode == 403) {
      return PasswordChallengeFailedWrongPassword();
    } else {
      return PasswordChallengeFailedOtherError();
    }
  }
}

abstract class PasswordChallengeResult {}

class PasswordChallengeFailedWrongPassword extends PasswordChallengeResult {}

class PasswordChallengeFailedOtherError extends PasswordChallengeResult {}

class PasswordChallengeSuccess extends PasswordChallengeResult {
  PasswordChallengeSuccess(this.token);
  final String token;
}
