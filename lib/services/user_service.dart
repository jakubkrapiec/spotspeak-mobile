import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
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
}
