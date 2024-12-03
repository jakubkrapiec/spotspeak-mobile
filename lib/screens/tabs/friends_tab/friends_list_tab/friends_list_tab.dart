import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/friendship.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friend_tile.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';

class FriendsListTab extends StatefulWidget {
  const FriendsListTab({super.key});

  @override
  State<FriendsListTab> createState() => _FriendsListTabState();
}

class _FriendsListTabState extends State<FriendsListTab> {
  final _friendService = getIt<FriendService>();

  List<Friendship>? _friendships;
  LoadingStatus _status = LoadingStatus.loading;

  @override
  void initState() {
    super.initState();
    _getFriends();
  }

  Future<void> _getFriends() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    final friendships = await _friendService.getFriends();
    if (!mounted) return;
    setState(() {
      _friendships = friendships;
      _status = LoadingStatus.loaded;
    });
  }

  Future<void> _unfriend(Friendship friendship) async {
    await _friendService.unfriend(friendId: friendship.friendInfo.id);
    await _getFriends();
  }

  Future<void> _onTapDelete(Friendship friendship) async {
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
    if (shouldUnfriend ?? false) {
      await _unfriend(friendship);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_status) {
        LoadingStatus.loading => const Center(child: CircularProgressIndicator()),
        LoadingStatus.error => Center(child: LoadingError(onRetry: _getFriends)),
        LoadingStatus.loaded when _friendships?.isEmpty ?? true => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Brak znajomych'),
                const Gap(8),
                ElevatedButton(
                  onPressed: () => DefaultTabController.of(context).animateTo(2),
                  child: Text('Dodaj znajomych'),
                ),
              ],
            ),
          ),
        LoadingStatus.loaded => ListView.separated(
            itemBuilder: (context, index) {
              final friendship = _friendships![index];
              return FriendTile(
                user: friendship.friendInfo,
                onTap: () => context.router.push(UserProfileRoute(userId: friendship.friendInfo.id)),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _onTapDelete(friendship),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const Gap(8),
            itemCount: _friendships?.length ?? 0,
            physics: const BouncingScrollPhysics(),
          ),
      },
    );
  }
}
