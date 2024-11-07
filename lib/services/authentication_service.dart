import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotspeak_mobile/misc/auth_constants.dart';
import 'package:spotspeak_mobile/models/auth_id_token.dart';
import 'package:spotspeak_mobile/models/auth_user.dart';

@singleton
class AuthenticationService {
  AuthenticationService(this._dio, this._appAuth, this._secureStoreage);

  final Dio _dio;
  final FlutterAppAuth _appAuth;
  final FlutterSecureStorage _secureStoreage;

  final _userController = BehaviorSubject<AuthUser>();

  ValueStream<AuthUser> get user => _userController.stream;

  final _loginInfo = LoginInfo();

  // UserType userType = UserType.guest;

  ValueNotifier<UserType> userTypeNotifier = ValueNotifier<UserType>(UserType.guest);

  Future<String?> get accessToken async {
    if (_tokenExpirationTimestamp != null && _tokenExpirationTimestamp!.isAfter(DateTime.now())) {
      return _accessToken;
    }
    final securedRefreshToken = await _secureStoreage.read(key: kAuthRefreshTokenKey);

    final response = await _appAuth.token(
      TokenRequest(
        kAuthClientId,
        kAuthRedirectUri,
        clientSecret: kAuthClientSecret,
        issuer: kAuthIssuer,
        refreshToken: securedRefreshToken,
      ),
    );

    if (await _setLocalVariables(response)) {
      return _accessToken;
    } else {
      return null;
    }
  }

  String? _accessToken;
  //AuthIdToken? _authIdToken;
  String? _idTokenRaw;
  DateTime? _tokenExpirationTimestamp;

  LoginInfo get logininfo => _loginInfo;

  Future<AuthResult> init() async {
    final securedRefreshToken = await _secureStoreage.read(key: kAuthRefreshTokenKey);

    if (securedRefreshToken == null) {
      return AuthResult.mustLogIn;
    }

    TokenResponse? response;
    try {
      response = await _appAuth.token(
        TokenRequest(
          kAuthClientId,
          kAuthRedirectUri,
          clientSecret: kAuthClientSecret,
          issuer: kAuthIssuer,
          refreshToken: securedRefreshToken,
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == 'token_failed') {
        return AuthResult.mustLogIn;
      }
    }

    if (response == null) {
      return AuthResult.error;
    }

    if (await _setLocalVariables(response)) {
      return AuthResult.success;
    } else {
      return AuthResult.mustLogIn;
    }
  }

  bool _isAuthResultValid(TokenResponse? response) => response?.accessToken != null && response?.idToken != null;

  Future<bool> _setLocalVariables(TokenResponse? result) async {
    if (_isAuthResultValid(result)) {
      _accessToken = result!.accessToken;
      _idTokenRaw = result.idToken;
      _tokenExpirationTimestamp = result.accessTokenExpirationDateTime;
      //_authIdToken = _parseIdToken(_idTokenRaw!);

      final profile = await getUserDetails(_accessToken!);
      _userController.add(profile);

      if (result.refreshToken != null) {
        await _secureStoreage.write(key: kAuthRefreshTokenKey, value: result.refreshToken);
      }

      _loginInfo.isLoggedIn = true;

      return true;
    }

    return false;
  }

  Future<AuthUser> login() async {
    final authorizationTokenRequest = AuthorizationTokenRequest(
      'flutter-frontend',
      kAuthRedirectUri,
      clientSecret: kAuthClientSecret,
      issuer: kAuthIssuer,
      scopes: ['openid', 'profile', 'email', 'offline_access'],
      promptValues: ['login'],
    );

    final result = await _appAuth.authorizeAndExchangeCode(authorizationTokenRequest);

    if (await _setLocalVariables(result)) {
      final authUser = await getUserDetails(_accessToken!);
      userTypeNotifier.value = UserType.normal;
      // userType = UserType.normal;
      return authUser;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    _loginInfo.isLoggedIn = false;
    userTypeNotifier.value = UserType.guest;
    // userType = UserType.guest;
    await _secureStoreage.delete(key: kAuthRefreshTokenKey);

    final request = EndSessionRequest(
      idTokenHint: _idTokenRaw,
      issuer: kAuthIssuer,
      postLogoutRedirectUrl: kLogoutRedirectUri,
    );

    await _appAuth.endSession(request);
    _loginInfo.isLoggedIn = false;
    // userType = UserType.guest;
  }

  AuthIdToken _parseIdToken(String idToken) {
    final parts = idToken.split('.');

    final Map<String, dynamic> json =
        jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))) as Map<String, Object?>;

    return AuthIdToken.fromJson(json);
  }

  Future<AuthUser> getUserDetails(String accessToken) async {
    final url = Uri.https(kAuthDomain, '/realms/$kAuthRealms/protocol/openid-connect/userinfo');

    final response = await _dio.get<String>(url.toString());

    if (response.statusCode == 200) {
      final user = AuthUser.fromJson(jsonDecode(response.data!) as Map<String, Object?>);
      _userController.add(user);
      return user;
    } else {
      throw Exception('Failed to get user details');
    }
  }

  @disposeMethod
  void dispose() {
    _userController.close();
  }
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
