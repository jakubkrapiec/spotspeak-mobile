// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:spotspeak_mobile/di/get_it.dart' as _i397;
import 'package:spotspeak_mobile/services/authentication_service.dart' as _i281;
import 'package:spotspeak_mobile/services/location_service.dart' as _i68;
import 'package:spotspeak_mobile/services/trace_service.dart' as _i192;

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
    await gh.factoryAsync<_i361.Dio>(
      () => registerModule.dio,
      preResolve: true,
    );
    gh.singleton<_i281.AuthenticationService>(
        () => _i281.AuthenticationService());
    gh.singleton<_i68.LocationService>(() => _i68.LocationService());
    gh.singleton<_i192.TraceService>(() => _i192.TraceService());
    return this;
  }
}

class _$RegisterModule extends _i397.RegisterModule {}
