import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Tab,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          children: [
            AutoRoute(
              page: FriendsRoute.page,
              path: 'friendship-requests',
              title: (context, data) => 'Znajomi',
              children: [AutoRoute(page: UserProfileRoute.page)],
            ),
            AutoRoute(page: MapRoute.page, path: 'map', initial: true, title: (context, data) => 'Mapa'),
            AutoRoute(page: ProfileRoute.page, title: (context, data) => 'Twoje konto'),
            AutoRoute(page: AchievementsRoute.page, title: (context, data) => 'Osiągnięcia'),
          ],
        ),
        AutoRoute(page: AppSettingsRoute.page),
        AutoRoute(page: UserProfileRoute.page),
        AutoRoute(page: AccountSettingsRoute.page),
        AutoRoute(page: ChangeAccountDataRoute.page),
        AutoRoute(page: ChangeAppDataRoute.page),
        AutoRoute(
          page: UserTracesRoute.page,
          path: '/user-traces',
        ),
        AutoRoute(page: SingleAchievementRoute.page),
      ];
}

enum ScreenType { home, profile, friends, achievements }
