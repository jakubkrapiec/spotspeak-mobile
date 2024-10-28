import 'package:dio/dio.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

class AuthInterceptor extends Interceptor {
  late final _authService = getIt<AuthenticationService>();

  static const _hostsWithAuth = ['keycloakspotspeakwebsite.website'];

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_hostsWithAuth.contains(options.uri.host)) {
      final token = await _authService.accessToken;
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    return handler.next(options);
  }
}
