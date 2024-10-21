import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, router) => AppBar(
        title: Text(router.currentChild?.title(context) ?? 'SpotSpeak'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),
      routes: const [
        FriendsRoute(),
        UserProfileRoute(),
        // NearbyRoute(),
        MapRoute(), AchievementsRoute(), ProfileRoute()
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Znajomi'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'W pobliżu'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
            BottomNavigationBarItem(icon: Icon(Icons.question_mark), label: 'Osiągnięcia'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        );
      },
    );
  }
}
