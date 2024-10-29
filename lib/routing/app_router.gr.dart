// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:spotspeak_mobile/screens/account_settings/account_settings_screen.dart'
    as _i1;
import 'package:spotspeak_mobile/screens/app_settings/app_settings_screen.dart'
    as _i3;
import 'package:spotspeak_mobile/screens/change_data/change_account_data_screen.dart'
    as _i4;
import 'package:spotspeak_mobile/screens/change_data/change_app_data_screen.dart'
    as _i5;
import 'package:spotspeak_mobile/screens/home_screen.dart' as _i7;
import 'package:spotspeak_mobile/screens/login/login_screen.dart' as _i8;
import 'package:spotspeak_mobile/screens/tabs/achievements_tab.dart' as _i2;
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friends_tab.dart'
    as _i6;
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab.dart' as _i9;
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_tab.dart'
    as _i10;
import 'package:spotspeak_mobile/screens/user_profile/user_profile_screen.dart'
    as _i11;
import 'package:spotspeak_mobile/screens/users_traces/user_traces_screen.dart'
    as _i12;

/// generated route for
/// [_i1.AccountSettingsScreen]
class AccountSettingsRoute extends _i13.PageRouteInfo<void> {
  const AccountSettingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AccountSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountSettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountSettingsScreen();
    },
  );
}

/// generated route for
/// [_i2.AchievementsTab]
class AchievementsRoute extends _i13.PageRouteInfo<void> {
  const AchievementsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AchievementsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AchievementsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.AchievementsTab();
    },
  );
}

/// generated route for
/// [_i3.AppSettingsScreen]
class AppSettingsRoute extends _i13.PageRouteInfo<void> {
  const AppSettingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AppSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppSettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.AppSettingsScreen();
    },
  );
}

/// generated route for
/// [_i4.ChangeAccountDataScreen]
class ChangeAccountDataRoute
    extends _i13.PageRouteInfo<ChangeAccountDataRouteArgs> {
  ChangeAccountDataRoute({
    required _i4.AccountData accountData,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ChangeAccountDataRoute.name,
          args: ChangeAccountDataRouteArgs(
            accountData: accountData,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeAccountDataRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangeAccountDataRouteArgs>();
      return _i4.ChangeAccountDataScreen(
        accountData: args.accountData,
        key: args.key,
      );
    },
  );
}

class ChangeAccountDataRouteArgs {
  const ChangeAccountDataRouteArgs({
    required this.accountData,
    this.key,
  });

  final _i4.AccountData accountData;

  final _i14.Key? key;

  @override
  String toString() {
    return 'ChangeAccountDataRouteArgs{accountData: $accountData, key: $key}';
  }
}

/// generated route for
/// [_i5.ChangeAppDataScreen]
class ChangeAppDataRoute extends _i13.PageRouteInfo<ChangeAppDataRouteArgs> {
  ChangeAppDataRoute({
    required _i5.AppData appData,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ChangeAppDataRoute.name,
          args: ChangeAppDataRouteArgs(
            appData: appData,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeAppDataRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangeAppDataRouteArgs>();
      return _i5.ChangeAppDataScreen(
        appData: args.appData,
        key: args.key,
      );
    },
  );
}

class ChangeAppDataRouteArgs {
  const ChangeAppDataRouteArgs({
    required this.appData,
    this.key,
  });

  final _i5.AppData appData;

  final _i14.Key? key;

  @override
  String toString() {
    return 'ChangeAppDataRouteArgs{appData: $appData, key: $key}';
  }
}

/// generated route for
/// [_i6.FriendsTab]
class FriendsRoute extends _i13.PageRouteInfo<void> {
  const FriendsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          FriendsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.FriendsTab();
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginScreen();
    },
  );
}

/// generated route for
/// [_i9.MapTab]
class MapRoute extends _i13.PageRouteInfo<void> {
  const MapRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.MapTab();
    },
  );
}

/// generated route for
/// [_i10.ProfileTab]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileTab();
    },
  );
}

/// generated route for
/// [_i11.UserProfileScreen]
class UserProfileRoute extends _i13.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    required _i11.FriendshipStatus status,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(
            status: status,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserProfileRouteArgs>();
      return _i11.UserProfileScreen(
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

  final _i11.FriendshipStatus status;

  final _i14.Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{status: $status, key: $key}';
  }
}

/// generated route for
/// [_i12.UserTracesScreen]
class UserTracesRoute extends _i13.PageRouteInfo<void> {
  const UserTracesRoute({List<_i13.PageRouteInfo>? children})
      : super(
          UserTracesRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserTracesRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.UserTracesScreen();
    },
  );
}
