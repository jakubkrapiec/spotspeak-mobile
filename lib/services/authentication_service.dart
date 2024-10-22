import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/auth_constants.dart';
import 'package:spotspeak_mobile/models/auth_id_token.dart';
import 'package:spotspeak_mobile/models/auth_user.dart';

@singleton
class AuthenticationService {
  final _loginInfo = LoginInfo();

  Future<String?> get accessToken async {
    if (tokenExpirationTimestamp != null && tokenExpirationTimestamp!.isAfter(DateTime.now())) {
      return _accessToken;
    }
    final securedRefreshToken = await secureStoreage.read(key: kAuthRefreshTokenKey);

    final response = await appAuth.token(
      TokenRequest(
        kAuthClientId,
        kAuthRedirectUri,
        clientSecret: kAuthClientSecret,
        issuer: kAuthIssuer,
        refreshToken: securedRefreshToken,
      ),
    );

    return _setLocalVariables(response);
  }

  String? _accessToken;
  AuthIdToken? authIdToken;
  String? idTokenRaw;
  AuthUser? profile;
  DateTime? tokenExpirationTimestamp;
  final _dio = getIt<Dio>();

  LoginInfo get logininfo => _loginInfo;

  final appAuth = FlutterAppAuth();

  final secureStoreage = FlutterSecureStorage();

  Future<String> init() async {
    return errorHandler(() async {
      final securedRefreshToken = await secureStoreage.read(key: kAuthRefreshTokenKey);

      if (securedRefreshToken == null) {
        return 'You need to login!';
      }

      final response = await appAuth.token(
        TokenRequest(
          kAuthClientId,
          kAuthRedirectUri,
          clientSecret: kAuthClientSecret,
          issuer: kAuthIssuer,
          refreshToken: securedRefreshToken,
        ),
      );

      return _setLocalVariables(response);
    });
  }

  bool isAuthResultValid(TokenResponse? response) => response?.accessToken != null && response?.idToken != null;

  Future<String> _setLocalVariables(TokenResponse? result) async {
    if (isAuthResultValid(result)) {
      _accessToken = result!.accessToken;
      idTokenRaw = result.idToken;
      tokenExpirationTimestamp = result.accessTokenExpirationDateTime;
      authIdToken = parseIdToken(idTokenRaw!);

      profile = await getUserDetails(_accessToken!);

      if (result.refreshToken != null) {
        await secureStoreage.write(key: kAuthRefreshTokenKey, value: result.refreshToken);
      }

      _loginInfo.isLoggedIn = true;

      return 'SUCCESS';
    }

    return 'Passing Token went wrong';
  }

  Future<String> errorHandler(Future<String> Function() callback) async {
    try {
      return callback();
    } on TimeoutException catch (e) {
      return e.message ?? 'Timeout error';
    } on FormatException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message ?? 'Unknown platform exception';
    } catch (e) {
      return 'Unknown error ${e.runtimeType}';
    }
  }

  Future<String> login() async {
    return errorHandler(() async {
      final authorizationTokenRequest = AuthorizationTokenRequest(
        'flutter-frontend',
        kAuthRedirectUri,
        clientSecret: kAuthClientSecret,
        issuer: kAuthIssuer,
        scopes: ['openid', 'profile', 'email', 'offline_access'],
        promptValues: ['login'],
      );

      final result = await appAuth.authorizeAndExchangeCode(authorizationTokenRequest);

      return _setLocalVariables(result);
    });
  }

  Future<void> logout() async {
    _loginInfo.isLoggedIn = false;
    await secureStoreage.delete(key: kAuthRefreshTokenKey);

    final request = EndSessionRequest(
      idTokenHint: idTokenRaw,
      issuer: kAuthIssuer,
      postLogoutRedirectUrl: kLogoutRedirectUri,
    );

    await appAuth.endSession(request);
    _loginInfo.isLoggedIn = false;
  }

  AuthIdToken parseIdToken(String idToken) {
    final parts = idToken.split('.');

    final Map<String, dynamic> json =
        jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))) as Map<String, Object?>;

    return AuthIdToken.fromJson(json);
  }

  Future<AuthUser> getUserDetails(String accessToken) async {
    final url = Uri.https(kAuthDomain, '/realms/$kAuthRealms/protocol/openid-connect/userinfo');

    final response = await _dio.get<String>(url.toString());

    if (response.statusCode == 200) {
      return AuthUser.fromJson(jsonDecode(response.data!) as Map<String, Object?>);
    } else {
      throw Exception('Failed to get user details');
    }
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
