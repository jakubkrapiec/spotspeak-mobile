import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/dtos/fcm_token_dto.dart';
import 'package:spotspeak_mobile/misc/auth_constants.dart';
import 'package:spotspeak_mobile/models/auth_user.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

@test
@Singleton(as: AuthenticationService)
class AuthenticationServiceMock implements AuthenticationService {
  AuthenticationServiceMock(this._dio, this._userService);

  final Dio _dio;
  final UserService _userService;

  final _userController = BehaviorSubject<AuthUser>();

  @override
  ValueStream<AuthUser> get user => _userController.stream;

  final _loginInfo = LoginInfo();

  @override
  final userTypeNotifier = ValueNotifier<UserType>(UserType.guest);

  @override
  Future<String?> get accessToken async => _accessToken;

  String? _accessToken;

  @override
  LoginInfo get logininfo => _loginInfo;

  @override
  Future<AuthResult> init() async => AuthResult.mustLogIn;

  @override
  Future<AuthUser> login() async {
    final url = Uri.https(kAuthDomain, '/realms/$kAuthRealms/protocol/openid-connect/token');
    final response = await _dio.post<Map<String, Object?>>(
      url.toString(),
      data: {
        'client_id': 'flutter-frontend',
        'client_secret': kAuthClientSecret,
        'grant_type': 'password',
        'username': 'contact@jakubkrapiec.dev',
        'password': 'TestPassword12!',
        'scope': ['openid', 'profile', 'email', 'offline_access'].join(' '),
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final accessToken = response.data!['access_token']! as String;
    _accessToken = accessToken;
    final authUser = await getUserDetails(accessToken);
    return authUser;
  }

  @override
  Future<void> logout() async {
    await _userService.userRepo.updateFCMToken(FcmTokenDto(fcmToken: null));
    _loginInfo.isLoggedIn = false;
    userTypeNotifier.value = UserType.guest;
    _accessToken = null;
  }

  @override
  Future<AuthUser> getUserDetails(String accessToken) async {
    final url = Uri.https(kAuthDomain, '/realms/$kAuthRealms/protocol/openid-connect/userinfo');

    final response = await _dio.get<String>(url.toString());

    if (response.statusCode == 200) {
      final user = AuthUser.fromJson(jsonDecode(response.data!) as Map<String, Object?>);
      _userController.add(user);
      userTypeNotifier.value = UserType.normal;
      logininfo.isLoggedIn = true;
      return user;
    } else {
      throw Exception('Failed to get user details');
    }
  }

  @override
  @disposeMethod
  void dispose() {
    _userController.close();
    userTypeNotifier.dispose();
  }
}
