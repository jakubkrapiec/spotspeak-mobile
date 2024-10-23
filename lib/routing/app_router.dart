import 'package:auto_route/auto_route.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';

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
          children: [
            AutoRoute(page: FriendsRoute.page, title: (context, data) => 'Znajomi'),
            AutoRoute(page: MapRoute.page, initial: true, title: (context, data) => 'Mapa'),
            AutoRoute(page: NearbyRoute.page, title: (context, data) => 'W pobliżu'),
            AutoRoute(page: ProfileRoute.page, title: (context, data) => 'Twoje konto'),
            AutoRoute(page: AchievementsRoute.page, title: (context, data) => 'Osiągnięcia'),
          ],
        ),
        AutoRoute(page: SettingsRoute.page),
      ];
}
