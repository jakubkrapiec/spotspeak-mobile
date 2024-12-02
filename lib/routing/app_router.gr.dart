// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:spotspeak_mobile/models/achievement_details.dart' as _i17;
import 'package:spotspeak_mobile/models/other_user.dart' as _i18;
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
import 'package:spotspeak_mobile/screens/single_achievement/single_achievement_screen.dart'
    as _i11;
import 'package:spotspeak_mobile/screens/splash_screen/splash_screen.dart'
    as _i12;
import 'package:spotspeak_mobile/screens/tabs/achievements_tab.dart' as _i2;
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friends_tab.dart'
    as _i6;
import 'package:spotspeak_mobile/screens/tabs/map_tab/map_tab.dart' as _i9;
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_tab.dart'
    as _i10;
import 'package:spotspeak_mobile/screens/user_profile/user_profile_screen.dart'
    as _i13;
import 'package:spotspeak_mobile/screens/users_traces/user_traces_screen.dart'
    as _i14;

/// generated route for
/// [_i1.AccountSettingsScreen]
class AccountSettingsRoute extends _i15.PageRouteInfo<void> {
  const AccountSettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AccountSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountSettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountSettingsScreen();
    },
  );
}

/// generated route for
/// [_i2.AchievementsTab]
class AchievementsRoute extends _i15.PageRouteInfo<AchievementsRouteArgs> {
  AchievementsRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          AchievementsRoute.name,
          args: AchievementsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AchievementsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AchievementsRouteArgs>(
          orElse: () => const AchievementsRouteArgs());
      return _i2.AchievementsTab(key: args.key);
    },
  );
}

class AchievementsRouteArgs {
  const AchievementsRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'AchievementsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.AppSettingsScreen]
class AppSettingsRoute extends _i15.PageRouteInfo<void> {
  const AppSettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AppSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppSettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.AppSettingsScreen();
    },
  );
}

/// generated route for
/// [_i4.ChangeAccountDataScreen]
class ChangeAccountDataRoute
    extends _i15.PageRouteInfo<ChangeAccountDataRouteArgs> {
  ChangeAccountDataRoute({
    required _i4.AccountData accountData,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ChangeAccountDataRoute.name,
          args: ChangeAccountDataRouteArgs(
            accountData: accountData,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeAccountDataRoute';

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  @override
  String toString() {
    return 'ChangeAccountDataRouteArgs{accountData: $accountData, key: $key}';
  }
}

/// generated route for
/// [_i5.ChangeAppDataScreen]
class ChangeAppDataRoute extends _i15.PageRouteInfo<ChangeAppDataRouteArgs> {
  ChangeAppDataRoute({
    required _i5.AppData appData,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ChangeAppDataRoute.name,
          args: ChangeAppDataRouteArgs(
            appData: appData,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeAppDataRoute';

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  @override
  String toString() {
    return 'ChangeAppDataRouteArgs{appData: $appData, key: $key}';
  }
}

/// generated route for
/// [_i6.FriendsTab]
class FriendsRoute extends _i15.PageRouteInfo<FriendsRouteArgs> {
  FriendsRoute({
    int initialTabIndex = 0,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          FriendsRoute.name,
          args: FriendsRouteArgs(
            initialTabIndex: initialTabIndex,
            key: key,
          ),
          rawQueryParams: {'initialTabIndex': initialTabIndex},
          initialChildren: children,
        );

  static const String name = 'FriendsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FriendsRouteArgs>(
          orElse: () => FriendsRouteArgs(
                  initialTabIndex: queryParams.getInt(
                'initialTabIndex',
                0,
              )));
      return _i6.FriendsTab(
        initialTabIndex: args.initialTabIndex,
        key: args.key,
      );
    },
  );
}

class FriendsRouteArgs {
  const FriendsRouteArgs({
    this.initialTabIndex = 0,
    this.key,
  });

  final int initialTabIndex;

  final _i16.Key? key;

  @override
  String toString() {
    return 'FriendsRouteArgs{initialTabIndex: $initialTabIndex, key: $key}';
  }
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i15.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i8.LoginScreen(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.MapTab]
class MapRoute extends _i15.PageRouteInfo<MapRouteArgs> {
  MapRoute({
    int? traceId,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            traceId: traceId,
            key: key,
          ),
          rawQueryParams: {'traceId': traceId},
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<MapRouteArgs>(
          orElse: () => MapRouteArgs(traceId: queryParams.optInt('traceId')));
      return _i9.MapTab(
        traceId: args.traceId,
        key: args.key,
      );
    },
  );
}

class MapRouteArgs {
  const MapRouteArgs({
    this.traceId,
    this.key,
  });

  final int? traceId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'MapRouteArgs{traceId: $traceId, key: $key}';
  }
}

/// generated route for
/// [_i10.ProfileTab]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileTab();
    },
  );
}

/// generated route for
/// [_i11.SingleAchievementScreen]
class SingleAchievementRoute
    extends _i15.PageRouteInfo<SingleAchievementRouteArgs> {
  SingleAchievementRoute({
    required _i17.AchievementDetails achievement,
    required List<_i18.OtherUser> achievementFriends,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SingleAchievementRoute.name,
          args: SingleAchievementRouteArgs(
            achievement: achievement,
            achievementFriends: achievementFriends,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleAchievementRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SingleAchievementRouteArgs>();
      return _i11.SingleAchievementScreen(
        achievement: args.achievement,
        achievementFriends: args.achievementFriends,
        key: args.key,
      );
    },
  );
}

class SingleAchievementRouteArgs {
  const SingleAchievementRouteArgs({
    required this.achievement,
    required this.achievementFriends,
    this.key,
  });

  final _i17.AchievementDetails achievement;

  final List<_i18.OtherUser> achievementFriends;

  final _i16.Key? key;

  @override
  String toString() {
    return 'SingleAchievementRouteArgs{achievement: $achievement, achievementFriends: $achievementFriends, key: $key}';
  }
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashScreen();
    },
  );
}

/// generated route for
/// [_i13.UserProfileScreen]
class UserProfileRoute extends _i15.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    required _i13.FriendshipStatus status,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(
            status: status,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserProfileRouteArgs>();
      return _i13.UserProfileScreen(
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

  final _i13.FriendshipStatus status;

  final _i16.Key? key;

  @override
  String toString() {
    return 'UserProfileRouteArgs{status: $status, key: $key}';
  }
}

/// generated route for
/// [_i14.UserTracesScreen]
class UserTracesRoute extends _i15.PageRouteInfo<UserTracesRouteArgs> {
  UserTracesRoute({
    int? traceId,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          UserTracesRoute.name,
          args: UserTracesRouteArgs(
            traceId: traceId,
            key: key,
          ),
          rawQueryParams: {'traceId': traceId},
          initialChildren: children,
        );

  static const String name = 'UserTracesRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<UserTracesRouteArgs>(
          orElse: () =>
              UserTracesRouteArgs(traceId: queryParams.optInt('traceId')));
      return _i14.UserTracesScreen(
        traceId: args.traceId,
        key: args.key,
      );
    },
  );
}

class UserTracesRouteArgs {
  const UserTracesRouteArgs({
    this.traceId,
    this.key,
  });

  final int? traceId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'UserTracesRouteArgs{traceId: $traceId, key: $key}';
  }
}
