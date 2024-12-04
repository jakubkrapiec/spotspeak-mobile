import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dateable/dateable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:spotspeak_mobile/common/widgets/horizontal_user_list.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/achievement_details.dart';
import 'package:spotspeak_mobile/models/other_user.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@RoutePage()
class SingleAchievementScreen extends StatefulWidget {
  const SingleAchievementScreen({required this.achievementId, super.key});

  final int achievementId;

  @override
  State<SingleAchievementScreen> createState() => _SingleAchievementScreenState();
}

class _SingleAchievementScreenState extends State<SingleAchievementScreen> {
  final _appService = getIt<AppService>();
  final _achievementService = getIt<AchievementService>();

  @override
  void initState() {
    super.initState();
    _getFriendsAchievements();
  }

  List<OtherUser>? _achievementFriends;
  AchievementDetails? _achievement;
  LoadingStatus _status = LoadingStatus.loading;

  Future<void> _getFriendsAchievements() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    try {
      final responses = await Future.wait([
        _achievementService.getAchievementDetails(widget.achievementId),
        _achievementService.getAchievementFriends(widget.achievementId),
      ]);
      final achievement = responses[0] as AchievementDetails;
      final friends = responses[1] as List<OtherUser>;
      if (!mounted) return;
      setState(() {
        _achievement = achievement;
        _achievementFriends = friends;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Osiągnięcia')),
      body: switch (_status) {
        LoadingStatus.loading => const Center(child: CircularProgressIndicator()),
        LoadingStatus.error => Center(child: LoadingError(onRetry: _getFriendsAchievements)),
        LoadingStatus.loaded => Column(
            children: [
              const Gap(16),
              Expanded(child: CachedNetworkImage(imageUrl: _achievement!.resourceAccessUrl)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_achievement!.achievementName, style: Theme.of(context).textTheme.bodyLarge),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(_achievement!.achievementDescription, textAlign: TextAlign.center),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: _appService.isDarkMode(context) ? CustomColors.grey6 : CustomColors.blue3,
                ),
                child: Text('${_achievement!.points} pkt.'),
              ),
              if (_achievement!.completedAt == null)
                _buildProgressSection(context)
              else
                _buildCompletedSection(context),
              Gap(8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Zdobyli też:'),
                ),
              ),
              const Gap(8),
              switch (_status) {
                LoadingStatus.loading => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: Center(child: const CircularProgressIndicator()),
                  ),
                LoadingStatus.error => Center(child: LoadingError(onRetry: _getFriendsAchievements)),
                LoadingStatus.loaded when (_achievementFriends ?? []).isEmpty => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Żaden z Twoich znajomych nie zdobył tego osiągnięcia',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                LoadingStatus.loaded => HorizontalUserList(
                    friendsList: _achievementFriends ?? [],
                    emptyText: '',
                  ),
              },
              const Gap(16),
            ],
          ),
      },
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
                '${_achievement!.quantityProgress}/${_achievement!.requiredQuantity}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LinearProgressBar(
            maxSteps: _achievement!.requiredQuantity,
            currentStep: _achievement!.quantityProgress,
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
                _achievement!.endTime == null ? 'brak limitu' : _remainingTime,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String get _remainingTime {
    final timeLeft = _achievement!.timeLeft!;
    if (timeLeft > const Duration(days: 2)) {
      return '${timeLeft.inDays} dni';
    }
    return '${timeLeft.inHours}:${(timeLeft.inMinutes % 60).toString().padLeft(2, '0')}:${(timeLeft.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Widget _buildCompletedSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Data zdobycia:'),
          Text(
            _achievement!.completedAt!.toDate().format([dd, '.', mm, '.', yyyy]),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
