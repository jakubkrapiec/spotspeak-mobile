import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/models/auth_user.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/notification_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@test
@Singleton(as: AuthenticationService)
class AuthenticationServiceMock implements AuthenticationService {
  AuthenticationServiceMock(this._notificationService, this._userService);

  final NotificationService _notificationService;
  final UserService _userService;

  final _userController = BehaviorSubject<AuthUser>();

  @override
  ValueStream<AuthUser> get user => _userController.stream;

  final _loginInfo = LoginInfo();

  @override
  final userTypeNotifier = ValueNotifier<UserType>(UserType.guest);

  @override
  Future<String?> get accessToken async {
    if (_tokenExpirationTimestamp != null && _tokenExpirationTimestamp!.isAfter(DateTime.now())) {
      return _accessToken;
    }
    return null;
  }

  String? _accessToken;
  //AuthIdToken? _authIdToken;
  DateTime? _tokenExpirationTimestamp;

  @override
  LoginInfo get logininfo => _loginInfo;

  @override
  Future<AuthResult> init() async {
    return AuthResult.mustLogIn;
  }

  bool _isAuthResultValid(TokenResponse? response) => true;

  Future<bool> _setLocalVariables(TokenResponse? result) async {
    if (_isAuthResultValid(result)) {
      _accessToken = 'token';
      _tokenExpirationTimestamp = DateTime.now().add(Duration(days: 1000));

      final profile = await getUserDetails(_accessToken!);
      _userController.add(profile);

      userTypeNotifier.value = profile.identityProvider == null ? UserType.normal : UserType.google;

      _loginInfo.isLoggedIn = true;

      return true;
    }

    return false;
  }

  @override
  Future<AuthUser> login() async {
    if (await _setLocalVariables(
      TokenResponse('', '', DateTime.now().add(const Duration(days: 1000)), '', '', [], {}),
    )) {
      final authUser = await getUserDetails(_accessToken!);
      await _notificationService.updateFCMToken();
      return authUser;
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<void> logout() async {
    await _userService.userRepo.updateFCMToken(FcmTokenDto(fcmToken: null));
    userTypeNotifier.value = UserType.guest;
    _loginInfo.isLoggedIn = false;
  }

  @override
  Future<AuthUser> getUserDetails(String accessToken) async =>
      AuthUser(sub: '', name: 'Test Test', email: 'test@gmail.com');

  @override
  @disposeMethod
  void dispose() {}
}
