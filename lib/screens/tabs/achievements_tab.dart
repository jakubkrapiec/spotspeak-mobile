import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/achievement_details.dart';
import 'package:spotspeak_mobile/models/other_user.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/guest_screen/guest_screen.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

@RoutePage()
class AchievementsTab extends StatelessWidget {
  AchievementsTab({super.key});

  final _authService = getIt<AuthenticationService>();

  final _achievService = getIt<AchievementService>();

  Future<List<Achievement>> _getAchievements() async {
    final achievements = await _achievService.getUsersAchievements();
    return achievements;
  }

  Future<AchievementDetails> _getAchievementsDetails(int id) async {
    final achievementDetails = await _achievService.getAchievementDetails(id);
    return achievementDetails;
  }

  Future<List<OtherUser>> _getAchievementFriends(int id) async {
    final friends = await _achievService.getAchievementFriends(id);
    return friends;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, _) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.achievements)
            : Container(
                child: ElevatedButton(
                  child: Text('Click me'),
                  onPressed: () async {
                    final achievements = await _getAchievements();
                    await context.router.push(
                      SingleAchievementRoute(
                        achievement: await _getAchievementsDetails(achievements[12].userAchievementId),
                        achievementFriends: await _getAchievementFriends(achievements[12].userAchievementId),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
