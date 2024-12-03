import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';

class RankingEntry extends StatelessWidget {
  RankingEntry({required this.user, this.onTap, this.isMe = false}) : super(key: ValueKey(user.friendId));

  final RankingUser user;
  final bool isMe;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                user.rankNumber.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(12),
              if (user.profilePictureUrl != null)
                CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(user.profilePictureUrl.toString()),
                )
              else
                const CircleAvatar(radius: 20, child: Icon(Icons.person)),
              const Gap(12),
              Expanded(
                child: AutoSizeText(
                  user.username,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: isMe ? FontWeight.bold : FontWeight.normal),
                  maxLines: 1,
                ),
              ),
              const Gap(12),
              Text(
                '${user.totalPoints} pkt',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
