import 'package:flutter/material.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({
    required this.username,
    required this.tapFunction,
    this.requestWidgets,
    super.key,
  });

  final String username;
  final VoidCallback tapFunction;
  final Widget? requestWidgets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: tapFunction,
        leading: SizedBox.square(
          dimension: 45,
          child: ClipOval(child: Image.asset('assets/default_icon.jpg')),
        ),
        title: Text(username),
        trailing: requestWidgets,
      ),
    );
  }
}
