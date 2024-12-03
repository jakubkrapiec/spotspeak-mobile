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
class FriendsTab extends StatefulWidget {
  const FriendsTab({@QueryParam('initialTabIndex') this.initialTabIndex = 0, super.key});

  final int initialTabIndex;

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> with SingleTickerProviderStateMixin {
  final _authService = getIt<AuthenticationService>();
  late final TabController _tabController;
  static const _tabAnimationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      initialIndex: widget.initialTabIndex,
      vsync: this,
      animationDuration: _tabAnimationDuration,
    );
    _tabController.addListener(() async {
      await Future<void>.delayed(_tabAnimationDuration);
      if (!mounted) return;
      if (_tabController.index == 2) return;
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserType>(
      valueListenable: _authService.userTypeNotifier,
      builder: (context, userType, child) {
        return userType == UserType.guest
            ? GuestScreen(screen: ScreenType.achievements)
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: AppBar(
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: 'Znajomi'),
                        Tab(text: 'Zaproszenia'),
                        Tab(text: 'Wyszukaj'),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    FriendsListTab(),
                    FriendRequestsTab(),
                    SearchFriendsTab(),
                  ],
                ),
              );
      },
    );
  }
}
