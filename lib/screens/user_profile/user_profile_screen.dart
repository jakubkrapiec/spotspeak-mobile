import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/achievement_container.dart';
import 'package:spotspeak_mobile/common/widgets/horizontal_user_list.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/models/friendship_status.dart';
import 'package:spotspeak_mobile/models/other_user_view.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/big_black_button.dart';
import 'package:spotspeak_mobile/screens/user_profile/widgets/friendship_status_bar.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({required this.userId, super.key});

  final String userId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _friendService = getIt<FriendService>();
  final _achievementService = getIt<AchievementService>();

  LoadingStatus _status = LoadingStatus.loading;
  OtherUserView? _user;
  List<RankingUser>? _mutualFriends;
  List<Achievement>? _achievements;

  @override
  void initState() {
    super.initState();
    _getUser(displaySpinner: true);
  }

  Future<void> _getUser({required bool displaySpinner}) async {
    if (displaySpinner) {
      setState(() {
        _status = LoadingStatus.loading;
      });
    }

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

  bool _buttonLoading = false;

  Future<void> _onRemoveFriend() async {
    final shouldUnfriend = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usuwanie znajomego', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Czy na pewno chcesz usunąć tą znajomość?', style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Usuń'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (shouldUnfriend ?? false) {
      setState(() {
        _buttonLoading = true;
      });
      try {
        await _friendService.unfriend(friendId: widget.userId);
        await _getUser(displaySpinner: false);
      } catch (e, st) {
        debugPrint('$e\n$st');
      } finally {
        if (mounted) {
          setState(() {
            _buttonLoading = false;
          });
        }
      }
    }
  }

  Future<void> _sendFriendRequest() async {
    setState(() {
      _buttonLoading = true;
    });
    try {
      await _friendService.sendRequest(receiverId: widget.userId);
      await _getUser(displaySpinner: false);
    } catch (e, st) {
      debugPrint('$e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _buttonLoading = false;
        });
      }
    }
  }

  Future<void> _cancelFriendRequest() async {
    setState(() {
      _buttonLoading = true;
    });
    try {
      final myRequests = await _friendService.getSentRequests();
      final requestId = myRequests.firstWhere((element) => element.userInfo.id == widget.userId).id;
      await _friendService.cancelRequest(requestId: requestId);
      await _getUser(displaySpinner: false);
    } catch (e, st) {
      debugPrint('$e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _buttonLoading = false;
        });
      }
    }
  }

  Future<void> _acceptFriendRequest() async {
    setState(() {
      _buttonLoading = true;
    });
    try {
      final myRequests = await _friendService.getReceivedRequests();
      final requestId = myRequests.firstWhere((element) => element.userInfo.id == widget.userId).id;
      await _friendService.acceptRequest(requestId: requestId);
      await _getUser(displaySpinner: false);
    } catch (e, st) {
      debugPrint('$e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _buttonLoading = false;
        });
      }
    }
  }

  Future<void> _rejectFriendRequest() async {
    setState(() {
      _buttonLoading = true;
    });
    try {
      final myRequests = await _friendService.getReceivedRequests();
      final requestId = myRequests.firstWhere((element) => element.userInfo.id == widget.userId).id;
      await _friendService.rejectRequest(requestId: requestId);
      await _getUser(displaySpinner: false);
    } catch (e, st) {
      debugPrint('$e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _buttonLoading = false;
        });
      }
    }
  }

  final _achievementsAutoSizeGroup = AutoSizeGroup();

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
        LoadingStatus.error => Center(child: LoadingError(onRetry: () => _getUser(displaySpinner: true))),
        LoadingStatus.loading => Center(child: CircularProgressIndicator()),
        LoadingStatus.loaded => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox.square(
                    dimension: MediaQuery.sizeOf(context).width * 0.5,
                    child: ClipOval(
                      child: _user?.userProfile.profilePictureUrl != null
                          ? CachedNetworkImage(
                              imageUrl: _user!.userProfile.profilePictureUrl!.toString(),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/default_icon.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
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
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 150),
                    child: SizedBox(
                      width: double.infinity,
                      child: _buttonLoading
                          ? Center(child: CircularProgressIndicator())
                          : switch (_user!.relationshipStatus) {
                              FriendshipStatus.friends => FriendshipStatusBar(
                                  onRemoveFriend: _onRemoveFriend,
                                ),
                              FriendshipStatus.invitationReceived => Row(
                                  children: [
                                    Expanded(
                                      child: BigBlackButton(
                                        onTap: _acceptFriendRequest,
                                        label: 'Akceptuj',
                                        icon: Icon(Icons.person_add),
                                      ),
                                    ),
                                    const Gap(16),
                                    Expanded(
                                      child: BigBlackButton(
                                        onTap: _rejectFriendRequest,
                                        label: 'Odrzuć',
                                        icon: Icon(Icons.person_remove),
                                      ),
                                    ),
                                  ],
                                ),
                              FriendshipStatus.noRelation => BigBlackButton(
                                  onTap: _sendFriendRequest,
                                  label: 'Zaproś do znajomych',
                                  icon: Icon(Icons.person_add),
                                ),
                              FriendshipStatus.invitationSent => BigBlackButton(
                                  onTap: _cancelFriendRequest,
                                  label: 'Anuluj zaproszenie',
                                  icon: Icon(Icons.person_remove),
                                ),
                            },
                    ),
                  ),
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Wspólni znajomi:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                HorizontalUserList(
                  friendsList: _mutualFriends!,
                  emptyText: 'Brak wspólnych znajomych',
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Zdobyte osiągnięcia:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: _achievements?.isEmpty ?? true
                      ? Center(child: Text('Brak osiągnięć'))
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _achievements!.length,
                          separatorBuilder: (context, index) => Gap(24),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemBuilder: (context, index) => AchievementContainer(
                            achievement: _achievements![index],
                            autoSizeGroup: _achievementsAutoSizeGroup,
                          ),
                        ),
                ),
                const Gap(16),
              ],
            ),
          ),
      },
    );
  }
}
