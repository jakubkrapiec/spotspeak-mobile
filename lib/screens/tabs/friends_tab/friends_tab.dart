import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friends_list.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friends_search.dart';
import 'package:spotspeak_mobile/screens/user_profile/user_profile_screen.dart';

@RoutePage()
class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(10000, (i) => 'Item $i');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Twoi znajomi'),
                Tab(text: 'Zaproszenia'),
                Tab(text: 'Wyszukaj'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                FriendsSearch(
                  pressFunction: (value) {},
                ),
                FriendsList(
                  items: items,
                  tapFunction: () {
                    context.router.push(UserProfileRoute(status: FriendshipStatus.friends));
                  },
                ),
              ],
            ),
            Column(
              children: [
                FriendsSearch(pressFunction: (value) {}),
                FriendsList(
                  items: items,
                  tapFunction: () {
                    context.router.push(UserProfileRoute(status: FriendshipStatus.request));
                  },
                ),
              ],
            ),
            Column(
              children: [
                FriendsSearch(pressFunction: (value) {}),
                FriendsList(
                  items: items,
                  tapFunction: () {
                    context.router.push(UserProfileRoute(status: FriendshipStatus.stranger));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
