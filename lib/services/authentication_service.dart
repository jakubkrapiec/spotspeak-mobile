import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/models/auth_user.dart';

abstract interface class AuthenticationService {
  ValueStream<AuthUser> get user;
  Future<String?> get accessToken;
  ValueNotifier<UserType> get userTypeNotifier;
  LoginInfo get logininfo;
  Future<AuthResult> init();
  Future<AuthUser> login();
  Future<void> logout();
  Future<AuthUser> getUserDetails(String accessToken);
  void dispose();
}

class LoginInfo extends ChangeNotifier {
  var _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

enum AuthResult { success, mustLogIn, error }

enum UserType { guest, google, normal }
