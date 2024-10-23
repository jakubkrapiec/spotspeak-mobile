// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:spotspeak_mobile/screens/home_screen.dart' as _i3;
import 'package:spotspeak_mobile/screens/login/login_screen.dart' as _i4;
import 'package:spotspeak_mobile/screens/settings/settings_screen.dart' as _i8;
import 'package:spotspeak_mobile/screens/splash_screen/splash_screen.dart'
    as _i9;
import 'package:spotspeak_mobile/screens/tabs/achievements_tab.dart' as _i1;
import 'package:spotspeak_mobile/screens/tabs/friends_tab.dart' as _i2;
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab.dart' as _i5;
import 'package:spotspeak_mobile/screens/tabs/nearby_tab.dart' as _i6;
import 'package:spotspeak_mobile/screens/tabs/profile_tab.dart' as _i7;

/// generated route for
/// [_i1.AchievementsTab]
class AchievementsRoute extends _i10.PageRouteInfo<void> {
  const AchievementsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AchievementsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AchievementsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.AchievementsTab();
    },
  );
}

/// generated route for
/// [_i2.FriendsTab]
class FriendsRoute extends _i10.PageRouteInfo<void> {
  const FriendsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FriendsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.FriendsTab();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i4.LoginScreen(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.MapTab]
class MapRoute extends _i10.PageRouteInfo<void> {
  const MapRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.MapTab();
    },
  );
}

/// generated route for
/// [_i6.NearbyTab]
class NearbyRoute extends _i10.PageRouteInfo<void> {
  const NearbyRoute({List<_i10.PageRouteInfo>? children})
      : super(
          NearbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'NearbyRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.NearbyTab();
    },
  );
}

/// generated route for
/// [_i7.ProfileTab]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProfileTab();
    },
  );
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashScreen();
    },
  );
}
