import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:spotspeak_mobile/common/widgets/horizontal_user_list.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/achievement_details.dart';
import 'package:spotspeak_mobile/models/other_user.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@RoutePage()
class SingleAchievementScreen extends StatelessWidget {
  SingleAchievementScreen({
    required this.achievement,
    required this.achievementFriends,
    super.key,
  });

  final AchievementDetails achievement;
  final List<OtherUser> achievementFriends;
  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Osiągnięcia'),
      ),
      body: Column(
        children: [
          const Gap(16),
          Expanded(
            child: CachedNetworkImage(imageUrl: achievement.resourceAccessUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              achievement.achievementName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              achievement.achievementDescription,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: _appService.isDarkMode(context) ? CustomColors.grey6 : CustomColors.blue3,
            ),
            child: Text('${achievement.points} pkt.'),
          ),
          if (achievement.completedAt == null) _buildProgressSection(context) else _buildCompletedSection(context),
          Gap(8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Zdobyli też:'),
            ),
          ),
          const Gap(8),
          if (achievementFriends.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Żaden z Twoich znajomych nie zdobył tego osiągnięcia',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
          else
            HorizontalUserList(friendsList: achievementFriends),
          const Gap(16),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Postęp:'),
              Text(
                '${achievement.quantityProgress}/${achievement.requiredQuantity}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LinearProgressBar(
            maxSteps: achievement.requiredQuantity,
            currentStep: achievement.quantityProgress,
            progressColor: _appService.isDarkMode(context) ? CustomColors.green5 : CustomColors.blue5,
            backgroundColor: _appService.isDarkMode(context) ? CustomColors.grey4 : CustomColors.grey12,
            borderRadius: BorderRadius.circular(10),
            minHeight: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pozostały czas:'),
              Text(
                achievement.remainingTime == null ? 'brak limitu' : achievement.remainingTime.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Data zdobycia:'),
          Text(
            achievement.completedAt.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
