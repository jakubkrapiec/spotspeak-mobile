import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friends_list_widget.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friends_search_widget.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

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
                Tab(
                  text: 'Zaproszenia',
                ),
                Tab(
                  text: 'Wyszukaj',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                FriendsSearchWidget(
                  pressFunction: (value) {},
                ),
                FriendsListWidget(items: items),
              ],
            ),
            Column(
              children: [
                FriendsSearchWidget(pressFunction: (value) {}),
                FriendsListWidget(
                  items: items,
                  requestWidgets: Wrap(
                    spacing: 12,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.person_add,
                          color: MediaQuery.platformBrightnessOf(context) == Brightness.light
                              ? CustomColors.blue7
                              : CustomColors.green7,
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.person_remove,
                          color: MediaQuery.platformBrightnessOf(context) == Brightness.light
                              ? CustomColors.blue7
                              : CustomColors.green7,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                FriendsSearchWidget(pressFunction: (value) {}),
                FriendsListWidget(items: items),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
