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
      ),
      routes: [
        MapRoute(),
        AchievementsRoute(),
        FriendsRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Osiągnięcia'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, key: ValueKey('bottom_nav_friends')),
            label: 'Znajomi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, key: ValueKey('bottom_nav_profile')),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
