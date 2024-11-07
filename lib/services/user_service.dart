import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';

@singleton
class UserService {
  UserService(this.userRepo);
  final UserRepository userRepo;

  final _userController = BehaviorSubject<User>();

  ValueStream<User> get user => _userController.stream;

  Future<User> syncUser() async {
    final user = await userRepo.getUser();
    _userController.add(user);
    return user;
  }

  Future<void> uploadProfilePicture(File file) async {
    final dio = getIt<Dio>();
    final formData = FormData();

    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.path.split(Platform.pathSeparator).last,
      contentType: MediaType.parse(lookupMimeType(file.path)!),
    );

    formData.files.add(MapEntry('file', multipartFile));

    await UserRepository(dio).addPicture(formData);
  }
}
