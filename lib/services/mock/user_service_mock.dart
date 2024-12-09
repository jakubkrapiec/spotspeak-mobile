import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@test
@Singleton(as: UserService)
class UserServiceMock implements UserService {
  UserServiceMock(this.userRepo);

  @override
  final UserRepository userRepo;

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
  ValueStream<User> get user => Stream.value(_user).shareValue();

  @override
  Future<User> syncUser() async => _user;

  @override
  Future<void> uploadProfilePicture(File file) async {}
}
