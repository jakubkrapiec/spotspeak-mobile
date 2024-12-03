import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';

class AchievementContainer extends StatelessWidget {
  AchievementContainer({
    required this.achievement,
    required this.autoSizeGroup,
  }) : super(key: ValueKey(achievement.achievementName));

  final Achievement achievement;
  final AutoSizeGroup autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey[200],
          boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => context.router.push(SingleAchievementRoute(achievementId: achievement.userAchievementId)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      heightFactor: 0.7,
                      child: CachedNetworkImage(imageUrl: achievement.resourceAccessUrl),
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: AutoSizeText(
                      achievement.achievementName,
                      maxLines: 2,
                      group: autoSizeGroup,
                      stepGranularity: 0.1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
