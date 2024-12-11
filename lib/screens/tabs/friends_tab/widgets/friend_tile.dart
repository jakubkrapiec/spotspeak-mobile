import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.profilePictureUrl.toString(),
            fit: BoxFit.cover,
            errorWidget: (context, url, _) => Image.asset('assets/default_icon.jpg'),
          ),
        ),
      ),
      title: AutoSizeText(user.username, maxLines: 1),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: actions),
    );
  }
}
