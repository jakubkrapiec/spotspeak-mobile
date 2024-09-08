import 'package:auto_route/auto_route.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Tab,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: FriendsRoute.page),
            AutoRoute(page: MapRoute.page, initial: true),
            AutoRoute(page: NearbyRoute.page),
            AutoRoute(page: ProfileRoute.page),
            AutoRoute(page: AchievementsRoute.page),
          ],
        ),
      ];
}
