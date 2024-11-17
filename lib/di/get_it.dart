import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:spotspeak_mobile/constants.dart';
import 'package:spotspeak_mobile/di/custom_instance_names.dart';

import 'package:spotspeak_mobile/di/get_it.config.dart';
import 'package:spotspeak_mobile/misc/auth_interceptor.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @injectable
  Dio dio(PackageInfo packageInfo) {
    final dio = Dio(
      BaseOptions(
        baseUrl: kApiBaseUrl,
        headers: {HttpHeaders.userAgentHeader: 'SpotSpeakMobile/${packageInfo.version}'},
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true, maxWidth: 120),
      );
    }
    dio.interceptors.add(AuthInterceptor());
    return dio;
  }

  @preResolve
  @singleton
  @Named(dioForOSMInstanceName)
  Future<Dio> get dioForOSM async {
    final packageInfo = await PackageInfo.fromPlatform();
    final dio = Dio(BaseOptions(headers: {HttpHeaders.userAgentHeader: 'SpotSpeakMobile/${packageInfo.version}'}))
      ..httpClientAdapter = Http2Adapter(ConnectionManager());
    return dio;
  }

  @singleton
  FlutterAppAuth get flutterAppAuth => FlutterAppAuth();

  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  @preResolve
  @singleton
  @Named(documentsDirInstanceName)
  Future<Directory> get documentsDir => getApplicationDocumentsDirectory();

  @singleton
  DbCacheStore dbCacheStore(@Named(documentsDirInstanceName) Directory documentsDir) =>
      DbCacheStore(databasePath: documentsDir.path);

  @preResolve
  @singleton
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
}
