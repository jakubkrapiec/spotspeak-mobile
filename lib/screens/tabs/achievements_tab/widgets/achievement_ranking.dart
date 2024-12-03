import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/achievements_tab/widgets/ranking_entry.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/ranking_service.dart';

class AchievementRanking extends StatefulWidget {
  const AchievementRanking({super.key});

  @override
  State<AchievementRanking> createState() => _AchievementRankingState();
}

class _AchievementRankingState extends State<AchievementRanking> {
  final _rankingService = getIt<RankingService>();
  final _authService = getIt<AuthenticationService>();

  List<RankingUser>? _ranking;
  LoadingStatus _status = LoadingStatus.loading;

  @override
  void initState() {
    super.initState();
    _fetchRanking();
  }

  List<RankingUser> _selectUpTo3UsersForRanking(List<RankingUser> users) {
    if (users.length <= 3) return users;
    final userId = _authService.user.value.id;
    final userRanking = users.indexWhere((user) => user.friendId == userId);
    if (userRanking == 0) return users.sublist(0, 3);
    if (userRanking == users.length - 1) return users.sublist(users.length - 3, users.length);
    return users.sublist(userRanking - 1, userRanking + 2);
  }

  Future<void> _fetchRanking() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    try {
      final ranking = await _rankingService.getRanking();
      final selectedUsers = _selectUpTo3UsersForRanking(ranking);
      setState(() {
        _ranking = selectedUsers;
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
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.all(16),
        child: switch (_status) {
          LoadingStatus.error => LoadingError(onRetry: _fetchRanking),
          LoadingStatus.loading => const Center(child: CircularProgressIndicator()),
          LoadingStatus.loaded => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (_ranking != null && index < _ranking!.length) {
                        final user = _ranking![index];
                        return RankingEntry(
                          user: user,
                          isMe: user.friendId == _authService.user.value.id,
                          onTap: () {
                            if (user.friendId == _authService.user.value.id) {
                              AutoTabsRouter.of(context).setActiveIndex(3);
                            } else {
                              context.router.push(UserProfileRoute(userId: user.friendId));
                            }
                          },
                        );
                      }
                      return const _AddFriendsEntry();
                    },
                    separatorBuilder: (context, index) => Container(height: 1, color: Colors.grey),
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ),
                const Gap(16),
                ElevatedButton.icon(
                  onPressed: () => context.router.push(RankingRoute()),
                  label: Text('Zobacz cały ranking'),
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
        },
      ),
    );
  }
}

class _AddFriendsEntry extends StatelessWidget {
  const _AddFriendsEntry();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () => AutoTabsRouter.of(context).setActiveIndex(2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.add),
              Gap(8),
              Text('Dodaj znajomych'),
            ],
          ),
        ),
      ),
    );
  }
}
