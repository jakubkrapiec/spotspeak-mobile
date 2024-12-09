import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/screens/guest_screen/guest_screen.dart';
import 'package:spotspeak_mobile/screens/tabs/achievements_tab/widgets/achievement_ranking.dart';
import 'package:spotspeak_mobile/screens/tabs/achievements_tab/widgets/my_achievements.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

@RoutePage()
class AchievementsTab extends StatefulWidget {
  const AchievementsTab({super.key});

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab> {
  final _authService = getIt<AuthenticationService>();

  late final StreamController<void> _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = StreamController<void>.broadcast();
    context.tabsRouter.addListener(_onTabChanged);
  }

  @override
  void deactivate() {
    context.tabsRouter.removeListener(_onTabChanged);
    super.deactivate();
  }

  @override
  void dispose() {
    _refreshController.close();
    super.dispose();
  }

  void _onTabChanged() {
    final tabIndex = context.tabsRouter.activeIndex;
    if (tabIndex == 1) {
      _refreshController.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, child) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.achievements)
            : RefreshIndicator(
                onRefresh: () async => _refreshController.add(null),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AchievementRanking(refreshStream: _refreshController.stream),
                      const Gap(16),
                      MyAchievements(refreshStream: _refreshController.stream),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
