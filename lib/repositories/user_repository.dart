import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
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
  Future<void> editUser();

  @DELETE('')
  Future<void> deleteUser();

  @PUT('/update-password')
  Future<void> updatePassword(
    @Query('currentPassword') String currentPassword,
    @Query('newPassword') String newPassword,
  );

  // @POST('/picture')
  // @MultiPart()
  // Future<void> addPicture(
  //   @Part(name: 'file') MultipartFile file,
  // );

  @POST('/picture')
  Future<void> addPicture(@Part(name: 'file') File file);

  @DELETE('/picture')
  @MultiPart()
  Future<void> deletePicture();
}
