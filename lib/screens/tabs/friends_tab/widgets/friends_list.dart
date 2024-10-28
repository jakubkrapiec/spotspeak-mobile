import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friend_tile.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({required this.items, required this.tapFunction, super.key});

  final List<String> items;
  final VoidCallback tapFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FriendTile(
            username: items[index],
            tapFunction: tapFunction,
          );
        },
      ),
    );
  }
}
