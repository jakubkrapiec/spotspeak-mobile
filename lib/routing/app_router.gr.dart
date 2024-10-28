// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:spotspeak_mobile/screens/home_screen.dart' as _i3;
import 'package:spotspeak_mobile/screens/login/login_screen.dart' as _i4;
import 'package:spotspeak_mobile/screens/settings/settings_screen.dart' as _i8;
import 'package:spotspeak_mobile/screens/splash_screen/splash_screen.dart'
    as _i9;
import 'package:spotspeak_mobile/screens/tabs/achievements_tab.dart' as _i1;
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friends_tab.dart'
    as _i2;
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab.dart' as _i5;
import 'package:spotspeak_mobile/screens/tabs/nearby_tab.dart' as _i6;
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_tab.dart'
    as _i7;
import 'package:spotspeak_mobile/screens/user_profile/user_profile_screen.dart'
    as _i10;

/// generated route for
/// [_i1.AchievementsTab]
class AchievementsRoute extends _i11.PageRouteInfo<void> {
  const AchievementsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AchievementsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AchievementsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AchievementsTab();
    },
  );
}

/// generated route for
/// [_i2.FriendsTab]
class FriendsRoute extends _i11.PageRouteInfo<void> {
  const FriendsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          FriendsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.FriendsTab();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
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

  final _i12.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.MapTab]
class MapRoute extends _i11.PageRouteInfo<void> {
  const MapRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.MapTab();
    },
  );
}

/// generated route for
/// [_i6.NearbyTab]
class NearbyRoute extends _i11.PageRouteInfo<void> {
  const NearbyRoute({List<_i11.PageRouteInfo>? children})
      : super(
          NearbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'NearbyRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.NearbyTab();
    },
  );
}

/// generated route for
/// [_i7.ProfileTab]
class ProfileRoute extends _i11.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<ProfileRouteArgs>(orElse: () => const ProfileRouteArgs());
      return _i7.ProfileTab(key: args.key);
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashScreen();
    },
  );
}

/// generated route for
/// [_i10.UserProfileScreen]
class UserProfileRoute extends _i11.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    required _i10.FriendshipStatus status,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(
            status: status,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserProfileRouteArgs>();
      return _i10.UserProfileScreen(
        status: args.status,
        key: args.key,
      );
    },
  );
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({
    required this.status,
    this.key,
  });

  final _i10.FriendshipStatus status;

  final _i12.Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{status: $status, key: $key}';
  }
}
