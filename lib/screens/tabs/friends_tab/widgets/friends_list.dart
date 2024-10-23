import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friend_tile.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({required this.items, required this.tapFunction, this.requestWidgets, super.key});

  final List<String> items;
  final VoidCallback tapFunction;
  final Widget? requestWidgets;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FriendTile(
            username: items[index],
            requestWidgets: requestWidgets,
            tapFunction: tapFunction,
          );
        },
      ),
    );
  }
}
