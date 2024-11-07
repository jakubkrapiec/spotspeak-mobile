import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/guest_screen/guest_screen.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friends_list.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friends_search.dart';
import 'package:spotspeak_mobile/screens/user_profile/user_profile_screen.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';

@RoutePage()
class FriendsTab extends StatelessWidget {
  FriendsTab({super.key});

  final _authService = getIt<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(10000, (i) => 'Item $i');
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, _) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.friends)
            : DefaultTabController(
                length: 3,
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
      },
    );
  }
}
