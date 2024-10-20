import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/friend_tile_widget.dart';

class FriendsListWidget extends StatelessWidget {
  const FriendsListWidget({required this.items, this.requestWidgets, super.key});

  final List<String> items;
  final Widget? requestWidgets;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FriendTileWidget(
            username: items[index],
            requestWidgets: requestWidgets,
          );
        },
      ),
    );
  }
}
