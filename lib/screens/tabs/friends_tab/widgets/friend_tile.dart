import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/models/search_user.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({required this.user, required this.onTap, this.actions = const [], super.key});

  final SearchUser user;
  final VoidCallback onTap;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SizedBox.square(
        dimension: 45,
        child: ClipOval(child: Image.asset('assets/default_icon.jpg')),
      ),
      title: Text(user.username),
      trailing: Wrap(
        spacing: 12,
        children: actions,
      ),
    );
  }
}
