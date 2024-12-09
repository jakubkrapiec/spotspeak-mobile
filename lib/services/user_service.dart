import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';

abstract interface class UserService {
  UserRepository get userRepo;
  ValueStream<User> get user;
  Future<User> syncUser();
  Future<void> uploadProfilePicture(File file);
}
