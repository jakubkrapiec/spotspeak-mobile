import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friend_requests_tab/friend_requests_bloc.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friend_tile.dart';

class FriendRequestsTab extends StatefulWidget {
  const FriendRequestsTab({super.key});

  @override
  State<FriendRequestsTab> createState() => _FriendRequestsTabState();
}

class _FriendRequestsTabState extends State<FriendRequestsTab> {
  late final FriendRequestsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<FriendRequestsBloc>();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendRequestsBloc, FriendRequestsState>(
      bloc: _bloc,
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: state.requests.length,
          itemBuilder: (context, index) => FriendTile(
            user: state.requests[index].userInfo,
            tapFunction: () {},
          ),
        );
      },
    );
  }
}
