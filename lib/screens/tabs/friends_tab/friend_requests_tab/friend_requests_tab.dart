import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/friend_request_user_info.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friend_tile.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';

class FriendRequestsTab extends StatefulWidget {
  const FriendRequestsTab({super.key});

  @override
  State<FriendRequestsTab> createState() => _FriendRequestsTabState();
}

class _FriendRequestsTabState extends State<FriendRequestsTab> {
  final _friendService = getIt<FriendService>();
  LoadingStatus _status = LoadingStatus.loading;
  List<FriendRequestUserInfo>? _requests;

  @override
  void initState() {
    super.initState();
    _getRequests();
  }

  Future<void> _getRequests() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    try {
      final requests = await _friendService.getReceivedRequests();
      if (!mounted) return;
      setState(() {
        _requests = requests;
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
    return switch (_status) {
      LoadingStatus.loading => const Center(child: CircularProgressIndicator()),
      LoadingStatus.error => Center(child: LoadingError(onRetry: _getRequests)),
      LoadingStatus.loaded when _requests?.isEmpty ?? true => const Center(child: Text('Brak nowych zaproszeń')),
      LoadingStatus.loaded => ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: _requests?.length ?? 0,
          itemBuilder: (context, index) {
            final request = _requests![index];
            return FriendTile(
              user: request.userInfo,
              onTap: () => context.router.push(UserProfileRoute(userId: request.userInfo.id)),
            );
          },
        ),
    };
  }
}
