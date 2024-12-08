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

@RoutePage()
class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final _rankingService = getIt<RankingService>();
  final _authService = getIt<AuthenticationService>();

  @override
  void initState() {
    super.initState();
    _getRankingUsers();
  }

  LoadingStatus _status = LoadingStatus.loading;
  List<RankingUser>? _ranking;
  String _topText = '';

  Future<void> _getRankingUsers() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    try {
      final ranking = await _rankingService.getRanking();
      setState(() {
        _ranking = ranking;
        _status = LoadingStatus.loaded;
        _topText = _getTopText();
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

  String _getTopText() {
    if (_ranking == null) return '';
    final userRanking = _ranking!.indexWhere((user) => user.friendId == _authService.user.value.id);
    if (userRanking == -1) return '';
    if (userRanking == 0) return 'Jesteś na pierwszym miejscu!';
    final betterUser = _ranking![userRanking - 1];
    final pointsDifference = betterUser.totalPoints - _ranking![userRanking].totalPoints;
    final pointsToOvertake = pointsDifference + 1;
    return 'Zdobądź $pointsToOvertake punktów, aby zająć wyższe miejsce!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ranking'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: _getRankingUsers,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(child: Text(_topText)),
            ),
            const SliverGap(16),
            switch (_status) {
              LoadingStatus.loading => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
              LoadingStatus.error => SliverFillRemaining(
                  child: Center(child: LoadingError(onRetry: _getRankingUsers)),
                ),
              LoadingStatus.loaded => SliverList.separated(
                  itemCount: _ranking!.length,
                  itemBuilder: (context, index) {
                    final user = _ranking![index];
                    return RankingEntry(
                      user: user,
                      isMe: user.friendId == _authService.user.value.id,
                      onTap: () {
                        if (user.friendId == _authService.user.value.id) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('To jesteś ty!'),
                              duration: Duration(seconds: 5),
                            ),
                          );
                          return;
                        }
                        context.router.push(UserProfileRoute(userId: user.friendId));
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(8),
                ),
            },
          ],
        ),
      ),
    );
  }
}
