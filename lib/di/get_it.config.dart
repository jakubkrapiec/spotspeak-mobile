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
import 'package:spotspeak_mobile/di/get_it.dart' as _i397;
import 'package:spotspeak_mobile/repositories/user_repository.dart' as _i643;
import 'package:spotspeak_mobile/routing/app_router.dart' as _i457;
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friend_requests_tab/friend_requests_bloc.dart'
    as _i488;
import 'package:spotspeak_mobile/screens/tabs/friends_tab/search_friends_tab/search_friends_bloc.dart'
    as _i868;
import 'package:spotspeak_mobile/services/achievement_service.dart' as _i77;
import 'package:spotspeak_mobile/services/app_service.dart' as _i724;
import 'package:spotspeak_mobile/services/authentication_service.dart' as _i281;
import 'package:spotspeak_mobile/services/comment_service.dart' as _i547;
import 'package:spotspeak_mobile/services/friend_service.dart' as _i100;
import 'package:spotspeak_mobile/services/location_service.dart' as _i68;
import 'package:spotspeak_mobile/services/notification_service.dart' as _i127;
import 'package:spotspeak_mobile/services/ranking_service.dart' as _i368;
import 'package:spotspeak_mobile/services/trace_service.dart' as _i192;
import 'package:spotspeak_mobile/services/user_service.dart' as _i448;

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
    gh.singleton<_i724.AppService>(() => _i724.AppService());
    gh.singleton<_i68.LocationService>(() => _i68.LocationService());
    gh.singleton<_i127.NotificationService>(() => _i127.NotificationService());
    await gh.singletonAsync<_i497.Directory>(
      () => registerModule.documentsDir,
      instanceName: 'documentsDir',
      preResolve: true,
    );
    await gh.singletonAsync<_i361.Dio>(
      () => registerModule.dioForOSM,
      instanceName: 'dioForOSM',
      preResolve: true,
    );
    gh.singleton<_i274.DbCacheStore>(() => registerModule
        .dbCacheStore(gh<_i497.Directory>(instanceName: 'documentsDir')));
    gh.factory<_i361.Dio>(() => registerModule.dio(gh<_i655.PackageInfo>()));
    gh.singleton<_i643.UserRepository>(
        () => _i643.UserRepository(gh<_i361.Dio>()));
    gh.singleton<_i77.AchievementService>(
        () => _i77.AchievementService(gh<_i361.Dio>()));
    gh.singleton<_i547.CommentService>(
        () => _i547.CommentService(gh<_i361.Dio>()));
    gh.singleton<_i100.FriendService>(
        () => _i100.FriendService(gh<_i361.Dio>()));
    gh.singleton<_i368.RankingService>(
        () => _i368.RankingService(gh<_i361.Dio>()));
    gh.singleton<_i192.TraceService>(() => _i192.TraceService(gh<_i361.Dio>()));
    gh.singleton<_i281.AuthenticationService>(
      () => _i281.AuthenticationService(
        gh<_i361.Dio>(),
        gh<_i337.FlutterAppAuth>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i448.UserService>(
        () => _i448.UserService(gh<_i643.UserRepository>()));
    gh.factory<_i488.FriendRequestsBloc>(
        () => _i488.FriendRequestsBloc(gh<_i100.FriendService>()));
    gh.factory<_i868.SearchFriendsBloc>(
        () => _i868.SearchFriendsBloc(gh<_i100.FriendService>()));
    return this;
  }
}

class _$RegisterModule extends _i397.RegisterModule {}
