import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friend_requests_tab/friend_requests_tab.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/search_friends_tab/search_friends_tab.dart';

@RoutePage()
class FriendsTab extends StatelessWidget {
  const FriendsTab({this.initialTabIndex = 0, super.key});

  final int initialTabIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialTabIndex,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Znajomi'),
                Tab(text: 'Zaproszenia'),
                Tab(text: 'Wyszukaj'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [],
            ),
            FriendRequestsTab(),
            SearchFriendsTab(),
          ],
        ),
      ),
    );
  }
}
