import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@Singleton(as: UserService)
class UserServiceImpl implements UserService {
  UserServiceImpl(this.userRepo);

  @override
  final UserRepository userRepo;

  final _userController = BehaviorSubject<User>();

  @override
  ValueStream<User> get user => _userController.stream;

  @override
  Future<User> syncUser() async {
    final user = await userRepo.getUser();
    _userController.add(user);
    return user;
  }

  @override
  Future<void> uploadProfilePicture(File file) async {
    final formData = FormData();

    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.path.split(Platform.pathSeparator).last,
      contentType: MediaType.parse(lookupMimeType(file.path)!),
    );

    formData.files.add(MapEntry('file', multipartFile));

    await userRepo.addPicture(formData);
  }
}
