import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/horizontal_user_list.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/friendship_status.dart';
import 'package:spotspeak_mobile/models/other_user_view.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/friendship_status_bar.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/manage_request_buttons.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/send_request_button.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({required this.userId, super.key});

  final String userId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _appService = getIt<AppService>();
  final _friendService = getIt<FriendService>();
  final _achievementService = getIt<AchievementService>();

  LoadingStatus _status = LoadingStatus.loading;
  OtherUserView? _user;
  List<RankingUser>? _mutualFriends;
  List<Achievement>? _achievements;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    try {
      final results = await Future.wait(
        [
          _friendService.getUser(userId: widget.userId),
          _friendService.getMutualFriends(userId: widget.userId),
          _achievementService.getAchievements(widget.userId),
        ],
        eagerError: true,
      );
      final user = results[0] as OtherUserView;
      final mutualFriends = results[1] as List<RankingUser>;
      final achievements = results[2] as List<Achievement>;
      setState(() {
        _user = user;
        _mutualFriends = mutualFriends;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          _user?.userProfile.username ?? '...',
          maxLines: 1,
        ),
      ),
      body: switch (_status) {
        LoadingStatus.error => Center(child: LoadingError(onRetry: _getUser)),
        LoadingStatus.loading => Center(child: CircularProgressIndicator()),
        LoadingStatus.loaded => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipOval(
                    child: _user?.userProfile.profilePictureUrl != null
                        ? CachedNetworkImage(imageUrl: _user!.userProfile.profilePictureUrl!.toString())
                        : Image.asset('assets/default_icon.jpg'),
                  ),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AutoSizeText(
                    _user!.userProfile.username,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${_user!.userProfile.totalPoints} pkt',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _user!.relationshipStatus == FriendshipStatus.friends
                      ? FriendshipStatusBar()
                      : _user!.relationshipStatus == FriendshipStatus.invitationReceived
                          ? ManageRequestButtons()
                          : SendRequestButton(),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Wspólni znajomi:'),
                  ),
                ),
                HorizontalUserList(friendsList: _mutualFriends!),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Zdobyte osiągnięcia:'),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _achievements!.length,
                    separatorBuilder: (context, index) => Gap(24),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => context.router
                          .push(SingleAchievementRoute(achievementId: _achievements![index].userAchievementId)),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(10),
                        width: 120,
                        decoration: _appService.isDarkMode(context)
                            ? CustomTheme.darkContainerStyle
                            : CustomTheme.lightContainerStyle,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bed_rounded),
                              Text(
                                _achievements![index].achievementName,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      },
    );
  }
}
