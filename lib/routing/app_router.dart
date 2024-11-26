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
            AutoRoute(
              page: FriendsRoute.page,
              path: 'friendship-requests',
              title: (context, data) => 'Znajomi',
              children: [AutoRoute(page: UserProfileRoute.page)],
            ),
            AutoRoute(page: MapRoute.page, initial: true, title: (context, data) => 'Mapa'),
            AutoRoute(page: ProfileRoute.page, title: (context, data) => 'Twoje konto'),
            AutoRoute(page: AchievementsRoute.page, title: (context, data) => 'Osiągnięcia'),
          ],
        ),
        AutoRoute(page: AppSettingsRoute.page),
        AutoRoute(page: UserProfileRoute.page),
        AutoRoute(page: AccountSettingsRoute.page),
        AutoRoute(page: ChangeAccountDataRoute.page),
        AutoRoute(page: ChangeAppDataRoute.page),
        AutoRoute(page: UserTracesRoute.page),
        AutoRoute(page: SingleAchievementRoute.page),
      ];

  @override
  DeepLinkBuilder get deepLinkBuilder => (deepLink) {
        // Example: Validate or modify the deep link
        if (deepLink.path.startsWith('/home')) {
          // Navigate to the HomeRoute
          return deepLink;
        } else if (deepLink.path.startsWith('friendship-requests')) {
          // Navigate to the ProfileRoute with arguments
          return DeepLink([FriendsRoute(initialTabIndex: 1)]);
        }
        // else if (deepLink.path.startsWith('/user')) {
        //   // Navigate to UserProfileRoute with a dynamic ID
        //   final id = deepLink.path.split('/').last; // Extract the ID from the path
        //   return DeepLink([UserProfileRoute(userId: id)]);
        // }
        // Fallback to default or root route
        return DeepLink.defaultPath;
      };
}

enum ScreenType { home, profile, friends, achievements }
