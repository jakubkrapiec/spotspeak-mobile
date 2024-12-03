import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/screens/guest_screen/guest_screen.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friend_requests_tab/friend_requests_tab.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friends_list_tab/friends_list_tab.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/search_friends_tab/search_friends_tab.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

@RoutePage()
class FriendsTab extends StatelessWidget {
  FriendsTab({@QueryParam('initialTabIndex') this.initialTabIndex = 0, super.key});

  final int initialTabIndex;
  final _authService = getIt<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, child) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.achievements)
            : DefaultTabController(
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
                      FriendsListTab(),
                      FriendRequestsTab(),
                      SearchFriendsTab(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
