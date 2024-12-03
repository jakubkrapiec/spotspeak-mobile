import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';

class MyAchievements extends StatefulWidget {
  const MyAchievements({super.key});

  @override
  State<MyAchievements> createState() => _MyAchievementsState();
}

class _MyAchievementsState extends State<MyAchievements> {
  final _achievementService = getIt<AchievementService>();

  List<Achievement>? _achievements;
  LoadingStatus _status = LoadingStatus.loading;

  @override
  void initState() {
    super.initState();
    _getAchievements();
  }

  Future<void> _getAchievements() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    try {
      final achievements = await _achievementService.getMyAchievements();
      setState(() {
        _achievements = achievements;
        _status = LoadingStatus.loaded;
      });
    } catch (e, st) {
      debugPrint('$e\n$st');
      if (mounted) {
        setState(() {
          _status = LoadingStatus.error;
        });
      }
    }
  }

  final _autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Twoje osiągnięcia', style: TextStyle(fontWeight: FontWeight.bold)),
        const Gap(16),
        switch (_status) {
          LoadingStatus.loading => Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Center(child: const CircularProgressIndicator()),
            ),
          LoadingStatus.error => LoadingError(onRetry: _getAchievements),
          LoadingStatus.loaded => GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) => _AchievementContainer(
                achievement: _achievements![index],
                autoSizeGroup: _autoSizeGroup,
              ),
              itemCount: _achievements!.length,
              shrinkWrap: true,
            ),
        },
      ],
    );
  }
}

class _AchievementContainer extends StatelessWidget {
  _AchievementContainer({
    required this.achievement,
    required this.autoSizeGroup,
  }) : super(key: ValueKey(achievement.achievementName));

  final Achievement achievement;
  final AutoSizeGroup autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
