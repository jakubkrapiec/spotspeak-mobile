// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i497;

import 'package:dio/dio.dart' as _i361;
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart'
    as _i274;
import 'package:flutter_appauth/flutter_appauth.dart' as _i337;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:spotspeak_mobile/di/get_it.dart' as _i397;
import 'package:spotspeak_mobile/repositories/impl/user_repository_impl.dart'
    as _i307;
import 'package:spotspeak_mobile/repositories/user_repository.dart' as _i643;
import 'package:spotspeak_mobile/routing/app_router.dart' as _i457;
import 'package:spotspeak_mobile/screens/tabs/friends_tab/search_friends_tab/search_friends_bloc.dart'
    as _i868;
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab_bloc.dart'
    as _i722;
import 'package:spotspeak_mobile/services/achievement_service.dart' as _i77;
import 'package:spotspeak_mobile/services/app_service.dart' as _i724;
import 'package:spotspeak_mobile/services/authentication_service.dart' as _i281;
import 'package:spotspeak_mobile/services/comment_service.dart' as _i547;
import 'package:spotspeak_mobile/services/difficult_multipart_service.dart'
    as _i528;
import 'package:spotspeak_mobile/services/event_service.dart' as _i356;
import 'package:spotspeak_mobile/services/friend_service.dart' as _i100;
import 'package:spotspeak_mobile/services/impl/achievement_service_impl.dart'
    as _i826;
import 'package:spotspeak_mobile/services/impl/app_service_impl.dart' as _i86;
import 'package:spotspeak_mobile/services/impl/authentication_service_impl.dart'
    as _i187;
import 'package:spotspeak_mobile/services/impl/comment_service_impl.dart'
    as _i428;
import 'package:spotspeak_mobile/services/impl/difficult_multipart_service_impl.dart'
    as _i286;
import 'package:spotspeak_mobile/services/impl/event_service_impl.dart'
    as _i506;
import 'package:spotspeak_mobile/services/impl/friend_service_impl.dart'
    as _i1060;
import 'package:spotspeak_mobile/services/impl/location_service_impl.dart'
    as _i200;
import 'package:spotspeak_mobile/services/impl/notification_service_impl.dart'
    as _i1014;
import 'package:spotspeak_mobile/services/impl/ranking_service_impl.dart'
    as _i1053;
import 'package:spotspeak_mobile/services/impl/trace_service_impl.dart'
    as _i831;
import 'package:spotspeak_mobile/services/impl/user_service_impl.dart' as _i112;
import 'package:spotspeak_mobile/services/location_service.dart' as _i68;
import 'package:spotspeak_mobile/services/mock/authentication_service_mock.dart'
    as _i868;
import 'package:spotspeak_mobile/services/mock/location_service_mock.dart'
    as _i552;
import 'package:spotspeak_mobile/services/notification_service.dart' as _i127;
import 'package:spotspeak_mobile/services/ranking_service.dart' as _i368;
import 'package:spotspeak_mobile/services/trace_service.dart' as _i192;
import 'package:spotspeak_mobile/services/user_service.dart' as _i448;

const String _test = 'test';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i337.FlutterAppAuth>(() => registerModule.flutterAppAuth);
    gh.singleton<_i558.FlutterSecureStorage>(
        () => registerModule.flutterSecureStorage);
    await gh.singletonAsync<_i655.PackageInfo>(
      () => registerModule.packageInfo,
      preResolve: true,
    );
    gh.singleton<_i457.AppRouter>(() => _i457.AppRouter());
    await gh.singletonAsync<_i497.Directory>(
      () => registerModule.documentsDir,
      instanceName: 'documentsDir',
      preResolve: true,
    );
    gh.singleton<_i724.AppService>(() => _i86.AppServiceImpl());
    gh.singleton<_i68.LocationService>(
      () => _i552.LocationServiceMock(),
      registerFor: {_test},
    );
    await gh.singletonAsync<_i361.Dio>(
      () => registerModule.dioForOSM,
      instanceName: 'dioForOSM',
      preResolve: true,
    );
    gh.singleton<_i274.DbCacheStore>(
      () => registerModule
          .dbCacheStore(gh<_i497.Directory>(instanceName: 'documentsDir')),
      dispose: _i397.disposeDbCacheStore,
    );
    gh.singleton<_i528.PrettyDioLogger>(
      () => registerModule.prettyDioLoggerTest,
      registerFor: {_test},
    );
    gh.singleton<_i528.PrettyDioLogger>(
      () => registerModule.prettyDioLoggerProd,
      registerFor: {_prod},
    );
    gh.singleton<_i68.LocationService>(
      () => _i200.LocationServiceImpl(),
      registerFor: {_prod},
    );
    gh.factory<_i361.Dio>(() => registerModule.dio(
          gh<_i655.PackageInfo>(),
          gh<_i528.PrettyDioLogger>(),
        ));
    gh.singleton<_i528.DifficultMultipartService>(
        () => _i286.DifficultMultipartServiceImpl(gh<_i361.Dio>()));
    gh.singleton<_i100.FriendService>(
        () => _i1060.FriendServiceImpl(gh<_i361.Dio>()));
    gh.singleton<_i643.UserRepository>(
        () => _i307.UserRepositoryImpl(gh<_i361.Dio>()));
    gh.singleton<_i192.TraceService>(
        () => _i831.TraceServiceImpl(gh<_i361.Dio>()));
    gh.singleton<_i368.RankingService>(
        () => _i1053.RankingServiceImpl(gh<_i361.Dio>()));
    gh.singleton<_i448.UserService>(
        () => _i112.UserServiceImpl(gh<_i643.UserRepository>()));
    gh.lazySingleton<_i547.CommentService>(
        () => _i428.CommentServiceImpl(gh<_i361.Dio>()));
    gh.singleton<_i356.EventService>(
        () => _i506.EventServiceImpl(gh<_i361.Dio>()));
    gh.factory<_i868.SearchFriendsBloc>(
        () => _i868.SearchFriendsBloc(gh<_i100.FriendService>()));
    gh.singleton<_i77.AchievementService>(
        () => _i826.AchievementServiceImpl(gh<_i361.Dio>()));
    gh.singleton<_i127.NotificationService>(
        () => _i1014.NotificationServiceImpl(
              gh<_i448.UserService>(),
              gh<_i457.AppRouter>(),
            ));
    gh.singleton<_i281.AuthenticationService>(
      () => _i868.AuthenticationServiceMock(
        gh<_i361.Dio>(),
        gh<_i448.UserService>(),
      ),
      registerFor: {_test},
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i281.AuthenticationService>(
      () => _i187.AuthenticationServiceImpl(
        gh<_i361.Dio>(),
        gh<_i337.FlutterAppAuth>(),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i127.NotificationService>(),
        gh<_i448.UserService>(),
      ),
      registerFor: {_prod},
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i722.MapTabBloc>(() => _i722.MapTabBloc(
          gh<_i192.TraceService>(),
          gh<_i356.EventService>(),
          gh<_i528.DifficultMultipartService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i397.RegisterModule {}
