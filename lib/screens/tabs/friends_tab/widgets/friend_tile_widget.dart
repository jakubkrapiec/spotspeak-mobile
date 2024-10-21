import 'package:flutter/material.dart';

class FriendTileWidget extends StatelessWidget {
  const FriendTileWidget({
    required this.username,
    this.requestWidgets,
    super.key,
  });

  final String username;
  final Widget? requestWidgets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: () {},
        leading: SizedBox(
          height: 45,
          width: 45,
          child: ClipOval(child: Image.asset('assets/default_icon.jpg')),
        ),
        title: Text(username),
        trailing: requestWidgets,
      ),
    );
  }
}
