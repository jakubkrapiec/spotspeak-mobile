import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, router) => AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light ? AppColors.blue5 : AppColors.grey6,
        titleTextStyle: const TextStyle().copyWith(
          color: AppColors.grey5,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),
      routes: const [FriendsRoute(), NearbyRoute(), MapRoute(), AchievementsRoute(), ProfileRoute()],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          // backgroundColor: Theme.of(context).brightness == Brightness.light ? AppColors.blue7 : AppColors.green8,
          currentIndex: tabsRouter.activeIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).brightness == Brightness.light ? AppColors.blue7 : AppColors.green8,
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
